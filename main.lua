--!optimize 2

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local Workspace = game:GetService('Workspace')

local camera = Workspace.CurrentCamera
local plr = Players.LocalPlayer
local util = loadstring(game:HttpGet('https://raw.githubusercontent.com/DevZse/bloxstrike/refs/heads/main/util.lua'))()

local function getTeam()
    return plr:GetAttribute('Team')
end
