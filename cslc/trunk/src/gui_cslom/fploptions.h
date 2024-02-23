#ifndef FPLOPTIONS_H
#define FPLOPTIONS_H

#include <string>

class FplOptions
{
public:
    FplOptions();

    bool bNetlisting;
    bool bFloorPlanning;
    bool bAddIncludes;
    std::string stringDevice;
};

#endif // FPLOPTIONS_H
