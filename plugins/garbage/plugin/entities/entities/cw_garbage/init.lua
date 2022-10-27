--[[
	© 2012 Iron-Wall.org do not share, re-distribute or modify
	without permission of its author (ext@iam1337.ru).
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	local garbageModels = {
		"models/props_junk/garbage128_composite001a.mdl",
		"models/props_junk/garbage128_composite001b.mdl",
		"models/props_junk/TrashCluster01a.mdl",
		"models/props_junk/garbage128_composite001d.mdl"
	};
	
	self.items = {
		"weapon_hl2brokenbottle",
		"glass_piece",
		"empty_firstaid",
		"plastic_piece",
		"wood_part",
		"screws",
		"springs",
		"uu_yam",
		"veg_oil",
		"vodka",
		"uu_tea",
		"uu_potato",
		"uu_cheese",
		"egg",
		"egg_piece",
		"eggplant",
		"contact_lenses",
		"facewrap",
		"fingerless_gloves",
		"empty_contra_cigs",
		"newspaper",
		"empty_wine_glass",
		"empty_whiskey_bottle",
		"empty_vodka_bottle",
		"empty_vegetable_oil_bottle",
		"empty_uu_rum_bottle",
		"empty_uu_gin_bottle",
		"empty_uu_cigarette_box",
		"empty_uu_butter_tub",
		"empty_uu_beer_bottle",
		"empty_tin_can",
		"empty_tea_cup",
		"empty_special_breens_can",
		"empty_soda_bottle",
		"empty_smooth_breens_can",
		"empty_sleeping_medicine_jar",
		"empty_rum_glass",
		"empty_plastic_jar",
		"empty_packet",
		"empty_orange_juice",
		"empty_noodle_carton",
		"empty_milk_carton",
		"empty_gin_bottle",
		"empty_energy_drink",
		"empty_uu_coffee",
		"empty_clean_water_bottle",
		"empty_citizen_supplements",
		"empty_cereal_box",
		"empty_beans",
		"empty_breens_water_can",
		"empty_biotic_water",
		"empty_apple_juice",
		"depleted_batteries",
		"grime_cassette",
		"yugoslav_songs",
		"trucker_cassette",
		"two_timer",
		"book_9901",
		"book_3601",
		"3001",
		"book_audit",
		"book_wonkacollab",
		"book_guu",
		"book_zotu",
		"book_req",
		"newspaper_terminal25jan2009",
		"newspaper_terminal26july2009",
		"newspaper_timessurrender",
		"book_twotimer",
		"book_creep1",
		"book_wisdom",
		"cloth",
		"thread",
		"pin"
	};

	self:SetModel(table.Random(garbageModels));
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetSolid(SOLID_VPHYSICS);
	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD);
	
	local phys = self:GetPhysicsObject()
	phys:SetMass( 120 )
	
	self:SetSpawnType(1);
end;

function ENT:SetSpawnType(entType)
	if (entType == TYPE_WATERCAN or entType == TYPE_SUPPLIES) then
		self:SetDTInt(1,entType);
	end;
end;

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

function ENT:PhysicsUpdate(physicsObject)
	if (!self:IsPlayerHolding() and !self:IsConstrained()) then
		physicsObject:SetVelocity( Vector(0, 0, 0) );
		physicsObject:Sleep();
	end;
end;

function ENT:Use(activator, caller)
	if (activator:IsPlayer() and activator:GetEyeTraceNoCursor().Entity == self) then
		
		if (activator:GetSharedVar("tied") == 0 and activator:Crouching()) then
			Clockwork.player:SetAction(activator, "cleanup", Clockwork.config:Get("garbage_clean_time"):Get());
			Clockwork.player:EntityConditionTimer(activator, self, self, Clockwork.config:Get("garbage_clean_time"):Get(), 192, function()
				return activator:Alive() and !activator:IsRagdolled() and activator:GetSharedVar("tied") == 0 and activator:Crouching();
			end, function(success)
				if (success) then
					Clockwork.plugin:Call("PlayerTakeGarbage", activator, self)
					
					activator:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
					activator:FakePickup(self);
					self:Remove();
				end;

				Clockwork.player:SetAction(activator, "cleanup", false);
			end);
		elseif (activator:GetSharedVar("tied") == 0 and !activator:Crouching()) then
			Clockwork.player:Notify(activator, "Crouch and press E to see if you find something in the trash!");
		end;
	end;
end;

function ENT:CanTool(player, trace, tool)
	return false;
end;