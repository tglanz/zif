const debug = @import("std").debug;
const builtin = @import("builtin");

const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    
    var exe = b.addExecutable("zif", "src/main.zig");

    exe.setBuildMode(mode);

    switch (std.Target.current.os.tag) {
        .linux => specificsForLinux(exe),
        .windows => specificsForWindows(exe),
        else => {},
    }

    linkWithRaylib(exe);

    const run = exe.run();
    run.step.dependOn(b.getInstallStep());

    const exec_step = b.step("exec", "execute");
    exec_step.dependOn(&run.step);
}

fn specificsForWindows(step: *LibExeObjStep) void {
    // TODO: copy dll to bin dir
}

fn specificsForLinux(step: *LibExeObjStep) void {
    // support dynamic loading of shared objects
    step.linkSystemLibrary("dl");

    // not needed
    // step.linkSystemLibrary("c");
}

fn linkWithRaylib(step: *LibExeObjStep) void {
    // lets link with raylib at external/raylib
    // it will probably be wiser to link with system's libraries - 
    // but for now, it's a good learning experience

    // TODO: raylib location from environment variables / arguments ?

    // addLibPath adds to libs_paths which each correspond to -L
    // SEE: https://github.com/ziglang/zig/blob/master/lib/std/build.zig#L2075
    step.addLibPath("external/raylib/lib");
    step.linkSystemLibrary("raylib");

    // addIncludeDir adds to include_dirs which each correspond to -I
    // SEE: https://github.com/ziglang/zig/blob/master/lib/std/build.zig#L2057
    step.addIncludeDir("external/raylib/include");
}
