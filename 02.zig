const std = @import("std");
const data = @import("./lib/data.zig");
const output = @import("./lib/output.zig");

pub fn main() !void {
    try output.printBanner("AoC 02");

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const lines = try data.readLines([]u8, &arena.allocator, "02.dat");
    defer lines.deinit();

    var horizontalPosition: i32 = 0;
    var depth: i32 = 0;
    var aim: i32 = 0;

    for (lines.items) |line| {
        if (isOp("forward", line)) {
            const forwardValue = try std.fmt.parseInt(u16, line[8..], 10);
            horizontalPosition += forwardValue;
            depth += aim * forwardValue;
        } else if (isOp("down", line)) {
            aim += try std.fmt.parseInt(u16, line[5..], 10);
        } else if (isOp("up", line)) {
            aim -= try std.fmt.parseInt(u16, line[3..], 10);
        }
    }

    std.debug.print("x: {d} y: {d} - solution: {d}\n", .{ horizontalPosition, depth, horizontalPosition * depth });
}

fn isOp(operation: []const u8, haystack: []const u8) bool {
    return std.mem.startsWith(u8, haystack, operation);
}

test "isOp finds a prefix" {
    try std.testing.expect(isOp("forward", "forward 100"));
}

test "isOp rejects a prefix" {
    try std.testing.expect(!isOp("forward", "down 100"));
}
