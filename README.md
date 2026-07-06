# DCS World — Setup Multi-Monitor (F-16C + AH-64D + Ka-50 III)

Exporta MFDs do F-16C, do AH-64D Apache e SHKVAL/ABRIS do Ka-50 III para monitor secundário, com ajuste de brilho via ReShade e painéis clicáveis via Helios.

## Ambiente

| | |
|---|---|
| Monitor principal | 3440×1440 (ultrawide) — à esquerda |
| Monitor secundário | 1920×1080 — à direita, alinhado no topo |
| DCS instalado em | `G:\DCS World` |
| Modo de tela | Janela (`fullScreen = false`) |
| Canvas total DCS | 5360×1440 (primário 0–3439 + secundário 3440–5359) |

---

## Estrutura do repositório

```
├── README.md
├── INSTRUCOES.md                       # doc complementar (setup antigo f16_2monitors + detalhes do Ka-50)
├── MonitorSetup/
│   └── Helios.lua                      # config de monitores gerada pelo Helios (F-16 + AH-64 + Ka-50)
├── ReShade/
│   ├── ReShadePreset.ini               # preset do ReShade (Tonemap para clarear monitor 2)
│   └── UIMask.png                      # máscara 5360×1440 — direita toda preta (shader aplica ao monitor inteiro)
└── Helios/
    ├── dcs-f16.hpf                     # perfil original F-16C (legado)
    ├── dcs-f16-new.hpf                 # perfil F-16C com todos os botões OSB mapeados
    ├── dcs-ah64.hpf                    # perfil AH-64D com Pilot + CP/G, botões OSB e funções
    ├── ka50.hpf                        # perfil Ka-50 III: SHKVAL/ABRIS + PVI-800, autopilot, datalink,
    │                                   #   targeting, armamento, UV-26 e luzes de alerta
    ├── Images/KA50/                    # imagens dos botões do perfil Ka-50 (obrigatórias)
    └── ViewportSetups/
        ├── dcs-f16-new.hvpf.json       # viewport setup F-16C para o Helios Profile Editor
        └── dcs-ah64.hvpf.json          # viewport setup AH-64D para o Helios Profile Editor
```

---

## 1. MonitorSetup — Exportar MFDs para o monitor 2

O arquivo `Helios.lua` é gerado pelo Helios Profile Editor e define quais viewports o DCS exporta, dependendo da aeronave carregada.

**Copiar o arquivo:**
```
MonitorSetup/Helios.lua
→ C:\Users\[usuario]\Saved Games\DCS\Config\MonitorSetup\
```

**Ativar no DCS:**
`Options → System → Displays → Monitors Configuration → Helios`

### Viewports exportados — F-16C

| Viewport | x | y | width | height | Descrição |
|---|---|---|---|---|---|
| `F_16C_LEFT_MFCD` | 3551 | 423 | 550 | 550 | MFD esquerdo |
| `F_16C_RIGHT_MFCD` | 4692 | 423 | 550 | 550 | MFD direito |
| `F_16C_DED` | 4677 | 57 | 517 | 175 | Data Entry Display |
| `F_16C_RWR` | 3790 | 8 | 296 | 296 | Radar Warning Receiver |
| `F_16C_EHSI` | 4199 | 630 | 391 | 391 | EHSI (navegação) |

### Viewports exportados — AH-64D

| Viewport | x | y | width | height | Descrição |
|---|---|---|---|---|---|
| `AH_64D_LEFT_MFCD_PLT` | 3618 | 247 | 544 | 579 | MFD esquerdo (Pilot) |
| `AH_64D_RIGHT_MFCD_PLT` | 4618 | 247 | 544 | 579 | MFD direito (Pilot) |
| `AH_64D_LEFT_MFCD_CPG` | 3618 | 247 | 544 | 579 | MFD esquerdo (CP/G) |
| `AH_64D_RIGHT_MFCD_CPG` | 4618 | 247 | 544 | 579 | MFD direito (CP/G) |

### Viewports exportados — Ka-50 III

| Viewport | x | y | width | height | Descrição |
|---|---|---|---|---|---|
| `KA_50_3_SHKVAL` | 3452 | 23 | 950 | 599 | Shkval (mira eletro-óptica) |
| `KA_50_3_ABRIS` | 4688 | 23 | 660 | 851 | ABRIS (mapa/navegação) |

> Coordenadas são absolutas no canvas DCS (monitor 2 começa em x=3440).
> Se mudar tamanho/posição dos viewports no perfil, reconfigurar a interface
> **DCS Monitor Setup** no Helios Profile Editor para regerar o `Helios.lua`.

---

## 2. ReShade — clarear o monitor secundário

O monitor secundário fica mais escuro que o cockpit. O ReShade aplica Tonemap em toda a tela secundária para compensar.

**Instalação:**
1. Baixar em [reshade.me](https://reshade.me)
2. Instalar em `G:\DCS World\bin\DCS.exe`
3. Selecionar API: **DirectX 10/11/12**

**Copiar os arquivos:**
```
ReShade/ReShadePreset.ini  →  G:\DCS World\bin\
ReShade/UIMask.png         →  G:\DCS World\bin\reshade-shaders\Textures\
```

**Como a máscara funciona:**

O `UIMask.png` tem 5360×1440 pixels (canvas inteiro do DCS):
- Lado esquerdo (0–3439px): **branco** → shader NÃO aplica (monitor principal preservado)
- Lado direito (3440–5359px): **preto** → shader aplica em toda a tela secundária

Isso garante que o efeito clareia o monitor secundário inteiro uniformemente, sem criar diferença de cor entre áreas.

**Gerar o UIMask.png manualmente (se necessário):**
```powershell
Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap(5360, 1440)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.FillRectangle([System.Drawing.Brushes]::White, 0, 0, 3440, 1440)
$g.FillRectangle([System.Drawing.Brushes]::Black, 3440, 0, 1920, 1440)
$g.Dispose()
$bmp.Save("G:\DCS World\bin\reshade-shaders\Textures\UIMask.png")
$bmp.Dispose()
```

**Valores Tonemap configurados:**
| Parâmetro | Valor |
|---|---|
| Gamma | 0.519 |
| Exposure | 0.147 |

---

## 3. Helios — botões OSB clicáveis

O Helios cria uma sobreposição transparente com botões OSB clicáveis em cima dos MFDs exportados.

**Instalação:**
1. Baixar em [github.com/HeliosVirtualCockpit/Helios/releases](https://github.com/HeliosVirtualCockpit/Helios/releases)
2. Instalar e abrir o **Helios Profile Editor**

**Copiar os perfis:**
```
Helios/dcs-f16-new.hpf  →  C:\Users\[usuario]\Documents\Helios\Profiles\
Helios/dcs-ah64.hpf     →  C:\Users\[usuario]\Documents\Helios\Profiles\
Helios/ka50.hpf         →  C:\Users\[usuario]\Documents\Helios\Profiles\
Helios/Images/KA50/     →  C:\Users\[usuario]\Documents\Helios\Images\KA50\   (pasta inteira)
```

**Copiar os viewport setups:**
```
Helios/ViewportSetups/dcs-f16-new.hvpf.json  →  C:\Users\[usuario]\Documents\Helios\Viewport Setups\
Helios/ViewportSetups/dcs-ah64.hvpf.json     →  C:\Users\[usuario]\Documents\Helios\Viewport Setups\
```

### 3.1 Perfil F-16C (`dcs-f16-new.hpf`)

**Botões mapeados por MFD:**
- Linha T (topo): T1–T6
- Linha R (direita): R1–R6
- Linha B (base): B1–B6
- Linha L (esquerda): L1–L6
- Botões de função: OSB 1–20 conforme layout do F-16C

**Interface DCS:**
- No Profile Editor: `Profile → Add Interface → DCS F-16C`
- Selecionar a pasta do DCS e clicar em **Install**

### 3.2 Perfil AH-64D (`dcs-ah64.hpf`)

**Botões mapeados por MFD (Pilot e CP/G):**
- Linha T (topo): T1–T6
- Linha R (direita): R1–R6
- Linha B (base): B1/M(Menu), B2–B6
- Linha L (esquerda): L1–L6
- Botões de função: FCR, WPN, TSD, M/B1, A/C, COM, VID, Asterisk

**Troca de assento (Pilot ↔ CP/G):**

O perfil exibe os painéis MFD de um assento por vez. Há dois botões no monitor 2:
- **Switch PLT** — mostra painéis do Pilot, oculta CP/G
- **Switch CPG** — mostra painéis do CP/G, oculta Pilot

Os painéis PLT e CPG ficam na mesma posição (sobrepostos); apenas um fica visível por vez.

**Interface DCS:**
- No Profile Editor: `Profile → Add Interface → DCS AH-64D Apache`
- Selecionar a pasta do DCS e clicar em **Install**

> **Importante:** O botão `B1` no AH-64D se chama `Button B1/M(Menu)` na interface DCS. O nome exato deve constar tanto no trigger quanto na action da binding — qualquer divergência faz o botão não responder.

### 3.3 Perfil Ka-50 III (`ka50.hpf`)

Perfil completo do Black Shark 3 no monitor 2, ao redor dos viewports SHKVAL e ABRIS:

- **PVI-800** (navegação): displays, teclado 0-9, ENTER/CANCEL, modos WPT/FIX/AIRF/TGT/φλ,
  alinhamento INU e seletor Master Mode de 7 posições
- **Autopilot**: canais B/P/H/A/FD com lâmpadas de engate + toggles ALT SRC e HDG-TRK
- **Datalink PRTz**: destinatários 1-4/ALL, tipos de alvo, SEND/MEM, ERASE, TURN AWAY,
  ponto de ingresso + knobs Self ID e modo
- **Targeting/Shkval**: AUTO TURN, AIR TGT, HEAD ON, MOV TGT, RESET + toggles LASER STBY e TRACK
- **Armamento (PUI-800)**: displays de arma selecionada, quantidade e munição do canhão
- **Weapon Control (PUI-800)**: lâmpadas de estação pronta 1-4 + toggles MASTER ARM,
  modo MAN/AUTO, munição HE/AP, cadência LO/HI e rajada LONG/MED/SHORT
- **UV-26**: display de flares, lâmpadas L/R, knob L/L+R/R, START/STOP/RESET e programação
- **Luzes de alerta**: MSTR CAUT e ROTOR RPM (clicáveis para reset), FIRE, UNDER FIRE, XMSN
- Softkeys 1-5 do ABRIS sob o viewport do mapa (alinhados com as luzes de alerta,
  acendem em âmbar ao clicar)

Legendas em inglês (padrão do cockpit EN do DCS). Lâmpadas e displays sincronizam
com o estado do jogo em tempo real.

> **Importante:** o perfil usa as imagens de `Helios/Images/KA50/` — sem essa pasta
> copiada para `Documents\Helios\Images\KA50\`, os botões aparecem vazios.

**Interface DCS:**
- No Profile Editor: `Profile → Add Interface → DCS Black Shark 3`
- Selecionar a pasta do DCS e clicar em **Install**

### 3.4 Iniciar o Helios

1. Abrir o **Helios Control Center**
2. Selecionar o perfil desejado (`dcs-f16-new`, `dcs-ah64` ou `ka50`)
3. Clicar em **Start**
4. Entrar no DCS com a aeronave correspondente

> O Helios Control Center deve ficar aberto durante toda a sessão de voo.

---

## Troubleshooting

**MFDs não exportam para o monitor 2:**
- Verificar se `Helios.lua` está em `Saved Games\DCS\Config\MonitorSetup\`
- Verificar se a configuração "Helios" está selecionada em Options → System → Displays
- O perfil `.hpf` precisa ter a interface `Patching.DCS.MonitorSetup` declarada

**Botões OSB não funcionam:**
- Verificar se o Helios Control Center está rodando com o perfil ativo
- Verificar se a interface DCS foi instalada pelo Profile Editor (`Export.lua` configurado)
- Checar o log do Helios em `C:\Users\[usuario]\Documents\Helios\Logs\` — erros de binding aparecem como `[nome] not found at interface`

**Botão B1 do AH-64D não responde:**
- O nome correto na interface é `Button B1/M(Menu)` — verificar se tanto o trigger quanto a action da binding usam esse nome exato

**Shader aplica no jogo inteiro (não só no monitor 2):**
- Verificar se o `UIMask.png` tem 5360×1440 e que os primeiros 3440px são brancos
- Confirmar que o shader `UIMask_Top` e `UIMask_Bottom` estão ativos no menu do ReShade (tecla Home)
