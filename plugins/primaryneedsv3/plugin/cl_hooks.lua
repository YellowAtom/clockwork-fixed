local PLUGIN = PLUGIN;

-- Called when the local player's motion blurs should be adjusted.
function PLUGIN:PlayerAdjustMotionBlurs(motionBlurs)
	if ( Clockwork.Client:HasInitialized() ) then
		local hunger = Clockwork.Client:GetSharedVar("hunger");
		local data = math.max(hunger);
		
		if (data >= 90) then
			motionBlurs.blurTable["needs"] = 1 - ( (0.25 / 10) * ( 10 - (100 - data) ) );
		end;
	end;
end;

-- Called when the F1 Text is needed.
function PLUGIN:GetBars(bars)
	local hunger = tonumber(Clockwork.Client:GetSharedVar("hunger"));
	local thirst = tonumber(Clockwork.Client:GetSharedVar("thirst"));
	local sleep = tonumber(Clockwork.Client:GetSharedVar("sleep"));
	
	if (!self.hunger) then
		self.hunger = hunger;
	else
		self.hunger = math.Approach(self.hunger, hunger, 1);
	end;
	
	if (!self.thirst) then
		self.thirst = thirst;
	else
		self.thirst = math.Approach(self.thirst, thirst, 1);
	end;
	
	if (!self.sleep) then
		self.sleep = sleep;
	else
		self.sleep = math.Approach(self.sleep, sleep, 1);
	end;
	
	local text = "Unknown";
	local thirstText = "Unknown";
	local sleepText = "Unknown";
	
	if ( hunger <= 30 ) then
		text = "Well Fed";
	elseif( hunger <= 50 ) then
		text = "Peckish";
	elseif( hunger <= 70 ) then
		text = "Hungry";
	elseif( hunger <= 80 ) then
		text = "Very Hungry";
	else
		text = "Starving";
	end;
	
	if ( thirst <= 30 ) then
		thirstText = "Hydrated";
	elseif( thirst <= 50 ) then
		thirstText = "Slightly Thirsty";
	elseif( thirst <= 70 ) then
		thirstText = "Thirsty";
	elseif( thirst <= 80 ) then
		thirstText = "Very Thirsty";
	else
		thirstText = "Dehydrated";
	end;
	
	if ( sleep <= 30 ) then
		sleepText = "Energized";
	elseif( sleep <= 50 ) then
		sleepText = "Tired";
	elseif( sleep <= 70 ) then
		sleepText = "Sleepy";
	elseif( sleep <= 80 ) then
		sleepText = "Very Sleepy";
	else
		sleepText = "Sleep Deprived";
	end;
	
	if (hunger > 25) then
		bars:Add("HUNGER", Color(255, 128, 0, 255), text, hunger, 100, hunger > 25, 1);
	end;
	
	if (thirst > 25) then
		bars:Add("THIRST", Color(0, 26, 255, 255), thirstText, thirst, 100, thirst > 25, 1);
	end;
	
	if (sleep > 25) then
		bars:Add("SLEEP", Color(192, 192, 192, 255), sleepText, sleep, 100, sleep > 25, 1);
	end;
	
	-- Code below not needed since we already have bars
	/*
		if (hunger > -1 or thirst > -1 or sleep > -1) then
			playerInfoText:Add("Header", "[Primary Needs]");
		end;
		if (hunger > -1) then
			playerInfoText:Add("HUNGER", "Hunger Level: "..text);
		end;
		if (thirst > -1) then
			playerInfoText:Add("THIRST", "Thirst Level: "..thirstText);
		end;
		if (sleep > -1) then
			playerInfoText:Add("SLEEP", "Sleep Level: "..tostring(sleep).."%");
		end;
		if (hunger > -1 or thirst > -1 or sleep > -1) then
			playerInfoText:Add("Header2", " ");
		end;
		if (hunger > -1 and thirst > -1 and sleep > -1) then
			playerInfoText:Add("Header3", "[Other]");
		end;
	*/
end;