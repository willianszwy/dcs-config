# DCS World — Setup Multi-Monitor F-16C

Setup para exportar os MFDs do F-16C para um monitor secundário, com ajuste de brilho via ReShade e botões OSB clicáveis via Helios.

## Ambiente

| | |
|---|---|
| Monitor principal | 3440x1440 (ultrawide) — à esquerda |
| Monitor secundário | 1920x1080 — à direita, alinhado no topo |
| DCS instalado em | `G:\DCS World` |
| Modo de tela | Janela (fullScreen = false) |

---

## 1. Exportar MFDs para o monitor secundário

**Copiar o arquivo:**
```
MonitorSetup/f16_2monitors.lua
→ C:\Users\[usuario]\Saved Games\DCS\Config\MonitorSetup\
```

**Ativar no DCS:**
`Options → System → Displays → Monitors Configuration → f16_2monitors`

### Layout no monitor 2

```
|<170px>| LEFT_MFCD 580x580 |<370px>| RIGHT_MFCD 580x580 |<170px>|
```

> Os MFDs são exportados em 580x580 para alinhar com a área interna dos painéis do Helios (800x800 com bezel de ~110px).

### Viewports disponíveis no F-16C

| Viewport | Descrição | Exportável |
|---|---|---|
| `LEFT_MFCD` | MFD esquerdo | Sim |
| `RIGHT_MFCD` | MFD direito | Sim |
| `EHSI` | Indicador de navegação | Sim |
| `DED` | Data Entry Display | Não |

---

## 2. ReShade — brilho dos MFDs

Os MFDs exportados ficam mais escuros que o cockpit. O ReShade corrige isso.

**Instalação:**
1. Baixar em [reshade.me](https://reshade.me)
2. Instalar em `G:\DCS World\bin\DCS.exe`
3. Selecionar API: **DirectX 10/11/12**

**Copiar os arquivos:**
```
ReShade/ReShadePreset.ini  →  G:\DCS World\bin\
ReShade/UIMask.png         →  G:\DCS World\bin\reshade-shaders\Textures\
```

**Valores Tonemap configurados:**
| Parâmetro | Valor |
|---|---|
| Gamma | 0.519 |
| Exposure | 0.147 |

> **Nota:** O UIMask está incluído para tentar isolar o efeito apenas nos MFDs.
> Se o efeito aplicar no jogo inteiro, desativar `UIMask_Top` e `UIMask_Bottom`
> no menu do ReShade (tecla Home) e deixar só o Tonemap ativo.

---

## 3. Helios — botões OSB clicáveis

O Helios cria uma sobreposição transparente com os botões OSB clicáveis em cima dos MFDs exportados.

**Instalação:**
1. Baixar em [github.com/HeliosVirtualCockpit/Helios/releases](https://github.com/HeliosVirtualCockpit/Helios/releases)
2. Instalar e abrir o **Helios Profile Editor**

**Carregar o perfil:**
```
Helios/dcs-f16.hpf
→ C:\Users\[usuario]\Documents\Helios\Profiles\
```

Abrir o Profile Editor → `Profile → Open` → selecionar `dcs-f16.hpf`

**Posições dos painéis MFD no Helios (monitor 2):**

| Painel | Left | Top | Width | Height |
|---|---|---|---|---|
| LEFT MFD | 60 | 140 | 800 | 800 |
| RIGHT MFD | 1060 | 140 | 800 | 800 |

**Interface DCS:**
- No Profile Editor: `Profile → Add Interface → DCS F-16C`
- Selecionar a pasta do DCS e clicar em **Install**
- Isso configura o `Export.lua` automaticamente

**Para usar:**
1. Abrir o **Helios Control Center**
2. Selecionar o perfil `dcs-f16`
3. Clicar em **Start**
4. Entrar no DCS com o F-16C

> O Helios Control Center deve ficar aberto durante toda a sessão de voo.

---

## Estrutura do repositório

```
├── README.md
├── INSTRUCOES.md
├── MonitorSetup/
│   └── f16_2monitors.lua       # config de monitores do DCS
├── ReShade/
│   ├── ReShadePreset.ini       # preset do ReShade
│   └── UIMask.png              # máscara para isolar efeito nos MFDs
└── Helios/
    └── dcs-f16.hpf             # perfil do Helios com MFDs do F-16C
```
