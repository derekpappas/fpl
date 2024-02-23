#ifndef TREECOMBOBOX_H
#define TREECOMBOBOX_H

#include <QtGui/QComboBox>
#include <QtCore/QString>
#include <QtGui/QTreeView>
#include <deque>
class QPainter;
class QModelIndex;
class TreeComboBox;

class TreeComboBoxEventFilter : public QObject
{
    Q_OBJECT
private:
    TreeComboBox* pComboBox;
public:
    TreeComboBoxEventFilter(QObject* parent) :
            QObject(parent)
    {
        pComboBox = qobject_cast<TreeComboBox*>(parent);
    }
protected:
    bool eventFilter(QObject* object, QEvent* e);
};

class TreeComboBox : public QComboBox
{
    friend class TreeComboBoxEventFilter;
    Q_OBJECT

public:
    explicit TreeComboBox(QWidget *parent = 0);
    ~TreeComboBox();

    virtual void showPopup ();
    virtual void hidePopup ();

protected:
    void paintEvent(QPaintEvent* e);

public:
    QModelIndex selectedIndex;

private:
    TreeComboBoxEventFilter* filter;
    Q_DISABLE_COPY(TreeComboBox)
Q_SIGNALS:
    void currentSelectedIndexChanged(const QString&);
};

class TreeComboBoxDelegate : public QAbstractItemDelegate
{
    Q_OBJECT
public:
    explicit TreeComboBoxDelegate(QObject *parent);

    // painting
    void paint(QPainter *painter,
               const QStyleOptionViewItem &option,
               const QModelIndex &index) const;

    QSize sizeHint(const QStyleOptionViewItem &option,
                   const QModelIndex &index) const;
private:
    QComboBox* pComboBox;
    bool hasChildren(const QModelIndex& index) const;
    bool hasMoreSiblings(const QModelIndex& index) const;

};

class TreeComboBoxItem
{
public:
    QString stringItem;
    bool bSelectable;
    QList<TreeComboBoxItem*> children;
    TreeComboBoxItem* parent;
public:
    TreeComboBoxItem(TreeComboBoxItem* p, const QString& item) :
            stringItem(item), bSelectable(true), parent(p)
    {
        if (p)
            p->children.append(this);
    }
    ~TreeComboBoxItem()
    {
        if (parent)
        {
            int index = parent->children.indexOf(this);
            if (index)
                parent->children.erase(children.begin() + index);
            parent = NULL;
        }
        QListIterator<TreeComboBoxItem*> iteratorList(children);
        while(iteratorList.hasNext())
        {
            TreeComboBoxItem* child = iteratorList.next();
            child->parent = NULL;
            delete child;
        }
        children.clear();
    }
    TreeComboBoxItem* getChild(int row) const
    {
        return children[row];
    }
    TreeComboBoxItem* getRecursiveChild(const std::deque<int>& queueRows) const
    {
        if (queueRows.size() == 1)
            return children[queueRows[0]];
        else
        {
            std::deque<int> queueChildRows = queueRows;
            queueChildRows.pop_front();
            return children[queueRows[0]]->getRecursiveChild(queueChildRows);
        }
    }
    QString getHierarchyString()
    {
        QString stringResult = stringItem;
        TreeComboBoxItem* pItem = parent;
        while(pItem)
        {
            if (pItem->stringItem.size())
                stringResult = pItem->stringItem + "." + stringResult;
            pItem = pItem->parent;
        }
        return stringResult;
    }
    bool hasChildren() const
    {
        return children.size();
    }
    void clear()
    {
        QListIterator<TreeComboBoxItem*> iteratorList(children);
        while(iteratorList.hasNext())
        {
            TreeComboBoxItem* child = iteratorList.next();
            child->parent = NULL;
            delete child;
        }
        children.clear();
    }
    TreeComboBoxItem* child(const QString& stringChild)
    {
        QListIterator<TreeComboBoxItem*> iteratorList(children);
        while(iteratorList.hasNext())
        {
            TreeComboBoxItem* child = iteratorList.next();
            if (child->stringItem == stringChild) return child;
        }
        return NULL;
    }
    TreeComboBoxItem* childRecursive(int index)
    {
        if (index == 0)
            return this;
        index --;
        int i;
        for (i = 0; i < children.size(); i++)
        {
            if (index < children[i]->childrenSize())
                return children[i]->childRecursive(index);
            else
                index -= children[i]->childrenSize();
        }
        return NULL;
    }
    int childrenSize()
    {
        int size = 1;
        int i;
        for (i = 0; i < children.size(); i++)
            size += children[i]->childrenSize();
        return size;
    }

    int index(const QString& stringChild)
    {
        int i = 0;
        QListIterator<TreeComboBoxItem*> iteratorList(children);
        while(iteratorList.hasNext())
        {
            TreeComboBoxItem* child = iteratorList.next();
            if (child->stringItem == stringChild) return i;
            i++;
        }
        return -1;
    }
private:
    TreeComboBoxItem()
    {
    }
    TreeComboBoxItem& operator=(const TreeComboBoxItem&)
    {
        return *this;
    }
    TreeComboBoxItem(const TreeComboBoxItem&)
    {
    }
};

class TreeComboBoxModel : public QAbstractItemModel
{
    Q_OBJECT
public:
    TreeComboBoxModel(QObject* parent) : QAbstractItemModel(parent)
    {
        root = new TreeComboBoxItem(NULL, "");
    }
    ~TreeComboBoxModel()
    {
        delete root;
    }
public:
    virtual int columnCount ( const QModelIndex & = QModelIndex() ) const
    {
        return 1;
    }
    virtual QVariant data ( const QModelIndex & index, int role = Qt::DisplayRole ) const
    {
        if (!index.isValid())
            return QVariant();
        TreeComboBoxItem* pItem = static_cast<TreeComboBoxItem*>(index.internalPointer());
        if (pItem == root)
            return QVariant();
        if (role == Qt::DisplayRole)
            return pItem->stringItem;
        else if (role == Qt::EditRole)
            return pItem->getHierarchyString();
        else
            return QVariant();
    }
    virtual bool setData ( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole )
    {
        if (!index.isValid())
            return false;
        TreeComboBoxItem* pItem = static_cast<TreeComboBoxItem*>(index.internalPointer());
        if (pItem == root)
            return false;
        if (role == Qt::DisplayRole || role == Qt::EditRole)
        {
            pItem->stringItem = value.toString();
            return true;
        }
        else
            return false;
    }
    virtual bool hasChildren ( const QModelIndex & parent = QModelIndex() ) const
    {
        if (!parent.isValid())
            return root->hasChildren();
        TreeComboBoxItem* pItem = static_cast<TreeComboBoxItem*>(parent.internalPointer());
        if (pItem)
            return pItem->hasChildren();
        else
            return false;
    }
    virtual QModelIndex parent ( const QModelIndex & index ) const
    {
        if (!index.isValid())
            return QModelIndex();
        TreeComboBoxItem* pItem = static_cast<TreeComboBoxItem*>(index.internalPointer());
        if (pItem == NULL)
            return QModelIndex();
        pItem = pItem->parent;
        if (pItem == NULL || pItem == root)
            return QModelIndex();
        return createIndex(pItem->parent->children.indexOf(pItem), 0, pItem);
    }
    virtual QModelIndex index ( int row, int column, const QModelIndex & parent = QModelIndex() ) const
    {
        if (row < 0)
            return QModelIndex();
        if (!parent.isValid())
        {
            if (row >= (int)root->children.size())
                return QModelIndex();
            return createIndex(row, column, root->children[row]);
        }
        else
        {
            TreeComboBoxItem* pItem = static_cast<TreeComboBoxItem*>(parent.internalPointer());
            if (row >= (int)pItem->children.size())
                return QModelIndex();
            return createIndex(row, column, pItem->children[row]);
        }
    }
    virtual int rowCount ( const QModelIndex & parent = QModelIndex() ) const
    {
        if (!parent.isValid())
            return root->children.size();
        TreeComboBoxItem* pItem = static_cast<TreeComboBoxItem*>(parent.internalPointer());
        return pItem->children.size();
    }
    virtual bool insertRows ( int row, int count, const QModelIndex & parent = QModelIndex() )
    {
        TreeComboBoxItem* pItem;
        if (!parent.isValid())
            pItem = root;
        else
            pItem = static_cast<TreeComboBoxItem*>(parent.internalPointer());
        int i;
        for (i = 0; i < count; i++)
            pItem->children.insert(pItem->children.begin() + row, new TreeComboBoxItem(pItem, ""));
        return true;
    }
    virtual bool removeRows ( int row, int count, const QModelIndex & parent = QModelIndex() )
    {
        TreeComboBoxItem* pItem;
        if (!parent.isValid())
            pItem = root;
        else
            pItem = static_cast<TreeComboBoxItem*>(parent.internalPointer());
        int i;
        for (i = 0; i < count; i++)
        {
            TreeComboBoxItem* child = pItem->children[row];
            if (child)
            {
                child->parent = NULL;
                delete child;
                pItem->children.erase(pItem->children.begin() + row);
            }
        }
        return true;
    }
    void setStringList(const QStringList& stringlist)
    {
        root->clear();
        if (stringlist.size() == 0) return;
        TreeComboBoxItem* pPreviousItem = new TreeComboBoxItem(root, stringlist[0]);
        QString stringPrevious = stringlist[0];
        int i;
        for (i = 1; i < (int)stringlist.size(); i++)
        {
            QString stringCurrent = stringlist[i];
            if (stringCurrent.indexOf('.') == -1)
                pPreviousItem = new TreeComboBoxItem(root, stringCurrent);
            else
            {
                while (stringPrevious.size() && stringCurrent.left(stringPrevious.length() + 1) != stringPrevious + ".")
                {
                    int index = stringPrevious.lastIndexOf('.');
                    if (index != -1)
                        stringPrevious = stringPrevious.left(index);
                    else
                        stringPrevious = QString::null;
                    pPreviousItem = pPreviousItem->parent;
                    if (pPreviousItem == root)
                        break;
                }
                pPreviousItem = new TreeComboBoxItem(pPreviousItem, stringCurrent.mid(stringPrevious.length() + 1));
            }
            stringPrevious = stringCurrent;
        }
    }
    void setSelectableList(const QStringList& stringlist)
    {
        int i;
        for (i = 0; i < stringlist.size(); i++)
        {
            TreeComboBoxItem* pItem = root->childRecursive(i + 1);
            if (pItem)
                pItem->bSelectable = (stringlist[i] == "1" ? true : false);
        }
    }
    Qt::ItemFlags flags(const QModelIndex &index) const
    {
        if (!index.isValid())
            return Qt::NoItemFlags;
        TreeComboBoxItem* pItem = static_cast<TreeComboBoxItem*>(index.internalPointer());
        if (pItem == root || pItem == NULL)
            return Qt::NoItemFlags;

        if (pItem->bSelectable)
            return Qt::ItemIsSelectable | Qt::ItemIsEnabled;
        else
            return Qt::ItemIsEnabled;
    }
    QModelIndex findIndex(const QString& stringValue)
    {
        TreeComboBoxItem* pPreviousItem = root;
        int iPrev = 0, iCurrent = -1;
        QString stringCurrent, stringRemaining;
        do
        {
            iCurrent = stringValue.indexOf('.', iPrev);
            if (iCurrent != -1)
                stringCurrent = stringValue.mid(iPrev, iCurrent - iPrev);
            else
                stringCurrent = stringValue.mid(iPrev);
            if (stringRemaining.size())
                stringCurrent = stringRemaining + "." + stringCurrent;
            TreeComboBoxItem* pChildItem = pPreviousItem->child(stringCurrent);
            if (pChildItem)
            {
                pPreviousItem = pChildItem;
                stringRemaining.clear();
            }
            else
                stringRemaining = stringCurrent;
            iPrev = iCurrent + 1;
        }
        while(iCurrent != -1);
        if (pPreviousItem && pPreviousItem->parent)
            return createIndex(pPreviousItem->parent->index(stringCurrent), 0, pPreviousItem);
        else
            return QModelIndex();
    }
private:
    TreeComboBoxItem* root;
};
#endif
