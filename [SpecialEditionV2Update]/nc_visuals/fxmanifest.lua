-- $$\   $$\  $$$$$$\  $$\   $$\ $$\   $$\ $$$$$$$\  
-- $$$\  $$ |$$  __$$\ $$ |  $$ |$$ |  $$ |$$  __$$\ 
-- $$$$\ $$ |$$ /  \__|$$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ $$\$$ |$$ |      $$$$$$$$ |$$ |  $$ |$$$$$$$\ |
-- $$ \$$$$ |$$ |      $$  __$$ |$$ |  $$ |$$  __$$\ 
-- $$ |\$$$ |$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ | \$$ |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$  |
-- \__|  \__| \______/ \__|  \__| \______/ \_______/  
-- discord.gg/sgx & Patreon.com/NCHub
fx_version 'adamant'
games { 'gta5' }

description 'discord.gg/sgx Graphics'
version '1.0.0'
lua54 'yes'
this_is_a_map 'yes'
replace_level_meta 'gta5'

client_scripts {
    'client/replacements.lua',
    'client/client.lua',
}

files {
    'visualsettings.dat',
	'vehicles.meta',
	'v_clouds.ytyp',
    'data/timecycle/timecycle_mods_1.xml',
    'data/timecycle/timecycle_mods_2.xml',
    'data/timecycle/timecycle_mods_3.xml',
    'data/timecycle/timecycle_mods_4.xml',
    'data/timecycle/timecycle_mods_5.xml',
    'data/timecycle/timecycle_mods_nv.xml',
	'data/timecycle/timecycle_mods_mb_fp.xml',
	'data/timecycle/timecycle_mods_mb_tp.xml',
	'data/timecycle/w_blizzard.xml',
    'data/timecycle/w_clear.xml',
    'data/timecycle/w_clearing.xml',
    'data/timecycle/w_clouds.xml',
    'data/timecycle/w_extrasunny.xml',
    'data/timecycle/w_foggy.xml',
    'data/timecycle/w_halloween.xml',
    'data/timecycle/w_neutral.xml',
    'data/timecycle/w_overcast.xml',
    'data/timecycle/w_rain.xml',
    'data/timecycle/w_smog.xml',
    'data/timecycle/w_snow.xml',
    'data/timecycle/w_snowlight.xml',
    'data/timecycle/w_thunder.xml',
    'data/timecycle/w_xmas.xml',
    'data/weather/blizzard_emitter_mist.xml',
    'data/weather/blizzard_render_drop.xml',
    'data/weather/blizzard_render_mist.xml',
    'data/weather/clearing_render_drop.xml',
    'data/weather/clearing_render_ground.xml',
    'data/weather/firefly_emitter_drop.xml',
    'data/weather/firefly_render_drop.xml',
    'data/weather/hurricane_emitter_mist.xml',
    'data/weather/hurricane_render_mist.xml',
    'data/weather/pollen_emitter_drop.xml',
    'data/weather/pollen_render_drop.xml',
    'data/weather/rainstorm_emitter_drop.xml',
    'data/weather/rainstorm_emitter_ground.xml',
    'data/weather/rainstorm_emitter_mist.xml',
    'data/weather/rainstorm_render_drop.xml',
    'data/weather/rainstorm_render_ground.xml',
	'data/weather/rainstorm_render_mist.xml',
    'data/weather/snowheavy_emitter_ground.xml',
    'data/weather/snowheavy_render_ground.xml',
    'data/weather/snowheavy_emitter_mist.xml',
    'data/weather/snowheavy_render_mist.xml',
    'data/weather/snowlight_emitter_drop.xml',
    'data/weather/snowlight_render_drop.xml',
    'data/weather/thunder_emitter_drop.xml',
    'data/weather/thunder_emitter_ground.xml',
    'data/weather/thunder_render_drop.xml',
    'data/weather/thunder_render_ground.xml',
    'data/action/vfx.meta',
    'data/effects/decals.dat',
    'data/effects/liquidfx.dat',
    'data/effects/bloodfx.dat',
    'data/effects/entityfx.dat',
    'data/effects/explosionfx.dat',
    'data/effects/firefx.dat',
    'data/effects/lensartefacts.ymt',
    'data/effects/vfxfogvolumeinfo.ymt',
    'data/effects/vfxregioninfo.ymt',
    'data/effects/vfxvehicleinfo.ymt',
    'data/effects/peds/peddamage.xml',
    'data/levels/doortuning.ymt',
    'data/levels/popzone.ipl',	
    'data/levels/zonebind.ymt',	
    'data/materials/procedural.meta',
    'data/metadata/explosion.ymt',	
    'gta5.meta',
    'weather.xml',
	'hbaosettings.xml',
    'popgroups.ymt',
    'popcycle.dat',
	'time.xml',
    'water.xml',
    'data/particlefx.rpf',
	'carvariations.meta',
    'vehiclemodelsets.meta',
	'informations.meta',
    'client/replacements.lua',
    'client/client.lua',
}

data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'AMBIENT_VEHICLE_MODEL_SET_FILE' 'vehiclemodelsets.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_2.xml'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_3.xml'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_4.xml'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_5.xml'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_nv.xml'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_mb_fp.xml'
data_file 'TIMECYCLEMOD_FILE' 'data/timecycle/timecycle_mods_mb_tp.xml'
data_file 'DLC_ITYP_REQUEST' 'v_clouds.ytyp'