ESX = nil
Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)

MenuCar = {
    ListVehMoteur = { "Allumer", "Eteindre" }, IndexVehMoteur = 1,
    ListVehCapot = { "Ouvert", "Fermé" }, IndexVehCapot = 1,
    ListVehCoffre = { "Ouvert", "Fermé" }, IndexVehCoffre = 1,
    ListVehPorte = { "Avant Gauche", "Avant Droite", "Arrière Gauche", "Arriere Droite", "Toutes les portes" }, IndexVehPorte = 1,
}

--- Création du Menu
function LoadMenuManageCar()
    local menuPrincipal = RageUI.CreateMenu("~u~Gestion Véhicule", "Options", 10, 40, 'banner', 'sk_banner')

    RageUI.Visible(menuPrincipal, not RageUI.Visible(menuPrincipal))
    while menuPrincipal do
        Citizen.Wait(0)

        --- Main Menu ---
        RageUI.IsVisible(menuPrincipal,true,true,true,function()
            local car = GetVehiclePedIsIn(PlayerPedId(), false)
            local ePorte = GetVehicleDoorLockStatus(car)
            local plaqueCar = GetVehicleNumberPlateText(car)
            local eCar = GetEntityHealth(car) / 10
            local essCar = GetVehicleFuelLevel(car)
            if ePorte == 1 then etatPorte = "~g~Ouvert~s~" else etatPorte = "~r~Fermé~s~" end 
            if math.ceil(eCar) <= 30 then etatCar = "~r~"..math.ceil(eCar).." %~s~" else etatCar = "~g~"..math.ceil(eCar).." %~s~" end
            if math.ceil(essCar) <= 30 then essenceCar = "~r~"..math.ceil(essCar).." %~s~" else essenceCar = "~g~"..math.ceil(essCar).." %~s~" end

            RageUI.Info("~b~Information Véhicule",{"Etat des Portes →","Plaque du Véhicule →","Etat du Véhicule →","Niveaux d'Essence  →"},{etatPorte,plaqueCar,etatCar,essenceCar})
            RageUI.Separator("↓ ~b~Actions~s~ ↓")
            RageUI.List("~b~→~s~ Gestion Moteur", MenuCar.ListVehMoteur , MenuCar.IndexVehMoteur ,nil,{},true,{
                onListChange= function(Index,Item) MenuCar.IndexVehMoteur=Index end,
                onSelected = function(Num,Choix)
                    if Choix == MenuCar.ListVehMoteur[1] then
                        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), true, false, true)
                    else
                        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), false, false, true)
                        SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), true)
                    end
                end
            })
            RageUI.List("~b~→~s~ Gestion Capot", MenuCar.ListVehCapot , MenuCar.IndexVehCapot ,nil,{},true,{
                onListChange= function(Index,Item) MenuCar.IndexVehCapot=Index end,
                onSelected = function(Num,Choix)
                    if Choix == MenuCar.ListVehCapot[1] then SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                    else SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 4, false, false) end
                end
            })
            RageUI.List("~b~→~s~ Gestion Coffre", MenuCar.ListVehCoffre , MenuCar.IndexVehCoffre ,nil,{},true,{
                onListChange= function(Index,Item) MenuCar.IndexVehCoffre=Index end,
                onSelected = function(Num,Choix)
                    if Choix == MenuCar.ListVehCoffre[1] then SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                    else SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 5, false, false) end
                end
            })
            RageUI.List("~b~→~s~ Gestion Portes", MenuCar.ListVehPorte , MenuCar.IndexVehPorte  ,nil,{},true,{
                onListChange= function(Index,Item) MenuCar.IndexVehPorte=Index end,
                onSelected = function(Num,Choix)
                    if Choix ==  MenuCar.ListVehPorte[1] then
                        if not avantGauche then SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 0, false, false) avantGauche = true
                        elseif avantg then SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 0, false, false) avantGauche = false end
                    end
                    if Choix ==  MenuCar.ListVehPorte[2] then
                        if not avantDroite then SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 1, false, false) avantDroite = true
                        elseif avantDroite then SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 1, false, false) avantDroite = false end
                    end
                    if Choix ==  MenuCar.ListVehPorte[3] then
                        if not arriereGauche then SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 2, false, false) arriereGauche = true
                        elseif arriereGauche then SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 2, false, false) arriereGauche = false end
                    end
                    if Choix ==  MenuCar.ListVehPorte[4]then
                        if not arriereDroite then SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 3, false, false) arriereDroite = true
                        elseif arriereDroite then SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 3, false, false) arriereDroite = false end
                    end
                    if Choix ==  MenuCar.ListVehPorte[5] then
                        if not allPortes then
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                            allPortes = true
                        elseif allPortes then
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                            allPortes = false
                        end
                    end
                end
            })
        end, function() end, 1)
        ----------------------

        --- Ne pas Toucher ---
        if not RageUI.Visible(menuPrincipal) then menuPrincipal=RMenu:DeleteType("~u~Gestion Véhicule", true) end
        ----------------------
    end
end

--- Ouvrir le menu avec une Commande
if Config.Command.etat then 
    RegisterCommand(Config.Command.name, function()
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            LoadMenuManageCar()
        else
            if Config.okokNotif then exports['okokNotify']:Alert("Gestion Véhicule", "Vous devez être dans un véhicule", 5000, 'error')
            else ESX.ShowNotification("~r~Vous devez être dans un véhicule") end 
        end 
    end)
end

--- Ouvrir le menu avec une Touche
if Config.Key.etat then 
    Keys.Register(Config.Key.key, Config.Key.key, 'Menu Gestion Véhicule', function()
        print("Pesse Key - "..Config.Key.key)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            LoadMenuManageCar()
        else
            if Config.okokNotif then exports['okokNotify']:Alert("Gestion Véhicule", "Vous devez être dans un véhicule", 5000, 'error')
            else ESX.ShowNotification("~r~Vous devez être dans un véhicule") end 
        end 
    end)
end
