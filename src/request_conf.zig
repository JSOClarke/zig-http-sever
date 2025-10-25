const std = @import("std");
const Connection = @import("std").net.Server.Connection;
const Map = @import("std").static_string_map.StaticStringMap;

// This is going read the contents of the conn into the buffer
pub fn read_request(buff: []u8, conn: Connection) !void {
    _ = try conn.stream.read(buff);
    // maybe we create some sort condition for the buffer stop when it arrives at the first newline char

}
// Returns the request struct with the top level information
pub fn parse_request_top_level_header(buff: []const u8) !Request {
    // stop at the newline character
    // std.debug.print("starting string, {any}\n", .{buff});

    if (std.mem.indexOfScalar(u8, buff, '\n')) |end_of_line| {
        const firstLine = std.mem.trim(u8, buff[0..end_of_line], "\r");
        // std.debug.print("\n{s} \n", .{firstLine});

        var iterator = std.mem.splitScalar(u8, firstLine, ' ');
        // std.debug.print("iterator,{any}", .{iterator.});
        // The init will check so see if the parsed method is valid if not it will throw erorr.
        const method = try Method.init(iterator.next().?);
        const endpoint = iterator.next().?;
        const html_v = iterator.next().?;

        return Request{ .method = method, .endpoint = endpoint, .html_v = html_v };
    }

    // now that we have a buffer for the line of data we then need to grab split that by ' '

    return error.ScalarNotFound;
}

test "test parse_request" {
    const buffer = "GET /path HTTP/1.1\r\nHost: example.com\r\n";

    const result = try parse_request_top_level_header(buffer);
    const expected = Request{ .method = Method.GET, .endpoint = "/path", .html_v = "HTTP/1.1" };
    // std.debug.print("\n Result, {any} \n", .{result});
    try std.testing.expectEqual(expected.method, result.method);
    try std.testing.expectEqualSlices(u8, expected.html_v, result.html_v);
    try std.testing.expectEqualSlices(u8, expected.endpoint, result.endpoint);

    // std.debug.print("\nExpected, {any}\n", .{expected});
}

// test "test parse_request - FAILURE" {
//     const buffer = "POSTs /path HTTP/1.1\r\nHost: example.com\r\n";

//     const result = try parse_request_top_level_header(buffer);
//     const expected = Request{ .method = Method.GET, .endpoint = "/path", .html_v = "HTTP/1.1" };
//     // std.debug.print("\n Result, {any} \n", .{result});
//     try std.testing.expectEqual(expected.method, result.method);
//     try std.testing.expectEqualSlices(u8, expected.html_v, result.html_v);
//     try std.testing.expectEqualSlices(u8, expected.endpoint, result.endpoint);

//     // std.debug.print("\nExpected, {any}\n", .{expected});
// }

// parse the read buffer get the first line for our use caes

const Request = struct {
    method: Method,
    endpoint: []const u8,
    html_v: []const u8,
    pub fn init(method: Method, endpoint: []const u8, html_v: []const u8) !void {
        return Request{ .method = method, .endpoint = endpoint, .html_v = html_v };
    }
};

const MethodMap = Map(Method).initComptime(.{.{ "GET", Method.GET }});

pub const Method = enum {
    GET,
    pub fn init(queried_method: []const u8) !Method {
        return MethodMap.get(queried_method) orelse error.MethodNotValid;
    }
    pub fn is_supported(q_method: []const u8) bool {
        return MethodMap.has(q_method);
    }
};

test "test Method enum" {
    const result = Method.is_supported("GET");
    try std.testing.expectEqual(true, result);
}

test "test Method Init - Success" {
    const result = try Method.init("GET");

    std.debug.print("Result, {}", .{result});
    try std.testing.expectEqual(Method.GET, result);
    // try std.testing.expectError(error.MethodNotValid, Method.init("POST"));
}

test "test Method Init - Failure" {
    // const result = Method.init("GET");
    try std.testing.expectError(error.MethodNotValid, Method.init("POST"));
}
