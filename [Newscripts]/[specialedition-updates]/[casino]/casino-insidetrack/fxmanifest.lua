fx_version 'cerulean'

game 'gta5'

version '1.0.1'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
    'config.lua',
    'client/utils.lua',
    'client/client.lua',
}

server_script 'server/server.lua' 