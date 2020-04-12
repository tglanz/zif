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

    const sheet = SpriteSheet.Digits;
    const image = c.rl.LoadImage(sheet.uri.ptr);
    defer debug.warn("unloading image\n", .{});
    defer c.rl.UnloadImage(image);

    const texture = c.rl.LoadTextureFromImage(image);
    defer debug.warn("unloading texture\n", .{});
    defer c.rl.UnloadTexture(texture);

    const tint = rgbaToColor(0xffffffff);

    const offset_x = 0;
    const offset_y = 0;
    const src_width = sheet.sprite_width;
    const src_height = sheet.sprite_height;

    while (!c.rl.WindowShouldClose()) {
        c.rl.BeginDrawing();
        c.rl.ClearBackground(WindowConfig.Default.back_color);


        var col: usize = 0;
        while (col < sheet.cols) : (col += 1) {

            var row: usize = 0;
            while (row < sheet.rows) : (row += 1) {
                
                const src_x = @intCast(c_int, col * src_width);
                const src_y = @intCast(c_int, row * src_height);
 
                const dst_x = offset_x + src_x;
                const dst_y = offset_y + src_y;

                c.rl.ZifDrawTexture(
                    texture,
                    src_x, src_y, src_width, src_height,
                    dst_x, dst_y, 
                    tint);

            }
        }

        c.rl.EndDrawing();
    }
}

