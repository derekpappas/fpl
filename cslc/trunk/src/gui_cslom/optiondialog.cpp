#include "optiondialog.h"
#include "qtvariantproperty.h"
#include "qtpropertybrowser.h"
#include "qtgroupboxpropertybrowser.h"
#include "qteditorfactory.h"

OptionDialog::OptionDialog(FplOptions& option_, QWidget* parent) :
        PropertyDialog(parent),
        fplOptions(option_)
{
    setWindowTitle("Options");
    addProperty(QVariant::Bool, "Netlisting Mode");
    setPropertyValue("Netlisting Mode", fplOptions.bNetlisting);
    QStringList stringDisplayName;
    stringDisplayName << "Off" << "On";
    setPropertyAttribute("Netlisting Mode", "booleanDisplay", stringDisplayName);
    addProperty(QVariant::Bool, "Floor Planning");
    setPropertyValue("Floor Planning", fplOptions.bFloorPlanning);
    setPropertyAttribute("Floor Planning", "booleanDisplay", stringDisplayName);
    addProperty(QtVariantPropertyManager::comboboxTypeId(), "Target Device");
    QStringList targetDevices;
    targetDevices << "FPGA" << "ASIC" << "Emulator" << "Simulations";
    setPropertyAttribute("Target Device", "comboboxNames", targetDevices);
    setPropertyAttribute("Target Device", "comboboxEditable", false);
    if (fplOptions.stringDevice.size())
        setPropertyValue("Target Device", QString(fplOptions.stringDevice.c_str()));
    addProperty(QVariant::Bool, "Generate include statements");
    setPropertyValue("Generate include statements", fplOptions.bAddIncludes);
    setPropertyAttribute("Generate include statements", "booleanDisplay", stringDisplayName);
}

void OptionDialog::onAccept()
{
    fplOptions.bNetlisting = getPropertyValue("Netlisting Mode").toBool();
    fplOptions.bFloorPlanning = getPropertyValue("Floor Planning").toBool();
    fplOptions.stringDevice = getPropertyValue("Target Device").toString().toStdString();
    fplOptions.bAddIncludes = getPropertyValue("Generate include statements").toBool();
    PropertyDialog::onAccept();
}
