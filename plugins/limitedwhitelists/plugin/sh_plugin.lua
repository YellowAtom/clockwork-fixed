
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");

if (CLIENT) then
	Clockwork.config:AddToSystem("Default Citizen limit", "default_citizen_limit", "The default amount of Citizen characters a player can create.");
else
	Clockwork.config:Add("default_citizen_limit", 3, true);
end;

Clockwork.config:ShareKey("default_citizen_limit");

function PLUGIN:Initialize()
	local COMMAND = Clockwork.command:FindByID("PlyWhitelist");

	if (COMMAND) then
		COMMAND.optionalArguments = 1;
		COMMAND.text = "<string Name> <string Faction> [number Limit]";

		function COMMAND:OnRun(player, arguments)
			local target = Clockwork.player:FindByID(arguments[1])
			
			if (target) then
				local factionTable = Clockwork.faction:FindByID(arguments[2]);
				
				if (factionTable) then
					if (factionTable.whitelist) then
						if (!Clockwork.player:IsWhitelisted(target, factionTable.name)) then
							Clockwork.player:SetWhitelisted(target, factionTable.name, true);
							Clockwork.player:SaveCharacter(target);

							local limit = tonumber(arguments[3]) or 1;
							local whitelistLimits = target:GetData("WhitelistLimits");
							whitelistLimits[factionTable.name] = limit;

							target:SetData("WhitelistLimits", whitelistLimits);
							Clockwork.datastream:Start(target, "WhitelistLimits", whitelistLimits);
							
							Clockwork.player:NotifyAll(player:Name().." has added "..target:Name().." to the "..factionTable.name.." whitelist, with a limit of "..limit.." character(s).");
						else
							Clockwork.player:Notify(player, target:Name().." is already on the "..factionTable.name.." whitelist!");
						end;
					else
						Clockwork.player:Notify(player, factionTable.name.." does not have a whitelist!");
					end;
				else
					Clockwork.player:Notify(player, arguments[2].." is not a valid faction!");
				end;
			else
				Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
			end;
		end;
	end;

	COMMAND = Clockwork.command:FindByID("PlyUnwhitelist");

	if (COMMAND) then
		function COMMAND:OnRun(player, arguments)
			local target = Clockwork.player:FindByID(arguments[1])
			
			if (target) then
				local factionTable = Clockwork.faction:FindByID(table.concat(arguments, " ", 2));
				
				if (factionTable) then
					if (factionTable.whitelist) then
						if (Clockwork.player:IsWhitelisted(target, factionTable.name)) then
							Clockwork.player:SetWhitelisted(target, factionTable.name, false);
							Clockwork.player:SaveCharacter(target);

							local whitelistLimits = target:GetData("WhitelistLimits");
							whitelistLimits[factionTable.name] = nil

							target:SetData("WhitelistLimits", whitelistLimits);
							Clockwork.datastream:Start(target, "WhitelistLimits", whitelistLimits);
							
							Clockwork.player:NotifyAll(player:Name().." has removed "..target:Name().." from the "..factionTable.name.." whitelist.");
						else
							Clockwork.player:Notify(player, target:Name().." is not on the "..factionTable.name.." whitelist!");
						end;
					else
						Clockwork.player:Notify(player, factionTable.name.." does not have a whitelist!");
					end;
				else
					Clockwork.player:Notify(player, factionTable.name.." is not a valid faction!");
				end;
			else
				Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
			end;
		end;
	end;

	COMMAND = Clockwork.command:FindByID("SilentWhitelist");

	if (COMMAND) then
		COMMAND.optionalArguments = 1;
		COMMAND.text = "<string Name> <string Faction> [number Limit]";

		function COMMAND:OnRun(player, arguments)
			local target = Clockwork.player:FindByID(arguments[1])
			
			if (target) then
				local factionTable = Clockwork.faction:FindByID(arguments[2]);
				
				if (factionTable) then
					if (factionTable.whitelist) then
						if (!Clockwork.player:IsWhitelisted(target, factionTable.name)) then
							Clockwork.player:SetWhitelisted(target, factionTable.name, true);
							Clockwork.player:SaveCharacter(target);

							local limit = tonumber(arguments[3]) or 1;
							local whitelistLimits = target:GetData("WhitelistLimits");
							whitelistLimits[factionTable.name] = limit

							target:SetData("WhitelistLimits", whitelistLimits);	
							Clockwork.datastream:Start(target, "WhitelistLimits", whitelistLimits);		
						else
							Clockwork.player:Notify(player, target:Name().." is already on the "..factionTable.name.." whitelist!");
						end;
					else
						Clockwork.player:Notify(player, factionTable.name.." does not have a whitelist!");
					end;
				else
					Clockwork.player:Notify(player, arguments[2].." is not a valid faction!");
				end;
			else
				Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
			end;
		end;
	end;

	COMMAND = Clockwork.command:FindByID("SilentDewhitelist");

	if (COMMAND) then
		function COMMAND:OnRun(player, arguments)
			local target = Clockwork.player:FindByID(arguments[1])
			
			if (target) then
				local factionTable = Clockwork.faction:FindByID(table.concat(arguments, " ", 2));
				
				if (factionTable) then
					if (factionTable.whitelist) then
						if (Clockwork.player:IsWhitelisted(target, factionTable.name)) then
							Clockwork.player:SetWhitelisted(target, factionTable.name, false);
							Clockwork.player:SaveCharacter(target);

							local whitelistLimits = target:GetData("WhitelistLimits");
							whitelistLimits[factionTable.name] = nil;

							target:SetData("WhitelistLimits", whitelistLimits);
							Clockwork.datastream:Start(target, "WhitelistLimits", whitelistLimits);
						else
							Clockwork.player:Notify(player, target:Name().." is not on the "..factionTable.name.." whitelist!");
						end;
					else
						Clockwork.player:Notify(player, factionTable.name.." does not have a whitelist!");
					end;
				else
					Clockwork.player:Notify(player, factionTable.name.." is not a valid faction!");
				end;
			else
				Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
			end;
		end;
	end;

	COMMAND = Clockwork.command:FindByID("CpWhitelist");

	if (COMMAND) then
		function COMMAND:OnRun(player, arguments)
			local target = Clockwork.player:FindByID(arguments[1])
			
			if (player:GetFaction() == FACTION_MPF) and (string.find(player:Name(), "CpC")) then
				if (target) then
					local factionTable = Clockwork.faction:FindByID("Metropolice Force");
					
					if (factionTable) then
						if (factionTable.whitelist) then
							if (!Clockwork.player:IsWhitelisted(target, factionTable.name)) then
								Clockwork.player:SetWhitelisted(target, factionTable.name, true);
								Clockwork.player:SaveCharacter(target);

								local whitelistLimits = target:GetData("WhitelistLimits");
								whitelistLimits[factionTable.name] = 1;

								target:SetData("WhitelistLimits", whitelistLimits);
								Clockwork.datastream:Start(target, "WhitelistLimits", whitelistLimits);
								
								Clockwork.player:NotifyAll(player:Name().." has added "..target:Name().." to the "..factionTable.name.." whitelist, with a limit of 1 character.");
							else
								Clockwork.player:Notify(player, target:Name().." is already on the "..factionTable.name.." whitelist!");
							end;
						else
							Clockwork.player:Notify(player, factionTable.name.." does not have a whitelist!");
						end;
					end;
				else
					Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
				end;
			else
				Clockwork.player:Notify(player, "You are not faction lead of the Civil Protection!");
			end;
		end;
	end;
end;
