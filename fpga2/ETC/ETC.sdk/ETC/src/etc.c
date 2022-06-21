#include "etc.h"

etc reg_etc;

void initEtcFieldOffset() {
	reg_etc.speed.offset = 0;
	reg_etc.done.offset = 14;
};
void initEtcFieldMask(){
	reg_etc.speed.mask = 0x00003fff;
	reg_etc.done.mask = 0x00004000;
};

void initEtcegister(){
	initEtcFieldOffset();
	initEtcFieldMask();
}
