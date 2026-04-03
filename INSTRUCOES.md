# DCS World — Setup Multi-Monitor F-16C

## Configuração do ambiente
- Monitor principal: 3440x1440 (ultrawide) — DISPLAY1
- Monitor secundário: 1920x1080 — DISPLAY2, posicionado à direita, alinhado no topo
- DCS instalado em: G:\DCS World
- DCS em modo janela (fullScreen = false)

---

## 1. Monitor Setup (MFDs no monitor 2)

**Arquivo:** `f16_2monitors.lua`  
**Destino:** `C:\Users\[usuario]\Saved Games\DCS\Config\MonitorSetup\`

Copiar o arquivo `MonitorSetup/f16_2monitors.lua` para o destino acima.

**Ativar no DCS:**  
`Options → System → Displays → Monitors Configuration → f16_2monitors`

### O que faz:
- Exporta LEFT_MFCD e RIGHT_MFCD do F-16C para o monitor secundário
- LEFT_MFCD: posição x=3500, y=140, tamanho 800x800
- RIGHT_MFCD: posição x=4500, y=140, tamanho 800x800
- UIMainView e GU_MAIN_VIEWPORT apontam para o monitor principal (evita offset no cursor/mira)

### Viewports disponíveis no F-16C:
- `LEFT_MFCD` — MFD esquerdo
- `RIGHT_MFCD` — MFD direito
- `EHSI` — indicador de navegação (não exportado neste setup)
- DED não suporta exportação nativa

---

## 2. ReShade (brilho dos MFDs)

**Instalação:**  
- Baixar ReShade em https://reshade.me
- Instalar em `G:\DCS World\bin\DCS.exe`
- Selecionar API: DirectX 10/11/12

**Arquivos:**  
Copiar `ReShade/ReShadePreset.ini` para `G:\DCS World\bin\`  
Copiar `ReShade/UIMask.png` para `G:\DCS World\bin\reshade-shaders\Textures\`

### Valores configurados (Tonemap):
- Gamma: 0.519
- Exposure: 0.147

### Observação UIMask:
O UIMask está configurado para tentar isolar o efeito apenas nos MFDs (monitor 2),
mas pode não funcionar dependendo da resolução de buffer que o ReShade detectar.
Se o efeito aplicar no jogo inteiro, desativar UIMask_Top e UIMask_Bottom no ReShade
e deixar só o Tonemap ativo — os valores foram escolhidos para serem sutis o suficiente.

---

## Estrutura de arquivos deste backup

```
DCS_Setup_Backup/
├── INSTRUCOES.md               <- este arquivo
├── MonitorSetup/
│   └── f16_2monitors.lua       -> Saved Games\DCS\Config\MonitorSetup\
└── ReShade/
    ├── ReShadePreset.ini       -> G:\DCS World\bin\
    └── UIMask.png              -> G:\DCS World\bin\reshade-shaders\Textures\
```
