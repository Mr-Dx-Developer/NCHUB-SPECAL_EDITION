name "qb-CatCafe"
author "qb-athy"
version "v1.3.1"
description "CatCafe Script By qb-athy"
fx_version "cerulean"
game "gta5"

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua',
}