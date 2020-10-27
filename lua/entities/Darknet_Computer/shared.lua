ENT.Base = "base_ai"
ENT.Type = "anim"
ENT.PrintName		= "DarkNet Computer"
ENT.Category		= "DarkNet" 
ENT.Instructions	= ""
ENT.Spawnable		= true

function ENT:Initialize()
    self:SetModel("models/testmodels/macbook_pro.mdl")
    self:SetSolid(SOLID_BBOX)
    if SERVER then self:SetUseType(SIMPLE_USE) end
end