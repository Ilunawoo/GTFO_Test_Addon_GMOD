include("shared.lua") 

function ENT:Draw() 
    self:DrawModel() 
end

local SH = function(Y)
    return ScrH()/(1080/Y)
end
local WH = function(X)
    return ScrW()/(1920/X)
end

--VARs

local TerminalTextsList = {

}
local TerminalLastUseTextInEntry = ""

--Terminal

net.Receive("OpenTerminal", function(len, ply)
	local TerminalFrame = vgui.Create("DFrame")
	TerminalFrame:SetPos(WH(1920/2/1.5),SH(1080/2/1.5))
	TerminalFrame:SetSize(WH(1920/3),SH(1080/3))
	TerminalFrame:SetTitle("")
	TerminalFrame:ShowCloseButton(true)
	function TerminalFrame:Paint(w, h)
		surface.SetDrawColor(Color(0,0,0))
		surface.DrawRect(0,0,w,h)
	end

	TerminalFrame:MakePopup()
	
	--local PSTBT = vgui.Create("DButton", DK)
	--PSTBT:SetPos(50, 150)
	--PSTBT:SetSize(100, 30)
	--PSTBT:SetText("Pistolet")
	--PSTBT.DoClick = function()
    --	net.Start("PSTHL")
    --	net.SendToServer()
    --	DK:Close()
    --	LocalPlayer():ChatPrint("Pistolet HalfLife Choisie")
	--end
	--function PSTBT:Paint(w, h)
	--	draw.RoundedBox(0, 0, 0, w, h, Color(250, 250, 250))
	--	draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
	--end
end)