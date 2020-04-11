const std = @import("std");
const c = @import("c.zig");

const debug = std.debug;

const WindowConfig = struct {
    width: u32,
    height: u32,
    title: []const u8,

    const Default = WindowConfig {
        .width = 800,
        .height = 600,
        .title = "zif",
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
    debug.warn("window config: {}\n", .{WindowConfig.Default});
    debug.warn("sprite sheet: {}\n", .{SpriteSheet.Digits});

    const vec2 = c.rl.Vector2 {
        .x = 4,
        .y = 5,
    };

    debug.warn("vector2: {}\n", .{vec2});

    c.rl.InitWindow(
        WindowConfig.Default.width,
        WindowConfig.Default.height,
        WindowConfig.Default.title.ptr);
}
