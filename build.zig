const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "ld64",
        .target = target,
        .optimize = optimize,
    });
    exe.addSystemIncludePath(.{ .path = "/Users/kubkon/opt/tapi/include" });
    exe.addLibraryPath(.{ .path = "/Users/kubkon/opt/tapi/lib" });
    exe.addRPath(.{ .path = "/Users/kubkon/opt/tapi/lib" });
    exe.linkSystemLibrary("tapi");
    exe.linkSystemLibrary("xar");
    exe.linkLibC();
    exe.linkLibCpp();

    exe.addIncludePath(.{ .cwd_relative = "src/abstraction" });
    exe.addIncludePath(.{ .cwd_relative = "src/ld" });
    exe.addIncludePath(.{ .cwd_relative = "src/ld/code-sign-blobs" });
    exe.addIncludePath(.{ .cwd_relative = "src/ld/parsers" });
    exe.addIncludePath(.{ .cwd_relative = "src/ld/passes" });
    exe.addIncludePath(.{ .cwd_relative = "src/ld/passes/stubs" });
    exe.addSystemIncludePath(.{ .cwd_relative = "src/ext" });
    exe.addCSourceFiles(&c_sources, &.{});
    exe.addCSourceFiles(&cpp_sources, &.{
        "-std=c++11",
        "-Wno-deprecated-declarations",
    });
    b.installArtifact(exe);
}

const c_sources = [_][]const u8{
    "src/ld/debugline.c",
    "src/ld/libcodedirectory.c",
    "src/ld/ld_vers.c",
};

const cpp_sources = [_][]const u8{
    "src/ld/ld.cpp",
    "src/ld/InputFiles.cpp",
    "src/ld/OutputFile.cpp",
    "src/ld/Options.cpp",
    "src/ld/PlatformSupport.cpp",
    "src/ld/Resolver.cpp",
    "src/ld/ResponseFiles.cpp",
    "src/ld/Snapshot.cpp",
    "src/ld/SymbolTable.cpp",

    "src/ld/code-sign-blobs/blob.cpp",

    "src/ld/passes/bitcode_bundle.cpp",
    "src/ld/passes/branch_island.cpp",
    "src/ld/passes/branch_shim.cpp",
    "src/ld/passes/code_dedup.cpp",
    "src/ld/passes/compact_unwind.cpp",
    "src/ld/passes/dtrace_dof.cpp",
    "src/ld/passes/dylibs.cpp",
    "src/ld/passes/inits.cpp",
    "src/ld/passes/got.cpp",
    "src/ld/passes/huge.cpp",
    "src/ld/passes/objc.cpp",
    "src/ld/passes/objc_constants.cpp",
    "src/ld/passes/order.cpp",
    "src/ld/passes/thread_starts.cpp",
    "src/ld/passes/tlvp.cpp",
    "src/ld/passes/stubs/stubs.cpp",

    "src/ld/parsers/archive_file.cpp",
    "src/ld/parsers/generic_dylib_file.cpp",
    "src/ld/parsers/lto_file.cpp",
    "src/ld/parsers/macho_dylib_file.cpp",
    "src/ld/parsers/macho_relocatable_file.cpp",
    "src/ld/parsers/opaque_section_file.cpp",
    "src/ld/parsers/textstub_dylib_file.cpp",
};
