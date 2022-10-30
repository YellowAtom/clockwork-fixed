local PLUGIN = PLUGIN

function PLUGIN:PlayerDeath(player)
	if player:GetRagdollEntity() then
		local ragdoll = player:GetRagdollEntity()
		local character = player:GetCharacter()
		local inventory = player:GetInventory()
		local copy = Clockwork.inventory:CreateDuplicate(inventory)

		ragdoll.cwInventory = copy
		ragdoll.cash = player:GetCash()

		for k,v in pairs( inventory ) do
			for k2,v2 in pairs( v ) do
				player:TakeItem( v2 )
			end
		end
		player:SetCharacterData("Cash", 0, true)
		player:SetSharedVar("Cash", 0)
	end
end