//----------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpathlogic
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

/*
 *   Part of the Csl parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <cerrno>
#include <sstream>
#include "Base.hpp"

using namespace std;

string intToStr(TInt val) {
  stringstream ss;
  ss<<val;
  return ss.str();
}

TInt charToInt(TChar ch) {
  return (TInt)(ch - '0');
}

TInt octStrToInt(const string& str) {
  TInt val = 0;
  TUInt i;

  for (i = 0; i < str.length(); i++)
  {
    val = val * 8 + charToInt(str[i]);
  }

  return val;
}

TInt strToInt(const string& str, TBool& overflow)
{
  TUInt u;
  overflow = TRUE;

  errno = 0;

  u = strtoul(str.c_str(), NULL, 10);

  if( errno == ERANGE )
    return 0;
  /*
     if (u == ULONG_MAX && errno == ERANGE)
     return 0;

     if (u > LONG_MAX)
     return 0;
   */

  overflow = FALSE;
  return (TInt) u;
}

double strToReal(const string& str, TBool& overflow, TBool& underflow) {
  double r;
  overflow = FALSE;
  underflow = FALSE;

  errno = 0;

  r = strtod(str.c_str(), NULL);

  if (errno == ERANGE)
  {
    if (r == (double)(HUGE_VAL))
      overflow = TRUE;
    else if (r == -(double)(HUGE_VAL))
      underflow = TRUE;
  }

  return r;
}

string realToStr(double real)
{
  stringstream ss;
  ss<<real;
  return ss.str();
}

string escapeStr(const string& str)
{
  string res;
  TUInt i;

  for (i = 0; i < str.length(); i++)
  {
    TChar c = str[i];
    if (c == '"')
      res += "\\\"";
    else if (c == '\\')
      res += "\\\\";
    else if (c == '\t')
      res += "\\t";
    else if (c == '\n')
      res += "\\n";
    else if (c < 33 || c > 126)
    {
      stringstream ss;
      ss<< "\\"<<(TInt)c;
      res+=ss.str();
    }
    else
      res += c;
  }

  return res;
}

TBool equal(const string& str1, const string& str2) {
  return !str1.compare(str2) ? TRUE : FALSE;
}

TBool startsWith(const string& str1, const string& str2, TBool ignoreCase)
{
  if (str1.length() >= str2.length())
  {
    TUInt str1Start = 0;//comparation starts from the beginning of str1 
    if (!ignoreCase) {//case sensitive
      return !str1.compare(str1Start, str2.length(), str2) ? TRUE : FALSE;//compare the first str2->length() characters from str1 to str2
    }
    else {//not case sensitive
      string str1Upper(str1);
      transform(str1Upper.begin(), str1Upper.end(), str1Upper.begin(), (int(*)(int))toupper);//transform str1 to upper case

      string str2Upper(str2);
      transform(str2Upper.begin(), str2Upper.end(), str2Upper.begin(), (int(*)(int))toupper);//transform str2 to upper case

      return !str1Upper.compare(str1Start, str2Upper.length(), str2Upper) ? TRUE : FALSE;//compare the first str2Upper->length() characters from str1Upper to str2Upper
    }
  }

  return FALSE;
}

// End of File
