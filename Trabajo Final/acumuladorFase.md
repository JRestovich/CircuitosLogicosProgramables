# Acumulador de fase

## Descripción del módulo

El acumulador de fase es el bloque del NCO que representa la fase de la onda senoidal. En cada actualización suma un incremento configurable $K$ a un registro de $N$ bits. Cuando la suma excede el rango del registro, se descarta el acarreo y la fase vuelve al comienzo del ciclo.

La actualización se expresa como:

$$
\phi[n+1] = (\phi[n] + K) \bmod 2^N
$$

El **máximo valor almacenado** es $2^N-1$, mientras que el **módulo del acumulador** es $2^N$: la cantidad de valores posibles, incluyendo el cero. Un recorrido completo del rango representa una vuelta de fase de $2\pi$ radianes:

$$
\theta[n] = 2\pi\frac{\phi[n]}{2^N}
$$

Por ejemplo, para $N=8$, los valores posibles son de 0 a 255 y el módulo es 256. Con $K=1$, después de 255 se obtiene 0.

## Interfaz de entrada y de salida como bloque

```text
                   +----------------------+
clk  ------------->|                      |
rst  ------------->|  Acumulador de fase  |----> fase[N-1:0]
sample_enable ---->|                      |
K[N-1:0] --------->|                      |
                   +----------------------+
```

| Señal | Dirección | Ancho | Función |
|---|---|---|---|
| `clk` | Entrada | 1 bit | Clock del circuito; la actualización ocurre en su flanco ascendente. |
| `rst` | Entrada | 1 bit | Reinicio del registro de fase a cero. Se propone reset síncrono, activo en alto y prioritario sobre la habilitación. |
| `sample_enable` | Entrada | 1 bit | Habilita la suma de $K$. Cuando vale cero, la fase conserva su valor. |
| `K` | Entrada | $N$ bits, sin signo | Incremento de fase que determina la frecuencia de salida. |
| `fase` | Salida | $N$ bits, sin signo | Fase acumulada, utilizada por el bloque que obtiene la amplitud senoidal desde la LUT. |

El ancho $N$ se define como un parámetro `generic` de VHDL al sintetizar. El incremento $K$ puede modificarse durante el funcionamiento. Para una LUT de $2^P$ posiciones, con $P\leq N$, se pueden utilizar los $P$ bits más significativos de `fase` como dirección.

Se denomina $f_s$ a la frecuencia de actualización de fase y de las muestras entregadas al DAC. Si `sample_enable` está siempre activo, $f_s=f_{clk}$. Si se activa una vez cada $D$ ciclos:

$$
f_s = \frac{f_{clk}}{D}
$$

Las ecuaciones siguientes suponen una tasa de muestras uniforme y un valor de $K$ constante. La interfaz del DAC debe sostener esa tasa sin perder muestras.

## Ecuaciones de frecuencia de salida

Cada actualización avanza una fracción $K/2^N$ de un ciclo. La frecuencia nominal de salida, dentro de la primera zona de Nyquist, es:

$$
f_o = \frac{K}{2^N} f_s
$$

Si el acumulador avanza en cada ciclo de clock:

$$
f_o = \frac{K}{2^N} f_{clk}
$$

Si avanza una vez cada $D$ ciclos:

$$
f_o = \frac{K\,f_{clk}}{2^N D}
$$

Para una frecuencia deseada $f_{o,\mathrm{deseada}}$, el incremento entero más cercano es:

$$
K = \operatorname{round}\left(\frac{f_{o,\mathrm{deseada}}\,2^N}{f_s}\right)
$$

La frecuencia realmente configurada se obtiene sustituyendo ese $K$ en la ecuación de $f_o$.

## Frecuencia máxima de salida y valor de K máximo

El límite de Nyquist corresponde a:

$$
f_{o,\mathrm{Nyquist}} = \frac{f_s}{2}
$$

Sustituyendo en la ecuación de frecuencia:

$$
\frac{K_{\mathrm{Nyquist}}}{2^N} f_s = \frac{f_s}{2}
\quad\Longrightarrow\quad
K_{\mathrm{Nyquist}} = 2^{N-1}
$$

Si se denomina $\mathrm{max}$ al máximo valor almacenado, entonces $\mathrm{max}=2^N-1$ y:

$$
K_{\mathrm{Nyquist}} = \frac{\mathrm{max}+1}{2}
$$

Para generar el seno se trabaja estrictamente por debajo de Nyquist:

$$
f_o < \frac{f_s}{2}
$$

Por lo tanto, el mayor incremento entero admisible bajo este criterio y su frecuencia asociada son:

$$
K_{\max} = 2^{N-1}-1
$$

$$
f_{o,\max} = \frac{2^{N-1}-1}{2^N}f_s
= \frac{f_s}{2}-\frac{f_s}{2^N}
$$

Si se actualiza en cada clock, se reemplaza $f_s$ por $f_{clk}$.

Exactamente en Nyquist hay dos muestras por período. Con fase inicial cero, las muestras del seno son todas nulas. Por eso este límite no debe utilizarse como frecuencia de operación del generador.

El máximo anterior es un límite de muestreo, no una garantía de calidad analógica. El DAC, el filtro de reconstrucción y la distorsión aceptable pueden exigir una frecuencia máxima menor. Si se requieren al menos $M_{\min}$ muestras por período:

$$
M = \frac{f_s}{f_o}
\qquad\Longrightarrow\qquad
f_{o,\max,\mathrm{práctica}} \leq \frac{f_s}{M_{\min}}
$$

Para un máximo práctico elegido por debajo de Nyquist:

$$
K_{\max,\mathrm{práctico}} =
\left\lfloor\frac{f_{o,\max,\mathrm{práctica}}\,2^N}{f_s}\right\rfloor
$$

Por ejemplo, exigir al menos 20 muestras por período da $K_{\max,\mathrm{práctico}}=\lfloor 2^N/20\rfloor$. Es un criterio de diseño inicial, no un requisito universal para reconstruir un seno.

## Frecuencia mínima de salida y valor de K mínimo

El menor incremento que produce una frecuencia positiva es:

$$
K_{\min} = 1
$$

Por lo tanto:

$$
f_{o,\min} = \frac{f_s}{2^N}
$$

Si se actualiza en cada clock:

$$
f_{o,\min} = \frac{f_{clk}}{2^N}
$$

El período correspondiente es:

$$
T_{o,\max} = \frac{2^N}{f_s}
$$

Para $K=0$, la fase queda constante: no se genera una oscilación y la LUT entrega un valor constante determinado por esa fase.

## Resolución de frecuencia

La resolución es la diferencia de frecuencia que resulta de aumentar $K$ en una unidad:

$$
\Delta f = f_o(K+1)-f_o(K) = \frac{f_s}{2^N}
$$

Si se actualiza en cada clock:

$$
\Delta f = \frac{f_{clk}}{2^N}
$$

Para una resolución requerida $\Delta f_{\mathrm{req}}$, se elige:

$$
N \geq \left\lceil\log_2\left(\frac{f_s}{\Delta f_{\mathrm{req}}}\right)\right\rceil
$$

Al redondear $K$ al entero más cercano, el error de cuantización de frecuencia es como máximo $\Delta f/2$, siempre que no se limite el resultado a los extremos del rango. Esto no incluye el error de la referencia física de clock.

Aumentar $N$ mejora la resolución de frecuencia, pero no aumenta la cantidad de muestras por período para una misma $f_s$ y $f_o$. El tamaño de la LUT determina la resolución de fase y el ancho de sus muestras determina la resolución digital de amplitud.
