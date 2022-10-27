local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

	function PLUGIN:OnNPCKilled(entity)
    local class = entity:GetClass()
    local items = {}

    if (class == "npc_zombie") then

        local loot = Clockwork.item:CreateInstance("bone");
        Clockwork.entity:CreateItem(nil, loot, entity:GetPos() + Vector(0, 0, 8))
		
	elseif (class == "npc_fastzombie") then
		
		local loot = Clockwork.item:CreateInstance("bone");
        Clockwork.entity:CreateItem(nil, loot, entity:GetPos() + Vector(0, 0, 8))
		
	elseif (class == "npc_poisonzombie") then
		
		local loot = Clockwork.item:CreateInstance("bone");
        Clockwork.entity:CreateItem(nil, loot, entity:GetPos() + Vector(0, 0, 8))
		
	elseif (class == "npc_antlionguard") then
		
		local loot = Clockwork.item:CreateInstance("Raw Meat");
		--local loot = Clockwork.item:CreateInstance("Pheropods");
        Clockwork.entity:CreateItem(nil, loot, entity:GetPos() + Vector(0, 0, 8))
		
	elseif (class == "npc_zombie_torso") then
		
		local loot = Clockwork.item:CreateInstance("bone");
        Clockwork.entity:CreateItem(nil, loot, entity:GetPos() + Vector(0, 0, 8))
		
	elseif (class == "npc_fastzombie_torso") then
		
		local loot = Clockwork.item:CreateInstance("bone");
        Clockwork.entity:CreateItem(nil, loot, entity:GetPos() + Vector(0, 0, 8))
        end;
    end;	