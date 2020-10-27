include("shared.lua") 

function ENT:Draw() 
    self:DrawModel() 
end 

net.Receive("DNLNC", function(len, ply)

	local DK = vgui.Create("DFrame")
	DK:SetPos(0, 0)
	DK:SetSize(1000, 500)
	DK:SetTitle("Terminal d'Arme :")
	DK:ShowCloseButton(true)
	function DK:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100))
		draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
	end

	DK:MakePopup()
	
	local PSTBT = vgui.Create("DButton", DK)
	PSTBT:SetPos(50, 150)
	PSTBT:SetSize(100, 30)
	PSTBT:SetText("Pistolet")
	PSTBT.DoClick = function()
    	net.Start("PSTHL")
    	net.SendToServer()
    	DK:Close()
    	LocalPlayer():ChatPrint("Pistolet HalfLife Choisie")
	end
	function PSTBT:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(250, 250, 250))
		draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
	end

	local SMGBT = vgui.Create("DButton", DK)
	SMGBT:SetPos(200, 150)
	SMGBT:SetSize(100, 30)
	SMGBT:SetText("SMG")
	SMGBT.DoClick = function()
    	net.Start("SMGHL")
    	net.SendToServer()
    	DK:Close()
    	LocalPlayer():ChatPrint("SMG HalfLife Choisie")
	end
	function SMGBT:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(250, 250, 250))
		draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
	end

	local RPGBT = vgui.Create("DButton", DK)
	RPGBT:SetPos(350, 150)
	RPGBT:SetSize(100, 30)
	RPGBT:SetText("RPG")
	RPGBT.DoClick = function()
		net.Start("RPGHL")
		net.SendToServer()
		DK:Close()
		LocalPlayer():ChatPrint("RPG HalfLife Choisie")
	end
	function RPGBT:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(250,250,250))
		draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
	end

	local SHTBT = vgui.Create("DButton", DK)
	SHTBT:SetPos(500, 150)
	SHTBT:SetSize(100, 30)
	SHTBT:SetText("Fusil à Pompe")
	SHTBT.DoClick = function()
		net.Start("SHTHL")
		net.SendToServer()
		DK:Close()
		LocalPlayer():ChatPrint("Fusil à Pompe HalfLife Choisie")
	end
	function SHTBT:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(250,250,250))
		draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
	end

	local AR2BT = vgui.Create("DButton", DK)
	AR2BT:SetPos(650, 150)
	AR2BT:SetSize(100, 30)
	AR2BT:SetText("AR2")
	AR2BT.DoClick = function()
		net.Start("AR2HL")
		net.SendToServer()
		DK:Close()
		LocalPlayer():ChatPrint("AR2 HalfLife Choisie")
	end
	function AR2BT:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(250,250,250))
		draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
	end

	local ARMal = vgui.Create("DButton", DK)
	ARMal:SetPos(400, 250)
	ARMal:SetSize(200, 70)
	ARMal:SetText("Arme Aléatoire")
	ARMal.DoClick = function()
		net.Start("ARMAL")
		net.SendToServer()
		DK:Close()
		LocalPlayer():ChatPrint("Que la chance soit !")
	end

	local NKBT = vgui.Create("DButton", DK)
	NKBT:SetPos(800, 150)
	NKBT:SetSize(150, 30)
	NKBT:SetText("Bombe Nucléaire")
	NKBT.DoClick = function()
		net.Start("NUKE")
		net.SendToServer()
		DK:Close()
		LocalPlayer():ChatPrint("Ca vas faire BOOM")
	end
	function NKBT:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(250,250,250))
		draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
	end
end)

net.Receive("NBD", function(ply)
	LocalPlayer():ChatPrint("ET, HOP, Tu ne gagne rien !")
end)