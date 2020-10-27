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

local TerminalVersion = "0.1"

local TerminalTextsList = {
	"- - - - - - - - - - - - - TERMINAL V"..TerminalVersion.." - - - - - - - - - - - - -",
	"For a list of all commands, type \"commands\"",
	"If you need help, type \"help\"",
	"Welcome !",
	"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
	" "
}
local TerminalTextEntryLastText = ""
local TerminalTextEntryCanModify = true

--COMMANDS FUNC & DIC

local CommandsList = {
	"    - \"help\" : show terminal info",
	"    - \"commands\" : show a list of all commands",
	"    - \"cls\" : clear the screen"
}

local TerminalCommandsFunc = function(command,arg)
	if command == "commands" then
		for _,v in pairs(CommandsList) do
			TerminalTextsList[table.getn(TerminalTextsList)+1] = v
		end
		TerminalTextsList[table.getn(TerminalTextsList)+1] = " "
	elseif command == "help" then 
		TerminalTextsList[table.getn(TerminalTextsList)+1] = "actual server: "..GetHostName()
		TerminalTextsList[table.getn(TerminalTextsList)+1] = "status: normal"
		TerminalTextsList[table.getn(TerminalTextsList)+1] = "version: "..TerminalVersion

		TerminalTextEntryCanModify = false
		net.Start("TerminalGetNameFromServer")
		net.SendToServer()
	else
		TerminalTextsList[table.getn(TerminalTextsList)+1] = "\""..command.."\" is not recognized as a command!"
		TerminalTextsList[table.getn(TerminalTextsList)+1] = " "
	end
end

--Terminal - NET

net.Receive("OpenTerminal", function(len, ply)
	local TerminalFrame = vgui.Create("DFrame")
	TerminalFrame:SetPos(WH(640),SH(365))
	TerminalFrame:SetSize(WH(640),SH(350))
	TerminalFrame:SetTitle("")
	TerminalFrame:ShowCloseButton(true)
	function TerminalFrame:Paint(w, h)
		surface.SetDrawColor(Color(0,0,0))
		surface.DrawRect(0,0,w,h)

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
		local CMS1 = ""
		local ARS2 = ""
		local k = 1
		for	v in string.gmatch(string.lower(self:GetValue()),"%S+") do
			if k == 1 then
				CMS1 = v
			elseif k == 2 then
				ARS2 = v 
			end

			k = k + 1
		end
		TerminalCommandsFunc(CMS1,ARS2)
		self:SetText("")
	end

	TerminalFrame.OnClose = function(self)
		TerminalLastTextInEntry = TerminalTextEntry:GetValue()
	end
end)

--TerminalGetNameFromServer - NET

net.Receive("TerminalGetNameFromServer",function(ply)
	TerminalTextsList[table.getn(TerminalTextsList)+1] = "name: "..net.ReadString()
	TerminalTextsList[table.getn(TerminalTextsList)+1] = " "

	TerminalTextEntryCanModify = true
end)