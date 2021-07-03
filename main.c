#include "game.h"
#include "sprite_data.h"
#include "tile_data.h"
#include "level_data.h"

#pragma output REGISTER_SP = 0xD000

typedef struct Enemy
{
	byte x;
	byte y;
	signed char dx;
	signed char dy;
	SPRITE* sprite;
} Enemy;

#define NUM_ENEMIES 10
Enemy Enemies[NUM_ENEMIES];

char CurrentLevel[LEVEL_WIDTH * LEVEL_HEIGHT];
byte PlayerX;
byte PlayerY;

bool IsTileWalkable(byte tileX, byte tileY)
{
	// <<5 = *32 = *LEVEL_WIDTH
	char* p = &CurrentLevel[(tileY << 5) + tileX];
	switch (*p) {
		case ' ':
			return true;

		case '*':
			*p = ' ';
			sp1_PrintAt(tileY, tileX, EmptyColor, (int)EmptyTile);
			bit_beepfx_fastcall(BEEPFX_GRAB_1);
			return true;

		case '#':
			return false;
	}

	return false;
}

bool CheckCanMoveX(byte curX, byte curY, signed char dirX)
{
	byte tileX = (curX + dirX) >> 3;
	byte tileY = curY >> 3;

	if ((curY & 7) == 0) {
		return IsTileWalkable(tileX, tileY);
	} else {
		return IsTileWalkable(tileX, tileY) &&
			   IsTileWalkable(tileX, tileY + 1);
	}
}

bool CheckCanMoveY(byte curX, byte curY, signed char dirY)
{
	byte tileX = curX >> 3;
	byte tileY = (curY + dirY) >> 3;

	if ((curX & 7) == 0) {
		return IsTileWalkable(tileX, tileY);
	} else {
		return IsTileWalkable(tileX,     tileY) &&
			   IsTileWalkable(tileX + 1, tileY);
	}
}

void DrawLevel()
{
	char* p = CurrentLevel;
	for (byte y = 0; y < LEVEL_HEIGHT; y++) {
		for (byte x = 0; x < LEVEL_WIDTH; x++) {
			switch (*p) {
				case ' ':
					sp1_PrintAt(y, x, EmptyColor, (int)EmptyTile);
					break;
				case '#':
					sp1_PrintAt(y, x, WallColor, (int)WallTile);
					break;
				case '*':
					sp1_PrintAt(y, x, DotColor, (int)DotTile);
					break;
				case 'p':
					PlayerX = x << 3;
					PlayerY = y << 3;
					*p = ' ';
					break;
			}
			++p;
		}
	}
}

int main()
{
  	zx_border(INK_BLACK);
 
    InitSprites();

    SPRITE* circle = CreateSprite8x8(circle_data);

    memcpy(CurrentLevel, Level1, sizeof(Level1));
    DrawLevel();

    for (byte i = 0; i < NUM_ENEMIES; i++) {
    	Enemies[i].x = i * 24;
    	Enemies[i].y = 0;
    	Enemies[i].dx = 1;
    	Enemies[i].dy = 1;
    	Enemies[i].sprite = CreateMaskedSprite16x16(enemy_data);
    }

   	for (;;) {
   		__asm
   		halt
   		__endasm;

   		Enemy* p = Enemies;
	    for (byte i = 0; i < NUM_ENEMIES; i++) {
	    	if (p->x == 0)
	    		p->dx = 1;
	    	else if (p->x == (255-16))
	    		p->dx = -1;

	    	if (p->y == 0)
	    		p->dy = 1;
	    	else if (p->y == (192-16))
	    		p->dy = -1;

			p->x += p->dx;
			p->y += p->dy;
			PutSprite(p->x, p->y, p->sprite);

			++p;
	    }

   		if (in_key_pressed(IN_KEY_SCANCODE_q)) {
   			if (CheckCanMoveY(PlayerX, PlayerY, -1))
   				PlayerY--;
   		} else if (in_key_pressed(IN_KEY_SCANCODE_a)) {
   			if (CheckCanMoveY(PlayerX, PlayerY, 8))
   				PlayerY++;
   		}

   		if (in_key_pressed(IN_KEY_SCANCODE_o)) {
   			if (CheckCanMoveX(PlayerX, PlayerY, -1))
   				PlayerX--;
   		} else if (in_key_pressed(IN_KEY_SCANCODE_p)) {
   			if (CheckCanMoveX(PlayerX, PlayerY, 8))
   				PlayerX++;
   		}

   		PutSprite(PlayerX, PlayerY, circle);

	  	sp1_UpdateNow();
	}
}
