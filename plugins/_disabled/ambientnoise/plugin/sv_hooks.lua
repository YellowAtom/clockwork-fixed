local PLUGIN = PLUGIN;
local math = math;
 
local randomSounds = {
    "items/battery_pickup.wav",
	"ambient/alarms/apc_alarm_pass1.wav",
	"physics/wood/wood_crate_impact_hard2.wav",
	"physics/wood/wood_crate_impact_hard3.wav",
	"doors/default_locked.wav",
	"doors/default_move.wav",
	"doors/default_stop.wav",
	"doors/door1_stop.wav",
	"doors/door_latch1.wav",
	"doors/door_latch3.wav",
	"doors/door_locked2.wav",
	"doors/latchlocked2.wav",
	"doors/latchunlocked1.wav",
	"doors/wood_move1.wav",
	"doors/wood_stop1.wav",
	"buttons/combine_button1.wav",
	"buttons/combine_button2.wav",
	"buttons/combine_button3.wav",
	"buttons/combine_button5.wav",
	"buttons/combine_button7.wav",
	"buttons/combine_button_locked.wav"
};
 
-- A function to emit a random sound
function PLUGIN:EmitRandomChatter(player)
    --[[
   
    -- Alternative sound emitter. Lowers the emitter's receiving sound but doesn't follow the player.
    for k,v in ipairs( _player.GetAll() ) do
        if (Schema:PlayerIsCombine(v)) then
            local pos = v:GetBonePosition(10)
            sound.Play( randomSounds[ math.random(1, #randomSounds) ], pos, 300, 100, 0.4 )
        end;
    end;
    ]]--

  
        pitch = math.random(95,105)
        volume = math.random(0.1,0.5)
   
    local randomSound = randomSounds[math.random(1, #randomSounds)];
    player:EmitSound(randomSound, 65, pitch, volume);
end;
 
function PLUGIN:PlayerThink(player, curTime)
    if ((player.nextChatterEmit or 0) < curTime) then
        if (!player:IsNoClipping() and player:Alive()) then
            player.nextChatterEmit = curTime + math.random(60, 180);
            PLUGIN:EmitRandomChatter(player);
        else
            player.nextChatterEmit = curTime + 180;
        end;
    end;
end;