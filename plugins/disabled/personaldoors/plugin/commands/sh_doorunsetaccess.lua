--[[
	Author: Arbiter
	Clockwork Version: 0.88a.
	
	Credits:	A small part of this code comes from kurozael's DoorCommands Plugin.
				Heavily based off the works of Cervidae Kosmonaut in Faction Doors.
--]]

local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("DoorUnsetAccess");
COMMAND.tip = "Remove the ability for a player to access a door.";
COMMAND.text = "[string Name]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local owningGuy = Clockwork.player:FindByID( arguments[1] );
	local owningPerson = owningGuy:Name();
	local door = player:GetEyeTraceNoCursor().Entity;
	
	if (IsValid(door) and Clockwork.entity:IsDoor(door) and PLUGIN.personalDoors[door]) then
		local msg = "all players";
		
		if (owningPerson) then
			door._OwningPersons[string.lower(owningPerson)] = nil;
			
			for k, v in pairs(PLUGIN.personalDoors[door].owners)do
				if(v == owningPerson)then
					table.remove(PLUGIN.personalDoors[door].owners, k);
					
					break;
				end;
			end;
			
			msg = "'" .. owningPerson .. "'";
		else
			door._OwningPersons = nil;
			
			PLUGIN.personalDoors = {};
		end;
		
		PLUGIN:SaveDoorData();
		
		Clockwork.player:Notify(player, "You have removed the ability of " .. msg .. " to access this door!");
	else
		Clockwork.player:Notify(player, "This is not a valid door!");
	end;
end;

COMMAND:Register();