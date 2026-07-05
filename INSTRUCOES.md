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

## 3. Profile Helios Ka-50 III (ka50.hpf)

**Arquivos:**
- `Helios/ka50.hpf` -> `Documents\Helios\Profiles\`
- `Helios/Images/KA50/` (pasta inteira) -> `Documents\Helios\Images\KA50\`

O profile usa imagens customizadas no estilo real do cockpit (botões pretos com
faixa-lâmpada verde/âmbar, legendas em inglês no padrão do cockpit EN do DCS).
**Sem a pasta de imagens os botões aparecem vazios.**

### Painéis incluídos (monitor 2, junto aos viewports SHKVAL/ABRIS):
- PVI-800 completo: displays, teclado 0-9, ENTER/CANCEL, modos (WPT/FIX/AIRF/TGT/φλ...),
  alinhamento INU e seletor Master Mode (7 posições)
- Autopilot: B/P/H/A/FD com lâmpadas de canal engatado + toggles ALT SRC e HDG-TRK
- Datalink PRTz: destinatários 1-4/ALL, tipos de alvo, SEND/MEM, ERASE, TURN AWAY,
  ponto de ingresso + knobs Self ID e modo
- Targeting/Shkval (faixa sob o SHKVAL): AUTO TURN, AIR TGT, HEAD ON, MOV TGT,
  RESET + toggles LASER STBY e TRACK
- Armamento (PUI-800): displays de arma selecionada, quantidade e munição do canhão
- UV-26: display de flares, lâmpadas L/R, knob L/L+R/R, START/STOP/RESET e programação
- Luzes de alerta sob o ABRIS: MSTR CAUT e ROTOR RPM (clicáveis), FIRE, UNDER FIRE, XMSN
- Lâmpadas e displays sincronizam com o estado do jogo (trigger `<nome> indicator`)
- Se mudar tamanho/posição dos viewports, reconfigurar a interface
  "DCS Monitor Setup" no Helios Profile Editor

---

## Estrutura de arquivos deste backup

```
DCS_Setup_Backup/
├── INSTRUCOES.md               <- este arquivo
├── Helios/
│   ├── ka50.hpf                -> Documents\Helios\Profiles\
│   ├── dcs-f16-new.hpf         -> Documents\Helios\Profiles\
│   ├── Images/KA50/            -> Documents\Helios\Images\KA50\
│   └── ...                     (demais profiles)
├── MonitorSetup/
│   └── f16_2monitors.lua       -> Saved Games\DCS\Config\MonitorSetup\
└── ReShade/
    ├── ReShadePreset.ini       -> G:\DCS World\bin\
    └── UIMask.png              -> G:\DCS World\bin\reshade-shaders\Textures\
```
