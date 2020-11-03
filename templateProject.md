Parte 1 Trace las tasas de mortalidad a 30 días por ataque cardíaco ( resultado.R )
# install.packages ("data.table") 
biblioteca ( " data.table " )

# Lectura de datos 
resultado  <-  data.table :: fread ( ' resultado-de-medidas-de-atención.csv ' )
 resultado [, ( 11 ) : = lapply ( .SD , as.numeric ), .SDcols  = ( 11 ) ]
 resultado [, lapply ( .SD 
                 , hist 
                 , xlab =  " Muertes " 
                 , main  =  " Tasas de muerte (mortalidad) hospitalarias a 30 días por ataque cardíaco" 
                 , col = " azul claro " )
        , .SDcols = (11)]


Parte 2 Encontrar el mejor hospital en un estado ( best.R )
mejor  <-  función ( estado , resultado ) {
  
  # Leer datos de resultado 
  out_dt  <-  data.table :: fread ( ' resultado-de-cuidados- medidas.csv ' )
  
  resultado  <- tolower ( resultado )
  
  # El nombre de la columna es el mismo que el de la variable, por lo que se 
  cambia el  estado elegido <-  estado 

  # Verifique que el estado y el resultado sean válidos 
  si ( ! Selected_state  % in% unique ( out_dt [[ " State " ]])) {
    detener ( ' estado inválido ' )
  }
  
  if ( ! result  % in% c ( " ataque cardíaco " , " insuficiencia cardíaca " , " neumonía " )) {
    detener ( ' resultado no válido ' )
  }
  
  # Cambiar el nombre de las columnas para que sean menos detallados y los conjuntos de 
  nombres en minúsculas ( out_dt 
           , tolower (sapply (colnames ( out_dt ), gsub , pattern  =  " ^ Hospital 30-Day Death \\ (Mortality \\ ) Rates from " , replacement  =  " " ))
  )
  
  # Filtrar por estado 
  out_dt  <-  out_dt [ state  ==  selected_state ]
  
  # Índices de columnas para mantener 
  col_indices  <- grep (paste0 ( " nombre del hospital | estado | ^ " , resultado ), colnames ( out_dt ))
  
  # Filtrado de datos no 
  deseados out_dt  <-  out_dt [, .SD , .SDcols  =  col_indices ]
  
  # Averigüe de qué clase es cada columna 
  # sapply (out_dt, class) 
  out_dt [, result ] <-  out_dt [, as.numeric (get ( result ))]
  
  
  # Eliminación de valores perdidos para el tipo de datos numérico (columna de resultado) 
  out_dt  <-  out_dt [complete.cases ( out_dt ),]
  
  # Columna de orden para 
  encabezar out_dt  <-  out_dt [order (get ( result ), `hospital name` )]
  
  return ( out_dt [, " nombre del hospital " ] [ 1 ])

}
Parte 3 Clasificación de hospitales por resultado en un estado ( rankhospital.R )
rankhospital  <-  función ( estado , resultado , num  =  " mejor " ) {
  
  # Leer datos de resultado 
  out_dt  <-  data.table :: fread ( ' resultado-de-cuidados- medidas.csv ' )
  
  resultado  <- tolower ( resultado )
  
  # El nombre de la columna es el mismo que el de la variable, por lo que se 
  cambia el  estado elegido <-  estado 
  
  # Verifique que el estado y el resultado sean válidos 
  si ( ! Selected_state  % in% unique ( out_dt [[ " State " ]])) {
    detener ( ' estado inválido ' )
  }
  
  if ( ! result  % in% c ( " ataque cardíaco " , " insuficiencia cardíaca " , " neumonía " )) {
    detener ( ' resultado no válido ' )
  }
  
  # Cambiar el nombre de las columnas para que sean menos detallados y los conjuntos de 
  nombres en minúsculas ( out_dt 
           , tolower (sapply (colnames ( out_dt ), gsub , pattern  =  " ^ Hospital 30-Day Death \\ (Mortality \\ ) Rates from " , replacement  =  " " ))
  )
  
  # Filtrar por estado 
  out_dt  <-  out_dt [ state  ==  selected_state ]
  
  # Índices de columnas para mantener 
  col_indices  <- grep (paste0 ( " nombre del hospital | estado | ^ " , resultado ), colnames ( out_dt ))
  
  # Filtrado de datos no 
  deseados out_dt  <-  out_dt [, .SD , .SDcols  =  col_indices ]
  
  # Averigüe de qué clase es cada columna 
  # sapply (out_dt, class) 
  out_dt [, result ] <-  out_dt [, as.numeric (get ( result ))]
  
  
  # Eliminación de valores perdidos para el tipo de datos numérico (columna de resultado) 
  out_dt  <-  out_dt [complete.cases ( out_dt ),]
  
  # Columna de orden para 
  encabezar out_dt  <-  out_dt [order (get ( result ), `hospital name` )]
  
  out_dt  <-  out_dt [,. ( `nombre del hospital`  =  ` nombre del hospital` , estado  =  estado , tasa  = obtener ( resultado ), Rango  =  .I )]
  
  if ( num  ==  " best " ) {
     return ( out_dt [ 1 , `nombre del hospital` ])
  }
  
  if ( num  ==  " peor " ) {
     return ( out_dt [ .N , `nombre del hospital` ])
  }
  
  return ( out_dt [ num , `nombre del hospital` ])

}
Parte 4 Clasificación de hospitales en todos los estados ( rankall.R )
rankall  <-  función ( resultado , num  =  " mejor " ) {
  
  # Leer datos de resultado 
  out_dt  <-  data.table :: fread ( ' resultado-de-cuidados- medidas.csv ' )
  
  resultado  <- tolower ( resultado )
  
  if ( ! result  % in% c ( " ataque cardíaco " , " insuficiencia cardíaca " , " neumonía " )) {
    detener ( ' resultado no válido ' )
  }
  
  # Cambiar el nombre de las columnas para que sean menos detallados y los conjuntos de 
  nombres en minúsculas ( out_dt 
           , tolower (sapply (colnames ( out_dt ), gsub , pattern  =  " ^ Hospital 30-Day Death \\ (Mortality \\ ) Rates from " , replacement  =  " " ))
  )
  
  # Índices de columnas para mantener 
  col_indices  <- grep (paste0 ( " nombre del hospital | estado | ^ " , resultado ), colnames ( out_dt ))
  
  # Filtrado de datos no 
  deseados out_dt  <-  out_dt [, .SD , .SDcols  =  col_indices ]
  
  # Averigüe de qué clase es cada columna 
  # sapply (out_dt, class)
  
  # Cambiar la clase de la columna de resultados 
  out_dt [, result ] <-  out_dt [, as.numeric (get ( result ))]
  
  if ( num  ==  " best " ) {
     return ( out_dt [order ( state , get ( result ), `hospital name` )
    ,. ( hospital  = head ( `nombre del hospital` , 1 ))
    , por  =  estado ])
  }
  
  if ( num  ==  " peor " ) {
     return ( out_dt [order (get ( result ), `hospital name` )
    ,. ( hospital  = tail ( `nombre del hospital` , 1 ))
    , por  =  estado ])
  }
  
  return ( out_dt [order ( state , get ( result ), `hospital name` )
                , cabeza ( .SD , num )
                , por  =  estado , .SDcols  = c ( " nombre del hospital " )])
  
}
