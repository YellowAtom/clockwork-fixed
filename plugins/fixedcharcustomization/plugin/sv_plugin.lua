
function PLUGIN:Initialize()
	function Clockwork.player:CreateCharacterFromData(player, data)
		if (player.cwIsCreatingChar) then
			return;
		end;

		local minimumPhysDesc = Clockwork.config:Get("minimum_physdesc"):Get();
		local attributesTable = Clockwork.attribute:GetAll();
		local factionTable = Clockwork.faction:FindByID(data.faction);
		local attributes = nil;
		local info = {};
		
		if (table.Count(attributesTable) > 0) then
			for k, v in pairs(attributesTable) do
				if (v.isOnCharScreen) then
					attributes = true;
					break;
				end;
			end;
		end;
		
		if (!factionTable) then
			return self:SetCreateFault(
				player, "You did not choose a faction, or the faction that you chose is not valid!"
			);
		end;
		
		info.attributes = {};
		info.faction = factionTable.name;
		info.gender = data.gender;
		info.model = data.model;
		info.data = {};
		
		if (data.plugin) then
			for k, v in pairs(data.plugin) do
				info.data[k] = v;
			end;
		end;
		
		local classes = false;
		
		for k, v in pairs(Clockwork.class:GetAll()) do
			if (v.isOnCharScreen and (v.factions
			and table.HasValue(v.factions, factionTable.name))) then
				classes = true;
			end;
		end;
		
		if (classes) then
			local classTable = Clockwork.class:FindByID(data.class);
			
			if (!classTable) then
				return self:SetCreateFault(
					player, "You did not choose a class, or the class that you chose is not valid!"
				);
			else
				info.data["class"] = classTable.name;
			end;
		end;
		
		if (attributes and type(data.attributes) == "table") then
			local maximumPoints = Clockwork.config:Get("default_attribute_points"):Get();
			local pointsSpent = 0;
			
			if (factionTable.attributePointsScale) then
				maximumPoints = math.Round(maximumPoints * factionTable.attributePointsScale);
			end;
			
			if (factionTable.maximumAttributePoints) then
				maximumPoints = factionTable.maximumAttributePoints;
			end;
			
			for k, v in pairs(data.attributes) do
				local attributeTable = Clockwork.attribute:FindByID(k);
				
				if (attributeTable and attributeTable.isOnCharScreen) then
					local uniqueID = attributeTable.uniqueID;
					local amount = math.Clamp(v, 0, attributeTable.maximum);
					
					info.attributes[uniqueID] = {
						amount = amount,
						progress = 0
					};
					
					pointsSpent = pointsSpent + amount;
				end;
			end;
			
			if (pointsSpent > maximumPoints) then
				return self:SetCreateFault(
					player, "You have chosen more "..Clockwork.option:GetKey("name_attribute", true).." points than you can afford to spend!"
				);
			end;
		elseif (attributes) then
			return self:SetCreateFault(
				player, "You did not choose any "..Clockwork.option:GetKey("name_attributes", true).." or the ones that you did are not valid!"
			);
		end;
		
		if (!factionTable.GetName) then
			if (!factionTable.useFullName) then
				if (data.forename and data.surname) then
					data.forename = string.gsub(data.forename, "^.", string.upper);
					data.surname = string.gsub(data.surname, "^.", string.upper);
					
					if (string.find(data.forename, "[%p%s%d]") or string.find(data.surname, "[%p%s%d]")) then
						return self:SetCreateFault(
							player, "Your forename and surname must not contain punctuation, spaces or digits!"
						);
					end;
					
					if (string.utf8len(data.forename) < 2 or string.utf8len(data.surname) < 2) then
						return self:SetCreateFault(
							player, "Your forename and surname must both be at least 2 characters long!"
						);
					end;
					
					if (string.utf8len(data.forename) > 16 or string.utf8len(data.surname) > 16) then
						return self:SetCreateFault(
							player, "Your forename and surname must not be greater than 16 characters long!"
						);
					end;
				else
					return self:SetCreateFault(
						player, "You did not choose a name, or the name that you chose is not valid!"
					);
				end;
			elseif (!data.fullName or data.fullName == "") then
				return self:SetCreateFault(
					player, "You did not choose a name, or the name that you chose is not valid!"
				);
			end;
		end;
		
		if (Clockwork.command:FindByID("CharPhysDesc") != nil) then
			if (type(data.physDesc) != "string") then
				return self:SetCreateFault(
					player, "You did not enter a physical description!"
				);
			elseif (string.utf8len(data.physDesc) < minimumPhysDesc) then
				return self:SetCreateFault(
					player, "The physical description must be at least "..minimumPhysDesc.." characters long!"
				);
			end;
			
			info.data["PhysDesc"] = Clockwork.kernel:ModifyPhysDesc(data.physDesc);
		end;
		
		if (!factionTable.GetModel and !info.model) then
			return self:SetCreateFault(
				player, "You did not choose a model, or the model that you chose is not valid!"
			);
		end;
		
		if (!Clockwork.faction:IsGenderValid(info.faction, info.gender)) then
			return self:SetCreateFault(
				player, "You did not choose a gender, or the gender that you chose is not valid!"
			);
		end;
		
		if (factionTable.whitelist and !self:IsWhitelisted(player, info.faction)) then
			return self:SetCreateFault(
				player, "You are not on the "..info.faction.." whitelist!"
			);
		elseif (Clockwork.faction:IsModelValid(factionTable.name, info.gender, info.model)
		or (factionTable.GetModel and !info.model)) then
			local charactersTable = Clockwork.config:Get("mysql_characters_table"):Get();
			local schemaFolder = Clockwork.kernel:GetSchemaFolder();
			local characterID = nil;
			local characters = player:GetCharacters();
			
			if (Clockwork.faction:HasReachedMaximum(player, factionTable.name)) then
				return self:SetCreateFault(
					player, "You cannot create any more characters in this faction."
				);
			end;
			
			for i = 1, self:GetMaximumCharacters(player) do
				if (!characters[i]) then
					characterID = i;
					break;
				end;
			end;
			
			if (characterID) then
				if (factionTable.GetName) then
					info.name = factionTable:GetName(player, info, data);
				elseif (!factionTable.useFullName) then
					info.name = data.forename.." "..data.surname;
				else
					info.name = data.fullName;
				end;
				
				if (factionTable.GetModel) then
					info.model = factionTable:GetModel(player, info, data);
				else
					info.model = data.model;
				end;
				
				if (factionTable.OnCreation) then
					local fault = factionTable:OnCreation(player, info);
					
					if (fault == false or type(fault) == "string") then
						return self:SetCreateFault(
							player, fault or "There was an error creating this character!"
						);
					end;
				end;
				
				for k, v in pairs(characters) do
					if (v.name == info.name) then
						return self:SetCreateFault(
							player, "You already have a character with the name '"..info.name.."'!"
						);
					end;
				end;
				
				local fault = Clockwork.plugin:Call("PlayerAdjustCharacterCreationInfo", player, info, data);
				
				if (fault == false or type(fault) == "string") then
					return self:SetCreateFault(
						player, fault or "There was an error creating this character!"
					);
				end;
				
				local queryObj = Clockwork.database:Select(charactersTable);
					queryObj:AddWhere("_Schema = ?", schemaFolder);
					queryObj:AddWhere("_Name = ?", info.name);
					queryObj:SetCallback(function(result)
						if (!IsValid(player)) then return; end;
						
						if (Clockwork.database:IsResult(result)) then
							self:SetCreateFault(
								player, "A character with the name '"..info.name.."' already exists!"
							);
							player.cwIsCreatingChar = nil;
						else
							self:LoadCharacter(player, characterID,
								{
									attributes = info.attributes,
									faction = info.faction,
									gender = info.gender,
									model = info.model,
									name = info.name,
									data = info.data
								},
								function()
									Clockwork.kernel:PrintLog(LOGTYPE_MINOR,
										player:SteamName().." has created a "..info.faction.." character called '"..info.name.."'."
									);
									
									Clockwork.datastream:Start(player, "CharacterFinish", {bSuccess = true});
									
									player.cwIsCreatingChar = nil;
									
									local characters = player:GetCharacters();
									
									if (table.Count(characters) == 1) then
										self:UseCharacter(player, characterID);
									end;
								end
							);
						end;
					end);
				queryObj:Pull();
			else
				return self:SetCreateFault(player, "You cannot create any more characters!");
			end;
		else
			return self:SetCreateFault(
				player, "You did not choose a model, or the model that you chose is not valid!"
			);
		end;
	end;
end;
