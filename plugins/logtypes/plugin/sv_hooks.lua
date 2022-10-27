local PLUGIN = PLUGIN;
local Clockwork = Clockwork;
local cwKernel = Clockwork.kernel;

function PLUGIN:PlayerSpawnedSENT(player, entity)
  if(IsValid(entity)) then
    cwKernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has spawned " .. tostring(entity) .. ".");
  end;
end;

function PLUGIN:PlayerSpawnedRagdoll(player, model, entity)
  if(IsValid(entity)) then
    cwKernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has spawned the ragdoll " .. tostring(model) .. ".");
  end;
end;

function PLUGIN:PlayerSpawnedEffect(player, model, entity)
  if(IsValid(entity)) then
    cwKernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has spawned " .. tostring(model) .. ".");
  end;
end;

function PLUGIN:PlayerSpawnedVehicle(player, entity)
  if(IsValid(entity)) then
    cwKernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has spawned " .. tostring(entity) .. ".");
  end;
end;

function PLUGIN:PlayerSpawnedSWEP(player, entity)
  if(IsValid(entity)) then
    cwKernel:PrintLog(LOGTYPE_MAJOR, player:Name() .. " has spawned " .. tostring(entity) .. ".");
  end;
end;
