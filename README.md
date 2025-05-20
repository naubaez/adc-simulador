# Simulador de Conversión de Señales (ADC)

Este proyecto simula la digitalización de señales analógicas mediante muestreo y cuantización.

## Tecnologías
- Python 3
- NumPy
- Matplotlib

## Estructura
- `signal_generator.py`: genera ondas analógicas (seno, cuadrada, ruido)
- `adc_converter.py`: realiza el muestreo y la cuantización
- `visualizer.py`: muestra gráficamente las señales

## Requisitos
```bash
pip install -r requirements.txt

# Crear entorno virtual (recomendado)
python -m venv env

# Activar entorno (Windows)
env\Scripts\activate

# Activar entorno (Linux/macOS)
source env/bin/activate

# Instalar librerías
pip install -r requirements.txt
