#ifndef FplXMLHandler_H
#define FplXMLHandler_H

#include <QXmlContentHandler>
#include <QXmlErrorHandler>
#include <stack>
#include <map>
#include <string>
#include "refcounted.h"
#include "fploptions.h"

class InterfaceType;
typedef RefCounting<InterfaceType> InterfaceTypeRef;
class UnitType;
typedef RefCounting<UnitType> UnitTypeRef;

class FplXMLHandler : public QXmlContentHandler
{
public:
    FplXMLHandler();
    virtual ~FplXMLHandler();
public:
    bool characters ( const QString & ch );
    bool endDocument ();
    bool endElement ( const QString & namespaceURI, const QString & localName, const QString & qName );
    bool endPrefixMapping ( const QString & prefix );
    QString errorString () const;
    bool ignorableWhitespace ( const QString & ch );
    bool processingInstruction ( const QString & target, const QString & data );
    void setDocumentLocator ( QXmlLocator * locator );
    bool skippedEntity ( const QString & name );
    bool startDocument ();
    bool startElement ( const QString & namespaceURI, const QString & localName, const QString & qName, const QXmlAttributes & atts );
    bool startPrefixMapping ( const QString & prefix, const QString & uri );

    bool parseInterfaceXmlElement(const std::stack<QString>& stackElements, std::map<std::string, std::string>& mapProperties, InterfaceTypeRef& interfaceType, std::string& stringInterfaceName);
    bool parseInterfaceXmlElementCreateObject(const std::map<std::string, std::string>& mapProperties, InterfaceTypeRef interfaceType);

    bool parseUnitXmlElement(const std::stack<QString>& stackElements, std::map<std::string, std::string>& mapProperties, UnitTypeRef& unitType, std::string& stringUnitName);
    bool parseUnitXmlElementCreateObject(const std::map<std::string, std::string>& mapProperties, UnitTypeRef unitType);

    std::stack<QString> stackElements;
    QString stringText, stringElement;
    std::stack<std::map<std::string, std::string> > stackProperties;

    InterfaceTypeRef interfaceType;
    std::string stringInterfaceName;

    UnitTypeRef unitType;
    std::string stringUnitName;

    std::string stringTopLevelUnitName;

    FplOptions* fplOptions;

    bool setFplOptions(FplOptions* opt){ fplOptions = opt; };

    QString stringError;
    int iUniqIndex;
    std::map<std::string, std::string> mapPortSignalNames;
};

class FplXMLErrorHandler : public QXmlErrorHandler
{
public:
    virtual bool error ( const QXmlParseException & exception );
    virtual QString errorString () const;
    virtual bool fatalError ( const QXmlParseException & exception );
    virtual bool warning ( const QXmlParseException & exception );
private:
    QString stringError;
};

#endif // FplXMLHandler_H
