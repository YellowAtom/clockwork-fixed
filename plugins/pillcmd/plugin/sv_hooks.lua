
local PLUGIN = PLUGIN;

-- Enforce a pill's walk/run speed.
function PLUGIN:PlayerThink(player, curTime, infoTable)
	local ent = pk_pills.getMappedEnt(player)
	if IsValid(ent) then
		if !ent.formTable then return end
		local speed = ent.formTable.moveSpeed || {}

		infoTable.walkSpeed = speed.walk || 200
		infoTable.runSpeed = speed.run || speed.walk || 500
		
		-- if speed.ducked then
			-- ply:SetCrouchedWalkSpeed(speed.ducked/(speed.walk||200))
		-- elseif duckBy==0 then
			-- ply:SetCrouchedWalkSpeed(1)
		-- else
			-- ply:SetCrouchedWalkSpeed(.3)
		-- end
	end
end;
