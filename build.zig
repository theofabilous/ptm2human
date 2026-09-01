const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sources: []const []const u8 = &.{
        "etmv4.c",
        "ptm.c",
        "ptm2human.c",
        "stream.c",
        "etb_format.c",
        "tracer-ptm.c",
        "tracer-etmv4.c",
    };
    const ptm2human_mod = b.createModule(.{
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });
    ptm2human_mod.addCSourceFiles(.{
        .files = sources,
        .flags = &.{ "-Wall", "-Werror", "-g" },
    });
    const exe = b.addExecutable(.{
        .root_module = ptm2human_mod,
        .name = "ptm2human",
    });
    b.installArtifact(exe);
}
