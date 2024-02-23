#include "CSLOM_GUI_CSL_generator.h"

using namespace NSCSLOm;

namespace NSCSLOmGuiCslGenerator{

CSLOmGuiCslGenerator::CSLOmGuiCslGenerator(std::string fileName) :
  m_file(fileName.c_str())
{
    m_file << "cucu" << endl;
}

CSLOmGuiCslGenerator::~CSLOmGuiCslGenerator(){
}
}
