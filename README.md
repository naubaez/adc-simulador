# Simulador de Conversión de Señales (ADC) - Grupo 17

Trabajo Práctico Integrador para la materia *Comunicación de Datos* (UTN La Plata, S32, 2025).

## Integrantes
- Baez Nahuel Maximiliano
- Crespo Milagros
- Hrynkiewicz Cristian
- Jorge Ricardo Matias
- Mugetti Emmanuel

## Descripción
Este proyecto implementa un simulador de conversión de señales analógicas a digitales (ADC) en Python. Permite:
- Generar señales (seno, cuadrada, ruido).
- Simular muestreo con diferentes tasas (ej. 8 kHz, 44.1 kHz).
- Aplicar cuantización con distintos bits (8, 16, 24).
- Visualizar señales original, muestreada y cuantizada.
- Demostrar el Teorema de Nyquist y aliasing.
- Exportar gráficos como PNG.

## Requisitos
- Python 3.8 o superior
- Dependencias: `numpy`, `matplotlib`, `scipy` (ver `requirements.txt`)

## Instalación
1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu_usuario/adc-simulator.git
   cd adc-simulator
