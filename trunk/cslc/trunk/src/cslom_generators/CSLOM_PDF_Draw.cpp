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

#include "CSLOM_PDF_Draw.h"

using namespace std;
using namespace NSCSLOm;
using namespace NSCSLOmVisitor;

namespace NSCPDFDraw{

jmp_buf env;

#ifdef HPDF_DLL
void  __stdcall
#else
  void
#endif
error_handler  (HpdfStatus error_no, HpdfStatus detail_no, void *user_data) {
  printf ("ERROR: error_no=%04X, detail_no=%u\n", (TInt)error_no, (TInt)detail_no);
  longjmp(env, 1);
}

CPDFDraw::CPDFDraw(RefString fName):
  m_pageNo(0),
  m_chapterNo(1),
  m_pageNumbers(RefTVec_TInt(new TVec_TInt))
  {
  m_fname = fName;
  m_fname->append(".pdf");
  time (&rawtime);
  m_time = RefString(new string (ctime (&rawtime)));
  m_pdf = HPDF_New (error_handler, NULL);
  m_font = HPDF_GetFont (m_pdf,FONT->c_str(),NULL);
  m_titlePage = HPDF_AddPage(m_pdf);
  m_pageWidth = HPDF_Page_GetWidth (m_titlePage);
  m_pageHeight = HPDF_Page_GetHeight (m_titlePage);
  drawTemplate (m_titlePage);
  drawTitle (m_titlePage);
  m_indexPage = insertPage (m_indexPage);
  drawIndex ();
}

CPDFDraw::~CPDFDraw() {
  HPDF_SaveToFile (m_pdf, m_fname->c_str());
  HPDF_Free (m_pdf);
}


void CPDFDraw::drawHeader(HpdfPage page, HpdfFont font, TInt size) {
  if(page == NULL) { page = m_page; }
  if(font == NULL) { font = m_font; }
  drawData (COMPANY_NAME, H_L_POS, m_pageHeight - H_L_POS, page, font, size);
  drawData (m_time, m_pageWidth-H_R_W_POS, m_pageHeight - H_L_POS, page, font, size);
}

void CPDFDraw::drawFooter(HpdfPage page, HpdfFont font, TInt size) {
  if(page == NULL) { page = m_page; }
  if(font == NULL) { font = m_font; }
  drawData(COPYRIGHT, m_pageWidth/TWO - F_W_POS, F_H_POS, page, font, size);
}

void CPDFDraw::drawTemplate(HpdfPage page) {
  if(page == NULL) { page = m_page; }
  drawHeader (page);
  drawCell (X_L_BORDER, Y_L_BORDER, m_pageWidth - X_R_BORDER, m_pageHeight - Y_R_BORDER, page);
  drawFooter (page);
}

void CPDFDraw::drawTitle(HpdfPage page, HpdfFont font, TInt size) {
  if(page == NULL) { page = m_page; }
  if(font == NULL) { font = m_font; }
  drawData (DOC_TITLE, m_pageWidth/TWO - T_W_POS , m_pageHeight/TWO + T_H_POS, page, font, size);
}

HpdfPage CPDFDraw::insertPage(HpdfPage page) {
  if(page == NULL) { page = m_page; }
  page = HPDF_AddPage(m_pdf);
  ++m_pageNo;
  m_pageNumbers->push_back(m_pageNo);
  drawTemplate (page);
  drawData (m_pageNo, m_pageWidth/TWO, PAGE_NO_POS, page, m_font, STRING_FONT_SIZE);
  return page;
}

void CPDFDraw::drawChapter(RefString label, HpdfPage page, HpdfFont font, TInt size) {
  if(page == NULL) { page = m_page; }
  if(font == NULL) { font = m_font; }
  insertPage ();
  drawData (CHAPTER, C_W_C, m_pageHeight/TWO + C_H);
  drawData (m_chapterNo, C_W_N, m_pageHeight/TWO + C_H);
  drawData (DOTS, C_W_D, m_pageHeight/TWO + C_H);
  drawData (label, C_W_L, m_pageHeight/TWO + C_H);
  ++m_chapterNo;
}


void CPDFDraw::drawData(RefString label, TDouble x, TDouble y, HpdfPage page, HpdfFont font, TInt size) {
  // display string
  if(page == NULL) { page = m_page; }
  if(font == NULL) { font = m_font; }
  HPDF_Page_SetFontAndSize (page, font, size);
  HPDF_Page_BeginText (page);
  HPDF_Page_MoveTextPos (page, x, y);
  HPDF_Page_ShowText (page, label->c_str());
  HPDF_Page_EndText (page);
}


void CPDFDraw::drawData(TInt label, TDouble x, TDouble y, HpdfPage page, HpdfFont font, TInt size) {
  // display string
  if(page == NULL) { page = m_page; }
  if(font == NULL) { font = m_font; }
  
  HPDF_Page_SetFontAndSize (page, font, size);
  HPDF_Page_BeginText (page);
  HPDF_Page_MoveTextPos (page, x, y);
  HPDF_Page_ShowText (page, ltos(label)->c_str());
  HPDF_Page_EndText (page);
}

void CPDFDraw::drawLine(TDouble x, TDouble y, TDouble w, HpdfPage page, TDouble lineWidth, TInt numPattern, TInt phase) {
  if(page == NULL) { page = m_page; }
  HPDF_Page_SetLineWidth (page, lineWidth);
  HPDF_Page_SetDash (page, DASH_MODE1, numPattern, phase);
  HPDF_Page_MoveTo(page, x, y );
  HPDF_Page_LineTo(page, x + w, y);
  HPDF_Page_Stroke(page);
}


void CPDFDraw::drawCell(TDouble x, TDouble y, TDouble m_cellWidth, TDouble m_cellHeight, HpdfPage page, RefString label, TDouble m_lineWidth) {
  if(page == NULL) { page = m_page; }
  HPDF_Page_GSave (page);
  HPDF_Page_SetLineWidth (page, m_lineWidth);
  HPDF_Page_Rectangle (page, x, y, m_cellWidth, m_cellHeight);
  HPDF_Page_Stroke (page);
  drawData (label, x, y, page, m_font, STRING_FONT_SIZE);
}


void CPDFDraw::drawIndex(RefString label, HpdfPage page) {
  if(page == NULL) { page = m_indexPage; }
  drawData (label, m_pageWidth/TWO - I_W_POS, m_pageHeight - I_H_POS, page, m_font, CHAPTER_FONT_SIZE);
  drawIndexContent(INDEX, IC_W_D, IC_H_D, page);
}

void CPDFDraw::drawIndexContent (RefString label, TDouble x, TDouble y, HpdfPage page) {
  drawData (label, x, m_pageHeight - y, page, m_font, STRING_FONT_SIZE);
  drawLine (IC_W_L, m_pageHeight - y, IC_L, m_indexPage);
  drawData (m_pageNo, IC_PN, m_pageHeight - y, page, m_font,STRING_FONT_SIZE);
  makeLink(IC_W_D, IC_H_D, m_indexPage, 200);
}

void CPDFDraw::makeLink(TDouble x, TDouble y, HpdfPage page, TDouble pos) {
  HpdfAnnotation annot;
  HpdfRect rect;
  HpdfPoint tp;
  HpdfDestination dst;
  HpdfStatus sts;
  rect.left = x;
  rect.bottom = m_pageHeight - y;
  rect.right = x + L_R;
  rect.top = m_pageHeight - y + L_T;
  m_page = insertPage();
  dst = HPDF_Page_CreateDestination (m_page);
  sts = HPDF_Destination_SetFitH (dst, pos);
  annot = HPDF_Page_CreateLinkAnnot (page, rect, dst);
  HPDF_LinkAnnot_SetBorderStyle (annot, 0, 0, 0);
}


HpdfPage CPDFDraw::getCurrentPage() {
  return m_page;
}

HpdfFont CPDFDraw::getCurrentFont() {
  return m_font;                     
}

}//namespace NSCPDFDraw
