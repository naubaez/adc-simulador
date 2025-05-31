import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import tkinter as tk
from tkinter import ttk
import scipy.signal

class ADCSimulator:
    def __init__(self, root):
        self.root = root
        self.root.title("Simulador de Conversión de Señales (ADC)")
        
        # Variables
        self.signal_type = tk.StringVar(value="Seno")
        self.frequency = tk.DoubleVar(value=1000.0)
        self.sampling_rate = tk.DoubleVar(value=8000.0)
        self.quantization_bits = tk.IntVar(value=8)
        
        # Interfaz
        self.create_widgets()
        
    def create_widgets(self):
        # Frame para entradas
        input_frame = ttk.LabelFrame(self.root, text="Parámetros", padding=10)
        input_frame.grid(row=0, column=0, padx=10, pady=10, sticky="ew")
        
        # Tipo de señal
        ttk.Label(input_frame, text="Tipo de señal:").grid(row=0, column=0, padx=5, pady=5)
        signal_types = ["Seno", "Cuadrada", "Ruido"]
        ttk.OptionMenu(input_frame, self.signal_type, "Seno", *signal_types).grid(row=0, column=1, padx=5, pady=5)
        
        # Frecuencia
        ttk.Label(input_frame, text="Frecuencia (Hz):").grid(row=1, column=0, padx=5, pady=5)
        ttk.Entry(input_frame, textvariable=self.frequency).grid(row=1, column=1, padx=5, pady=5)
        
        # Tasa de muestreo
        ttk.Label(input_frame, text="Tasa de muestreo (Hz):").grid(row=2, column=0, padx=5, pady=5)
        ttk.Entry(input_frame, textvariable=self.sampling_rate).grid(row=2, column=1, padx=5, pady=5)
        
        # Bits de cuantización
        ttk.Label(input_frame, text="Bits de cuantización:").grid(row=3, column=0, padx=5, pady=5)
        ttk.OptionMenu(input_frame, self.quantization_bits, 8, 8, 16, 24).grid(row=3, column=1, padx=5, pady=5)
        
        # Botón Simular
        ttk.Button(input_frame, text="Simular", command=self.simulate).grid(row=4, column=0, columnspan=2, pady=10)
        
        # Botón Exportar (funcionalidad adicional)
        ttk.Button(input_frame, text="Exportar Gráfico", command=self.export_plot).grid(row=5, column=0, columnspan=2, pady=10)
        
        # Área para gráficos
        self.figure, self.axs = plt.subplots(3, 1, figsize=(8, 6))
        self.canvas = FigureCanvasTkAgg(self.figure, master=self.root)
        self.canvas.get_tk_widget().grid(row=1, column=0, padx=10, pady=10)
        
    def generate_signal(self, t):
        if self.signal_type.get() == "Seno":
            return np.sin(2 * np.pi * self.frequency.get() * t)
        elif self.signal_type.get() == "Cuadrada":
            return scipy.signal.square(2 * np.pi * self.frequency.get() * t)
        elif self.signal_type.get() == "Ruido":
            return np.random.normal(0, 1, len(t))
    
    def sample_signal(self, signal, t, fs):
        sampling_interval = 1 / fs
        sample_times = np.arange(0, t[-1], sampling_interval)
        sampled_signal = np.interp(sample_times, t, signal)
        return sample_times, sampled_signal
    
    def quantize_signal(self, signal, bits):
        levels = 2 ** bits
        signal_min, signal_max = np.min(signal), np.max(signal)
        quantized_signal = np.round((signal - signal_min) / (signal_max - signal_min) * (levels - 1)) / (levels - 1) * (signal_max - signal_min) + signal_min
        return quantized_signal
    
    def simulate(self):
        # Limpiar gráficos
        for ax in self.axs:
            ax.clear()
        
        # Generar señal
        t = np.linspace(0, 0.01, 10000)  # 10ms de señal
        signal = self.generate_signal(t)
        
        # Muestreo
        fs = self.sampling_rate.get()
        sample_times, sampled_signal = self.sample_signal(signal, t, fs)
        
        # Cuantización
        bits = self.quantization_bits.get()
        quantized_signal = self.quantize_signal(sampled_signal, bits)
        
        # Verificar Teorema de Nyquist
        nyquist_rate = 2 * self.frequency.get()
        aliasing_message = "OK" if fs >= nyquist_rate else "Aliasing detectado (fs < 2*f)"
        
        # Graficar
        self.axs[0].plot(t, signal, label="Señal Original")
        self.axs[0].set_title("Señal Original")
        self.axs[0].legend()
        
        self.axs[1].stem(sample_times, sampled_signal, label="Señal Muestreada")
        self.axs[1].set_title(f"Señal Muestreada (fs={fs} Hz, {aliasing_message})")
        self.axs[1].legend()
        
        self.axs[2].stem(sample_times, quantized_signal, label=f"Señal Cuantizada ({bits} bits)")
        self.axs[2].set_title("Señal Cuantizada")
        self.axs[2].legend()
        
        self.figure.tight_layout()
        self.canvas.draw()
        
    def export_plot(self):
        self.figure.savefig("adc_simulation.png")
        tk.messagebox.showinfo("Éxito", "Gráfico exportado como adc_simulation.png")

if __name__ == "__main__":
    root = tk.Tk()
    app = ADCSimulator(root)
    root.mainloop()