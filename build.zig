// no other way to import these things?
// const {alias1, alias2} = @import("std").build.{Builder, LibExeObjStep};
const debug = @import("std").debug;
const Builder = @import("std").build.Builder;
const LibExeObjStep = @import("std").build.LibExeObjStep;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    
    var exe = b.addExecutable("zif", "src/main.zig");

    exe.setBuildMode(mode);

    link_with_raylib(exe);

    const run = exe.run();
    run.step.dependOn(b.getInstallStep());

    const exec_step = b.step("exec", "execute");
    exec_step.dependOn(&run.step);
}

fn link_with_raylib(step: *LibExeObjStep) void {
    // lets link with raylib at external/raylib
    // it will probably be wiser to link with system's libraries - 
    // but for now, it's a good learning experience

    // TODO: raylib location from environment variables / arguments ?

    // addLibPath adds to libs_paths which each correspond to -L
    // SEE: https://github.com/ziglang/zig/blob/master/lib/std/build.zig#L2075
    step.addLibPath("./external/raylib/lib");
    step.linkSystemLibrary("raylib");

    // addIncludeDir adds to include_dirs which each correspond to -I
    // SEE: https://github.com/ziglang/zig/blob/master/lib/std/build.zig#L2057
    step.addIncludeDir("./external/raylib/include");
}
