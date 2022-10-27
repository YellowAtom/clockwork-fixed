local ITEM = Clockwork.item:New()
ITEM.name = "Container Lock"
ITEM.cost = 50
ITEM.model = "models/props_wasteland/prison_padlock001a.mdl"
ITEM.weight = 2.5
ITEM.access = "1"
ITEM.category = "Other"
ITEM.business = true
ITEM.batch = 1;
ITEM.spawnType = "misc";
ITEM.spawnValue = 8;
ITEM.description = "Sets a random password on a container when used."
local randomwords = {
"fort",
"adjunct",
"union",
"sword",
"jury", 
"yourefat",
"tightly",
"shield",
"taco",
"clexo",
"cwu",
"fat",
"albert",
"didntyou",
"doitplease",
"whateveryousay",
"followme",
"yeahaboutthat",
"documents",
"undetermined",
"gaming",
"dumbledore",
"snape",
"white",
"black",
"yellow",
"green",
"blue",
"lock",
"stabilize",
"cauterize",
"duty",
"sword",
"noon",
"dinner",
"dinnershock",
"germans",
"denny",
"british",
"cube",
"doors",
"windows",
"gordonfreemanandabouttimetoo",
"sphere",
"rectangle",
"absolute",
"hairy",
"twelve",
"quantum",
"enterprise",
"star",
"trek",
"additional",
"mathematical",
"radical"}

-- Called when a player drops the item.
function ITEM:OnUse(player, position)
	local trace = player:GetEyeTraceNoCursor()
	local password = tostring(math.random(1, 99999))
	local word = table.Random(randomwords)

	if trace.Entity.cwPassword ~= nil then
		player:Notify("This container already has a lock on it.")

		return false
	end

	if (IsValid(trace.Entity)) then
		if (Clockwork.entity:IsPhysicsEntity(trace.Entity)) then
			local model = string.lower(trace.Entity:GetModel())

			if (cwStorage.containerList[model]) then
				if (not trace.Entity.inventory) then
					cwStorage.storage[trace.Entity] = trace.Entity
					trace.Entity.inventory = {}
				end

				trace.Entity.cwPassword = word .. password
				trace.Entity:SetNetworkedString("Name", "This container is locked with a " .. ITEM.name)
				Clockwork.player:Notify(player, "This container's password has been set to '" .. word .. password .. "'.")
			else
				Clockwork.player:Notify(player, "This is not a valid container!")
				return false
			end
		else
			Clockwork.player:Notify(player, "This is not a valid container!")
			return false
		end
	else
		Clockwork.player:Notify(player, "This is not a valid container!")
		return false
	end
end

function ITEM:OnDrop()
	end

ITEM:Register()