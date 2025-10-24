const std = @import("std");
const Connection = @import("std").net.Server.Connection;
// This is going read the contents of the conn into the buffer
pub fn read_request(buff: []u8, conn: Connection) !void {
    _ = try conn.stream.read(buff);
}
