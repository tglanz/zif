
const builtin = @import("builtin");

const std = @import("std");
const fs = std.fs;
const debug = std.debug;
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

// were downloaded from https://github.com/raysan5/raylib/releases
const raylib_binaries = "C:\\rl\\raylib-3.0.0-Win64-msvc15";

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("zif", "game/main.zig");
    exe.setBuildMode(mode);

    const compatibility_flags =  &[_][]const u8{"-std=c99"};
    exe.addIncludeDir("compatibility/");
    exe.addCSourceFile("compatibility/compatibility-raylib.c", compatibility_flags);

    linkWithRaylib(b, exe);

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}

fn linkWithRaylib(builder: *Builder, step: *LibExeObjStep) void {
    step.addIncludeDir(builder.fmt("{}/include", .{raylib_binaries}));
    step.addLibPath(builder.fmt("{}/lib", .{raylib_binaries}));
    step.linkSystemLibrary("raylib");

    if (std.Target.current.os.tag == .windows) {
        const dll_path = builder.fmt("{}/bin/raylib.dll", .{raylib_binaries});
        builder.installBinFile(dll_path, "raylib.dll");
    }
}