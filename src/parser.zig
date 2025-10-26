const std = @import("std");

pub const Headers = struct {
    _header_map: std.StringHashMap([]const u8),
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, req_buff: []const u8) !Headers {
        // // logic for the parser
        // self.allocator = allocator; // The allocator that the struct is dealing with is a pointer from whatis passed it form it.
        // self._header_map = std.StringHashMap([]const u8).init(allocator);
        var header_map = std.StringHashMap([]const u8).init(allocator);
        try parser_buffer(req_buff, &header_map);
        return Headers{ ._header_map = header_map, .allocator = allocator };
    }
    /// Returns the value pair of the provided key.
    pub fn get(self: Headers, key: []const u8) ![]const u8 {
        return self._header_map.get(key) orelse error.NoHeaderValueFound;
    }
    pub fn deinit(self: *Headers) void {
        self._header_map.deinit();
    }
};

test "test Headers.init - success" {
    const allocator = std.testing.allocator;
    const req_buffer = "Host: localhost:3490\r\nAccept-Encoding: gzip, deflate\r\nAccept: */*\r\nConnection: keep-alive\r\nUser-Agent: HTTPie/3.2.4\r\n";

    var header = try Headers.init(allocator, req_buffer);

    header.deinit();
}

test "test fire - get" {
    const allocator = std.testing.allocator;
    const req_buffer = "Host: localhost:3490\r\nAccept-Encoding: gzip, deflate\r\nAccept: */*\r\nConnection: keep-alive\r\nUser-Agent: HTTPie/3.2.4\r\n";

    var header = try Headers.init(allocator, req_buffer);
    defer header.deinit();

    const result = try header.get("Host");
    const expected = "localhost:3490";

    try std.testing.expectEqualStrings(expected, result);
}

pub fn parser_buffer(buffer: []const u8, map: *std.StringHashMap([]const u8)) !void {
    var newl_iterator = std.mem.splitSequence(u8, buffer, "\r\n");
    while (true) {
        const maybe_line_field = newl_iterator.next();
        if (maybe_line_field == null) {
            break;
        }
        var split_iterator = std.mem.splitSequence(u8, maybe_line_field.?, ": ");
        while (true) {
            const key = split_iterator.next();
            if (key == null) {
                break;
            }
            const value = split_iterator.next();
            if (value == null) {
                break;
            }
            // const value = iterator.next().?;
            try map.put(key.?, value.?);
            // std.debug.print("k", .{});
            std.debug.print("key : {s}, value : {s}\n", .{ key.?, value.? });
        }
    }
}

test "test parser buffer" {
    const header = "Host: localhost:3490\r\nAccept-Encoding: gzip, deflate\r\nAccept: */*\r\nConnection: keep-alive\r\nUser-Agent: HTTPie/3.2.4\r\n";
    const allocator = std.testing.allocator;

    var map = std.StringHashMap([]const u8).init(allocator);
    defer map.deinit();
    try parser_buffer(header, &map);
}

test "test hashmap creation" {
    const allocator = std.testing.allocator;

    var map = std.StringHashMap([]const u8).init(allocator);
    defer map.deinit();

    try map.put("jordan", "clarke");
    const result = map.get("jordan").?;
    std.debug.print("result {s}", .{result});
}
