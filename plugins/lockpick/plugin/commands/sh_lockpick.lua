local COMMAND = Clockwork.command:New("Lockpick");
COMMAND.tip = "Pick a lock.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local door = player:GetEyeTraceNoCursor().Entity;
	local trace = player:GetEyeTraceNoCursor();
	local target = trace.Entity;
	
	if ( player:HasItemByID("screw_driver") and player:HasItemByID("b_pin") ) then
		if ( IsValid(door) and Clockwork.entity:IsDoor(door) ) then
			if door:GetClass()=="prop_door_rotating" or door:GetName() == "sewer_vent" then
					if (target:GetPos():Distance( player:GetShootPos() ) <= 64) then
						Clockwork.player:SetAction(player, "lockpick", 15);
						-- The sound timer is taken from the DarkRP Lockpick swep, so credit to the creators of that for the sound maker thing.
						timer.Create("LockPickSounds", 1, 15, function()
							if not IsValid(target) then return end
							local snd = {1,3,4}
							target:EmitSound("weapons/357/357_reload".. tostring(snd[math.random(1, #snd)]) ..".wav", 50, 100)
						end);
						Clockwork.player:EntityConditionTimer(player, target, target, 15, 192, function()
							return player:Alive() and !player:IsRagdolled() and player:GetSharedVar("tied") == 0;
						end, function(success)
							if (success) then
								local dex = Clockwork.attributes:Get(player, ATB_DEXTERITY, false, false);
								if dex > 75 then
									dex = 75;
								end;
							
								if math.random( dex, 80 ) >= 75 then
									if math.random(1, 5) == 5 then
										Clockwork.entity:OpenDoor(target, 0, true, true);
										Clockwork.player:Notify(player, "You manage to pick the lock.");
										player:ProgressAttribute(ATB_DEXTERITY, 1, true);
										door:EmitSound("doors/door_latch3.wav");
										door:Fire("Unlock", "", 0);
									else
										player:EmitSound( "physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav" );
										Clockwork.player:Notify(player, "You manage to pick the lock, but your bobby pin breaks.");
										player:TakeItem(player:FindItemByID("bobby_pin"));
										player:ProgressAttribute(ATB_DEXTERITY, 1, true);
										door:EmitSound("doors/door_latch3.wav");
										door:Fire("Unlock", "", 0);
									end;
								else
									player:EmitSound( "physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav" ); -- placehold for a sound imma add
									Clockwork.player:Notify(player, "You fail to pick the lock and your bobby pin snaps.");
									player:TakeItem(player:FindItemByID("b_pin"));
								end;
							end;
			
							Clockwork.player:SetAction(player, "lockpick", false);
							timer.Destroy("LockPickSounds");
						end);
					else
						Clockwork.player:Notify(player, "That door is too far away.");
					end;
			else
				Clockwork.player:Notify(player, "You can't pick this door's lock.");
			end;
		else
			Clockwork.player:Notify(player, "This is not a valid door.");
		end;
	else
		Clockwork.player:Notify(player, "You don't have both a Screwdriver and a Bobby pin.")
	end;
end;

COMMAND:Register();