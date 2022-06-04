resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "Add-On Ped Skinchange Menu" -- Resource Descrption

client_script {
	'@NativeUI/NativeUI.lua',
	'Client/Preload.lua',
	'Config.lua',
	'Client/Client.lua',
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	'Server/Server.lua',
}


