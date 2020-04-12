#include "compatibility.h" 

// RLAPI void ZifDrawTextureRec(Texture2D texture,
//                              Rectangle srcRect,
//                              int posX, int posY,
//                              Color tint) {
//     Vector2 position;
//     position.x = posX;
//     position.y = posY;
// 
//     DrawTextureRec(texture, srcRect, position, tint); 
// }

RLAPI void ZifDrawTexture(
        Texture2D texture, 
        int srcRectX, int srcRectY, int srcRectWidth, int srcRectHeight,
        int dstX, int dstY,
        Color tint) {
    Rectangle srcRect;
    srcRect.x = srcRectX;
    srcRect.y = srcRectY;
    srcRect.width = srcRectWidth;
    srcRect.height = srcRectHeight;

    Vector2 position;
    position.x = dstX;
    position.y = dstY;

    DrawTextureRec(texture, srcRect, position, tint);
}
