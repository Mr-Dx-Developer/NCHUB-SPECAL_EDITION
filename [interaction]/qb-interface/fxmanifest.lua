
fx_version "cerulean"

version '0.0.1'

lua54 'yes'

game "gta5"

ui_page 'web/build/index.html'

client_scripts {
  "@qb-lib/client/cl_rpc.lua",
  'client/cl_exports.lua',
  'client/cl_utils.lua',
  'client/model/cl_*.lua'
}

files {
  'web/build/index.html',
  'web/build/**/*'
}