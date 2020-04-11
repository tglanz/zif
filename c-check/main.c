#include <stdio.h>
#include <raylib.h>

int main(int argc, const char** argv) {
    InitWindow(800, 600, "zif");
    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(LIGHTGRAY);
        EndDrawing();
    }

    CloseWindow();

    return 0;
 }
