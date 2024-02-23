#ifndef PREFERENCEDIALOG_H
#define PREFERENCEDIALOG_H

#include <QDialog>
#include "ui_dialogPreferences.h"

class PreferenceDialog : public QDialog
{
    Q_OBJECT
public:
    PreferenceDialog(QWidget*, const QString& stringCslcLocation);
    QString getCslcLocation();
private:
    Ui_DialogPreferences ui;
protected slots:
    void slotCslcLocation();
};

#endif // PREFERENCEDIALOG_H
