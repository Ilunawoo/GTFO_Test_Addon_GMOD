AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("DNLNC")
util.AddNetworkString("PSTHL")
util.AddNetworkString("SMGHL")
util.AddNetworkString("RPGHL")
util.AddNetworkString("SHTHL")
util.AddNetworkString("AR2HL")
util.AddNetworkString("ARMAL")
util.AddNetworkString("NUKE")
util.AddNetworkString("NBD")

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
        net.Start("DNLNC")
        net.Send(ply)
    	local PLN = ply:Name()
    	print(PLN)
    end
end

net.Receive("PSTHL", function(len, ply)
	ply:Give( "weapon_pistol", true )
	ply:GiveAmmo( 1000, "Pistol", true)
end)

net.Receive("SMGHL", function(len, ply)
	ply:Give( "weapon_SMG1", true )
	ply:GiveAmmo( 1000, "SMG1", true)
end)

net.Receive("RPGHL", function(len, ply)
	ply:Give("weapon_RPG", true )
	ply:GiveAmmo( 100, "RPG_Round", true)
end)

net.Receive("SHTHL", function(len, ply)
	ply:Give("weapon_shotgun", true )
	ply:GiveAmmo( 1000, "Buckshot", true)
end)

net.Receive("AR2HL", function(len, ply)
	ply:Give("weapon_ar2", true)
	ply:GiveAmmo( 1000, "AR2", true)
	ply:GiveAmmo( 100, "AR2AltFire", true)
end)

net.Receive("NUKE", function(len, ply)
	ply:Give("m9k_davy_crockett", false )
end)

net.Receive("ARMAL", function(len, ply)
	local randomnumber = math.random(1,6)
	if randomnumber == 1 then
		ply:Give("weapon_pistol", true )
		ply:GiveAmmo( 1000, "Pistol", true)
	elseif randomnumber == 2 then
		ply:Give("weapon_SMG1", true )
		ply:GiveAmmo( 1000, "SMG1", true)
	elseif randomnumber == 3 then
		ply:Give("weapon_RPG", true )
		ply:GiveAmmo( 100, "RPG_Round", true)
	elseif randomnumber == 4 then
		ply:Give("weapon_shotgun", true )
		ply:GiveAmmo( 1000, "Buckshot", true)
	elseif randomnumber == 5 then
		ply:Give("weapon_ar2", true)
		ply:GiveAmmo( 1000, "AR2", true)
		ply:GiveAmmo( 100, "AR2AltFire", true)
	elseif randomnumber == 6 then
		net.Start("NBD")
		net.Send()
	end
end)