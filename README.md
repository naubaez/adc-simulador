# **Simulador de Conversión de Señales (ADC) - Grupo 17**

*Trabajo Práctico Integrador para **Comunicación de Datos** (UTN La Plata, S32, 2025)*

## **Integrantes**
- **Baez Nahuel Maximiliano**
- **Crespo Milagros**
- **Hrynkiewicz Cristian**
- **Jorge Ricardo Matias**
- **Mugetti Emmanuel**

## **Descripción**
Este proyecto implementa un **simulador de conversión analógica-digital (ADC)** en *Python*. Permite:

- Generar señales: **seno**, **cuadrada**, **ruido**, **triangular**, **diente de sierra**, y **modulada en amplitud (AM)**.
- Simular **muestreo** con tasas como *8 kHz* o *44.1 kHz*.
- Aplicar **cuantización** con *8*, *16*, *24* o *32 bits*.
- Visualizar señales: *original*, *muestreada*, y *cuantizada* en una interfaz con **desplazamiento vertical**.
- Demostrar el **Teorema de Nyquist** y el fenómeno de **aliasing**.
- Exportar gráficos como **PNG** (pendiente de implementación).

## **Requisitos**

### 1. Instalar Git
- Descarga e instala Git desde la página oficial: [https://git-scm.com/downloads](https://git-scm.com/downloads).
- Sigue el instalador predeterminado, aceptando todas las opciones recomendadas.

### 2. Instalar Python 3.13.3 o superior
- Descarga Python 3.13.3 desde la página oficial: [https://www.python.org/downloads/release/python-3133/](https://www.python.org/downloads/release/python-3133/).
- Durante la instalación, **asegúrate de marcar la opción "Add Python to PATH"** para que el comando `python` esté disponible en la consola.
- Recomendamos instalar para todos los usuarios y completar el proceso con las opciones predeterminadas.

### 3. Instalar las dependencias del simulador
- Instalar las dependencias del simulador
Se incluye un script para automatizar la instalación de librerías necesarias (numpy, matplotlib, scipy) en entornos Windows:

- Pasos para ejecutar el script
Navega a la carpeta del proyecto.

Abre el archivo install_libraries.ps1 con clic derecho y selecciona "Ejecutar con PowerShell".

El script instalará automáticamente las dependencias si Python está correctamente instalado y accesible en el sistema.
