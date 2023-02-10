---
sidebar_position: 3
---

# Timer Example

Timer:
```lua
local TimerCountdown = require(...);
local NewTimerCountdown = TimerCountdown.new();

local Timer = NewTimerCountdown:Timer("TimerName", 10, 1, function(t)
    print("Timer has updated " .. t);
end);

Timer:Connect(function()
    print("Timer has finished!");
end);
```