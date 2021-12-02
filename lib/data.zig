const std = @import("std");

pub fn readLines(comptime valueType: type, allocator: *std.mem.Allocator, filename: []const u8) !std.ArrayList(valueType) {
    var file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var data = std.ArrayList(valueType).init(allocator);

    while (try in_stream.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |line| {
        if (comptime isIntegerType(valueType)) {
            const item = try std.fmt.parseInt(valueType, line, 10);
            try data.append(item);
        } else {
            try data.append(line);            
        }
    }
    return data;
}

fn isIntegerType(comptime T: type) bool {
    return T == u8 or T == u16 or T == u32 or T == u64 or T == u128;        
}