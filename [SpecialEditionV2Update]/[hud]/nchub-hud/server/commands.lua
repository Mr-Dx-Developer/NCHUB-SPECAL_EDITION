if Config.FrameWork == "esx" then
    Koci.Framework.RegisterCommand("hudsettings", "user", function(xPlayer, args, showError)
        xPlayer.triggerEvent("nchub-hud:Client:OpenHudSettings")
    end, true, {
        help = _t("hud.commands.hudsettings.help"),
        validate = true,
    })
elseif Config.FrameWork == "qb" then
    Koci.Framework.Commands.Add("hud", _t("hud.commands.hudsettings.help"), {}, false, function(source, args)
        local src = source
        TriggerClientEvent("nchub-hud:Client:OpenHudSettings", src)
    end)
end
