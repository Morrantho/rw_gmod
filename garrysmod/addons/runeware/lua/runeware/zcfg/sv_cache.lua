if !cache.enabled then return; end
local ceil=math.ceil;
local tickrate=engine.TickInterval;
cache.tickrate = ceil(1/tickrate());