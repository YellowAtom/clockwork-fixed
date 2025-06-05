local COMMAND = Clockwork.command:New("CharBan")

COMMAND.tip = "CmdCharBan"
COMMAND.text = "CmdCharBanDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1

-- Helper function to perform the actual ban
local function PerformBan(player, target)
	if not IsValid(target) then return end
	
	-- Set the character as banned
	Clockwork.player:SetBanned(target, true)
	
	-- Notify everyone about the ban
	Clockwork.player:NotifyAll({"PlayerBannedPlayer", player:Name(), target:Name()})
	
	-- Kick the player to prevent any issues
	timer.Simple(1, function()
		if IsValid(target) then
			target:Kick("Your character has been banned.")
		end
	end)
end

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(table.concat(arguments, " "))

	if not target then
		Clockwork.player:Notify(player, {"NotValidCharacter", arguments[1]})
		return
	end
	
	-- If player is dead, respawn them first
	if not target:Alive() then
		target:Spawn()
		
		-- Wait for the player to respawn before banning
		timer.Simple(0.5, function()
			if IsValid(target) then
				PerformBan(player, target)
			end
		end)
	else
		-- Player is alive, ban them immediately
		PerformBan(player, target)
	end
end

COMMAND:Register()
