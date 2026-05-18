
Clockwork.config:AddToSystem("Take Physcannon", "take_physcannon", "Whether or not the player is stripped of the physics cannon.")

-- Client-side rotation state.
cwPickupObjects.isRotating = false

-- InputMouseApply hook: when ALT is held and player is holding an object,
-- lock the view and send rotation deltas to the server.
hook.Add("InputMouseApply", "cwPickupObjects.Rotate", function(cmd, x, y, screenAngle)
	local client = Clockwork.Client

	if not IsValid(client) then return end
	if not client:GetSharedVar("IsHolding") then
		cwPickupObjects.isRotating = false
		return
	end

	if not input.IsKeyDown(KEY_LALT) then
		cwPickupObjects.isRotating = false
		return
	end

	-- ALT is held and player is holding an object.
	cwPickupObjects.isRotating = true

	local pitch = -y
	local yaw = x

	-- Only send if there's actual input.
	if pitch ~= 0 or yaw ~= 0 then
		net.Start("cwPickupRotate")
			net.WriteFloat(pitch)
			net.WriteFloat(yaw)
		net.SendToServer()
	end

	-- Return true to prevent the engine from applying mouse to view angles.
	return true
end)
