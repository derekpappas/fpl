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
//Author Petronela E.

#ifndef INC_GUARD_CSLOM_PDF_Draw_h
#define INC_GUARD_CSLOM_PDF_Draw_h

#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "../support/CommonSupport.h"

#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <ctime>

#include <hpdf.h>
#include <hpdf_error.h>
#include <hpdf_types.h>
#include <setjmp.h>

using namespace NSCSLOm;
using namespace NSCSLOmVisitor;

typedef time_t           TTime;
typedef HPDF_Doc         HpdfDoc;
typedef HPDF_Page        HpdfPage;
typedef HPDF_Font        HpdfFont;
typedef HPDF_STATUS      HpdfStatus;
typedef HPDF_Annotation  HpdfAnnotation;
typedef HPDF_Rect        HpdfRect;
typedef HPDF_Point       HpdfPoint;
typedef HPDF_Destination HpdfDestination;

//typedef boost::shared_ptr<HPDF_UINT16> RefTInt16;


const RefString DOC_TITLE         = RefString (new std::string ("Interconnect"));
const RefString COMPANY_NAME      = RefString (new std::string ("Fastpath Logic Inc."));
const RefString COPYRIGHT         = RefString (new std::string ("Version 1.0 FPL Company Copyright 2008"));
const RefString INDEX             = RefString (new std::string ("Index"));
const RefString FONT              = RefString (new std::string ("Courier"));
const RefString CHAPTER           = RefString (new std::string ("Chapter"));
const RefString SUBCHAPTER        = RefString (new std::string ("Subchapter "));
const RefString DOTS              = RefString (new std::string (":"));
const RefString NULL_VALUE        = RefString (new std::string (""));

const TInt TITLE_FONT_SIZE    = 26;
const TInt CHAPTER_FONT_SIZE  = 20;
const TInt TOP_FONT_SIZE      = 8; 
const TInt BOTTOM_FONT_SIZE   = 9;
const TInt STRING_FONT_SIZE   = 12;
const TInt CELL_WIDTH         = 25;
const TInt CELL_HEIGHT        = 15;

const TDouble LINE_WIDTH      = 1;

const TDouble H_L_POS         = 20;
const TDouble H_R_W_POS       = 150; 
const TDouble H_R_H_POS       = 40;
const TDouble F_W_POS         = 90;
const TDouble F_H_POS         = 40;

const TDouble X_L_BORDER      = 50;
const TDouble Y_L_BORDER      = 55;
const TDouble X_R_BORDER      = 90;
const TDouble Y_R_BORDER      = 90; 

const TDouble T_W_POS         = 90;
const TDouble T_H_POS         = 30;

const TDouble I_W_POS         = 25;
const TDouble I_H_POS         = 80; 

const TDouble IC_W_D          = 80;
const TDouble IC_H_D          = 150;
const TDouble IC_W_L          = 120;
const TDouble IC_L            = 400;
const TDouble IC_PN           = 530;

const TDouble C_W_C           = 110;
const TDouble C_W_N           = 130;
const TDouble C_W_D           = 135;
const TDouble C_W_L           = 140;
const TDouble C_H             = 40; 

const TDouble L_R             = 40;
const TDouble L_T             = 15;

const TInt PAGE_NO_POS        = 17;
const TInt TWO                = 2;

const HPDF_UINT16 DASH_MODE1[] = {3};
const TInt NUM_PATTERN         = 1;
const TInt PHASE               = 1;


namespace NSCPDFDraw{

class CPDFDraw{
  private:
    HpdfDoc           m_pdf;        // pdf doc
    HpdfFont          m_font;       // text font
    HpdfPage          m_page;       // current page
    HpdfPage          m_titlePage;  // title page
    HpdfPage          m_indexPage;  // index page
    TInt              m_pageNo;     // page number
    TInt              m_chapterNo;  // chapter number
    TInt              m_subChapterNo;// subchapter number
    RefString         m_fname;      // pdf file name
    RefString         m_time;
    TDouble           m_pageWidth;
    TDouble           m_pageHeight;
    TTime             rawtime;
    RefTVec_TInt      m_pageNumbers;

  public:
   
    CPDFDraw(RefString);
    ~CPDFDraw();
    
    //TInt getNumber();
    void drawHeader (HpdfPage page = NULL, HpdfFont font = NULL, TInt size = TOP_FONT_SIZE);    // draw the top part
    void drawFooter (HpdfPage page = NULL, HpdfFont font = NULL, TInt size = BOTTOM_FONT_SIZE); // draw the bottom part
    void drawTemplate (HpdfPage page = NULL);                                                    // draw the border, page number, company name, copyright of the page
    void drawTitle (HpdfPage page = NULL, HpdfFont font = NULL, TInt size = TITLE_FONT_SIZE);   // display the document title
    HpdfPage insertPage (HpdfPage page = NULL);
    void drawChapter (RefString label, HpdfPage page = NULL, HpdfFont font = NULL, TInt size = CHAPTER_FONT_SIZE);
    void drawData (RefString label, TDouble x, TDouble y, HpdfPage page = NULL, HpdfFont font = NULL, TInt size = STRING_FONT_SIZE);  // just display a string  
    void drawData(TInt label, TDouble x, TDouble y, HpdfPage page = NULL, HpdfFont font = NULL, TInt size = STRING_FONT_SIZE);
    void drawLine (TDouble x, TDouble y, TDouble w, HpdfPage page = NULL, TDouble lineWidth = LINE_WIDTH, TInt numPattern = NUM_PATTERN, TInt phase = PHASE);
    void drawCell ( TDouble x, TDouble y, TDouble m_cellWidth = CELL_WIDTH, TDouble m_cellHeight = CELL_HEIGHT, HpdfPage page = NULL, RefString label = NULL_VALUE,TDouble m_lineWidth = LINE_WIDTH);
    void drawIndex (RefString label = INDEX  ,HpdfPage page = NULL);                       // draw index 
    void drawIndexContent (RefString label, TDouble x, TDouble y, HpdfPage page = NULL);
    void makeLink (TDouble x, TDouble y, HpdfPage page, TDouble pos);
    HpdfPage getCurrentPage ();
    HpdfFont getCurrentFont ();
};

}//namespace NSCPDFDraw

#endif
