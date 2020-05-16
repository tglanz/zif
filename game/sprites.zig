const rl = @import("raylib.zig");
const Vec2 = @import("vectors.zig").Vec2;
const math = @import("std").math;

pub const Sprite = struct {
    position: Vec2(f32),
    size: Vec2(f32),

    pub fn create(x: f32, y: f32, width: f32, height: f32) Sprite {
        return .{
            .position = Vec2(f32).create(x, y),
            .size = Vec2(f32).create(width, height),
        };
    }
};

pub const SpriteSheet = struct {

    const Error = error {
        AlreadyLoaded,
        NotLoaded
    };

    uri: []const u8,
    sprites: []const Sprite,

    sprites_bounding_size: Vec2(f32),

    image: ?rl.Image,
    texture: ?rl.Texture2D,

    pub fn create(uri: []const u8, sprites: []const Sprite) SpriteSheet {
        return .{
            .uri = uri,
            .sprites = sprites,
            .sprites_bounding_size = calculateSpriteBoundingSize(sprites, 0, 0),
            .image = null,
            .texture = null,
        };
    }

    pub fn load_to_memory(self: *SpriteSheet) Error!void {
        if (self.image != null or self.texture != null) {
            return Error.AlreadyLoaded;
        }

        self.image = rl.LoadImage(self.uri.ptr);
        self.texture = rl.LoadTextureFromImage(self.image.?);
    }

    pub fn unload_from_memory(self: *SpriteSheet) void {
        // TODO: doesn't seem very idiomatic
        if (self.texture != null) {
            rl.UnloadTexture(self.texture.?);
            self.texture = null;
        }

        // TODO: doesn't seem very idiomatic
        if (self.image != null) {
            rl.UnloadImage(self.image.?);
            self.image = null;
        }
    }
};

fn calculateSpriteBoundingSize(sprites: []const Sprite, minX: f32, minY: f32) Vec2(f32) {
    var ans = Vec2(f32).create(0, 0);
    for (sprites) |sprite| {
        ans.setX(math.max(sprite.size.getX(), ans.getX()));
        ans.setY(math.max(sprite.size.getY(), ans.getY()));
    }

    return ans;
}