#include "raylib-compatibility.h" 

RLAPI void ZifDrawTexture(
        Texture2D texture, 
        int srcRectX, int srcRectY, int srcRectWidth, int srcRectHeight,
        int dstX, int dstY,
        Color tint) {
    Rectangle srcRect = { srcRectX, srcRectY, srcRectWidth, srcRectHeight};
    Vector2 position = { dstX, dstY };
    DrawTextureRec(texture, srcRect, position, tint);
}
