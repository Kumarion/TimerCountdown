-- Imports
local Signal = require(script.Signal);
local SleitnickTimer = require(script.Timer);

--[=[
	@class TimerCountdown

    The TimerCountdown class that returns a new TimerCountdown object with functions to create timers and countdowns.
]=]
local TimerCountdown = {};
TimerCountdown.__index = TimerCountdown;

--[=[
	@return TimerCountdown
	
	Creates a new timer object.
]=]
function TimerCountdown.new()
    local self = setmetatable({}, TimerCountdown);
    self._timers = {};
    return self;
end

--[=[
	@param countdownName string
    @param start number
    @param interval number
    @param updateFn function
    @param stopAtZero boolean

	Uses Sleitnicks Timer module to create a ``Simple`` timer that counts down from ``start`` to 0.
    Returns a signal that fires when the countdown is finished.

    If ``stopAtZero`` is true, the countdown will stop at 0. If it is false, the countdown will stop at 1.

    Countdown is automatically disconnected at the end of the countdown.

    @return Signal
]=]
function TimerCountdown:Countdown(countdownName, start, interval, updateFn, stopAtZero)
    local finished = Signal.new();
    local currTime = start;

    local cn
    cn = SleitnickTimer.Simple(interval, function()
        updateFn(currTime);
        currTime -= interval;
        local stopAt = if (stopAtZero) then -1 else 0;
        if (currTime <= stopAt) then
            finished:Fire();
            cn:Disconnect();
        end;
    end, true);

    self._timers[countdownName] = cn;
    return finished;
end

--[=[
    @param timerName string
    @param endT number
    @param interval number
    @param updateFn function

    Uses Sleitnicks Timer module to create a ``Simple`` timer that counts up from 0 to ``endT``.
    Returns a signal that fires when the timer is finished.

    Timer is automatically disconnected at the end of the timer.
    
    @return Signal
]=]
function TimerCountdown:Timer(timerName, endT, interval, updateFn)
    local finished = Signal.new();
    local currTime = 0;
    local cn
    cn = SleitnickTimer.Simple(interval, function()
        updateFn(currTime);
        currTime += interval;
        if (currTime >= endT) then
            finished:Fire();
            cn:Disconnect();
        end;
    end, true);

    self._timers[timerName] = cn;
    return finished;
end

--[=[
    @param name string
    Destroys the timer/countdown with the name ``name``.
]=]
function TimerCountdown:Destroy(name)
    local cn = self._timers[name];
    if (cn) then
        cn:Disconnect();
        self._timers[name] = nil;
    end;
end

return TimerCountdown;