ENT.Base = "base_ai"
ENT.Type = "anim"
ENT.PrintName		= "Terminal ( small )"
ENT.Category		= "GTFO ( Test )" 
ENT.Instructions	= "A small simple terminal"
ENT.Spawnable		= true

function ENT:Initialize()
    self:SetModel("models/props_lab/monitor01b.mdl")
    self:SetSolid(SOLID_BBOX)
    if SERVER then self:SetUseType(SIMPLE_USE) end
end