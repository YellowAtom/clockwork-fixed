CloudAuthX = CWUtil
CloudAuthX.kernel = {}

CLOUDAUTHX_VERSION = -1

function CloudAuthX.GetVersion()
	return CLOUDAUTHX_VERSION
end

function CloudAuthX.Base64Encode(data)
	return data and util.Base64Encode(data) or ""
end

function CloudAuthX.Base64Decode(data)
	return data and util.Base64Decode(data) or ""
end

function CloudAuthX.External(data)
	MsgC(Color(255, 100, 0, 255), "[Clockwork] CloudAuthX.External is no longer supported.\n")
	debug.Trace()
end

local cwOldRunConsoleCommand = RunConsoleCommand

function RunConsoleCommand(...)
	local arguments = {...}

	if arguments[1] == nil then return end
	cwOldRunConsoleCommand(...)
end
