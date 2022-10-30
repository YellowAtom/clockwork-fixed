function PLUGIN:PhysgunPickup(player, entity)
    print(player);
    print(entity);
    local playerCharacterKey = player:GetCharacterKey();
    local ownerCharacterKey = entity:GetOwnerKey();
    
    if (playerOwnerKey != ownerCharacterKey and !Clockwork.player:IsAdmin(player)) then
        return false;
    end;
end;