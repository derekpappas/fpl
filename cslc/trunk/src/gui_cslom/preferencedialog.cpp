#include "preferencedialog.h"
#include <QFileDialog>
#include <QLineEdit>
#include <QMessageBox>

PreferenceDialog::PreferenceDialog(QWidget* parent, const QString& s2) :
        QDialog(parent)
{
    ui.setupUi(this);
    ui.lineEditCslcLocation->setText(s2);
    ui.lineEditCslcLocation->setReadOnly(true);
    connect(ui.pushButtonCslcLocation, SIGNAL(clicked()), this, SLOT(slotCslcLocation()));
}

void PreferenceDialog::slotCslcLocation()
{
    bool repeat = true;
    QString filter = "cslc executable(cslc);;All Files (*)";
    QString stringFile = "";

    while (repeat) {
        stringFile = QFileDialog::getOpenFileName(this, QString("Open cslc executable"), ui.lineEditCslcLocation->text().section('/',0,-2),
                                 filter);
        if (!stringFile.isNull()) {
            if(QFile::exists(stringFile)) {
                ui.lineEditCslcLocation->setText(stringFile);
                repeat = false;
            } else {
                QMessageBox::critical(this, "Error", "The file does not exist\nPlease select a valid one", QMessageBox::Ok);
            }
        } else repeat = false;
    }
}

QString PreferenceDialog::getCslcLocation()
{
    return ui.lineEditCslcLocation->text();
}
