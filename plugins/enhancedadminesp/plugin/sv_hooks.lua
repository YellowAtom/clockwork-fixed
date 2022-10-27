local PLUGIN = PLUGIN;

util.AddNetworkString("spawnESP")
util.AddNetworkString("spawnESPcall")

function PLUGIN:Tick()
	net.Receive("spawnESPcall", function()
		for k, v in pairs (cwSpawnPoints.spawnPoints) do 
			local faction = Clockwork.faction:FindByID(k);
			local class = Clockwork.class:FindByID(k);
			local spawnname;
			
			if (class or faction) then
				if (faction) then
					spawnname = faction.name;
				else
					spawnname = class.name;
				end;
			else
				spawnname = "Default"
			end;
			for k2, v2 in pairs (_player.GetAll()) do
				if (Clockwork.player:IsAdmin(v2)) then
					for k3, v3 in pairs (v) do
						local location = v3.position
						net.Start("spawnESP")
						net.WriteString(spawnname)
						net.WriteVector(location)
						net.Send(v2)
					end					
				end;
			end;
		end;
	end)
end;