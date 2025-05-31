# Simulador de Conversión de Señales (ADC) – Grupo 17

**Trabajo Práctico Integrador – Comunicación de Datos**  
UTN La Plata – S32 – 2025

## Integrantes
- Báez Nahuel Maximiliano  
- Crespo Milagros  
- Hrynkiewicz Cristian  
- Jorge Ricardo Matías  
- Mugetti Emmanuel  

---

##  Descripción

Simulador interactivo en Python que permite representar el proceso de **conversión analógica-digital (ADC)**, visualizando el efecto de distintos parámetros sobre una señal.

### Funcionalidades:
- Generación de señales: seno, cuadrada y ruido.
- Simulación de muestreo con tasas configurables (ej. 8 kHz, 44.1 kHz).
- Cuantización con distintos niveles de bits (8, 16, 24).
- Visualización gráfica: señal original, muestreada y cuantizada.
- Detección y visualización de aliasing (según Teorema de Nyquist).
- Exportación de gráficos como imagen PNG.

---

##Requisitos

- **Python**: 3.9 o superior  
- **Librerías**: `numpy`, `matplotlib`, `scipy` (ver `requirements.txt`)
- **Sistema operativo**:
  - Windows (recomendado)
  - Linux o WSL (con servidor X11)
- **Tkinter**:
  - Incluido en Windows
  - En Linux/WSL requiere instalación de `python3-tk`

---

## 🧪 Instalación y ejecución

###  Windows

1. **Abrir PowerShell como administrador**
2. Clonar el repositorio:
   ```bash
   git clone https://github.com/naubae

