local PLUGIN = PLUGIN

-- If there's a certain weapon you don't want to be dropped when a player's arm is hit, add said weapon's CLASS NAME here.
local NoStripWeps = {
	"cw_hands",
	"cw_keys",
	"weapon_physgun",
	"gmod_tool",
	"cw_stunstick"
}

function PLUGIN:PlayerCharacterLoaded(ply)
	if ply:GetFaction() == FACTION_OTA and Clockwork.config:Get("affectivewounds_affectota"):Get() then
		ply:SetSharedVar("legshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsota"):Get())
		ply:SetSharedVar("armshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsota"):Get())
	elseif ply:GetFaction() == FACTION_MPF and Clockwork.config:Get("affectivewounds_affectmpf"):Get() then
		ply:SetSharedVar("legshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsmpf"):Get())
		ply:SetSharedVar("armshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsmpf"):Get())
	else
		ply:SetSharedVar("legshotamount", 0)
		ply:SetSharedVar("armshotamount", 0)
	end
end

function PLUGIN:PlayerTraceAttack(ply, dmginfo, dir, trace)
	if Clockwork.config:Get("affectivewounds_enabled"):Get() then
		if ply:GetFaction() == FACTION_OTA and !Clockwork.config:Get("affectivewounds_affectota"):Get() then return end
		if ply:GetFaction() == FACTION_MPF and !Clockwork.config:Get("affectivewounds_affectmpf"):Get() then return end
		if (!ply:InVehicle() and !Clockwork.player:IsNoClipping(ply)) then
			if trace.HitGroup == HITGROUP_LEFTLEG or trace.HitGroup == HITGROUP_RIGHTLEG then
				if Clockwork.config:Get("affectivewounds_legshotenabled"):Get() then
					if (!ply:IsRagdolled()) then
						if ply:GetSharedVar("legshotamount") < Clockwork.config:Get("affectivewounds_legshotlimit"):Get()-1 then
							ply:SetSharedVar("legshotamount", ply:GetSharedVar("legshotamount")+1)
						else
							if ply:GetFaction() == FACTION_MPF then
								ply:SetSharedVar("legshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsmpf"):Get())
							elseif ply:GetFaction() == FACTION_OTA then
								ply:SetSharedVar("legshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsota"):Get())
							else
								ply:SetSharedVar("legshotamount", 0)
							end
							Clockwork.player:SetRagdollState(ply, RAGDOLL_FALLENOVER, nil)
							ply:SetSharedVar("FallenOver", true)
						end
					end
				end
			end

			if trace.HitGroup == HITGROUP_LEFTARM or trace.HitGroup == HITGROUP_RIGHTARM then
				if Clockwork.config:Get("affectivewounds_armshotenabled"):Get() then
					if ply:GetSharedVar("armshotamount") < Clockwork.config:Get("affectivewounds_armshotlimit"):Get()-1 then
						ply:SetSharedVar("armshotamount", ply:GetSharedVar("armshotamount")+1)
					else
						if ply:GetFaction() == FACTION_MPF then
							ply:SetSharedVar("armshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsmpf"):Get())
						elseif ply:GetFaction() == FACTION_OTA then
							ply:SetSharedVar("armshotamount", 0-Clockwork.config:Get("affectivewounds_additionalhitsota"):Get())
						else
							ply:SetSharedVar("armshotamount", 0)
						end

						local activeWep = ply:GetActiveWeapon()
						local wepClass = activeWep:GetClass()
						local canStrip = true

						for k,v in pairs(NoStripWeps) do
							if v == activeWep:GetClass() then canStrip = false; break end
						end

						if canStrip then
							if IsValid(activeWep) then
								local dropPos = ply:GetPos() + Vector(0, 0, 35) + ply:GetAngles():Forward() * 4
								local itemTable = Clockwork.item:GetByWeapon(activeWep)
								local entity = Clockwork.entity:CreateItem(ply, itemTable, dropPos)
								if (IsValid(entity)) then
									ply:TakeItem(itemTable, true)
									ply:SelectWeapon("cw_hands")
									ply:StripWeapon(activeWep:GetClass())
								end
							end
						end
					end
				end
			end
		end
	end
end