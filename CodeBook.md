Información del conjunto de datos
Los experimentos se han realizado con un grupo de 30 voluntarios dentro de un grupo de edad de 19 a 48 años. Cada persona realizó seis actividades (CAMINAR, CAMINAR_ARRIBA, CAMINAR_BAJAR, SENTARSE, DE PIE, ACOSTARSE) con un teléfono inteligente (Samsung Galaxy S II) en la cintura. Usando su acelerómetro y giroscopio integrados, capturamos la aceleración lineal 3-axial y la velocidad angular 3-axial a una tasa constante de 50Hz. Los experimentos se han grabado en video para etiquetar los datos manualmente. El conjunto de datos obtenido se ha dividido aleatoriamente en dos conjuntos, donde se seleccionó al 70% de los voluntarios para generar los datos de entrenamiento y al 30% los datos de la prueba.

Las señales del sensor (acelerómetro y giroscopio) se preprocesaron aplicando filtros de ruido y luego se muestrearon en ventanas deslizantes de ancho fijo de 2,56 segundos y 50% de superposición (128 lecturas / ventana). La señal de aceleración del sensor, que tiene componentes gravitacionales y de movimiento corporal, se separó mediante un filtro de paso bajo Butterworth en aceleración corporal y gravedad. Se supone que la fuerza gravitacional tiene solo componentes de baja frecuencia, por lo que se utilizó un filtro con una frecuencia de corte de 0.3 Hz. De cada ventana, se obtuvo un vector de características mediante el cálculo de variables del dominio del tiempo y la frecuencia.

Información de atributos
Para cada registro del conjunto de datos se proporciona:

Aceleración triaxial del acelerómetro (aceleración total) y la aceleración corporal estimada.
Velocidad angular triaxial del giroscopio.
Un vector de 561 características con variables de dominio de tiempo y frecuencia.
Su etiqueta de actividad.
Un identificador del sujeto que realizó el experimento.
Consulte el archivo README.md para ver cómo se implementan las siguientes instrucciones. README.md
1. Combine los conjuntos de entrenamiento y prueba para crear un conjunto de datos.
2. Extrae solo las mediciones de la media y la desviación estándar de cada medición.
3. Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos
4. Etiquete adecuadamente el conjunto de datos con nombres de variables descriptivos.
5. A partir del conjunto de datos del paso 4, crea un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.
