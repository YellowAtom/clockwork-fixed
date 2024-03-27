local COMMAND = Clockwork.command:New("PlySearch")

COMMAND.tip = "CmdPlySearch"
COMMAND.text = "CmdPlySearchDesc"
COMMAND.access = "a"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if target then
		if not target.cwBeingSearched then
			if not player:GetSharedVar("IsSearching") then
				target.cwBeingSearched = true
				player:SetSharedVar("IsSearching", true)

				Clockwork.storage:Open(player, {
					name = target:Name(),
					cash = target:GetCash(),
					weight = target:GetMaxWeight(),
					space = target:GetMaxSpace(),
					entity = target,
					inventory = target:GetInventory(),
					OnClose = function(player, storageTable, entity)
						player:SetSharedVar("IsSearching", false)

						if IsValid(entity) then
							entity.cwBeingSearched = nil
						end
					end,
					OnTakeItem = function(player, storageTable, itemTable) end,
					OnGiveItem = function(player, storageTable, itemTable) end
				})
			else
				Clockwork.player:Notify(player, {"YouAreAlreadySearchingCharacter"})
			end
		else
			Clockwork.player:Notify(player, {"PlayerAlreadyBeingSearched", target:Name()})
		end
	else
		Clockwork.player:Notify(player, {"NotValidPlayer", arguments[1]})
	end
end

COMMAND:Register()
