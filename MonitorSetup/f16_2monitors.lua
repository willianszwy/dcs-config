_  = function(p) return p; end;
name = _('f16_2monitors');

Viewports =
{
  Center =
  {
    x = 0; y = 0;
    width = 3440;
    height = 1440;
    viewDx = 0; viewDy = 0;
    aspect = 3440/1440;
  }
}

UIMainView = Viewports.Center
GU_MAIN_VIEWPORT = Viewports.Center

-- Monitor secundario: 1920x1080, posicionado a direita do principal (X=3440)
-- Helios painel 800x800, area interna 580x580 com offset de 110px
LEFT_MFCD =
{
  x = 3440 + 60 + 110;  -- offset do painel Helios + bezel
  y = 140 + 110;
  width = 580;
  height = 580;
}

RIGHT_MFCD =
{
  x = 3440 + 1060 + 110;  -- painel direito + bezel
  y = 140 + 110;
  width = 580;
  height = 580;
}
