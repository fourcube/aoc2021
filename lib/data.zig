const std = @import("std");

pub fn readLines(allocator: *std.mem.Allocator, filename: []const u8) !std.ArrayList(u32) {
    var file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var data = std.ArrayList(u32).init(allocator);

    while (try in_stream.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |line| {
        const item = try std.fmt.parseInt(u32, line, 10);
        try data.append(item);
    }
    return data;
}