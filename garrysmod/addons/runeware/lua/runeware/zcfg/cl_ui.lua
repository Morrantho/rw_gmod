if !ui.enabled then return; end
ui.disabled   =
{
	CHudAmmo      = true,
	CHudBattery   = true,
	CHudCrosshair = true,
	CHudCloseCaption = true,
	CHudDamageIndicator = true,
	CHudDeathNotice = true,
	CHudHealth = true,
	CHudPoisonDamageIndicator = true,
	CHudSecondaryAmmo = true,
	CHudSquadStatus = true,
	CHudVehicle = true,
	CHudSuitPower = true,
};
-- these point to commands and run them when binds are hit.
ui.binds =
{
	gm_showspare1 = "rw_cursor"
};