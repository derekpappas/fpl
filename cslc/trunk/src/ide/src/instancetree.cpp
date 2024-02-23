//----------------------------------------------------------------------
// Copyright (c) 2005-2007 FastPath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of FastPath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of FastPath Logic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/*
 * This is a part of the CSL IDE
 * Author: Codrin Pruteanu <codrin@fastpathlogic.ro>
 * 2007
 */

#include "instancetree.h"
#include <iostream>
#include <QtGui>
#include <QStringList>

using namespace std;

////////////////////////////////////////////////////////////////////////////////////////////////////
// class TreeItem
////////////////////////////////////////////////////////////////////////////////////////////////////
TreeItem::TreeItem(const QList<QVariant> &data, TreeItem *parent) {
  parentItem = parent;
  itemData = data;
}

TreeItem::~TreeItem() {
  qDeleteAll(childItems);
}

void TreeItem::appendChild(TreeItem *item) {
  childItems.append(item);
}

TreeItem *TreeItem::child(int row) {
  return childItems.value(row);
}

int TreeItem::childCount() const {
  return childItems.count();
}

int TreeItem::columnCount() const {
  return itemData.count();
}

QVariant TreeItem::data(int column) const {
  return itemData.value(column);
}

TreeItem *TreeItem::parent() {
  return parentItem;
}

int TreeItem::row() const {
  if (parentItem)
    return parentItem->childItems.indexOf(const_cast<TreeItem*>(this));

  return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// class TreeModel
////////////////////////////////////////////////////////////////////////////////////////////////////
TreeModel::TreeModel(const QString &data, QObject *parent) : QAbstractItemModel(parent) {
  QList<QVariant> rootData;
  rootData << "Instance name" << "Level";
  rootItem = new TreeItem(rootData);
  setupModelData(data.split(QString("\n")), rootItem);
}

TreeModel::~TreeModel() {
  delete rootItem;
}

int TreeModel::columnCount(const QModelIndex &parent) const {
  if (parent.isValid())
    return static_cast<TreeItem*>(parent.internalPointer())->columnCount();
  else
    return rootItem->columnCount();
}

QVariant TreeModel::data(const QModelIndex &index, int role) const {
  if (!index.isValid())
    return QVariant();
  if (role != Qt::DisplayRole)
    return QVariant();
  TreeItem *item = static_cast<TreeItem*>(index.internalPointer());
  return item->data(index.column());
}

Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const {
  if (!index.isValid())
    return Qt::ItemIsEnabled;
  return Qt::ItemIsEnabled | Qt::ItemIsSelectable;
}

QVariant TreeModel::headerData(int section, Qt::Orientation orientation, int role) const {
  if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
    return rootItem->data(section);
  return QVariant();
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const {
  TreeItem *parentItem;
  if (!parent.isValid())
    parentItem = rootItem;
  else
    parentItem = static_cast<TreeItem*>(parent.internalPointer());
  TreeItem *childItem = parentItem->child(row);
  if (childItem)
    return createIndex(row, column, childItem);
  else
    return QModelIndex();
}

QModelIndex TreeModel::parent(const QModelIndex &index) const {
  if (!index.isValid())
    return QModelIndex();
  TreeItem *childItem = static_cast<TreeItem*>(index.internalPointer());
  TreeItem *parentItem = childItem->parent();
  if (parentItem == rootItem)
    return QModelIndex();
  return createIndex(parentItem->row(), 0, parentItem);
}

int TreeModel::rowCount(const QModelIndex &parent) const {
  TreeItem *parentItem;
  if (!parent.isValid())
    parentItem = rootItem;
  else
    parentItem = static_cast<TreeItem*>(parent.internalPointer());
  return parentItem->childCount();
}

void TreeModel::setupModelData(const QStringList &lines, TreeItem *parent) {
  QList<TreeItem*> parents;
  QList<int> indentations;
  parents << parent;
  indentations << 0;
  int number = 0;
  while (number < lines.count()) {
    int position = 0;
    while (position < lines[number].length()) {
      if (lines[number].mid(position, 1) != "|")
        break;
      position++;
    }
    QString lineData = lines[number].mid(position).trimmed();
    if (!lineData.isEmpty()) {
      // Read the column data from the rest of the line.
      QStringList columnStrings = lineData.split("|", QString::SkipEmptyParts);
      QList<QVariant> columnData;
      for (int column = 0; column < columnStrings.count(); ++column)
        columnData << columnStrings[column];
      if (position > indentations.last()) {
        // The last child of the current parent is now the new parent unless the current parent has no children.
        if (parents.last()->childCount() > 0) {
          parents << parents.last()->child(parents.last()->childCount() - 1);
          indentations << position;
        }
      } else {
        while (position < indentations.last() && parents.count() > 0) {
          parents.pop_back();
          indentations.pop_back();
        }
      }
      // Append a new item to the current parent's list of children.
      parents.last()->appendChild(new TreeItem(columnData, parents.last()));
    }
    number++;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// class InstanceTree Visitor
////////////////////////////////////////////////////////////////////////////////////////////////////
RefVisitor Visitor::build(NSCInstTree::RefCInstTreeNode node) {
  Visitor *visitor = new Visitor();
  RefVisitor refVisitor(visitor); //converts the pointer to ref
  //initialize weakRef
  //visitor->m_weakRef = refVisitor.getWeakRef();
  visitor->m_weakRef = boost::weak_ptr<Visitor>(refVisitor);
  return refVisitor;
}

void Visitor::beforeTraversal(const NSCInstTree::RefCInstTreeNode &node) {
  if (!node->isRoot()) {
    for (int i = 0; i <= node->getLevel(); i++) {
      instTreeData.append("|");
    }
//    NSCSLOm::RefTVec_RefString names = node->getHid()->getHidNames();
     RefTVec_RefString names = RefTVec_RefString(new TVec_RefString());
    names.get()->push_back(node->getName()); // FIX DEP need hid path-How?? RefCInstTreeNode::    static RefTVec_RefCInstTreeNode getNodeMap() { return m_nodeMap; }

    for(TVec_RefString::const_iterator iter = names->begin(); iter < names->end(); ++iter) {
      if (iter == names->end()-1) {
        instTreeData.append(QString("%1|(%2)").arg((*(*iter)).c_str()).arg(node->getLevel()));
      }
    }
 // FIX DEP   RefTVec_TLong numbers = node->getNumHid();
 // FIX DEP   for(TVec_TLong_const_iter iter = numbers->begin(); iter < numbers->end(); ++iter) {
 // FIX DEP     if (iter < numbers->end()-1) cout << ".";
   // FIX DEP  }
    instTreeData.append("\n");
  }
}

void Visitor::inTraversal(const NSCInstTree::RefCInstTreeNode &node) {
}

void Visitor::afterTraversal(const NSCInstTree::RefCInstTreeNode &node) {
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// class TreeView
////////////////////////////////////////////////////////////////////////////////////////////////////
TreeView::TreeView(QWidget *parent) : QTreeView(parent) {
  setWindowTitle(QObject::tr("Tree View"));
}

void TreeView::mousePressEvent(QMouseEvent *event) {
  if (event->button() == Qt::LeftButton) {
    cout << "left button pressed" << endl;
  } else
  if (event->button() == Qt::RightButton) {
    cout << "right button pressed" << endl;
  }
  QTreeView::mousePressEvent(event);
}

void TreeView::build(NSCInstTree::RefCInstTreeNode &instTreeRoot) {
  RefVisitor visitor = Visitor::build(instTreeRoot);
  instTreeRoot->acceptVisitor(*visitor);
  model = new TreeModel(visitor->getInstTreeData());
  setModel(model);
  expandAll();
}
