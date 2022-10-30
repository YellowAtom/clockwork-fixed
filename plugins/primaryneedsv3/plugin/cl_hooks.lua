
local PLUGIN = PLUGIN

function PLUGIN:PlayerAdjustMotionBlurs(motionBlurs)
	if Clockwork.Client:HasInitialized() then
		local hunger = Clockwork.Client:GetSharedVar("hunger")
		local data = math.max(hunger)

		if data >= 90 then
			motionBlurs.blurTable["needs"] = 1 - (0.25 / 10) * (10 - (100 - data))
		end
	end
end

function PLUGIN:GetBars(bars)
	local hunger = tonumber(Clockwork.Client:GetSharedVar("hunger"))
	local thirst = tonumber(Clockwork.Client:GetSharedVar("thirst"))
	local sleep = tonumber(Clockwork.Client:GetSharedVar("sleep"))

	if not self.hunger then
		self.hunger = hunger
	else
		self.hunger = math.Approach(self.hunger, hunger, 1)
	end

	if not self.thirst then
		self.thirst = thirst
	else
		self.thirst = math.Approach(self.thirst, thirst, 1)
	end

	if not self.sleep then
		self.sleep = sleep
	else
		self.sleep = math.Approach(self.sleep, sleep, 1)
	end

	local text = "Unknown"
	local thirstText = "Unknown"
	local sleepText = "Unknown"

	if hunger <= 30 then
		text = "Well Fed"
	elseif hunger <= 50 then
		text = "Peckish"
	elseif hunger <= 70 then
		text = "Hungry"
	elseif hunger <= 80 then
		text = "Very Hungry"
	else
		text = "Starving"
	end

	if thirst <= 30 then
		thirstText = "Hydrated"
	elseif thirst <= 50 then
		thirstText = "Slightly Thirsty"
	elseif thirst <= 70 then
		thirstText = "Thirsty"
	elseif thirst <= 80 then
		thirstText = "Very Thirsty"
	else
		thirstText = "Dehydrated"
	end

	if sleep <= 30 then
		sleepText = "Energized"
	elseif sleep <= 50 then
		sleepText = "Tired"
	elseif sleep <= 70 then
		sleepText = "Sleepy"
	elseif sleep <= 80 then
		sleepText = "Very Sleepy"
	else
		sleepText = "Sleep Deprived"
	end

	if hunger > 25 then
		bars:Add("HUNGER", Color(200, 200, 40, 255), text, hunger, 100, hunger > 25, 1)
	end

	if thirst > 25 then
		bars:Add("THIRST", Color(0, 119, 101, 255), thirstText, thirst, 100, thirst > 25, 1)
	end

	if sleep > 25 then
		bars:Add("SLEEP", Color(192, 192, 192, 255), sleepText, sleep, 100, sleep > 25, 1)
	end
end
