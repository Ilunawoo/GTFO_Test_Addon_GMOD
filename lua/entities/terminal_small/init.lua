AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("OpenTerminal")
util.AddNetworkString("TerminalGetNameFromServer")

local ENTName = "TERMINAL"

function ENT:SpawnFunction(ply, tr, classname)
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create(classname)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Use(act, ply) 
    if IsValid(ply) and ply:IsPlayer() then
        net.Start("OpenTerminal")
        net.Send(ply)
    end
end

net.Receive("TerminalGetNameFromServer",function(len,ply)
	net.Start("TerminalGetNameFromServer")
	net.WriteString(ENTName)
	net.Send(ply)
	print(ENTName)
end)