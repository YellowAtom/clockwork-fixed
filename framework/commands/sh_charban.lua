local COMMAND = Clockwork.command:New("CharBan")

COMMAND.tip = "CmdCharBan"
COMMAND.text = "CmdCharBanDesc"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(table.concat(arguments, " "))

	if target then
		if not Clockwork.player:IsProtected(target) then
			-- Fully respawn
			Clockwork.player:LightSpawn(target, true, true, false)
			local pos = target:GetPos() + Vector(0, 0, 8);
			local angles = target:GetAngles();
			local eyeAngles = target:EyeAngles();
			target:Spawn();		
			target:SetPos(pos);
			target:SetAngles(angles);
			target:SetEyeAngles(eyeAngles);

			Clockwork.player:SetBanned(target, true)
			Clockwork.player:NotifyAll({"PlayerBannedPlayer", player:Name(), target:Name()})

			target:KillSilent()
		else
			Clockwork.player:Notify(player, {"PlayerHasProtectionStatus", target:Name()})
		end
	else
		Clockwork.player:Notify(player, {"NotValidCharacter", arguments[1]})
	end
end

COMMAND:Register()
