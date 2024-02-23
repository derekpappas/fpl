#ifndef OPTIONDIALOG_H
#define OPTIONDIALOG_H

#include "propertydialog.h"
#include "fploptions.h"
class QtProperty;

class OptionDialog : public PropertyDialog
{
    Q_OBJECT
public:
    OptionDialog(FplOptions& option, QWidget* parent);
    FplOptions& fplOptions;
protected:
    void onAccept();
};

#endif // OPTIONDIALOG_H
