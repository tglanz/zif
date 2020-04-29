#include "compatibility-raylib.h"

void ZifDrawTextureRec(Texture2D texture, Rectangle sourceRec, int posX, int posY, Color tint) {
    Vector2 pos = { posX, posY };
    DrawTextureRec(texture, sourceRec, pos, tint);
}
