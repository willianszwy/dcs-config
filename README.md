# DCS World — Setup Multi-Monitor F-16C

Setup para exportar os MFDs do F-16C para um monitor secundário, com ajuste de brilho via ReShade.

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
|<60px>| LEFT_MFCD 800x800 |<200px>| RIGHT_MFCD 800x800 |<60px>|
```

Centralizados verticalmente (140px de margem topo/base).

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

## Estrutura do repositório

```
├── README.md
├── INSTRUCOES.md               # instruções detalhadas
├── MonitorSetup/
│   └── f16_2monitors.lua       # config de monitores do DCS
└── ReShade/
    ├── ReShadePreset.ini        # preset do ReShade
    └── UIMask.png               # máscara para isolar efeito nos MFDs
```
