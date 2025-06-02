import tkinter as tk
from tkinter import ttk
import numpy as np
from scipy import signal
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

class ADCSimulator:
    def __init__(self, root):
        self.root = root
        self.root.title("Simulador ADC - Grupo 17")

        # Crear Canvas y Scrollbar para desplazamiento vertical
        self.canvas = tk.Canvas(root)
        self.scrollbar = ttk.Scrollbar(root, orient="vertical", command=self.canvas.yview)
        self.scrollable_frame = ttk.Frame(self.canvas)

        # Configurar el Canvas para que se desplace según el tamaño del Frame
        self.scrollable_frame.bind(
            "<Configure>",
            lambda e: self.canvas.configure(scrollregion=self.canvas.bbox("all"))
        )
        self.canvas.create_window((0, 0), window=self.scrollable_frame, anchor="nw")
        self.canvas.configure(yscrollcommand=self.scrollbar.set)

        # Empaquetar Canvas y Scrollbar
        self.canvas.pack(side="left", fill="both", expand=True)
        self.scrollbar.pack(side="right", fill="y")

        # Configuración de la interfaz en scrollable_frame
        self.setup_gui()

    def setup_gui(self):
        # Selección de señal
        ttk.Label(self.scrollable_frame, text="Tipo de señal:").grid(row=0, column=0, padx=5, pady=5)
        self.signal_type = tk.StringVar(value="Seno")
        signal_options = ["Seno", "Cuadrada", "Ruido", "Triangular", "Diente de sierra", "AM"]
        ttk.OptionMenu(self.scrollable_frame, self.signal_type, "Seno", *signal_options).grid(row=0, column=1, padx=5, pady=5)

        # Frecuencia
        ttk.Label(self.scrollable_frame, text="Frecuencia (Hz):").grid(row=1, column=0, padx=5, pady=5)
        self.freq = tk.Entry(self.scrollable_frame)
        self.freq.insert(0, "1000")
        self.freq.grid(row=1, column=1, padx=5, pady=5)

        # Tasa de muestreo
        ttk.Label(self.scrollable_frame, text="Tasa de muestreo (Hz):").grid(row=2, column=0, padx=5, pady=5)
        self.fs = tk.Entry(self.scrollable_frame)
        self.fs.insert(0, "8000")
        self.fs.grid(row=2, column=1, padx=5, pady=5)

        # Bits de cuantización
        ttk.Label(self.scrollable_frame, text="Bits de cuantización:").grid(row=3, column=0, padx=5, pady=5)
        self.bits = tk.StringVar(value="8")
        ttk.OptionMenu(self.scrollable_frame, self.bits, "8", "8", "16", "24").grid(row=3, column=1, padx=5, pady=5)

        # Botón Simular
        ttk.Button(self.scrollable_frame, text="Simular", command=self.simulate).grid(row=4, column=0, columnspan=2, pady=10)

        # Área para gráficos
        self.fig, self.ax = plt.subplots(3, 1, figsize=(8, 6))
        self.canvas_plot = FigureCanvasTkAgg(self.fig, master=self.scrollable_frame)
        self.canvas_plot.get_tk_widget().grid(row=5, column=0, columnspan=2, padx=5, pady=5)

    def generate_signal(self, t, freq, signal_type):
        if signal_type == "Seno":
            return np.sin(2 * np.pi * freq * t)
        elif signal_type == "Cuadrada":
            return signal.square(2 * np.pi * freq * t)
        elif signal_type == "Ruido":
            return np.random.normal(0, 1, len(t))
        elif signal_type == "Triangular":
            return signal.sawtooth(2 * np.pi * freq * t, width=0.5)
        elif signal_type == "Diente de sierra":
            return signal.sawtooth(2 * np.pi * freq * t, width=1)
        elif signal_type == "AM":
            carrier = np.sin(2 * np.pi * 10 * freq * t)  # Portadora 10x frecuencia
            modulator = 0.5 * (1 + np.sin(2 * np.pi * freq * t))  # Moduladora
            return carrier * modulator

    def quantize(self, signal, bits):
        levels = 2 ** bits
        signal_max = np.max(np.abs(signal))
        step = 2 * signal_max / levels
        quantized = np.round(signal / step) * step
        return quantized

    def simulate(self):
        try:
            freq = float(self.freq.get())
            fs = float(self.fs.get())
            bits = int(self.bits.get())
            signal_type = self.signal_type.get()

            # Generar señal
            t = np.linspace(0, 0.01, int(fs * 0.01))  # 10ms
            analog_signal = self.generate_signal(t, freq, signal_type)

            # Muestreo
            ts = np.arange(0, 0.01, 1/fs)
            sampled_signal = self.generate_signal(ts, freq, signal_type)

            # Cuantización
            quantized_signal = self.quantize(sampled_signal, bits)

            # Graficar
            self.ax[0].clear()
            self.ax[0].plot(t, analog_signal)
            self.ax[0].set_title("Señal Analógica")
            self.ax[0].set_xlabel("Tiempo (s)")
            self.ax[0].set_ylabel("Amplitud")

            self.ax[1].clear()
            self.ax[1].stem(ts, sampled_signal)
            self.ax[1].set_title("Señal Muestreada")
            self.ax[1].set_xlabel("Tiempo (s)")
            self.ax[1].set_ylabel("Amplitud")

            self.ax[2].clear()
            self.ax[2].stem(ts, quantized_signal)
            self.ax[2].set_title(f"Señal Cuantizada ({bits} bits)")
            self.ax[2].set_xlabel("Tiempo (s)")
            self.ax[2].set_ylabel("Amplitud")

            self.fig.tight_layout()
            self.canvas_plot.draw()

        except ValueError as e:
            tk.messagebox.showerror("Error", "Ingresa valores numéricos válidos.")
        except Exception as e:
            tk.messagebox.showerror("Error", str(e))

if __name__ == "__main__":
    root = tk.Tk()
    app = ADCSimulator(root)
    root.mainloop()