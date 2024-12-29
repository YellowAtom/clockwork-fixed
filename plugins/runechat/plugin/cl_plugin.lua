/* -------------------------------------------------------------------------- */
/*                               Config & Setup                               */
/* -------------------------------------------------------------------------- */
-- function Clockwork.config:AddToSystem(name, key, help, minimum, maximum, decimals, category)
Clockwork.config:AddToSystem("Runechat - Enabled", "runechat_enabled", "Enables Runechat behaviour.")
Clockwork.config:AddToSystem("Runechat - Minimum Players", "runechat_minplayers", "Minimum players before runechat shows up.", 1, 32, 0, "Runechat")
Clockwork.config:AddToSystem("Runechat - Message Length", "runechat_messagelen", "Message Length for runechat text.", 8, 256, 0, "Runechat")
Clockwork.config:AddToSystem("Runechat - Message Time", "runechat_messagetime", "Time runechat text stays on screen.", 1, 60, nil, "Runechat")
Clockwork.config:AddToSystem("Runechat - Maximum Messages", "runechat_max", "The maximum amount of messages allowed to display.", 1, 16, 0, "Runechat")
Clockwork.config:AddToSystem("Runechat - Range", "runechat_range", "The range to consider activating runechat if crowded..", 8, 2048, nil, "Runechat")

Clockwork.kernel:CreateClientConVar("cwRunechatEnable", 1, true, true)
Clockwork.setting:AddCheckBox("Framework", "Enable Runechat", "cwRunechatEnable", "Whether or not to draw runechat (shortened version of their messages above player heads) for you.", function () return Clockwork.config:Get("runechat_enabled"):Get() end)

runechat = runechat or {}
runechat.messages = runechat.messages or {}
runechat.opacity = 190 -- Overall opacity for runechat
runechat.font = "runechat"
runechat.fontYell = "runechatYell"
runechat.fontWhisper = "runechatWhisper"
runechat.fontAction = "runechat"
runechat.fontRadio = "runechat"

local classFormat = {
    ["default"] = "'%s'",
    ["ic"]      = "\"%s\"",
    ["yell"]    = "\"%s\"",
    ["whisper"] = "\"%s\"",
    ["looc"]    = "[%s]",
    ["ooc"]     = "[%s]",
    ["radio"]   = ": %s :",
    ["request"] = "! %s !",
    ["me"]      = "*** %s",
    ["mec"]      = "* %s",
    ["mel"]      = "***** %s",
}

local classColors = {
    ["default"] = Color(92,92,92),
    ["ic"]      = Color(255, 255, 150),
    ["yell"]    = Color(255, 255, 175),
    ["whisper"] = Color(255, 255, 175),
    ["looc"]    = Color(226,158,158),
    ["ooc"]     = Color(255,255,255),
    ["radio"]   = Color(75, 150, 50),
    ["request"] = Color(200,125,45),
    ["me"]      = Color(248,235,119),
    ["mel"]      = Color(248,235,119),
    ["mec"]      = Color(248,235,119),
}

local classFonts = {
    ["ic"]      = runechat.font,
    ["yell"]    = runechat.fontYell,
    ["whisper"] = runechat.fontWhisper,
    ["looc"]    = runechat.font,
    ["ooc"]     = runechat.font,
    ["radio"]   = runechat.font,
    ["request"] = runechat.font,
    ["me"]      = runechat.font,
    ["mel"]      = runechat.fontYell,
    ["mec"]      = runechat.fontWhisper
}

/* -------------------------------------------------------------------------- */
/*                                    Fonts                                   */
/* -------------------------------------------------------------------------- */
local FONT_USED = "GorDIN"

surface.CreateFont("runechat", {
    size = Clockwork.kernel:FontScreenScale(8),
    weight = 400, 
    antialias = true,
    font = FONT_USED,
    italic = false,
});

surface.CreateFont("runechatWhisper", {
    size = Clockwork.kernel:FontScreenScale(4),
    weight = 400, 
    antialias = true,
    font = FONT_USED,
    italic = true,
});

surface.CreateFont("runechatYell", {
    size = Clockwork.kernel:FontScreenScale(16),
    weight = 400, 
    antialias = true,
    font = FONT_USED,
    italic = false,
});

/* -------------------------------------------------------------------------- */
/*                                  Rendering                                 */
/* -------------------------------------------------------------------------- */

local function IsPlayerVisibleToLocalPlayer(ply)
    local traceData = {
        start = LocalPlayer():EyePos(),
        endpos = ply:EyePos(),
        filter = {LocalPlayer(), ply}
    }
    local trace = util.TraceLine(traceData)
    return not trace.Hit or trace.Entity == ply
end

hook.Add("PostDrawEffects", "cwRunechatRender", function()
    if (not Clockwork.config:Get("runechat_enabled"):Get()) then return end
    if (LocalPlayer():GetInfoNum("cwRunechatEnable", 1) == 0) then return end
    local minPlayers = math.Round(Clockwork.config:Get("runechat_minplayers"):Get() or 1)
    local range = math.Round(Clockwork.config:Get("runechat_range"):Get() or 2048)

    for _, ply in ipairs(player.GetAll()) do
        if not IsValid(ply) or not ply:Alive() then continue end
        if not IsPlayerVisibleToLocalPlayer(ply) then continue end
        if Clockwork.player:IsNoClipping(Clockwork.Client) then continue end
        if (ply == LocalPlayer() and (not Clockwork.Client:GetThirdPerson())) then continue end

        local nearbyCount = 0
        -- Count players within the specified range
        for _, other in ipairs(player.GetAll()) do
            if not IsValid(other) or not other:Alive() then continue end -- (or other == ply) add this to stop counting yourself.
            if ply:GetPos():DistToSqr(other:GetPos()) <= (range * range) then
                nearbyCount = nearbyCount + 1
            end
        end

        -- Adjust opacity based on player proximity or count
        if nearbyCount < minPlayers then
            runechat.opacity = math.max(runechat.opacity - FrameTime() * 100, 0)
        else
            runechat.opacity = math.min(runechat.opacity + FrameTime() * 100, 190)
        end

        if runechat.opacity <= 0 then continue end -- Skip if completely faded

        local messages = runechat.messages[ply]
        if not messages or #messages == 0 then continue end

        local height = 12
        local pos = (ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1")) + Vector(0,0,height)) or (ply:GetPos() + Vector(0, 0, 72+height))
        local offsetY = 0
        for i = #messages, 1, -1 do -- Draw messages in reverse order
            local runemsg = messages[i]
            if not runemsg or not runemsg.text then continue end

            local remainingTime = runemsg.time - CurTime()
            local messageOpacity = runechat.opacity
            
            -- If ragdolled, fade faster.
            if (ply:IsRagdolled()) then
                if (remainingTime > 2) then
                    runemsg.time = CurTime() + 1
                end
            end

            -- Fade messages with less than 2 seconds left
            if remainingTime <= 2 then
                messageOpacity = math.max((remainingTime / 2) * 255, 0)
            end
            
            -- Respect overall opacity
            messageOpacity = math.min(messageOpacity, runechat.opacity)            

            local color = classColors[runemsg.class]
            color.a = messageOpacity

            local font = classFonts[runemsg.class] or runechat.font or "Monofonto"
            
            local screenPos = (pos + Vector(0, 0, offsetY)):ToScreen()
            if screenPos.visible then
                cam.Start2D()
                draw.NoTexture()
                surface.SetDrawColor(color)
                draw.SimpleTextOutlined(
                    runemsg.text,
                    font,
                    screenPos.x,
                    screenPos.y,
                    color,
                    TEXT_ALIGN_CENTER,
                    TEXT_ALIGN_CENTER,
                    0.5,
                    Color(0,0,0, messageOpacity)
                )
                cam.End2D()
            end
            offsetY = offsetY + 6 -- Spacing between messages
        end
    end
end)

/* -------------------------------------------------------------------------- */
/*                                 Processing                                 */
/* -------------------------------------------------------------------------- */

function AddRunechatMessage(ply, text, class)
    if not IsValid(ply) then return end
    local maxMessages = math.floor(Clockwork.config:Get("runechat_max"):Get() or 3)
    local messageLength = math.floor(Clockwork.config:Get("runechat_messagelen"):Get() or 32)
    local class = class or "default"
    local text = text
    
    local formattedText = string.sub(text, 1, messageLength) -- Truncate to max length
    if (string.len(text) > messageLength) then 
        formattedText = formattedText .. "..."
    end
    formattedText = string.format(classFormat[class], formattedText)

    runechat.messages[ply] = runechat.messages[ply] or {}
    local runemsg = {
        text = formattedText,
        time = CurTime() + (Clockwork.config:Get("runechat_messagetime"):Get() or 5),
        class = class
    }

    table.insert(runechat.messages[ply], runemsg)

    -- Remove oldest messages if exceeding maxMessages
    if #runechat.messages[ply] > maxMessages then
        table.remove(runechat.messages[ply], 1)
    end
end

function PLUGIN:Think()
    for ply, messages in pairs(runechat.messages) do
        for i = #messages, 1, -1 do
            local runemsg = messages[i]
            if runemsg.time <= CurTime() then
                table.remove(messages, i) -- Remove expired messages
            end
        end

        -- Remove the player entry if no messages left
        if #messages == 0 then
            runechat.messages[ply] = nil
        end
    end
end

net.Receive("cwRunechatAddMessage", function ()
    local ply = net.ReadEntity()
    local text = net.ReadString()
    local class = net.ReadString()
    AddRunechatMessage(ply, text, class)
end)