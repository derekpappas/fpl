#include "treecombobox.h"

#include <qstringlistmodel.h>
#include <qitemdelegate.h>
#include <qlistview.h>
#include <qpainter.h>
#include <qevent.h>
#include <qstylepainter.h>

bool TreeComboBoxEventFilter::eventFilter(QObject* object, QEvent* e)
{
    QTreeView* view = qobject_cast<QTreeView*>(pComboBox->view());
    if (!view)
        return false;
    switch (e->type()) {
    case QEvent::ShortcutOverride:
        switch (static_cast<QKeyEvent*>(e)->key()) {
        case Qt::Key_Enter:
        case Qt::Key_Return:
            if (view->currentIndex().isValid() && (view->currentIndex().flags() & Qt::ItemIsEnabled) ) {
                pComboBox->selectedIndex = view->currentIndex();
                pComboBox->update();
                emit pComboBox->currentSelectedIndexChanged(view->model()->data(pComboBox->selectedIndex, Qt::EditRole).toString());
                return false;
            }
        default:
            break;
        }
    break;
    case QEvent::MouseButtonRelease: {
        QMouseEvent *m = static_cast<QMouseEvent *>(e);
        if (pComboBox->isVisible() && view->rect().contains(m->pos()) && view->currentIndex().isValid()
            && (view->currentIndex().flags() & Qt::ItemIsEnabled)
            && (view->currentIndex().flags() & Qt::ItemIsSelectable)) {
            pComboBox->selectedIndex = view->currentIndex();
            pComboBox->update();
            emit pComboBox->currentSelectedIndexChanged(view->model()->data(pComboBox->selectedIndex, Qt::EditRole).toString());
            return false;
        }
        break;
    }
    default:
        break;
    }
    return QObject::eventFilter(object, e);
}

TreeComboBoxDelegate::TreeComboBoxDelegate(QObject *parent)
    : QAbstractItemDelegate(parent), pComboBox((QComboBox*)parent)
{
}

void TreeComboBoxDelegate::paint(QPainter *painter,
                                const QStyleOptionViewItem &option,
                                const QModelIndex &index) const
{
    QString text = index.data(Qt::DisplayRole).toString();
    int indent = text.count('.') * 20;
    if (indent)
        text = text.mid(text.lastIndexOf('.') + 1);

    if (option.state & QStyle::State_Selected) {
        painter->save();
        painter->setBrush(option.palette.highlight());
        painter->setPen(Qt::NoPen);
        painter->drawRect(option.rect);
        painter->setPen(QPen(option.palette.highlightedText(), 0));
    }

    QRect rectText = option.rect;
    bool reverse = (option.direction == Qt::RightToLeft);
    if (reverse)
        rectText.setRight(rectText.right() - indent - 4);
    else
        rectText.setLeft(rectText.left() + indent + 4);

    painter->drawText(rectText, Qt::AlignVCenter|Qt::AlignLeading|Qt::TextSingleLine, text);

    QRect primitive = option.rect;
    primitive.moveLeft(reverse ? primitive.left() : primitive.left() - indent);
    primitive.setWidth(20);
    QStyleOptionViewItemV2 opt;
    opt.decorationAlignment = option.decorationAlignment;
    opt.decorationPosition = option.decorationPosition;
    opt.decorationSize = option.decorationSize;
    opt.direction = option.direction;
    opt.displayAlignment = option.displayAlignment;
    opt.font = option.font;
    opt.fontMetrics = option.fontMetrics;
    opt.palette = option.palette;
    opt.rect = primitive;
    opt.showDecorationSelected = option.showDecorationSelected;
    opt.state = option.state;
    opt.textElideMode = option.textElideMode;

    const bool children = hasChildren(index);
    const bool moreSiblings = hasMoreSiblings(index);

    QStyle::State extraFlags = QStyle::State_None;
    if (pComboBox->isEnabled())
        extraFlags |= QStyle::State_Enabled;
    if (pComboBox->window()->isActiveWindow())
        extraFlags |= QStyle::State_Active;

    opt.state = QStyle::State_Item | extraFlags | QStyle::State_Open
                    | (moreSiblings ? QStyle::State_Sibling : QStyle::State_None)
                    | (children ? QStyle::State_Children : QStyle::State_None);
    //opt.state |= QStyle::State_MouseOver;
    pComboBox->style()->drawPrimitive(QStyle::PE_IndicatorBranch, &opt, painter, pComboBox);

    if (option.state & QStyle::State_Selected)
        painter->restore();

}

QSize TreeComboBoxDelegate::sizeHint(const QStyleOptionViewItem &option,
                                    const QModelIndex &index) const
{
    QString text = index.data(Qt::DisplayRole).toString();
    int indent = text.count('.') * 20;
    if (indent)
        text = text.mid(text.lastIndexOf('.') + 1);
    QFontMetrics fontMetrics(option.font);
    return QSize(fontMetrics.width(text) + indent + 8, fontMetrics.lineSpacing());
}

TreeComboBox::TreeComboBox(QWidget *parent)
    : QComboBox(parent)
{
    filter = new TreeComboBoxEventFilter(this);
}


/*!
    Destroys the combobox.
*/
TreeComboBox::~TreeComboBox()
{
}


void TreeComboBox::showPopup()
{
    QTreeView* pTreeView = qobject_cast<QTreeView*>(view());
    if (pTreeView)
    {
        pTreeView->installEventFilter(filter);
        pTreeView->viewport()->installEventFilter(filter);
    }
    QComboBox::showPopup();
    if (pTreeView)
        pTreeView->setCurrentIndex(selectedIndex);
}

void TreeComboBox::hidePopup()
{
    QComboBox::hidePopup();
    QTreeView* pTreeView = qobject_cast<QTreeView*>(view());
    if (pTreeView)
    {
        pTreeView->removeEventFilter(filter);
        pTreeView->viewport()->removeEventFilter(filter);
    }
}

void TreeComboBox::paintEvent(QPaintEvent*)
{
    QTreeView* pTreeView = qobject_cast<QTreeView*>(view());
    QStylePainter painter(this);
    painter.setPen(palette().color(QPalette::Text));

    // draw the combobox frame, focusrect and selected etc.
    QStyleOptionComboBox opt;
    initStyleOption(&opt);
    if (pTreeView && selectedIndex.isValid())
        opt.currentText = model()->data(selectedIndex, Qt::EditRole).toString();
    painter.drawComplexControl(QStyle::CC_ComboBox, opt);

    // draw the icon and text
    painter.drawControl(QStyle::CE_ComboBoxLabel, opt);
}

bool TreeComboBoxDelegate::hasChildren(const QModelIndex& index) const
{
    QStringListModel* modelStringList = (QStringListModel*) pComboBox->model();
    QModelIndex indexChild = index.sibling(index.row() + 1, index.column());
    if (!indexChild.isValid())
        return false;
    QString stringParent = modelStringList->data(index, Qt::DisplayRole).toString();
    QString stringChild = modelStringList->data(indexChild, Qt::DisplayRole).toString();
    stringParent += ".";
    if (stringChild.left(stringParent.length()) == stringParent)
        return true;
    else
        return false;
}

bool TreeComboBoxDelegate::hasMoreSiblings(const QModelIndex& index) const
{
    QStringListModel* modelStringList = (QStringListModel*) pComboBox->model();
    QString stringSibling = modelStringList->data(index, Qt::DisplayRole).toString();
    QString stringParent = stringSibling + ".";
    if (stringSibling.count('.'))
        stringSibling = stringSibling.mid(stringSibling.lastIndexOf('.') + 1);
    else
        stringSibling = QString::null;
    do
    {
        QModelIndex indexSibling = index.sibling(index.row() + 1, index.column());
        if (!indexSibling.isValid())
            return false;
        QString stringChild = modelStringList->data(indexSibling, Qt::DisplayRole).toString();
        if (stringChild.left(stringParent.length()) == stringParent)
            continue;
        if (stringChild.count('.'))
            stringChild = stringChild.mid(stringChild.lastIndexOf('.') + 1);
        else
            stringChild = QString::null;
        return stringChild == stringSibling;
    }
    while(1);
}


