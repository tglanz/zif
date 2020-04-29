const rl = @import("raylib.zig");

pub const SpriteSheet = struct {

    const Error = error {
        AlreadyLoaded,
        NotLoaded
    };

    uri: []const u8,
    cols: usize,
    total: usize,
    sprite_width: usize,
    sprite_height: usize,
    image: ?rl.Image,
    texture: ?rl.Texture2D,

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