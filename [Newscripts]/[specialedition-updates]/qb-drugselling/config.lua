Config  = Config or {}

Config.PoliceNeeded = 0 --// Amount of police needed for player to able to start talking to ped

--// This here is the chance of calling the police on each sale
Config.CallPoliceChance = 0

--// This here is the chance of calling the police on each Decline
Config.CallPoliceOnDeclineChance = 100

Config.police_percent = false --// default false set to true if you want to Uses percent_polices % value to times the decimal by the math random value

--// Drugs to sell
Config.Drugs = {
    ["coke_baggy"] = {
        min = 15,
        max = 21,
        percent_police = 50,
    },
    ["weed_baggy"] = {
        min = 15,
        max = 28,
        percent_police = 1,
    },
    ["meth_baggy"] = {
        min = 15,
        max = 31,
        percent_police = 1,
    }
}

--// Locations to sell drugs at
Config.Locations = {
    [1] = {id = 1, name = "Vinewood",  coords = vector3(101.36, 318.54, 112.09), blipradius = 70.0, blipcolor = 42, blipalpha = 200},
    [2] = {id = 2, name = "Forum Drive",  coords = vector3(-167.58, -1666.75, 33.08), blipradius = 70.0, blipcolor = 42, blipalpha = 200},
    [3] = {id = 3, name = "Little Seoul", coords = vector3(-656.74, -892.44, 24.71), blipradius = 70.0,  blipcolor = 42, blipalpha = 200},
    [4] = {id = 4, name = "The Richmonds Hotel", coords = vector3(-1255.15, 244.5, 63.09), blipradius = 70.0, blipcolor = 42, blipalpha = 200},
    [5] = {id = 5, name = "Airport", coords = vector3(-942.98, -2579.21, 13.96), blipradius = 70.0, blipcolor = 42, blipalpha = 200},
}

--// Drug Selling Animations
Config.DrugSellingAnimDic = "gestures@f@standing@casual" --// Anim Dic Ignore this if you dont know what your doing with changing Anims
Config.DrugSellingAnim = "gesture_point" --// Anim Dic Ignore this if you dont know what your doing with changing Anims

--// Ped Starting Stuff Below
Config.PedModel = "a_m_y_golfer_01" --// Ped start drug selling  can find list here https://docs.fivem.net/docs/game-references/ped-models/
Config.PedModelAnim = "WORLD_HUMAN_DRUG_DEALER" --// Anim for Ped to start selling can find list to change here https://wiki.rage.mp/index.php?title=Scenarios
Config.PedStartCoords = vector4(-61.84, -1218.32, 28.7, 270.65) --// Coords for ped to start selling

--// Ped Target Things
Config.PedIconTarget = "fas fa-user-secret" --// Icon for ped target
Config.PedLabelTarget = "Talk to Stranger" --// Label for ped target

Config.PedIconTargetStopSell = "fas fa-user-secret" --// Icon for ped target to stop selling
Config.PedLabelTargetStopSell = "Stop Working!" --// Label for ped target to stop selling

--// Menu Stuff
Config.MenuHeader = "Pick a location" --// Start Selling Menu Header Message
Config.MenuHeaderText = "You will only be able to awll drugs in the area you select" --// Start Selling Menu Header Warning Text
Config.StopSellingName = "Stop Working" --// Text that shows in menu to stop working

--// Notify Stuff
Config.NoPoliceNotify = "Not enough police" --// Alert for when starting run returns not enough police
Config.NoPoliceNotifyTime = 7500 --// Alert for when not enough police

Config.JobStartedHeadToLoc = "Head to the Location!" --// Notify that pops up when a player selected a locations
Config.JobStartedHeadToLocTextTime = 7500 --// Time for Notify when a player selected a locations

Config.JobAlreadyStartedNotifyText = "You have already selected a location!" --// Notify that pops up if player has a job active
Config.JobAlreadyStartedNotifyTextTime = 7500 --// Time for Notify that pops up if player has a job active

Config.JobAlreadyStopNotifyText = "You have stopped working!" --// Notify that pops up when job is no longer active
Config.JobAlreadyStoptedNotifyTextTime = 7500 --// Time for Notify for Job no longer active

Config.JobAlreadyNotWorkingNotifyText = "You are not working right now pick a job or scoot!" --// Notify that pops up when player doesnt have a job to stop
Config.JobAlreadyNotWorkingNotifyTextTime = 7500 --// Time for Notify that pops up when player doesnt have a job to stop

Config.DeclineSellDrugNotify = "You declined Drug offer seems like they migth have called the police!" --// Notify For Decline selling drugs
Config.DeclineSellDrugNotifyTime = 7500 --// Time Notify For Decline selling drugs

--// Warning please read the message at the end of this config
Config.Debug = false --// Command to open sell menu enabling this enables it for EVERYONE even permision group users
