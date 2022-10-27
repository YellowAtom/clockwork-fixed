local PLUGIN = PLUGIN

function PLUGIN:EntityFireBullets(entity, bulletInfo)
	if not entity:IsPlayer() then return end
	--tables are for losers!
	if entity:GetAmmoCount("Pistol") > 150 then
		entity:SetAmmo(150, "Pistol")
	end

	if entity:GetAmmoCount("AR2") > 90 then
		entity:SetAmmo(90, "AR2")
	end

	if entity:GetAmmoCount("SMG1") > 255 then
		entity:SetAmmo(255, "SMG1")
	end

	if entity:GetAmmoCount("357") > 12 then
		entity:SetAmmo(12, "357")
	end

	if entity:GetAmmoCount("XBowBolt") > 3 then
		entity:SetAmmo(3, "XBowBolt")
	end
	if entity:GetAmmoCount("Buckshot") > 30 then
		entity:SetAmmo(30, "Buckshot")
	end

end