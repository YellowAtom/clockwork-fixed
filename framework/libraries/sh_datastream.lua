
local Clockwork = Clockwork
local net = net
local pairs = pairs
local type = type
local util = util

Clockwork.datastream = Clockwork.kernel:NewLibrary("Datastream")
Clockwork.datastream.stored = Clockwork.datastream.stored or {}

--[[
	@codebase Shared
	@details A function to hook a data stream.
	@param {String} A unique identifier.
	@param {Function} The datastream callback.
--]]
function Clockwork.datastream:Hook(name, Callback)
	self.stored[name] = Callback
end

if SERVER then
	util.AddNetworkString("cwDataDS")

	--[[
		@codebase Shared
		@details A function to start a data stream.
		@param {Unknown} Missing description for player.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for data.
		@returns {Unknown}
	--]]
	function Clockwork.datastream:Start(player, name, data)
		local recipients = {}
		local bShouldSend = false

		if type(player) ~= "table" then
			if not player then
				player = cwPlayer.GetAll()
			else
				player = {player}
			end
		end

		for k, v in pairs(player) do
			if type(v) == "Player" then
				recipients[#recipients + 1] = v
				bShouldSend = true
			elseif type(k) == "Player" then
				recipients[#recipients + 1] = k
				bShouldSend = true
			end
		end

		if data == nil then
			data = 0
		end

		local dataTable = {
			data = data
		}

		local encodedData = Clockwork.kernel:Serialize(dataTable)

		if encodedData and #encodedData > 0 and bShouldSend then
			net.Start("cwDataDS")
			net.WriteString(name)
			net.WriteUInt(#encodedData, 32)
			net.WriteData(encodedData, #encodedData)
			net.Send(recipients)
		end
	end

	--[[
		@codebase Shared
		@details A function to listen for a request.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for Callback.
		@returns {Unknown}
	--]]
	function Clockwork.datastream:Listen(name, Callback)
		self:Hook(name, function(player, data)
			local bShouldReply, reply = Callback(player, data)

			if bShouldReply then
				self:Start(player, name, reply)
			end
		end)
	end

	net.Receive("cwDataDS", function(length, player)
		local CW_DS_NAME = net.ReadString()
		local CW_DS_LENGTH = net.ReadUInt(32)
		local CW_DS_DATA = net.ReadData(CW_DS_LENGTH)

		if CW_DS_NAME and CW_DS_DATA and CW_DS_LENGTH then
			player.cwDataStreamName = CW_DS_NAME
			player.cwDataStreamData = ""

			if player.cwDataStreamName and player.cwDataStreamData then
				player.cwDataStreamData = CW_DS_DATA

				if Clockwork.datastream.stored[player.cwDataStreamName] then
					local wasSuccess, value = xpcall(Clockwork.kernel.Deserialize, debug.traceback, Clockwork.kernel, player.cwDataStreamData)

					if wasSuccess then
						Clockwork.datastream.stored[player.cwDataStreamName](player, value.data)
					elseif value ~= nil then
						MsgC(Color(255, 100, 0, 255), "[Clockwork:Datastream] The '" .. CW_DS_NAME .. "' datastream has failed to run.\n" .. value .. "\nData: " .. tostring(player.cwDataStreamData) .. "\n")
					end
				end

				player.cwDataStreamName = nil
				player.cwDataStreamData = nil
			end
		end

		CW_DS_NAME, CW_DS_DATA, CW_DS_LENGTH = nil, nil, nil
	end)
else
	--[[
		@codebase Shared
		@details A function to start a data stream.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for data.
		@returns {Unknown}
	--]]
	function Clockwork.datastream:Start(name, data)
		if data == nil then
			data = 0
		end

		local dataTable = {
			data = data
		}

		local encodedData = Clockwork.kernel:Serialize(dataTable)

		if encodedData and #encodedData > 0 then
			net.Start("cwDataDS")
			net.WriteString(name)
			net.WriteUInt(#encodedData, 32)
			net.WriteData(encodedData, #encodedData)
			net.SendToServer()
		end
	end

	--[[
		@codebase Shared
		@details A function to send a request.
		@param {Unknown} Missing description for name.
		@param {Unknown} Missing description for data.
		@param {Unknown} Missing description for Callback.
		@returns {Unknown}
	--]]
	function Clockwork.datastream:Request(name, data, Callback)
		self:Hook(name, Callback)
		self:Start(name, data)
	end

	net.Receive("cwDataDS", function(length)
		local CW_DS_NAME = net.ReadString()
		local CW_DS_LENGTH = net.ReadUInt(32)
		local CW_DS_DATA = net.ReadData(CW_DS_LENGTH)

		if (CW_DS_NAME and CW_DS_DATA and CW_DS_LENGTH) and Clockwork.datastream.stored[CW_DS_NAME] then
			local wasSuccess, value = xpcall(Clockwork.kernel.Deserialize, debug.traceback, Clockwork.kernel, CW_DS_DATA)

			if wasSuccess then
				Clockwork.datastream.stored[CW_DS_NAME](value.data)
			elseif value ~= nil then
				MsgC(Color(255, 100, 0, 255), "[Clockwork:Datastream] The '" .. CW_DS_NAME .. "' datastream has failed to run.\n" .. value .. "\nData: " .. tostring(CW_DS_DATA) .. "\n")
			end
		end

		CW_DS_NAME, CW_DS_DATA, CW_DS_LENGTH = nil, nil, nil
	end)
end
