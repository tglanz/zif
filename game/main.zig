const std = @import("std");
const rl = @import("raylib.zig");
const compatibility = @import("compatibility.zig");
const Timer = std.time.Timer;
const Vec2 = @import("vectors.zig").Vec2;


const debug = std.debug;
const SpriteSheet = @import("sprites.zig").SpriteSheet;
const Sprite = @import("sprites.zig").Sprite;
const Animation = @import("animations.zig").Animation;

const WindowConfig = struct {
    width: u32,
    height: u32,
    color: u32,
    title: []const u8,

    const Default = WindowConfig {
        .width = 800,
        .height = 600,
        .color = 0xf3f3f3,
        .title = "zif",
    };
};

var digits_ss = SpriteSheet.create("resources/spritesheets/digits.png", &init: {
    var ans: [10]Sprite = undefined;
    const cols = 3;
    for (ans) |*sprite, idx| {
        const col = idx % cols;
        const row = idx / cols;
        sprite.* = Sprite.create(col * 32, row * 32, 32, 32);
    }
    break :init ans;
});

var digits_animation =  Animation.create(&init: {
    var frames: [10]Animation.Frame = undefined;
    for (frames) |*frame, i| {
        frame.*.key = i;
        frame.*.duration_ms = 1000;
    }
    break :init frames;
});

fn rgbaToColor(value: u32) rl.Color {
    return rl.Color {
        .r = @intCast(u8, (value >> 24) & 0xff),
        .g = @intCast(u8, (value >> 16) & 0xff),
        .b = @intCast(u8, (value >> 8 ) & 0xff),
        .a = @intCast(u8, (value >> 0 ) & 0xff), 
    };
}

pub fn main() void {

    const window_config = WindowConfig.Default;
    rl.InitWindow(window_config.width, window_config.height, window_config.title.ptr);
    defer rl.CloseWindow();

    var ss = digits_ss;
    var animation = digits_animation;

    ss.load_to_memory() catch |err| {
        debug.warn("failed to load digits spritesheet to memory: {}", .{@errorName(err)});
        return;
    };

    defer ss.unload_from_memory();

    const back_color = rgbaToColor(window_config.color);
    const tint_color = rgbaToColor(0xffffffff);

    const dst = Vec2(i32).create(20, 20);
    var timer = Timer.start() catch |err| @panic("failed to initialize timer");

    while (rl.WindowShouldClose() == .@"false") {
        
        const dt = timer.lap() / std.time.millisecond;

        const sprite_index = animation.update(dt).key;
        const sprite = ss.sprites[sprite_index];

        const src_rect = rl.Rectangle {
            .x = sprite.position.getX(),
            .y = sprite.position.getY(),
            .width = sprite.size.getWidth(),
            .height = sprite.size.getHeight(),
        };

        rl.BeginDrawing();
        rl.ClearBackground(back_color);

        rl.ZifDrawTextureRec(ss.texture.?, src_rect, dst.getX(), dst.getY(), tint_color);

        rl.EndDrawing();
        std.time.sleep(5 * std.time.millisecond);
    }
}

