local ITEM = Clockwork.item:New()

ITEM.name = "Cassette Player"
ITEM.uniqueID = "cassette_player"
ITEM.cost = 200
ITEM.model = "models/ug_imports/cassette/casetteplayer.mdl"
ITEM.weight = 2
ITEM.batch = 1
ITEM.access = "1"
ITEM.category = "Electronics"
ITEM.business = true
ITEM.description = "It's a state of the art cassette player."
ITEM.spawnType = "misc"

function ITEM:OnUse(player, itemEntity)
	local trace = player:GetEyeTraceNoCursor()

	if trace.HitPos:Distance(player:GetShootPos()) <= 192 then
		local entity = ents.Create("t_cassette_player")
		Clockwork.player:GiveProperty(player, entity)
		entity:SetItemTable(self)
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		Clockwork.entity:MakeFlushToGround(entity, trace.HitPos, trace.HitNormal)
		cassetteplugin:SaveCassettes()
	else
		Clockwork.player:Notify(player, "You cannot drop a cassette player that far away!")

		return false
	end
end

function ITEM:OnDrop(player, position)
end

ITEM:Register()
