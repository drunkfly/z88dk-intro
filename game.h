#ifndef GAME_H
#define GAME_H

#include <arch/zx.h>
#include <arch/zx/sp1.h>
#include <sound/bit.h>
#include <input.h>
#include <stdbool.h>
#include <string.h>

typedef unsigned char byte;
typedef unsigned short word;
typedef struct sp1_ss SPRITE;

// sprites.c

extern const struct sp1_Rect FullScreen;

void InitSprites();

SPRITE* CreateSprite8x8(const byte* data);
SPRITE* CreateMaskedSprite16x16(const byte* data);

void PutSprite(byte x, byte y, SPRITE* sprite);

#endif
