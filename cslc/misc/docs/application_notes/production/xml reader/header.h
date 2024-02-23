#ifndef __HEADER_xxx123xxx

#define __HEADER_xxx123xxx

#include <iostream>
#include <fstream>
#include <vector>
#include <exception>

class my_exception : public std::exception {
  private:
    const char *m_mesg;
  public:
    my_exception(const char *mesg) throw() : m_mesg(mesg) {}
    const char* what() const throw() { return m_mesg; }
};

typedef enum {
//values from 1st tabel
  VALUE_11 = 0,
  VALUE_12 = 1,
  VALUE_13 = 2,
  VALUE_14 = 3,
  VALUE_15 = 4,
  VALUE_16 = 5
} Tab1;
typedef enum {
//values from 2nd tabel
  VALUE_21 = 6,
  VALUE_22 = 7,
  VALUE_23 = 8,
  VALUE_24 = 9,
  VALUE_25 = 10,
  VALUE_26 = 11,
  VALUE_27 = 12
} Tab2;
typedef enum {
//values from 3rd tabel
  VALUE_31 = 13,
  VALUE_32 = 14,
  VALUE_33 = 15,
  VALUE_34 = 16,
  VALUE_35 = 17,
  VALUE_36 = 18,
  VALUE_37 = 19,
  VALUE_38 = 20,
  VALUE_39 = 21,
  VALUE_310 = 22,
  VALUE_311 = 23,
  VALUE_312 = 24,
  VALUE_313 = 25,
  VALUE_314 = 26,
  VALUE_315 = 27,
  VALUE_316 = 28,
  VALUE_317 = 29,
  VALUE_318 = 30,
  VALUE_319 = 31,
  VALUE_320 = 32,
  VALUE_321 = 33,
  VALUE_322 = 34,
  VALUE_323 = 35,
  VALUE_324 = 36,
  VALUE_325 = 70,
  VALUE_326 = 38,
  VALUE_327 = 39,
  VALUE_328 = 40,
  VALUE_329 = 41,
  VALUE_330 = 42,
  VALUE_331 = 43,
  VALUE_332 = 44,
  VALUE_333 = 45,
  VALUE_334 = 46,
  VALUE_335 = 47,
  VALUE_336 = 48,
  VALUE_337 = 49,
  VALUE_338 = 50,
  VALUE_339 = 51,
  VALUE_340 = 52,
  VALUE_341 = 53,
  VALUE_342 = 54,
  VALUE_343 = 55,
  VALUE_344 = 56,
  VALUE_345 = 57,
  VALUE_346 = 58,
  VALUE_347 = 59,
  VALUE_348 = 60,
  VALUE_349 = 61,
  VALUE_350 = 62,
  VALUE_351 = 63,
  VALUE_352 = 64,
  VALUE_353 = 65,
  VALUE_354 = 66,
  VALUE_355 = 67,
  VALUE_356 = 68,
  VALUE_357 = 69,
  VALUE_358 = 70,
  VALUE_359 = 71,
  VALUE_360 = 72,
  VALUE_361 = 73,
  VALUE_362 = 74,
  VALUE_363 = 75,
  VALUE_364 = 76,
  VALUE_365 = 77,
  VALUE_366 = 78,
  VALUE_367 = 79,
  VALUE_368 = 80,
  VALUE_369 = 81,
  VALUE_370 = 82,
  VALUE_371 = 83,
  VALUE_372 = 84,
  VALUE_373 = 85,
  VALUE_374 = 86,
  VALUE_375 = 87,
  VALUE_376 = 88,
  VALUE_377 = 89,
  VALUE_378 = 90,
  VALUE_379 = 91,
  VALUE_380 = 92,
  VALUE_381 = 93
} Tab3;

std::istream& operator>>(std::istream& in, Evalue &value);
std::ostream& operator<<(std::ostream &out, const Evalue &value);
std::vector<std::string> readEnumStrings(const char *fileName);

#endif
