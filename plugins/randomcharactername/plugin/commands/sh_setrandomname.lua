local COMMAND = Clockwork.command:New("CharGenName")
COMMAND.tip = "Gives a player a random first and last name."
COMMAND.text = "<string Name>"
COMMAND.access = "o"
COMMAND.arguments = 1

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if (target) then
		local MakeName = function()
			local frontnamesm = string.Explode("\r\n", file.Read("namegen/malenames.txt", "DATA"))
			local frontnamesf = string.Explode("\r\n", file.Read("namegen/femalenames.txt", "DATA"))
			local surnames = string.Explode("\r\n", file.Read("namegen/surnames.txt", "DATA"))
			local fname = ""
			local sname = ""
			if target:GetGender() == GENDER_MALE then
				fname = frontnamesm[math.random((#frontnamesm))]
				sname = surnames[math.random((#surnames))]
			else
				fname = frontnamesf[math.random((#frontnamesf))]
				sname = surnames[math.random((#surnames))]
			end
			return fname .. " " .. sname
		end
		local name = MakeName()

		--Clockwork.player:NotifyAll(player:Name() .." set ".. target:Name() .."'s name to " .. name .. ".")
		Clockwork.player:SetName(target, name)
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!")
	end
end

COMMAND:Register()