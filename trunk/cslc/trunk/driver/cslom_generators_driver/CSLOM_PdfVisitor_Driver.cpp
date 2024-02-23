//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

#include <iostream>
#include <fstream>
#include <string>


#include "CSLOM_PDF_Generator.h"
#include "CSLOM_PDF_Draw.h"

using namespace std;
using namespace NSCSLOm;
using namespace NSCSLOmVisitor;
using namespace NSCPDFGenerator;
using namespace NSCPDFDraw;

int main() {
  // RefCSLOmDesign design = CSLOmDesign::build();
  
  //CPDFGenerator pdfVisitor("Interconnect");
  // design -> acceptVisitor(pdfVisitor);
  HPDF_Page  m_currentPage;     
  HPDF_Font  m_font;
  RefString  m_docTitle = RefString(new string("GeneratedDoc"));

  CPDFDraw* pdf = new CPDFDraw(m_docTitle);
  //m_currentPage = pdf->getCurrentPage ();
  //m_font = pdf->getCurrentFont ();
  // pdf->drawTitle (m_currentPage, m_font);
  //pdf->drawChapter("Unit");
  //m_currentPage = pdf->getCurrentPage();
  //pdf->drawLine(60,80,480);
  //pdf->drawCell(100,100,"ala");
  //pdf->drawCell(125,100,"bal");
  //pdf->drawCell(150,100,"a p");
  //pdf->drawIndex("unit",880);
  delete pdf;
  return 0;
}
