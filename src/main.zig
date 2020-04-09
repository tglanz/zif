const std = @import("std");
const c = @import("c.zig");

pub fn main() void {

    var vec2 = c.rl.Vector2 {
        .x = 3,
        .y = 4,
    };

    vec2.x = 4;

    std.debug.warn("{}\n", .{vec2});
}
