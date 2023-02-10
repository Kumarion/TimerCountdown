local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = ReplicatedStorage:WaitForChild("lib");
local TimerCountdown = require(Lib:WaitForChild("TimerCountdown"));

local newTimerCountdown = TimerCountdown.new();

local function updateFn(time)
    print(time);
end

-- Make a countdown called "testCountdown" that counts down from 10 to 0
local countdownFinished = newTimerCountdown:Countdown("testCountdown", 10, 1, updateFn, true);

countdownFinished:Connect(function()
    print("testCountdown finished!");
end)