---
sidebar_position: 2
---

# Countdown Example

Countdown:
```lua
local TimerCountdown = require(...);
local NewTimerCountdown = TimerCountdown.new();

local Countdown = NewTimerCountdown:Countdown("CountdownName", 10, 1, function(t)
    print("Update has updated: " .. t);
end, true);

Countdown:Connect(function()
    print("Countdown has finished!");
end);
```