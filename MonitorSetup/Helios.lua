_  = function(p) return p end
name = _('Helios')
description = 'Generated from compatible Helios Profiles'

function reconfigure_for_unit(unit_type)
  if  unit_type == "F-16C_50" or false then
    F_16C_DED = { x = 4677, y = 57, width = 517, height = 175 }
    F_16C_LEFT_MFCD = { x = 3551, y = 423, width = 550, height = 550 }
    F_16C_RIGHT_MFCD = { x = 4692, y = 423, width = 550, height = 550 }
    F_16C_RWR = { x = 3790, y = 8, width = 296, height = 296 }
    return
  end -- _F-16C_50
end -- reconfigure_for_unit()

Viewports = {
  Center = {
    x = 0,
    y = 0,
    width = 3440,
    height = 1440,
    aspect = 2.38888888888889,
    dx = 0,
    dy = 0
  }
}
UIMainView = Viewports.Center
GU_MAIN_VIEWPORT = Viewports.Center