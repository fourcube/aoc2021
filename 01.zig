const std = @import("std");
const data = @import("./lib/data.zig");
const output = @import("./lib/output.zig");


pub fn main() !void {
    try output.printBanner("AoC 01");

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const lines = try data.readLines(u32, &arena.allocator, "01.dat");
    defer lines.deinit();

    var last = lines.items[0];
    var increased: u32 = 0;
    for (lines.items[1..]) |item| {
        if (item > last) {
            increased+=1;
        }
        last = item;
    }

    std.debug.print("Increased: {d}\n", .{increased});

    var index: u32 = 0;
    increased = 0;
    while (index < lines.items.len - 3) {
        const windowA = try sumSlice(lines.items[index..index+3]);
        const windowB = try sumSlice(lines.items[(index+1)..(index+4)]);
        
        if (windowB > windowA) {
            increased+=1;
        }

        index+=1;
    }

     std.debug.print("Increased windows: {d}\n", .{increased});
}

fn sumSlice(slice: []u32) !u64 {
    var sum: u64 = 0;
    for(slice) |item| {
        sum += item;
    }
    return sum;
}


    // const io = std.io;
    // var file = try std.fs.cwd().openFile("01_01.dat", .{});
    // defer file.close();
    // var buf_reader = io.bufferedReader(file.reader());
    // var in_stream = buf_reader.reader();
    // const data = std.ArrayList([]u8);
    // var buf: [1024]u8 = undefined;
    // while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
    //     std.debug.print("{s}\n", .{line});
    //     data.append(line.ptr);
    // }

    // std.debug.print("{*}\n", .{data});