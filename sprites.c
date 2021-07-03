#include "game.h"

const struct sp1_Rect FullScreen = {0, 0, 32, 24};

void InitSprites()
{
  	sp1_Initialize(
  		SP1_IFLAG_MAKE_ROTTBL | // генерируем таблицы для попиксельного вывода
  		SP1_IFLAG_OVERWRITE_TILES | // первые 256 тайлов - символы из шрифта ROM
  		SP1_IFLAG_OVERWRITE_DFILE, // стандартный маппинг знакомест на экран
        INK_WHITE | PAPER_BLACK, ' ' // заполняем экран пробелами белый на черном
        );

	// Запрашиваем перерисовку всего экрана
  	sp1_Invalidate(&FullScreen);
}

SPRITE* CreateSprite8x8(const byte* data)
{
  	SPRITE* spr = sp1_CreateSpr(SP1_DRAW_LOAD1LB, SP1_TYPE_1BYTE, 2, (int)(data + 7), 0);
  	sp1_AddColSpr(spr, SP1_DRAW_LOAD1RB, SP1_TYPE_1BYTE, 0, 0);
  	return spr;
}

SPRITE* CreateMaskedSprite16x16(const byte* data)
{
  	SPRITE* spr = sp1_CreateSpr(SP1_DRAW_MASK2LB, SP1_TYPE_2BYTE, 3, (int)(data + 14), 0);
  	sp1_AddColSpr(spr, SP1_DRAW_MASK2, SP1_TYPE_2BYTE, (int)(data + 62), 0);
  	sp1_AddColSpr(spr, SP1_DRAW_MASK2RB, SP1_TYPE_2BYTE, 0, 0);
  	return spr;
}

void PutSprite(byte x, byte y, SPRITE* sprite)
{
	sp1_MoveSprPix(sprite, &FullScreen, 0, x, y);
}
