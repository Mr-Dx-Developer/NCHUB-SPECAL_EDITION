fx_version "cerulean"
game "gta5"

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/cursor.png',
	'html/background.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}

client_scripts {
	'client/cl_*.lua'
}

server_scripts { 
	'server/sv_*.lua'
}

