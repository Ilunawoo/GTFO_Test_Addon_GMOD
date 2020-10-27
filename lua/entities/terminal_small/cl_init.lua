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
local TerminalTextEntryLastText = ""
local TerminalTextEntryCanModify = true

--Terminal

net.Receive("OpenTerminal", function(len, ply)
	local TerminalFrame = vgui.Create("DFrame")
	TerminalFrame:SetPos(WH(640),SH(365))
	TerminalFrame:SetSize(WH(640),SH(350))
	TerminalFrame:SetTitle("")
	TerminalFrame:ShowCloseButton(true)
	function TerminalFrame:Paint(w, h)
		surface.SetDrawColor(Color(0,0,0))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(Color(100,100,100))
		surface.DrawRect(0,SH(314),WH(640),SH(2))

		surface.SetFont("HUDHltFontS")
		surface.SetTextColor(255,255,255,255)

		for i=1,table.getn(TerminalTextsList),1 do
			surface.SetTextPos(WH(15),SH(280-(table.getn(TerminalTextsList)-i)*20))
			surface.DrawText(TerminalTextsList[i])
		end
	end

	TerminalFrame:MakePopup()
	
	local TerminalTextEntry = vgui.Create("DTextEntry",TerminalFrame)
	TerminalTextEntry:SetPos(WH(10),SH(320))
	TerminalTextEntry:SetSize(WH(620),SH(25))
	TerminalTextEntry:SetFont("HUDHltFontS")
	TerminalTextEntry:SetValue(TerminalTextEntryLastText)
	TerminalTextEntry.OnChange = function(self)
		if !TerminalTextEntryCanModify then
			self:SetText("")
		end
	end
	TerminalTextEntry.OnEnter = function(self)
		TerminalTextsList[table.getn(TerminalTextsList)+1] = ">> "..self:GetValue()
		self:SetText("")
	end

	TerminalFrame.OnClose = function(self)
		TerminalLastTextInEntry = TerminalTextEntry:GetValue()
	end
end)