local COMMAND = Clockwork.command:New("SalesmanPaste")

COMMAND.tip = "Paste copied salesman data to create a new salesman at your target position."
COMMAND.text = "< None >"
COMMAND.flags = CMD_DEFAULT
COMMAND.access = "s"

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	-- Check if player has copied salesman data
	if not player.cwSalesmanClipboard then
		Clockwork.player:Notify(player, "You haven't copied any salesman data! Use SalesmanCopy first.")
		return
	end

	local salesmanData = player.cwSalesmanClipboard

	-- Validate that we have the minimum required data
	if not salesmanData.name or not salesmanData.model then
		Clockwork.player:Notify(player, "Copied salesman data is incomplete!")
		return
	end

	-- Set spawn position (use player's eye trace hit position)
	local trace = player:GetEyeTraceNoCursor()
	local spawnPos = trace.HitPos
	local angles = player:GetAngles()
	angles.pitch = 0
	angles.roll = 0
	angles.yaw = angles.yaw + 180

	-- Create the salesman entity
	local salesman = ents.Create("cw_salesman")
	salesman:SetPos(spawnPos)
	salesman:SetAngles(angles)
	salesman:SetModel(salesmanData.model)
	salesman:Spawn()

	-- Apply all the salesman properties from copied data
	if salesmanData.cash then
		salesman.cwCash = salesmanData.cash
	end

	if salesmanData.stock then
		salesman.cwStock = salesmanData.stock
	end

	if salesmanData.buyTab then
		salesman.cwBuyTab = salesmanData.buyTab
	end

	if salesmanData.sellTab then
		salesman.cwSellTab = salesmanData.sellTab
	end

	if salesmanData.textTab then
		salesman.cwTextTab = salesmanData.textTab
	end

	if salesmanData.classes then
		salesman.cwClasses = salesmanData.classes
	end

	if salesmanData.buyRate then
		salesman.cwBuyRate = salesmanData.buyRate
	end

	if salesmanData.factions then
		salesman.cwFactions = salesmanData.factions
	end

	if salesmanData.priceScale then
		salesman.cwPriceScale = salesmanData.priceScale
	end

	if salesmanData.buyInShipments then
		salesman.cwBuyInShipments = salesmanData.buyInShipments
	end

	if salesmanData.animation then
		salesman.cwAnimation = salesmanData.animation
	end

	if salesmanData.physDesc then
		salesman:SetNWString("PhysDesc", salesmanData.physDesc)
	end

	-- Apply visual properties
	if salesmanData.material then
		salesman:SetMaterial(salesmanData.material)
	end

	if salesmanData.color then
		salesman:SetColor(salesmanData.color)
	end

	if salesmanData.renderMode then
		salesman:SetRenderMode(salesmanData.renderMode)
	end

	if salesmanData.renderFX then
		salesman:SetRenderFX(salesmanData.renderFX)
	end

	if salesmanData.skin then
		salesman:SetSkin(salesmanData.skin)
	end

	-- Apply body groups if they exist
	if salesmanData.bodyGroups then
		for bodyGroupId, value in pairs(salesmanData.bodyGroups) do
			salesman:SetBodygroup(bodyGroupId, value)
		end
	end

	-- Apply flex data if it exists
	if salesmanData.flexes then
		for flexId, weight in pairs(salesmanData.flexes) do
			salesman:SetFlexWeight(tonumber(flexId), weight)
		end
	end

	-- Setup the salesman with name, description, animation, and chat bubble
	local showChatBubble = salesmanData.showChatBubble or false
	salesman:SetupSalesman(salesmanData.name, salesmanData.physDesc or "", salesmanData.animation, showChatBubble)

	-- Make it safe and add to the salesmen table
	Clockwork.entity:MakeSafe(salesman, true, true)
	cwSalesmen.salesmen[#cwSalesmen.salesmen + 1] = salesman

	-- Save the salesmen data
	cwSalesmen:SaveSalesmen()

	-- Clear the clipboard
	player.cwSalesmanClipboard = nil

	Clockwork.player:Notify(player, "Salesman pasted successfully at your target position!")
end

COMMAND:Register()
