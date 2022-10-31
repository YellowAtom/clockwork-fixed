
local entityMeta = FindMetaTable("Entity")
entityMeta.ClockworkFireBullets = entityMeta.ClockworkFireBullets or entityMeta.FireBullets

-- A function to make a player fire bullets.
function entityMeta:FireBullets(bulletInfo)
	if self:IsPlayer() then
		Clockwork.plugin:Call("PlayerAdjustBulletInfo", self, bulletInfo)
	end

	Clockwork.plugin:Call("EntityFireBullets", self, bulletInfo)

	return self:ClockworkFireBullets(bulletInfo)
end
