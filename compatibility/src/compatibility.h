#ifndef ZIF_COMPATIBILITY
#define ZIF_COMPATIBILITY

#include <raylib.h>

// RLAPI void ZifDrawTextureRec(Texture2D texture,
//                              Rectangle sourceRect,
//                              int posX, int posY,
//                              Color tint);

RLAPI void ZifDrawTexture(Texture2D texture,
                             int srcRectX, int srcRectY, int srcRectWidth, int srcRectHeight,
                             int posX, int posY,
                             Color tint);

#endif
