
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PlyRocket");
COMMAND.tip = "Slays a player.";
COMMAND.text = "<string Name>";
COMMAND.access = "s";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (target) then
		if (target:Alive()) then
			target:Ignite(2);
			local ent = util.SpriteTrail(target, 0, Color(81, 81, 81, 255), false, 64, 32, 3, 1 / (32), "trails/smoke.vmt");
			local exp = ents.Create("env_explosion");
	        exp:SetPos(target:GetPos());
	        exp:Spawn();
	        exp:SetKeyValue("iMagnitude", "0");
	        exp:Fire("Explode", 0, 100);
	        timer.Simple(0.5, function() exp:Remove() end);
	        timer.Simple(0.1, function()
	        	target:SetVelocity(target:GetVelocity() + Vector(0, 0, 1000))
	        	for i = 1, 4 do
	        		timer.Simple(i * 0.4, function()
						local exp = ents.Create("env_explosion");
				        exp:SetPos(target:GetPos() + target:GetVelocity() * 0.2);
				        exp:Spawn();
				        exp:SetKeyValue("iMagnitude", 0);
				        exp:SetKeyValue("iRadiusOverride", 100);
				        exp:Fire("Explode", 0, 0);
				        timer.Simple(0.1, function()
				        	local effectdata = EffectData();

							effectdata:SetOrigin(target:GetPos());
				        	target:SetVelocity(target:GetVelocity() + Vector(0, 0, 400));
				        end);
				        timer.Simple(0.5, function() exp:Remove() end);
	        		end);
	        	end;
	        	timer.Simple(2, function()
	        		local exp = ents.Create("env_explosion");
			        exp:SetPos(target:GetPos() + target:GetVelocity() * 0.2);
			        exp:Spawn();
			        exp:SetKeyValue("iMagnitude", 0);
			        exp:SetKeyValue("iRadiusOverride", 255);
			        exp:Fire("Explode", 0, 0);
			        timer.Simple(0.1, function()
			        	local effectdata = EffectData();

						effectdata:SetOrigin(target:GetPos());
						effectdata:SetMagnitude(1);
						effectdata:SetScale(100);

						util.Effect("explosion_large", effectdata);

			        	ent:Remove();
			        	target:Kill();
			        end);
			        timer.Simple(0.5, function() exp:Remove() end);
	        	end);
	        end);

			if (target != player) then
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player and v != target) then
							v:CPNotify(player:Name().." has rocketed "..target:Name()..".", "bomb");
						end;
					end;
				end;

				player:CPNotify("You have rocketed "..target:Name()..".", "bomb");
				target:CPNotify(player:Name().." has rocketed you.", "bomb");
			else
				if (Clockwork.config:Get("global_echo"):Get()) then
					for k, v in pairs(_player.GetAll()) do
						if (v != player) then
							v:CPNotify(player:Name().." has rocketed themself.", "bomb");
						end;
					end;
				end;

				player:CPNotify("You have rocketed yourself.", "bomb");
			end;
		else
			player:CPNotify(target:Name().." is already dead!", Clockwork.option:GetKey("cannot_do_icon"));
		end;
	else
		player:CPNotify(arguments[1].." is not a valid player!", Clockwork.option:GetKey("invalid_target_icon"));
	end;
end;

--COMMAND:Register();