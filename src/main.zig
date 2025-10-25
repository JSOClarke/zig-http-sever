const std = @import("std");
const http_server = @import("http_server.zig");
const req = @import("request_conf.zig");

pub fn main() !void {
    const socket = try http_server.Socket.init();
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);

    const stdout = &stdout_writer.interface;

    try stdout.print("Server address, {any}\n", .{socket._address.getPort()});
    try stdout.flush();

    var server = try socket._address.listen(.{});

    const connection = try server.accept();
    defer connection.stream.close();

    var buffer: [1024]u8 = undefined;
    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }
    // Ok so we are going to need to loop to accept the incomming connections each of the clients
    // will open up a new socket that will handle/manage that connection.

    _ = try req.read_request(buffer[0..buffer.len], connection);
    const top_level = try req.parse_request_top_level_header(&buffer);
    try stdout.print("Top level,{any}", .{top_level});
    try stdout.flush();
}
