local skynet = require "skynet"
local socket = require "skynet.socket"





local config={}
function CMD.open( conf )
	config.port=conf.port
	config.address=conf.address
	
    local fd=socket.listen(config.address,tonumber(config.port))
	socket.start(fd,function ( fd,addr )
		skynet.error(addr,fd,"socket me!")
        skynet.fork(function (  ){
                local x = socket.readline(id)
				skynet.error(x)
				if not x then 
					print("have closed")
					break
				end
        })
	end)	
end
skynet.start(function (  )
	skynet.dispatch("lua",function ( session,source,cmd,... )
		local f = assert(CMD[cmd])
		skynet.ret(skynet.pack(f(...)))
	end)
end)
