This requires Dunko`s VRP v6.7.

A UBER Eats job where you pick food from a fast food/restaurant and deliver it to a location on the map.

To add it to your server, move it to your resources folder then add 'ensure vrp_uberEats' in your server.cfg.

To cancel the mission from the phone, go into vrp/modules/mission.lua and at line 95 replace the menu builder with:
```
vRP.registerMenuBuilder("main", function(add, data)
  local player = data.player
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local choices = {}

    -- build admin menu
    choices[lang.mission.cancel.title()] = {function(player,choice)
      vRP.stopMission(player)
      TriggerClientEvent('stopDeliveryMission', source)
    end}

    add(choices)
  end
end)
```

If you have any questions or issues, create an issue and I`ll answer back ASAP.
