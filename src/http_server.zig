const std = @import("std");
const net = @import("std").net;
// Creating a web framework kida at least

// We will need a socket to connect to it seems that socket connectoin will need an address and stream

pub const Socket = struct {
    _address: std.net.Address,
    _stream: std.net.Stream,

    //We need to provide a host,port which will get turned into a address
    pub fn init() !Socket {
        const host = [4]u8{ 127, 0, 0, 1 };
        const port: u16 = 3490;
        const addr = net.Address.initIp4(host, port);
        // The socket will either really be datagram which is udp or stream which is tcp which is connectionless and connection respectively
        const socket = try std.posix.socket(addr.any.family, std.posix.SOCK.STREAM, std.posix.IPPROTO.TCP);
        const stream = net.Stream{ .handle = socket };
        return Socket{ ._address = addr, ._stream = stream };
    }
};
