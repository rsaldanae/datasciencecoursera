# 1. Fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos.
# 2. Extrae solo las medidas de la media y la desviación estándar de cada medida.
# 3. Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos
# 4. Etiqueta adecuadamente el conjunto de datos con nombres de variables descriptivos.
# 5. A partir del conjunto de datos del paso 4, crea un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.

# Cargar paquetes y obtener los datos
paquetes  <- c ( " data.table " , " reshape2 " )
sapply ( paquetes , require , character.only = TRUE , quietly = TRUE )
ruta  <- getwd ()
url  <-  " https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file ( url , file.path ( ruta , " dataFiles.zip " ))
descomprimir ( zipfile  =  " dataFiles.zip " )

# Cargar etiquetas de actividad + características
activityLabels  <- fread (file.path ( ruta , " UCI HAR Dataset / activity_labels.txt " )
                        , col.names  = c ( " classLabels " , " activityName " ))
características  <- fread (file.path ( ruta , " UCI HAR Dataset / features.txt " )
                  , col.names  = c ( " índice " , " featureNames " ))
featuresWanted  <- grep ( " (mean | std) \\ ( \\ ) " , features [, featureNames ])
mediciones  <-  características [ featuresWanted , featureNames ]
medidas  <- gsub ( ' [()] ' , ' ' , medidas )

# Cargar conjuntos de datos de trenes
train  <- fread (file.path ( path , " UCI HAR Dataset / train / X_train.txt " )) [, featuresWanted , with  =  FALSE ]
data.table :: setnames ( tren , colnames ( tren ), medidas )
trainActivities  <- fread (file.path ( ruta , " UCI HAR Dataset / train / Y_train.txt " )
                       , col.names  = c ( " Actividad " ))
trainSubjects  <- fread (file.path ( path , " UCI HAR Dataset / train / subject_train.txt " )
                       , nombres de columna  = c ( " SubjectNum " ))
train  <- cbind ( trainSubjects , trainActivities , train )

# Cargar conjuntos de datos de prueba
test  <- fread (file.path ( path , " UCI HAR Dataset / test / X_test.txt " )) [, featuresWanted , with  =  FALSE ]
data.table :: setnames ( prueba , colnames ( prueba ), mediciones )
testActivities  <- fread (file.path ( ruta , " UCI HAR Dataset / test / Y_test.txt " )
                        , col.names  = c ( " Actividad " ))
testSubjects  <- fread (file.path ( ruta , " UCI HAR Dataset / test / subject_test.txt " )
                      , nombres de columna  = c ( " SubjectNum " ))
test  <- cbind ( testSubjects , testActivities , test )

# fusionar conjuntos de datos
combinado  <- rbind ( entrenar , probar )

# Convierta classLabels a activityName básicamente. Más explícito.
combinado [[ " Actividad " ]] <-  factor ( combinado [, Actividad ]
                              , niveles  =  activityLabels [[ " classLabels " ]]
                              , etiquetas  =  activityLabels [[ " activityName " ]])

combinado [[ " SubjectNum " ]] <- as.factor ( combinado [, SubjectNum ])
combinado  <-  reshape2 :: derretir ( datos  =  combinado , id  = c ( " SubjectNum " , " Actividad " ))
combinado  <-  reshape2 :: dcast ( datos  =  combinado , SubjectNum  +  Activity  ~  variable , fun.aggregate  =  mean )

data.table :: fwrite ( x  =  combinado , file  =  " tidyData.txt " , quote  =  FALSE )
