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

#ifndef TreeModel_H
#define TreeModel_H

#include <QAbstractItemModel>
#include <QModelIndex>
#include <QTreeView>
#include <QVariant>
#include <QList>
#include "boost/shared_ptr.hpp"
//#include "../../support/boost/weak_ptr.hpp"
#include "../../support/TypeDefs.h"

#include "../../cslc/new_cslc.h"
#include "../../autorouter/CSLOM_InstTreeVisitor.h"

//class definition section
class TreeItem;
class TreeModel;
class TreeView;
class Visitor;

//reference class declaration section
//typedef NSRefCount::RefCount<Visitor>           RefVisitor;
typedef boost::shared_ptr<Visitor>           RefVisitor;

class TreeItem {
  public:
    TreeItem(const QList<QVariant> &data, TreeItem *parent = 0);
    ~TreeItem();

    void appendChild(TreeItem *child);

    TreeItem *child(int row);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
    int row() const;
    TreeItem *parent();
  private:
    QList<TreeItem*> childItems;
    QList<QVariant> itemData;
    TreeItem *parentItem;
};

class TreeModel : public QAbstractItemModel {
    Q_OBJECT
  public:
    TreeModel(const QString &data, QObject *parent = 0);
    ~TreeModel();
    QVariant data(const QModelIndex &index, int role) const;
    Qt::ItemFlags flags(const QModelIndex &index) const;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    QModelIndex index(int row, int column, const QModelIndex &parent = QModelIndex()) const;
    QModelIndex parent(const QModelIndex &index) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
  private:
    void setupModelData(const QStringList &lines, TreeItem *parent);
    TreeItem *rootItem;
};

class TreeView : public QTreeView {
    Q_OBJECT
  public:
    TreeView(QWidget *parent = 0);
    virtual void mousePressEvent(QMouseEvent *event);
    void build(NSCInstTree::RefCInstTreeNode &instTreeRoot);
    virtual ~TreeView() {};
  private:
    TreeModel *model;
    Visitor *visitor;
};

//This class visits the InstanceTree and displays each node level and values
class Visitor : public NSCInstTreeVisitor::CInstTreeTraversal {
  private:
    //NSRefCount::WeakRef<Visitor> m_weakRef;
    boost::weak_ptr<Visitor> m_weakRef;
    QString instTreeData;
  protected:
    Visitor() { instTreeData.append("root|root node\n"); }
  public:
    // build an object type Visitor from an Instance Tree Node
    static RefVisitor build(NSCInstTree::RefCInstTreeNode);
    void beforeTraversal(const NSCInstTree::RefCInstTreeNode &node);
    void inTraversal(const NSCInstTree::RefCInstTreeNode &node);
    void afterTraversal(const NSCInstTree::RefCInstTreeNode &node);
    QString getInstTreeData() { return instTreeData; };
    ~Visitor() { instTreeData.clear(); }
};
#endif
