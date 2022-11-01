
function cwStoreFlag:ClockworkItemInitialized(itemTable)
	if itemTable.access and not string.find(itemTable.access, 'N') then
		itemTable.access = itemTable.access .. "N"
	end
end
