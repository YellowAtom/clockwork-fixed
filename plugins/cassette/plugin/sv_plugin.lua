local Clockwork = Clockwork;

local PLUGIN = PLUGIN;

	resource.AddFile("resource/fonts/advanced_pixel_lcd-7.ttf")
	util.AddNetworkString("tcp_click")
	util.AddNetworkString("tcp_play")
	
	local t_cassette = {}
	
	function t_cassette.ReceiveButtonClick(_, pl)
		local ent = net.ReadEntity()
		local key = net.ReadUInt(2) + 1
		if IsValid(ent) and ent:GetClass() == "t_cassette_player" and ent:CanClick() then
			if ent:GetPos():Distance(pl:GetShootPos()) < 64 then
				ent.next_click = SysTime() + (ent.data.click_delay / 2)
				local btn = ent.data.buttons[key]
				if btn then
					btn:OnClick(ent)
				end
			end
		end
	end
	net.Receive("tcp_click", t_cassette.ReceiveButtonClick)
	
	-- A function to load the fields.
function PLUGIN:LoadCassettes()
	local fields = Clockwork.kernel:RestoreSchemaData("plugins/cassettes/"..game.GetMap());
	
	for k, v in pairs(fields) do
		local entity = ents.Create("t_cassette_player");
		entity:SetAngles(v.angles);
		entity:SetPos(v.position);
		entity:Spawn();
		entity:Activate();
		entity.cassette_class = v.class
		local itemTable = Clockwork.item:FindByID( v.class );
		if (itemTable and itemTable("isCassette")) then
			entity:SetCassetteKey(itemTable("key"))
		end

		local physicsObject = entity:GetPhysicsObject();
		
		if ( IsValid(physicsObject) ) then
			physicsObject:EnableMotion(false);
		end;
	end;
end;

-- A function to save the fields.
function PLUGIN:SaveCassettes()
	local fields = {};
	
	for k, v in pairs(ents.FindByClass("t_cassette_player")) do
		local position = v:GetPos();
		local angles = v:GetAngles();
		local class = v.cassette_class

		fields[#fields + 1] = {
			position = position,
			angles = angles,
			class = class
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/cassettes/"..game.GetMap(), fields);
end;