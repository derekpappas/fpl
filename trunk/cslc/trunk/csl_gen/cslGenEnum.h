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

#ifndef _CSL_ENUM_CODE_GEN_H_
#define _CSL_ENUM_CODE_GEN_H_

#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <fstream>

using namespace std;

namespace NSCSLinterconnect{
  
class CSLenum : public CSLbase {
    public:
     CSLenum(CSLbase*, string name);
     ~CSLenum();

     bool buildDecl();
     void print();
 };

class CSLenumItem : public CSLbase {

   private:
     int m_value;
    bool m_valueF;

   public:
     CSLenumItem(CSLbase*, string name);
     ~CSLenumItem();

     bool buildDecl();
     void print();
 };
}

#endif //_CSL_INTERCONNECT_GEN_H_




