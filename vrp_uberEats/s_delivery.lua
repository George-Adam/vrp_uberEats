local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_UberEats")
vRPCUberEats = Tunnel.getInterface("vRP_UberEats","vRP_UberEats")

vRPUberEats = {}
Tunnel.bindInterface("vRP_UberEats",vRPUberEats)
Proxy.addInterface("vRP_UberEats",vRPUberEats)

configS = {
    deliveredFood1 = "Ai livrat pachetul si ai primit: ~g~",
    deliveredFood2 = "$~w~.",
    priceMin = 100,
    priceMax = 200
}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
  if first_spawn then
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, "UBER Eats"}) then
        TriggerClientEvent('hasDeliveryJob', player)
    end
  end
end)

AddEventHandler('vRP:playerJoinGroup', function(user_id, group, gtype)
    local player = vRP.getUserSource({user_id})
    if group == "UBER Eats" then
        TriggerClientEvent('hasDeliveryJob', player)
    end
end)

AddEventHandler('vRP:playerLeaveGroup', function(user_id, group, gtype)
    local player = vRP.getUserSource({user_id})
    if group == "UBER Eats" then
        TriggerClientEvent('noDeliveryJob', player)
    end
end)

function vRPUberEats.deliverFood()
	local player = source
	local user_id = vRP.getUserId({source})
	local price = math.random(priceMin, priceMax)
	if player then
		vRP.giveMoney({user_id, price})
		vRPclient.notify(source, {deliveredFood1, price, deliveredFood2})
	end	
end