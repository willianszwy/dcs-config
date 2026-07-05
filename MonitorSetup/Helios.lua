_  = function(p) return p end
name = _('Helios')
description = 'Generated from compatible Helios Profiles'

function reconfigure_for_unit(unit_type)
  if  unit_type == "AH-64D_BLK_II" or false then
    AH_64D_LEFT_MFCD_CPG = { x = 3618, y = 247, width = 544, height = 579 }
    AH_64D_LEFT_MFCD_PLT = { x = 3618, y = 247, width = 544, height = 579 }
    AH_64D_RIGHT_MFCD_CPG = { x = 4618, y = 247, width = 544, height = 579 }
    AH_64D_RIGHT_MFCD_PLT = { x = 4618, y = 247, width = 544, height = 579 }
    return
  end -- _AH-64D_BLK_II

  if  unit_type == "F-16C_50" or false then
    F_16C_DED = { x = 4677, y = 57, width = 517, height = 175 }
    F_16C_EHSI = { x = 4203, y = 533, width = 391, height = 391 }
    F_16C_LEFT_MFCD = { x = 3551, y = 423, width = 550, height = 550 }
    F_16C_RIGHT_MFCD = { x = 4692, y = 423, width = 550, height = 550 }
    F_16C_RWR = { x = 3790, y = 8, width = 296, height = 296 }
    return
  end -- _F-16C_50

  if  unit_type == "Ka-50_3" or false then
    KA_50_3_ABRIS = { x = 4688, y = 23, width = 660, height = 851 }
    KA_50_3_SHKVAL = { x = 3452, y = 23, width = 950, height = 599 }
    return
  end -- _Ka-50_3
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