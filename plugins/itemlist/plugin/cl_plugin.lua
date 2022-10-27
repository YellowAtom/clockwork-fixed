local PLUGIN = PLUGIN;
local icons = {
	["Ammunition"] = "briefcase",
	["Clothing"] = "user_suit",
	["Communication"] = "telephone",
	["Consumables"] = "cake",
	["Crafting Resource"] = "cog",
	["Crafting Station"] = "cog",
	["Crafting"] = "cog",
	["Deployables"] = "arrow_down",
	["Filters"] = "weather_clouds",
	["Junk"] = "box",
	["Lights"] = "lightbulb",
	["Literature"] = "book",
	["Medical"] = "heart",
	["Melee Weapons"] = "bomb",
	["Other"] = "brick",
	["Promotional"] = "coins",
	["Reusables"] = "arrow_rotate_clockwise",
	["Storage"] = "package",
	["Tools"] = "wrench",
	["Turret"] = "gun",
	["UU-Branded Items"] = "asterisk_yellow",
	["Weapons"] = "gun",
	["Workstations"] = "page",
};

spawnmenu.AddContentType("cwItem", function(container, data)
	if (!data.name) then return; end;

	local icon = vgui.Create("ContentIcon", container);

	icon:SetContentType("cwItem");
	icon:SetSpawnName(data.uniqueID);
	icon:SetName(data.name);

	function icon:DoClick()
		Clockwork.datastream:Start("MenuItemSpawn", data.uniqueID);
		surface.PlaySound("ui/buttonclickrelease.wav");
	end;

	function icon:OpenMenu()
		local menu = DermaMenu();
		menu:AddOption("Copy Item ID to Clipboard", function()
			SetClipboardText(data.uniqueID);
		end);

		menu:AddOption("Give to Self", function()
			Clockwork.datastream:Start("MenuItemGive", data.uniqueID);
		end);

		menu:Open();
	end;

	if (IsValid(container)) then
		container:Add(icon);
	end;
end);

local function itemPanel()
	local base = vgui.Create("SpawnmenuContentPanel");
	local tree = base.ContentNavBar.Tree;
	local categories = {};

	vgui.Create("ItemSearch", base.ContentNavBar);

	for k, v in SortedPairsByMemberValue(Clockwork.item.stored, "category") do
		if (!categories[v.category] and !v.isBase) then
			categories[v.category] = true;

			local category = tree:AddNode(v.category, icons[v.category] and ("icon16/" .. icons[v.category] .. ".png") or "icon16/brick.png");

			function category:DoPopulate()
				if (self.Container) then return; end;

				self.Container = vgui.Create("ContentContainer", base);
				self.Container:SetVisible(false)
				self.Container:SetTriggerSpawnlistChange(false);

				 
				for uniqueID, itemTable in SortedPairsByMemberValue(Clockwork.item.stored, "name") do
					if (itemTable.category == v.category and !itemTable.isBase) then
						spawnmenu.CreateContentIcon("cwItem", self.Container, itemTable);
					end;
				end;
			end;

			function category:DoClick()
				self:DoPopulate();
				base:SwitchPanel(self.Container);
			end;

			-- function category:Think()
			-- 	print("Thinking")
			-- 	print(Clockwork.player:HasFlags(Clockwork.Client, "G"))
			-- 	print(Clockwork.Client.rebuildItems)
			-- 	print("\n")
			-- 	if (!Clockwork.player:HasFlags(Clockwork.Client, "G")) then
			-- 		self:Clear();

			-- 		if (!Clockwork.Client.rebuildItems) then
			-- 			Clockwork.Client.rebuildItems = true
			-- 		end
			-- 	elseif (Clockwork.Client.rebuildItems) then
			-- 		self:DoPopulate();
			-- 		Clockwork.Client.rebuildItems = nil
			-- 	end;
			-- end
		end;
	end;

	local FirstNode = tree:Root():GetChildNode(0);

	if (IsValid(FirstNode)) then
		FirstNode:InternalDoClick();
	end;

	PLUGIN:PopulateContent(base, tree, nil);

	return base;
end

Clockwork.datastream:Hook("CreateItemsCategory", function()

	local creationMenu = g_SpawnMenu.CreateMenu;

	local pnl = vgui.Create( "Panel" )

	creationMenu:AddSheet( "Items", pnl, "icon16/script_key.png")

	timer.Simple( 0, function()
		local childpnl = itemPanel()
		childpnl:SetParent( pnl )
		childpnl:Dock( FILL )
	end )
end); 