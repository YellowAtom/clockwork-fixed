/* -------------------------------------------------------------------------- */
/*                                   Config                                   */
/* -------------------------------------------------------------------------- */
-- function Clockwork.config:Add(key, value, isShared, isGlobal, isStatic, isPrivate, needsRestart)
Clockwork.config:Add("runechat_minplayers", 1, true, true)
Clockwork.config:Add("runechat_messagelen", 32, true, true)
Clockwork.config:Add("runechat_messagetime", 5, true, true)
Clockwork.config:Add("runechat_max", 3, true, true)
Clockwork.config:Add("runechat_enabled", true, true, true)
Clockwork.config:Add("runechat_range", 512, true, true)

util.AddNetworkString("cwRunechatAddMessage")

local allowedClasses = {
    ["ic"] = true,
    ["yell"] = true,
    ["whisper"] = true,
    ["me"] = true,
    ["mel"] = true,
    ["mec"] = true,
    ["looc"] = false, -- Enable LOOC here.
    ["ooc"] = false, -- Enable OOC here.
    ["radio"] = false, -- Enable Radio here.
    ["request"] = true, -- Enable Request Device here
}

function runechat:ChatBoxMessageAdded(info)
    if (not Clockwork.config:Get("runechat_enabled"):Get()) then return end
    local listeners = info.listeners
    local speaker = info.speaker
    local text = info.text
    local class = info.class
    
    if not allowedClasses[class] then return end

    local range = Clockwork.config:Get("runechat_range"):Get() or 2048
    local speakerPos = speaker:GetPos()


    for _, ply in ipairs(listeners) do
        if not IsValid(ply) then continue end
        local distance = ply:GetPos():Distance(speakerPos)
        if (distance > range) then continue end
        
        net.Start("cwRunechatAddMessage")
        net.WriteEntity(speaker)
        net.WriteString(text)
        net.WriteString(class)
        net.Send(ply)
    end
end