ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('popsdiner:BuyItem')
AddEventHandler('popsdiner:BuyItem', function(theItem,theLabel,thePrice)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
     TriggerEvent('esx_addonaccount:getSharedAccount', "society_popsdinerjob", function(Society)
          local SocietyMoney = Society.money
          if SocietyMoney >= thePrice then
               TriggerClientEvent("blowCore:Notification", source, "~b~Pop's Diner~s~\nVous avez acheter ~b~x1 "..theLabel)
               Society.removeMoney(thePrice)
               xPlayer.addInventoryItem(theItem, 1)
          else
               TriggerClientEvent("blowCore:Notification", source, "~b~Pop's Diner~s~\nVotre entreprise ~r~n'a plus assez~s~ d'argent.")
          end
	end)
end)

RegisterServerEvent("popsdiner:preparation")
AddEventHandler("popsdiner:preparation", function(removename, addname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local getinvent = xPlayer.getInventoryItem(removename).count
    if getinvent >= 1 then
        if removename == "tomate" or removename == "mozzarella" or removename == "salade" then
            TriggerClientEvent("anim:animationspopsdiner", source, "preparation")
        else
            TriggerClientEvent("anim:animationspopsdiner", source, "steak")
        end
        if removename == "steak" or removename == "oignon" then
            Wait(13000)
        else
            Wait(10000)
        end
        xPlayer.removeInventoryItem(removename, 1)
        xPlayer.addInventoryItem(addname, count)
        if removename == "tomate" then
            TriggerClientEvent("blowCore:Notification", source, "~g~Vous coupez une tomate en tranche")
        elseif removename == "mozzarella" then
            TriggerClientEvent("blowCore:Notification", source, "~g~Vous coupez de la mozzarella en tranche")
        elseif removename == "salade" then
            TriggerClientEvent("blowCore:Notification", source, "~g~Vous coupez une salade en Poignet")
        elseif removename == "steak" then
            TriggerClientEvent("blowCore:Notification", source, "~g~Vous cuisinez un steak")
        elseif removename == "oignon" then
            TriggerClientEvent("blowCore:Notification", source, "~g~Vous êtes en train de frire des oigons")
        end
    else
        TriggerClientEvent("blowCore:Notification", source, "~r~Vous n'avez pas ou plus de "..removename.." sur vous")
    end
end)

RegisterServerEvent("popsdiner:cookburger")
AddEventHandler("popsdiner:cookburger", function(addname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local getinvent = xPlayer.getInventoryItem("painburger", "tomatecouper", "mozzarellacouper", "saladecouper", "steakcuit", "oignonfrit").count
    if getinvent >= count then
        TriggerClientEvent("anim:animationspopsdiner", source, "assemblage")
        Wait(10000)
        xPlayer.removeInventoryItem("painburger", 2)
        xPlayer.removeInventoryItem("tomatecouper", 2)
        xPlayer.removeInventoryItem("mozzarellacouper", 2)
        xPlayer.removeInventoryItem("saladecouper", 2)
        xPlayer.removeInventoryItem("steakcuit", 1)
        xPlayer.removeInventoryItem("oignonfrit", 3)
        xPlayer.addInventoryItem(addname, count)
        TriggerClientEvent("blowCore:Notification", source, "~g~Vous cusinez un burger")
    else
        TriggerClientEvent("blowCore:Notification", source, "~r~Vous n'avez pas assez ou plus d'ingrédient sur vous")
    end
end)

ESX.RegisterServerCallback('popsdiner:GetItems', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("painburger", "tomatecouper", "mozzarellacouper", "oignonfrit", "saladecouper", "steakcuit").count
    if item >= 1 then
        cb(true)
    else
        cb(false)
    end
end)