fx_version 'cerulean'

games { 'gta5' }

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@fxl/server/server.lua',
    'server/classes/*lua',
    'server/server.js',
    'server/events.lua',
    'server/util.lua',
    'server/server.lua'
}

shared_scripts {
    'async.lua'
}

client_scripts {
    'client/client.lua'
}
