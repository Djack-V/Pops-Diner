ESX = nil
PlayerData = {}

function defPopsDinerESX()
    while ESX == nil do
         TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
         Citizen.Wait(0)
     end
     while ESX.GetPlayerData().job == nil do
           Citizen.Wait(10)
     end
     if ESX.IsPlayerLoaded() then
           ESX.PlayerData = ESX.GetPlayerData()
     end
end
Citizen.CreateThread(function()
    defPopsDinerESX()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    for _, info in pairs(popsJobConfig.blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.5)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

function Notification(msg)
  SetNotificationTextEntry('STRING')
  AddTextComponentSubstringPlayerName(msg)
  DrawNotification(false, true)
end

function PlayAnim(animDict, animName, duration)
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Wait(0)
  end
  TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
  RemoveAnimDict(animDict)
end

RegisterNetEvent("anim:animationspopsdiner")
AddEventHandler("anim:animationspopsdiner", function(actions)
    if actions == "preparation" then
      PlayAnim("anim@amb@business@cfm@cfm_cut_sheets@", "cut_guilotine_v1_billcutter", 10000)
      Wait(10000)
      ClearPedTasks(PlayerPedId())
    elseif actions == "steak" then
      TaskStartScenarioInPlace(GetPlayerPed(-1),"PROP_HUMAN_BBQ", 0, true)
      Wait(13000)
      ClearPedTasks(PlayerPedId())
    elseif actions == "assemblage" then
      PlayAnim("anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_cokecutter", 10000)
      Wait(10000)
      ClearPedTasks(PlayerPedId())
    end
end)