local PLUGIN = PLUGIN;

cwHeartBeat.lastHeartbeatAmount = 0;
cwHeartBeat.nextHeartbeatCheck = 0;
cwHeartBeat.heartbeatGradient = Material("gui/gradient_down");
cwHeartBeat.heartbeatOverlay = Material("effects/combine_binocoverlay");
cwHeartBeat.heartbeatPoints = {};
cwHeartBeat.heartbeatPoint = Material("sprites/glow04_noz");