local skynet = require "skynet"
local socket = require "skynet.socket"
local config={}
local CMD={}
function CMD.open( conf )
	config.port=conf.port
	config.address=conf.address
	
    local fd=socket.listen(config.address,tonumber(config.port))
	socket.start(fd,function ( fd,addr )
		skynet.error(addr,fd,"socket me!")
        local agent=skynet.newservice("useragent")
		skynet.send(agent,"lua","startReceive",{address=addr,fd=fd})
	end)	
end
skynet.start(function (  )
	skynet.dispatch("lua",function ( session,source,cmd,... )
		local f = assert(CMD[cmd])
		skynet.ret(skynet.pack(f(...)))
	end)
end)
