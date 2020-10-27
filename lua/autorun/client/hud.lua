local SH = function(Y)
    return ScrH()/(1080/Y)
end
local WH = function(X)
    return ScrW()/(1920/X)
end

local DrawCSRect = function(Mat,Col,X,Y,W,H)
    surface.SetMaterial(Mat)
    surface.SetDrawColor(Col)
    surface.DrawTexturedRect(WH(X),SH(Y),WH(W),SH(H))
end

local CsPlayer = ""


surface.CreateFont( "HUDHltFont", {font = "Euro Caps", extended = true, size = WH(30), weight = 1000} )
surface.CreateFont( "HUDHltFontS", {font = "Euro Caps", extended = true, size = WH(25), weight = 1000} )
surface.CreateFont( "HUDHltFontT", {font = "Euro Caps", extended = true, size = WH(50), weight = 1000} )
local HUDPosSize = function()
    WH1 = WH(1)

    ArrayPosSize = {}

    ArrayPosSize["health"] = {}
    ArrayPosSize["health"]["barrelf"] = {
        ScrW()/2-WH(440),
        SH(900),
        WH(380),
        SH(6),
        ScrW()/2+(WH(440)-WH(380))
    }
    ArrayPosSize["health"]["barrels"] = {
        ScrW()/2-WH(433),
        SH(887),
        WH(380),
        SH(5),
        ScrW()/2+(WH(433)-WH(380))
    }
    ArrayPosSize["health"]["barrelt"] = {
        ScrW()/2-WH(439),
        SH(901),
        WH(378),
        SH(4),
        ScrW()/2+(WH(439)-WH(378))
    }
    ArrayPosSize["health"]["text"] = {
        ScrW()/2,
        SH(902),
    }

    ArrayPosSize["armor"] = {}
    ArrayPosSize["armor"]["barrelf"] = {
        ScrW()/2-WH(440),
        SH(879),
        WH(390),
        SH(4),
        ScrW()/2+(WH(440)-WH(390))
    }
    ArrayPosSize["armor"]["text"] = {
        ScrW()/2-WH(440),
        SH(860),
    }

    ArrayPosSize["ammo"] = {}
    ArrayPosSize["ammo"]["fond"] = {
        Color(255,255,255,255),
        WH(1920-350),
        SH(50),
        WH(300),
        SH(100)
    }
    ArrayPosSize["ammo"]["fondextension"] = {
        Color(65,65,65,85),
        WH(1920-50),
        SH(87),
        WH(35),
        SH(26)
    }
    ArrayPosSize["ammo"]["weaponname"] = {
        Color(200,200,200,180),
        WH(1920-110),
        SH(50)
    }
    ArrayPosSize["ammo"]["ammocount"] = {
        Color(200,200,200,180),
        WH(1920-110-52),
        SH(104)
    }
    ArrayPosSize["ammo"]["ammocount2"] = {
        Color(200,200,200,180),
        WH(1920-100),
        SH(123)
    }
    ArrayPosSize["ammo"]["ammoindicator"] = {
        Color(200,200,200,180),
        WH(1920-22),
        SH(100)
    }
end
HUDPosSize()

local PNGs = {}

PNGs["fond"] = {}
PNGs["fond"]["weapons"] = Material("fond_weapons.png","unlitgeneric smooth")

--------------------------------------------

hook.Add("OnScreenSizeChanged","",function()
    HUDPosSize()
end)

hook.Add("HUDPaint","",function()
    --first exec
    if CsPlayer != LocalPlayer() then
        CsPlayer = LocalPlayer()
    end

    --health
    local OwHlt = CsPlayer:Health()

    if OwHlt <= 100 then
        HUDHltCol = OwHlt * 2.55
        HUDHltColR = 255 - (( OwHlt * 0.6 - 60 ) * -1 )
        HUDHltS = ArrayPosSize["health"]["barrelf"][3] - (( OwHlt * (WH(380) / 100) - WH(380) ) * -1 )
        HUDHltP = {
            ArrayPosSize["health"]["barrelf"][1] + (( HUDHltS - WH(380) ) * -1 ),
            ArrayPosSize["health"]["barrels"][1] + (( HUDHltS - WH(380) ) * -1 ),
        }
        HUDHltFont = "HUDHltFont"
        HUDHltVar = OwHlt.."%"
    else
        HUDHltCol = 255
        HUDHltColR = 255
        HUDHltS = ArrayPosSize["health"]["barrelf"][3]
        HUDHltP = {
            ArrayPosSize["health"]["barrelf"][1],
            ArrayPosSize["health"]["barrels"][1]
        }
        HUDHltFont = "HUDHltFontS"
        HUDHltVar = OwHlt
    end

    local PS = ArrayPosSize["health"]["barrelt"]
    draw.RoundedBox(WH1,PS[1],PS[2],PS[3],PS[4],Color(75,75,75,125))
    draw.RoundedBox(WH1,PS[5],PS[2],PS[3],PS[4],Color(75,75,75,125))
    local PS = ArrayPosSize["health"]["barrelf"]
    draw.RoundedBox(WH1,HUDHltP[1],PS[2],HUDHltS,PS[4],Color(HUDHltColR,HUDHltCol,HUDHltCol,200))
    draw.RoundedBox(WH1,PS[5],PS[2],HUDHltS,PS[4],Color(HUDHltColR,HUDHltCol,HUDHltCol,200))
    local PS = ArrayPosSize["health"]["barrels"]
    draw.RoundedBox(WH1,HUDHltP[2],PS[2],HUDHltS,PS[4],Color(HUDHltColR,HUDHltCol,HUDHltCol,5))
    draw.RoundedBox(WH1,PS[5],PS[2],HUDHltS,PS[4],Color(HUDHltColR,HUDHltCol,HUDHltCol,5))
    local PS = ArrayPosSize["health"]["text"]
    draw.SimpleText(HUDHltVar,HUDHltFont,PS[1],PS[2],Color(HUDHltColR,HUDHltCol,HUDHltCol,120),1,1)
    draw.SimpleText(HUDHltVar,HUDHltFont,PS[1],PS[2]-SH(14),Color(HUDHltColR,HUDHltCol,HUDHltCol,5),1,1)

    --armor
    local OwArm = CsPlayer:Armor()
    local HUDArmCD = false

    if OwArm <= 100 and OwArm > 0 then
        HUDArmS = ArrayPosSize["armor"]["barrelf"][3] - (( OwArm * (WH(390) / 100) - WH(390) ) * -1 )
        HUDArmP = ArrayPosSize["armor"]["barrelf"][5] + (( HUDArmS - WH(390) ) * -1 )
        HUDArmCD = true
        HUDArmVar = OwArm.."%"
    elseif OwArm > 100 then
        HUDArmS = ArrayPosSize["armor"]["barrelf"][3] - (( OwArm * (WH(390) / 100) - WH(390) ) * -1 )
        HUDArmP = ArrayPosSize["armor"]["barrelf"][5] + (( HUDArmS - WH(390) ) * -1 )
        HUDArmCD = true
        HUDArmVar = OwArm
    end

    if HUDArmCD == true then
        local PS = ArrayPosSize["armor"]["barrelf"]
        draw.RoundedBox(WH1,PS[1],PS[2],HUDArmS,PS[4],Color(100,180,160,200))
        draw.RoundedBox(WH1,HUDArmP,PS[2],HUDArmS,PS[4],Color(100,180,160,200))
        draw.RoundedBox(WH1,PS[1]+WH(7),PS[2]-SH(12),HUDArmS,PS[4],Color(100,180,160,8))
        draw.RoundedBox(WH1,HUDArmP-WH(7),PS[2]-SH(12),HUDArmS,PS[4],Color(100,180,160,8))
        local PS = ArrayPosSize["armor"]["text"]
        draw.SimpleText("ARMOR : "..HUDArmVar,"HUDHltFontS",PS[1]+WH(10),PS[2]-SH(10),Color(100,180,160,8),0,1)
        draw.SimpleText("ARMOR : "..HUDArmVar,"HUDHltFontS",PS[1],PS[2],Color(100,180,160,120),0,1)
    end

    --ammo
    local OwAWeap = CsPlayer:GetActiveWeapon()

    if OwAWeap:IsValid() and ( CsPlayer:GetAmmoCount(OwAWeap:GetPrimaryAmmoType()) > 0 or OwAWeap:GetMaxClip1() > 0 or ( OwAWeap:GetMaxClip1() == -1 and OwAWeap:GetPrimaryAmmoType() != -1 ) ) then
        local PS = ArrayPosSize["ammo"]["fond"]
        DrawCSRect(PNGs["fond"]["weapons"],PS[1],PS[2],PS[3],PS[4],PS[5])
        local PS = ArrayPosSize["ammo"]["weaponname"]
        draw.SimpleText(OwAWeap:GetPrintName(),"HUDHltFontS",PS[2],PS[3],PS[1],2,0)
        draw.SimpleText(OwAWeap:GetPrintName(),"HUDHltFontS",PS[2]-WH(14),PS[3]+SH(14),Color(200,200,200,10),2,0)
        local PS = ArrayPosSize["ammo"]["fondextension"]
        draw.RoundedBox(WH1,PS[2],PS[3],PS[4],PS[5],PS[1])

        if type(game.GetAmmoName(OwAWeap:GetPrimaryAmmoType())) != "no value" then
            if OwAWeap:GetMaxClip1() != -1 then
                HUDCurrentAmmo = OwAWeap:Clip1()
                HUDCurrentMaxClip = OwAWeap:Clip1() / OwAWeap:GetMaxClip1() * 100
                HUDCurrentReserve = CsPlayer:GetAmmoCount(OwAWeap:GetPrimaryAmmoType())
            else
                if CsPlayer:GetAmmoCount(OwAWeap:GetPrimaryAmmoType()) > 0 then
                    HUDCurrentAmmo = 1
                    HUDCurrentMaxClip = 100
                    HUDCurrentReserve = CsPlayer:GetAmmoCount(OwAWeap:GetPrimaryAmmoType())-1
                else
                    HUDCurrentAmmo = 0
                    HUDCurrentMaxClip = 100
                    HUDCurrentReserve = 0
                end
            end
        else
            HUDCurrentAmmo = OwAWeap:Clip1()
            HUDCurrentMaxClip = OwAWeap:Clip1() / OwAWeap:GetMaxClip1() * 100
            HUDCurrentReserve = CsPlayer:GetAmmoCount(OwAWeap:GetPrimaryAmmoType())
        end

        local PS = ArrayPosSize["ammo"]["ammocount"]
        draw.SimpleText(HUDCurrentAmmo,"HUDHltFontT",PS[2],PS[3],PS[1],2,2)
        draw.SimpleText(HUDCurrentAmmo,"HUDHltFontT",PS[2]-WH(14),PS[3]+SH(14),Color(200,200,200,10),2,2)
        local PS = ArrayPosSize["ammo"]["ammocount2"]
        draw.SimpleText("/"..HUDCurrentReserve,"HUDHltFontS",PS[2],PS[3],PS[1],2,2)
        draw.SimpleText("/"..HUDCurrentReserve,"HUDHltFontS",PS[2]-WH(14),PS[3]+SH(14),Color(200,200,200,10),2,2)
        local PS = ArrayPosSize["ammo"]["ammoindicator"]
        draw.SimpleText(math.ceil(HUDCurrentMaxClip).."%","HUDHltFontS",PS[2],PS[3],PS[1],2,1)
        draw.SimpleText(math.ceil(HUDCurrentMaxClip).."%","HUDHltFontS",PS[2]-WH(14),PS[3]+SH(14),Color(200,200,200,10),2,1)
    end

end)


hook.Add("HUDShouldDraw","HideHBASA",function(name)
    if ( name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo" ) then
        return false
    end
end)