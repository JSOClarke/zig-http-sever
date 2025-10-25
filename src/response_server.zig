const std = @import("std");
const Connection = @import("std").net.Server.Connection;

pub fn send200(conn: Connection) !void {
    const message: []const u8 = ("HTTP/1.1 200 Ok\nContent-Length:48" ++ "\nContent-Type: text/html\n" ++ "Connection: Closed\n\n<html><body><h1>Hello ,World!</h1></body></html>");

    try conn.stream.writeAll(message);
}
