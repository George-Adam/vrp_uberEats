fx_version 'bodacious'
games {'rdr3', 'gta5'}

author 'FTDark'
description 'vRP Uber Eats'
version '1.0.0'

client_scripts{ 
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"c_delivery.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
	"s_delivery.lua"
}
