#ifndef SRC_HEADER_ETC_H
#define SRC_HEADER_ETC_H

#include "xil_io.h"
#include "define.h"

typedef struct FieldETC {
  u8 offset;  // address
  u32 mask;
  volatile u32 value;
} FieldETC;

typedef struct ETC {
  u32 data;
  FieldETC speed;
  FieldETC done;
} etc;

extern etc reg_etc;
void initEtcFieldOffset();
void initEtcFieldMask();
void initEtcegister();

#endif
