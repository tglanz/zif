const std = @import("std");
const rl = @import("raylib.zig");
const compatibility = @import("compatibility.zig");
const Timer = std.time.Timer;


const debug = std.debug;
const SpriteSheet = @import("sprites.zig").SpriteSheet;
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

    var ss = SpriteSheet {
        .uri = "resources/spritesheets/digits.png",
        .total = 10,
        .cols = 3,
        .sprite_width = 32,
        .sprite_height = 32,
        .image = null,
        .texture = null,
    };

    ss.load_to_memory() catch |err| {
        debug.warn("failed to load digits spritesheet to memory: {}", .{@errorName(err)});
        return;
    };

    defer ss.unload_from_memory();

    const back_color = rgbaToColor(window_config.color);
    const tint_color = rgbaToColor(0xffffffff);

    var src_rect = rl.Rectangle {
        .x = 0, .y = 0,
        .width = @intToFloat(f32, ss.sprite_width),
        .height = @intToFloat(f32, ss.sprite_height)
    };

    const dst_x = 20;
    const dst_y = 20;

    const frames = init: {
        var frames: [10]Animation.Frame = undefined;
        for (frames) |*frame, i| {
            frame.*.key = i;
            frame.*.duration_ms = 1000;
        }
        break :init frames;
    };

    var timer = Timer.start() catch |err| @panic("failed to initialize timer");
    var animation = Animation.create(&frames);

    while (rl.WindowShouldClose() == .@"false") {
        
        const dt = timer.lap() / std.time.millisecond;
        const frame = animation.update(dt);
        const sprite_index = frame.key;
        const col = sprite_index % ss.cols;
        const row = sprite_index / ss.cols;
        src_rect.x = @intToFloat(f32, ss.sprite_width * col);
        src_rect.y = @intToFloat(f32, ss.sprite_height * row);

        rl.BeginDrawing();
        rl.ClearBackground(back_color);


        rl.ZifDrawTextureRec(ss.texture.?, src_rect, dst_x, dst_y, tint_color);
    

        rl.EndDrawing();
        std.time.sleep(5 * std.time.millisecond);
    }
}

