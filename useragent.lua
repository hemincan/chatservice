local skynet = require "skynet"
local socket = require "skynet.socket"
local userInfo={}
local CMD={}


function CMD.startReceive(info)
	userInfo.address=info.address
	userInfo.fd=info.fd
	socket.start(userInfo.fd)
	skynet.fork(function()
		while true do
			local message=socket.readline(userInfo.fd, "\n")
			skynet.error(userInfo.address..":"..message)
		end
	end)
end

skynet.start(function()
   	skynet.dispatch("lua",function (session,source,cmd,...)
		local f=assert(CMD[cmd])
		skynet.pack(f(...))
	end)
end)