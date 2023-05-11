fx_version 'cerulean'
games { 'gta5' }
author 'Jayden Bentley <jayden@jaydestudios.com>'
description 'A government system for the QB framework.'
version '1.0.0'
client_scripts {
    'client/client.lua',
}
server_script {
    'server/server.lua',
}
lua54 'yes'
dependency {
	"oxmysql",
}