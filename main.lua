local skynet = require "skynet"


skynet.start(function()
	skynet.error("Server start")
	skynet.newservice("debug_console",8000)
	local gate=skynet.newservice("gate")
	skynet.call(gate,"lua","open",{
		address="0.0.0.0",
		port = 8050,
	})
	skynet.exit()
end)
