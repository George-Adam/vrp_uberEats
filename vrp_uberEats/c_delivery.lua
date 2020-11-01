vRPUberEatsC = {}
Tunnel.bindInterface("vRP_UberEats",vRPUberEatsC)
Proxy.addInterface("vRP_UberEats",vRPUberEatsC)
vRP = Proxy.getInterface("vRP")
vRPSUberEats = Tunnel.getInterface("vRP_UberEats","vRP_UberEats")

hasMission = false
hasDeliveryJob = false

configC = {
    pickFood = "~y~Ia mancarea de la locatia de pe harta.",
    leaveFood = "~o~Apasa ~r~E ~o~ pentru a lua pachetul.",
    leavingFood = "~g~Lasi pachetul cu mancare la usa."
}

local deliverLocation = {
    {1846.1658935546,3914.671875,33.45896911621},
    {1809.5310058594,3906.490234375,33.762325286866},
    {1813.4381103516,3854.4038085938,34.35440826416},
    {1807.519165039,3851.5471191406,34.354331970214},
    {1777.165649414,3737.9489746094,34.655338287354},
    {1501.138305664,3694.9582519532,35.21291732788},
    {1435.9473876954,3640.193359375,34.943939208984},
    {1364.437133789,4316.2631835938,37.681121826172},
    {1662.8937988282,4776.1831054688,42.00756072998},
    {1658.2700195312,4851.7836914062,41.968692779542},
    {1957.3248291016,5171.9970703125,47.870635986328},
    {2563.5234375,4681.345703125,34.078311920166},
    {-114.63251495362,6325.7592773438,35.501029968262},
    {-200.75090026856,6353.4204101562,31.495893478394},
    {-60.375846862792,6451.3374023438,30.853048324584},
    {-51.793811798096,6460.9985351562,30.854564666748},
    {-45.021224975586,6467.27734375,30.857669830322},
    {-12.32414340973,6561.3774414062,31.319553375244},
    {14.735867500306,6576.080078125,32.103099822998},
    {534.73999023438,199.20622253418,104.90426635742},
    {315.5001525879,-127.69466400146,69.976951599122},
    {206.60885620118,-85.517189025878,69.224182128906},
    {44.596000671386,-29.655420303344,69.394760131836},
    {36.728675842286,-70.922645568848,62.746353149414},
    {-269.81896972656,26.798164367676,54.105995178222},
    {-1460.1004638672,-414.41928100586,35.09345626831},
    {-1328.6314697266,-682.41284179688,25.701313018798},
    {-1356.4532470704,-702.54681396484,24.401473999024},
    {-1319.3768310546,-832.74603271484,16.320394515992}, 
    {-1290.2811279296,-853.64080810546,14.265422821044},
    {-1282.5234375,-867.53344726562,11.47161769867},
    {-1111.6573486328,-902.31103515625,3.6171894073486},
    {121.48512268066,-1350.5209960938,28.645357131958},
    {495.65188598632,-1822.6311035156,28.869709014892},
    {463.59341430664,-1850.6068115234,27.192483901978},
    {399.68212890625,-1864.8892822266,26.716329574584},
    {385.25103759766,-1881.867553711,26.022314071656},
    {324.22912597656,-1937.3170166016,25.018980026246},
    {103.56656646728,-1691.8916015625,28.596462249756},
    {84.53353881836,-1958.1900634766,21.121696472168},
    {76.44679260254,-1948.1586914062,21.17413520813},
    {100.91497039794,-1912.304321289,21.407424926758},
    {460.69369506836,-694.40252685546,26.848484039306},
    {165.14253234864,-1282.9537353516,28.629453659058},
    {202.11108398438,-1269.3908691406,28.54965019226},
    {16.9130153656,-986.72766113282,28.750646591186},
    {-3.471801996231,-980.64544677734,28.734024047852},
    {7.3011116981506,-934.6748046875,29.905025482178},
    {-53.504592895508,-398.19268798828,38.128116607666},
    {-49.256187438964,-142.52265930176,57.453395843506},
    {36.74089050293,-171.06901550292,54.716625213624},
    {144.6086730957,-212.64428710938,53.75883102417}
}

local pickupLocation = {
    {168.29393005372,-1632.3450927734,28.758069992066},
    {132.27360534668,-1462.4245605468,28.82338142395},
    {-134.9525756836,-255.39198303222,42.97384262085},
    {-1249.3194580078,-297.10653686524,36.818241119384}
}

RegisterNetEvent('hasDeliveryJob')
AddEventHandler('hasDeliveryJob', function()
    hasDeliveryJob = true
end)

RegisterNetEvent('noDeliveryJob')
AddEventHandler('noDeliveryJob', function()
    hasDeliveryJob = false
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        local player = GetPlayerPed(-1)
        local pos = GetEntityCoords(player)
        local isInVehicle = IsPedInAnyVehicle(player)
        if hasDeliveryJob == true then
            if hasMission == false then
                Wait(math.random(3000, 10000))
                pickup = pickupLocation[math.random(#pickupLocation)]
                notify(configC.pickFood)
                pickupFoodBlip(pickup[1], pickup[2], pickup[3], 515, 44)
                hasMission = true
                print(pickup)
            end
            if pickup ~= nil then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, pickup[1],pickup[2],pickup[3]) < 5) then
                    DrawText3D(pickup[1],pickup[2],pickup[3]+0.5, "", 255)
                    DrawMarker(1, pickup[1],pickup[2],pickup[3]-1, 0, 0, 0, 0, 0, 0, 1.2001, 1.2001, 2.001, 255, 255, 255, 100, 0, 0, 0, 1, 0, 0, 0)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, pickup[1],pickup[2],pickup[3]) < 2.001) and not isInVehicle then
                        if IsControlPressed(1, 51) then
                            notify("~g~Iei pachetul cu mancare.")
                            TaskStartScenarioInPlace(player, 'PROP_HUMAN_PARKING_METER', 0, true)
                            Wait(4000)
                            ClearPedTasks(player)
                            DeleteEntity(parcel)
                            if DoesBlipExist(pickupBlip) then
                                RemoveBlip(pickupBlip)
                                pickupBlip = nil
                                pickup = nil
                            end
                            delivery = deliverLocation[math.random(#deliverLocation)]
                            notify("~y~Livreaza mancarea la locatia de pe harta.")
                            deliveryFoodBlip(delivery[1],delivery[2],delivery[3], 649, 44)
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        local player = GetPlayerPed(-1)
        local pos = GetEntityCoords(player)
        local isInVehicle = IsPedInAnyVehicle(player)
        if hasDeliveryJob == true then
            if hasMission == true then
                if delivery ~= nil then
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, delivery[1],delivery[2],delivery[3]) < 5) then
                        DrawText3D(delivery[1],delivery[2],delivery[3]+0.5, conficC.leaveFood, 255)
                        DrawMarker(1, delivery[1],delivery[2],delivery[3]-1, 0, 0, 0, 0, 0, 0, 1.2001, 1.2001, 2.001, 255, 255, 255, 100, 0, 0, 0, 1, 0, 0, 0)
                        if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, delivery[1],delivery[2],delivery[3]) < 2.001) and not isInVehicle then
                            if IsControlPressed(1, 51) then
                                notify(configC.leavingFood)
                                TaskStartScenarioInPlace(player, 'PROP_HUMAN_PARKING_METER', 0, true)
                                Wait(4000)
                                ClearPedTasks(player)
                                DeleteEntity(parcel)
                                vRPSUberEats.deliverFood()
                                if DoesBlipExist(deliveryBlip) then
                                    RemoveBlip(deliveryBlip)
                                    deliveryBlip = nil
                                    delivery = nil
                                    hasMission = false
                                end
                                hasMission = false
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('stopDeliveryMission')
AddEventHandler('stopDeliveryMission', function()
    if DoesBlipExist(pickupBlip) then
        RemoveBlip(pickupBlip)
        pickupBlip = nil
        pickup = nil
    end
    if DoesBlipExist(deliveryBlip) then
        RemoveBlip(deliveryBlip)
        deliveryBlip = nil
        delivery = nil
        hasMission = false
    end
end)

function DrawText3D(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0, 0, 0, 0, alpha)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        SetDrawOrigin(x,y,z, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end

function pickupFoodBlip(x, y, z, id, colour)
      pickupBlip = AddBlipForCoord(x, y, z)
      SetBlipSprite(pickupBlip, id)
      SetBlipDisplay(pickupBlip, 4)
      SetBlipRoute(pickupBlip, true)
      SetBlipScale(pickupBlip, 0.9)
      SetBlipColour(pickupBlip, colour)
      SetBlipAsShortRange(pickupBlip, true)
end

function deliveryFoodBlip(x, y, z, id, colour)
    deliveryBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(deliveryBlip, id)
    SetBlipDisplay(deliveryBlip, 4)
    SetBlipRoute(deliveryBlip, true)
    SetBlipScale(deliveryBlip, 0.9)
    SetBlipColour(deliveryBlip, colour)
    SetBlipAsShortRange(deliveryBlip, true)
end

function alert(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function notify(msg) 
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(true, false)
end

function pickupParcel()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
end