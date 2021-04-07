local label = "~g~Mettre~s~ son service !"
local showPosition = false
local tenuecivil = true
local tenuetravail = false
local veh = true

local menuPopsf6 = false
RMenu.Add('f6pops', 'menu', RageUI.CreateMenu("Pop\'s Diner", "Menu Pop\'s Diner"))
RMenu:Get('f6pops', 'menu').Closed = function()
    menuPopsf6 = false
end

local PopsGarage = false
RMenu.Add('PopsGarage', 'menu', RageUI.CreateMenu("Pop\'s Garage", "Menu Pop\'s Diner"))
RMenu:Get('PopsGarage', 'menu').Closed = function()
    PopsGarage = false
end

local PopsVestiaire = false
RMenu.Add('PopsVestiaire', 'menu', RageUI.CreateMenu("Pop\'s Vestiaire", "Menu Pop\'s Diner"))
RMenu:Get('PopsVestiaire', 'menu').Closed = function()
    PopsVestiaire = false
end

local PopsShops = false
RMenu.Add('PopsShops', 'menu', RageUI.CreateMenu("Pop\'s Magasin", "Menu Pop\'s Diner"))
RMenu:Get('PopsShops', 'menu').Closed = function()
    PopsShops = false
end

local PopsCuisine = false
RMenu.Add('PopsCuisine', 'menu', RageUI.CreateMenu("Pop\'s Cuisine", "Menu Pop\'s Diner"))
RMenu:Get('PopsCuisine', 'menu').Closed = function()
    FreezeEntityPosition(PlayerPedId(), false)
    PopsCuisine = false
end

local function openMenuGarage()
    if PopsGarage then
        PopsGarage = false
    else
        defPopsDinerESX()
        PopsGarage = true
        RageUI.Visible(RMenu:Get('PopsGarage', 'menu'), true)
    Citizen.CreateThread(function()
        while PopsGarage do
            Wait(0)

            RageUI.IsVisible(RMenu:Get('PopsGarage', 'menu'), true, true, true, function()
                for _,v in pairs(popsJobConfig.popsJobVeh.Veh) do
                    for _,c in pairs(popsJobConfig.PosSpawn) do
                        RageUI.ButtonWithStyle(v.Label, nil, {RightBadge = RageUI.BadgeStyle.Car}, veh,function(_,_,s)
                            if s then
                                veh = false
                                Wait(10000)
                                veh = true
                                local model = GetHashKey(v.Name)
                                FreezeEntityPosition(PlayerPedId(), false)
                                RequestModel(model)
                            while not HasModelLoaded(model) do Wait(10) end
                                local pos = c.SpawnVeh
                                local popsVeh = CreateVehicle(model, pos.x, pos.y, pos.z, 157.22171020508, true, false)
                                SetVehicleNumberPlateText(popsVeh, "Pops"..math.random(1,100))
                                SetVehicleCustomPrimaryColour(popsVeh, 0, 0, 255)
                                SetVehicleCustomSecondaryColour(popsVeh, 0, 0, 255)
                                SetVehicleFixed(popsVeh)
                                SetVehicleDirtLevel(popsVeh, 0.0)
                                TaskWarpPedIntoVehicle(PlayerPedId(), popsVeh, -1)
                                lastveh = popsVeh
                                lastplate = GetVehicleNumberPlateText(popsVeh)
                                Notification('Pop\'s Diner~s~\nvous avez sortie un(e) '..v.Label)
                                TriggerServerEvent("esx_vehiclelock:givekey", 'no', GetVehicleNumberPlateText(popsVeh))
                                RageUI.CloseAll()
                                PopsGarage = false
                            end
                        end)
                    end
                end
            end)
        end
    end)
    end
end

local function openMenuVestiaire()
    if PopsVestiaire then
        PopsVestiaire = false
    else
        defPopsDinerESX()
        PopsVestiaire = true
        RageUI.Visible(RMenu:Get('PopsVestiaire', 'menu'), true)
    Citizen.CreateThread(function()
        while PopsVestiaire do
            Wait(0)

            RageUI.IsVisible(RMenu:Get('PopsVestiaire', 'menu'), true, true, true, function()

                RageUI.ButtonWithStyle("Tenue Civil", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, not tenuecivil,function(_,_,s)
                    if s then
                        tenuecivil = true
                        tenuetravail = false
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                        Notification("Pop\'s Diner~s~\nVoici votre tenue, bonne journée !")
                        RageUI.CloseAll()
                        PopsVestiaire = false
                    end
                end)

                RageUI.ButtonWithStyle("Tenue Travail", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, not tenuetravail,function(_,_,s)
                    if s then
                        tenuecivil = false
                        tenuetravail = true
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local homme = skin.sex == 0
                            local femme = skin.sex == 1
                            if homme then
                                TriggerEvent('skinchanger:loadClothes', skin, popsJobConfig.Tenue.homme)
                            elseif femme then
                                TriggerEvent('skinchanger:loadClothes', skin, popsJobConfig.Tenue.femme)
                            end
                        end)
                        Notification("Pop\'s Diner~s~\nVoici votre tenue, bon travail !")
                        RageUI.CloseAll()
                        PopsVestiaire = false
                    end
                end)

            end)
        end
    end)
    end
end

local function openMenuShops()
    if PopsShops then
        PopsShops = false
    else
        defPopsDinerESX()
        PopsShops = true
        RageUI.Visible(RMenu:Get('PopsShops', 'menu'), true)
    Citizen.CreateThread(function()
        while PopsShops do
            Wait(0)

            RageUI.IsVisible(RMenu:Get('PopsShops', 'menu'), true, true, true, function()

                RageUI.Separator('↓ Nourritures ↓')
                for _,v in pairs(popsJobConfig.popsJobShops.bouffe) do
                    RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "~g~"..v.price.." ~s~$"}, true, function(_, _, s)
                        if s then
                            TriggerServerEvent("popsdiner:BuyItem", v.label, v.name ,v.price)
                        end
                    end)
                end
                RageUI.Separator('↓ Boissons ↓')
                for _,v in pairs(popsJobConfig.popsJobShops.boisson) do
                    RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "~g~"..v.price.." ~s~$"}, true, function(_, _, s)
                        if s then
                            TriggerServerEvent("popsdiner:BuyItem", v.label, v.name ,v.price)
                        end
                    end)
                end
            end)
        end
    end)
    end
end

local function openMenuCuisine()
    if PopsCuisine then
        PopsCuisine = false
    else
        defPopsDinerESX()
        ESX.TriggerServerCallback('popsdiner:GetItems', function(GoGo)
            burger = GoGo
        end)
        PopsCuisine = true
        RageUI.Visible(RMenu:Get('PopsCuisine', 'menu'), true)
        Citizen.CreateThread(function()
            while PopsCuisine do
                Wait(0)

                RageUI.IsVisible(RMenu:Get('PopsCuisine', 'menu'), true, true, true, function()

                    RageUI.Separator('↓ Préparation ↓')
                    for _,v in pairs(popsJobConfig.popsJobCuisine.preparation) do
                        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                PopsCuisine = false
                                TriggerServerEvent("popsdiner:preparation", v.removeitem, v.additem, v.nombre)
                                Wait(10000)
                                PopsCuisine = true
                            end
                        end)
                    end

                    RageUI.Separator('↓ Cuisine ↓')
                    for _,v in pairs(popsJobConfig.popsJobCuisine.cuisine) do
                        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                PopsCuisine = false
                                TriggerServerEvent("popsdiner:preparation", v.removeitem, v.additem, v.nombre)
                                Wait(13000)
                                PopsCuisine = true
                            end
                        end)
                    end

                    for _,v in pairs(popsJobConfig.popsJobCuisine.assemblage) do
                        if burger == false then
                            RageUI.Separator('~c~↓ Assemblage ↓')
                        else
                            RageUI.Separator('↓ Assemblage ↓')
                        end
                        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "→→"}, burger, function(_,_,s)
                            if s then
                                PopsCuisine = false
                                TriggerServerEvent("popsdiner:cookburger", v.additem, v.nombre)
                                Wait(10000)
                                PopsCuisine = true
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

local function openMenuPopsF6()
    if menuPopsf6 then
        menuPopsf6 = false
    else
        defPopsDinerESX()
        menuPopsf6 = true
        RageUI.Visible(RMenu:Get('f6pops', 'menu'), true)
    Citizen.CreateThread(function()
        while menuPopsf6 do
            Wait(0)

            RageUI.IsVisible(RMenu:Get('f6pops', 'menu'), true, true, true, function()

                if box then
                    RageUI.Separator("Service : ~g~Pris")
                else
                    RageUI.Separator("Service : ~r~Non pris")
                end

                RageUI.Checkbox(label, nil, box, { Style = RageUI.CheckboxStyle.Tick }, function(_, _, _, c)
                    box = c;
                  end, function()
                    showPosition = true
                    Notification("Pop\'s Diner~s~\nVous êtes en ~g~service~s~ !")
                    label = "~r~Quitter~s~ son service !"
                  end, function()
                    showPosition = false
                    Notification("Pop\'s Diner~s~\nVous n'êtes plus en ~r~service~s~ !")
                    label = "~g~Mettre~s~ son service !"
                end)

                if box then
                    RageUI.Separator('↓ Factures ↓')

                    RageUI.ButtonWithStyle("Donner une facture", nil, {RightBadge = RageUI.BadgeStyle.Cash}, true, function(_, _, s)
                        if s then
                            local raison = ""
                            local montant = 0
                            AddTextEntry("FMMC_MPM_NA", "Raison de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de la facture:", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de la facture:", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            local player, distance = ESX.Game.GetClosestPlayer()
                                            if player ~= -1 and distance <= 3.0 then
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_ambulance', ('ambulance'), montant)
                                                TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Banque', 'Facture envoyée : ', 'Vous avez envoyé une facture de : '..montant.. ' $ ~s~pour : ' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                            else
                                                ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
                                            end
                                        end
                                    end
                                end
                            end
                            RageUI.CloseAll()
                            menuPopsf6 = false
                        end
                    end)

                    RageUI.Separator('↓ Annonces ↓')

                    RageUI.ButtonWithStyle('Annonce ~g~Ouvert', nil, {RightLabel = "→"}, box, function(_,_,s)
                        if s then
                            TriggerServerEvent("blowCore:allservannounce", "Facebook","@Pop\'s Diner","Le Pop\'s Diner ~g~ouvre~s~ ses portes","CHAR_FACEBOOK")
                            RageUI.CloseAll()
                            menuPopsf6 = false
                        end
                    end)
                    RageUI.ButtonWithStyle('Annonce ~r~Fermer', nil, {RightLabel = "→"}, box, function(_,_,s)
                        if s then
                            TriggerServerEvent("blowCore:allservannounce", "Facebook","@Pop\'s Diner","Le Pop\'s Diner ~r~ferme~s~ ses portes","CHAR_FACEBOOK")
                            RageUI.CloseAll()
                            menuPopsf6 = false
                        end
                    end)
                else
                    RageUI.ButtonWithStyle('Donner une facture', nil, {RightBadge = RageUI.BadgeStyle.Lock}, box, function()end)
                    RageUI.ButtonWithStyle('Annonces Ouvert', nil, {RightBadge = RageUI.BadgeStyle.Lock}, box, function()end)
                    RageUI.ButtonWithStyle('Annonces Fermer', nil, {RightBadge = RageUI.BadgeStyle.Lock}, box, function()end)
                end

            end, function() end, 1)
        end
        while showPosition do
            local pCoords2 = GetEntityCoords(PlayerPedId())
            local activerfps = false
            for _,v in pairs(popsJobConfig.PosSpawn) do
                if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "popsdiner" then
                    if #(pCoords2 - v.SpawnVeh) < 2.0 then
                        activerfps = true
                        RageUI.Text({ message = "Appuyer sur E~s~ pour ranger le véhicule", time_display = 1 })
                        if IsControlJustReleased(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), -1) then
                                local pVeh = GetVehiclePedIsIn(PlayerPedId(), false)
                                DeleteEntity(pVeh)
                                ESX.ShowNotification("Pop\'s Diner~s~\nLe véhicule a était supprimer")
                            else
                                ESX.ShowNotification("Pop\'s Diner~s~\n~r~Tu n'est pas dans un véhicule")
                            end
                        end
                    elseif #(pCoords2 - v.SpawnVeh) < 7.0 then
                        activerfps = true
                        DrawMarker(22, v.SpawnVeh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 170, 1, 1, 2, 0, nil, nil, 0)
                    end
                end
            end
            for _,v in pairs(popsJobConfig.PosGarage) do
                if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "popsdiner" then
                    if #(pCoords2 - v.Garage) < 1.5 then
                        activerfps = true
                        RageUI.Text({ message = "Appuyer sur E~s~ pour accéder au Garage", time_display = 1 })
                        if IsControlJustPressed(0, 38) then
                            if PopsGarage == false then
                                openMenuGarage()
                            end
                        end
                    elseif #(pCoords2 - v.Garage) < 4.5 then
                        activerfps = true
                        DrawMarker(22, v.Garage, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 170, 1, 1, 2, 0, nil, nil, 0)
                    end
                end
            end
            for _,v in pairs(popsJobConfig.PosVestiaire) do
                if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "popsdiner" then
                    if #(pCoords2 - v.Vestiaire) < 1.5 then
                        activerfps = true
                        RageUI.Text({ message = "Appuyer sur E~s~ pour accéder au vestiaire", time_display = 1 })
                        if IsControlJustPressed(0, 38) then
                            if PopsVestiaire == false then
                                openMenuVestiaire()
                            end
                        end
                    elseif #(pCoords2 - v.Vestiaire) < 4.5 then
                        activerfps = true
                        DrawMarker(22, v.Vestiaire, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 170, 1, 1, 2, 0, nil, nil, 0)
                    end
                end
            end
            for _,v in pairs(popsJobConfig.PosBoss) do
                if ESX.PlayerData.job.name == "popsdiner" and ESX.PlayerData.job.grade_name == "boss"  then
                    if #(pCoords2 - v.Boss) < 1.5 then
                        activerfps = true
                        RageUI.Text({ message = "Appuyer sur E~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent("blowSociety:openBoss")
                        end
                    elseif #(pCoords2 - v.Boss) < 4.5 then
                        activerfps = true
                        DrawMarker(22, v.Boss, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 170, 1, 1, 2, 0, nil, nil, 0)
                    end
                end
            end
            if tenuetravail then
                for _, info in pairs(popsJobConfig.blips2) do
                    info.blip2 = AddBlipForCoord(info.x, info.y, info.z)
                    SetBlipSprite(info.blip2, info.id)
                    SetBlipDisplay(info.blip2, 4)
                    SetBlipScale(info.blip2, 0.5)
                    SetBlipColour(info.blip2, info.colour)
                    SetBlipAsShortRange(info.blip2, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(info.title)
                    EndTextCommandSetBlipName(info.blip2)
                end
                for _,v in pairs(popsJobConfig.PosShops) do
                    if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "popsdiner" then
                        if #(pCoords2 - v.Shops) < 1.5 then
                            activerfps = true
                            RageUI.Text({ message = "Appuyer sur E~s~ pour accéder au magasin", time_display = 1 })
                            if IsControlJustPressed(0, 38) then
                                if PopsShops == false then
                                    openMenuShops()
                                end
                            end
                        elseif #(pCoords2 - v.Shops) < 4.5 then
                            activerfps = true
                            DrawMarker(22, v.Shops, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 170, 1, 1, 2, 0, nil, nil, 0)
                        end
                    end
                end
                for _,v in pairs(popsJobConfig.PosCuisine) do
                    if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "popsdiner" then
                        if #(pCoords2 - v.Cuisine) < 1.5 then
                            activerfps = true
                            RageUI.Text({ message = "Appuyer sur E~s~ pour cuisiner", time_display = 1 })
                            if IsControlJustPressed(0, 38) then
                                if PopsCuisine == false then
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    openMenuCuisine()
                                end
                            end
                        elseif #(pCoords2 - v.Cuisine) < 4.5 then
                            activerfps = true
                            DrawMarker(22, v.Cuisine, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 170, 1, 1, 2, 0, nil, nil, 0)
                        end
                    end
                end
            end
            if activerfps then
                Wait(1)
            else
                Wait(1500)
            end
        end
    end)
    end
end

Keys.Register('F6', 'openPopsF6', 'Touche menu F6 Pop\'s Diner JOB', function()
    if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "popsdiner" then
        if menuPopsf6 == false then
            defPopsDinerESX()
            openMenuPopsF6()
        end
    end
end)