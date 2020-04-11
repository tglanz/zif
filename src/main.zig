const std = @import("std");
const c = @import("c.zig");

const debug = std.debug;

fn rgbaToColor(value: u32) c.rl.Color {
    return c.rl.Color {
        .r = @intCast(u8, (value >> 24) & 0xff),
        .g = @intCast(u8, (value >> 16) & 0xff),
        .b = @intCast(u8, (value >> 8 ) & 0xff),
        .a = @intCast(u8, (value >> 0 ) & 0xff), 
    };
}

const WindowConfig = struct {
    width: u32,
    height: u32,
    title: []const u8,
    back_color: c.rl.Color,

    const Default = WindowConfig {
        .width = 800,
        .height = 600,
        .title = "zif",
        .back_color = rgbaToColor(0xff000000),
    };
};

const SpriteSheet = struct {
    uri: []const u8,
    rows: usize,
    cols: usize,
    sprite_width: usize,
    sprite_height: usize,

    const Digits = SpriteSheet {
        .uri = "resources/spritesheets/digits.png",
        .rows = 4,
        .cols = 3,
        .sprite_width = 32,
        .sprite_height = 32,
    };
};

pub fn main() void {
    c.rl.InitWindow(
        WindowConfig.Default.width,
        WindowConfig.Default.height,
        WindowConfig.Default.title.ptr); 
    defer debug.warn("closing window\n", .{});
    defer c.rl.CloseWindow();

    const spritesheet = SpriteSheet.Digits;
    const image = c.rl.LoadImage(spritesheet.uri.ptr);
    defer debug.warn("unloading image\n", .{});
    defer c.rl.UnloadImage(image);

    const texture = c.rl.LoadTextureFromImage(image);
    defer debug.warn("unloading texture\n", .{});
    defer c.rl.UnloadTexture(texture);

    const tint = rgbaToColor(0xffffffff);
    while (!c.rl.WindowShouldClose()) {
        c.rl.BeginDrawing();
        c.rl.ClearBackground(WindowConfig.Default.back_color);

        const position = c.rl.Vector2 {
            .x = 0.0,
            .y = 0.0,
        }; 

        // Not compiling!
        c.rl.DrawTextureV(texture, position, tint);
        // But below will work
        // c.rl.DrawTexture(texture, 0, 0, tint);
 
        c.rl.EndDrawing();
    }
}

//////////// KEEP //////////


// const offset_x = 0;
// const offset_y = 0;
// var col: usize = 0;
// var row: usize = 0;
// while (col < spritesheet.cols) : (col += 1) {
//     while (row < spritesheet.rows) : (row += 1) {
//         
//         const rectangle = c.rl.Rectangle {
//             .x = @intToFloat(f32, col * spritesheet.sprite_width),
//             .y = @intToFloat(f32, row * spritesheet.sprite_height),
//             .width = spritesheet.sprite_width,
//             .height = spritesheet.sprite_height,
//         }; 

//         const position = c.rl.Vector2 {
//             .x = offset_x + rectangle.x, 
//             .y = offset_y + rectangle.y 
//         };

//         // c.rl.DrawTextureRec(texture, rectangle, position, tint); 
//     }
// }


