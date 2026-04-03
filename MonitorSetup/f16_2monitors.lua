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
-- Dois MFDs 800x800, centralizados verticalmente, com margem lateral de 60px
LEFT_MFCD =
{
  x = 3440 + 60;    -- 60px de margem esquerda
  y = 140;          -- (1080 - 800) / 2 = centralizado verticalmente
  width = 800;
  height = 800;
}

RIGHT_MFCD =
{
  x = 3440 + 60 + 800 + 200;  -- 200px de espaco no meio
  y = 140;
  width = 800;
  height = 800;
}
