pub fn Vec2(comptime T: type) type {
    return struct {
        data: [2]T,

        // static

        pub fn create(x: T, y: T) Vec2(T) {
            return .{
                .data = .{x, y}
            };
        }

        // methods

        pub fn map(self: *const Vec2(T), mapper: fn(T) comptime Y) Vec2(Y) {
            return Vec2(Y).create(
                mapper(self.data[0]),
                mapper(self.data[1])
            );
        }

        // X, Y

        pub fn getX(self: *const Vec2(T)) T {
            return self.data[0];
        }

        pub fn getY(self: *const Vec2(T)) T {
            return self.data[1];
        }

        pub fn setX(self: *Vec2(T), value: T) void {
            self.data[0] = value;
        }

        pub fn setY(self: *Vec2(T), value: T) void {
            self.data[1] = value;
        }

        // W, H

        pub fn getWidth(self: *const Vec2(T)) T {
            return self.data[0];
        }

        pub fn getHeight(self: *const Vec2(T)) T {
            return self.data[1];
        }

        pub fn setWidth(self: *Vec2(T), value: T) void {
            self.data[0] = value;
        }

        pub fn setHeight(self: *Vec2(T), value: T) void {
            self.data[1] = value;
        }

        // U, V
        
        pub fn getU(self: *const Vec2(T)) T {
            return self.data[0];
        }

        pub fn getV(self: *const Vec2(T)) T {
            return self.data[1];
        }

        pub fn setU(self: *Vec2(T), value: T) void {
            self.data[0] = value;
        }

        pub fn setV(self: *Vec2(T), value: T) void {
            self.data[1] = value;
        }
    };
}