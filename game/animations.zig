pub const Animation = struct {
    pub const Frame = struct {
        key: usize,
        duration_ms: i32,
    };

    frames: []const Frame,
    remaining_frame_duration_ms: i32,
    current_frame_index: usize,

    pub fn create(frames: []const Frame) Animation {
        const duration = if (frames.len > 0) frames[0].duration_ms else 0;
        return .{
            .frames = frames,
            .current_frame_index = 0,
            .remaining_frame_duration_ms = duration,
        };
    }

    pub fn update(self: *Animation, dt: usize) *const Frame {
        var current_frame = self.frames[self.current_frame_index];
        self.remaining_frame_duration_ms -= @intCast(i32, dt);
        while (self.remaining_frame_duration_ms <= 0) {
            self.current_frame_index += 1;
            self.current_frame_index %= self.frames.len;
            current_frame = self.frames[self.current_frame_index];
            self.remaining_frame_duration_ms += current_frame.duration_ms;
        }
        return &current_frame;
    }
};