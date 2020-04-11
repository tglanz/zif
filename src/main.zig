const std = @import("std");
const c = @import("c.zig");

const debug = std.debug;

const WindowConfig = struct {
    width: u32,
    height: u32,
    title: []const u8,
};

const SpriteSheet = struct {
    uri: []const u8,
    rows: usize,
    cols: usize,
    sprite_width: usize,
    sprite_height: usize,
};

pub fn main() void {

    debug.warn("1\n", .{});

    const window_config = WindowConfig {
        .title = "zif",
        .width = 800,
        .height = 600,
    };

    debug.warn("2\n", .{});

    const digits: SpriteSheet = .{
        .uri = "resources/spritesheets/digits.png",
        .rows = 4,
        .cols = 3,
        .sprite_width = 32,
        .sprite_height = 32,
    };

    debug.warn("3\n", .{});

    c.rl.InitWindow(123, 123, "asd");
}
