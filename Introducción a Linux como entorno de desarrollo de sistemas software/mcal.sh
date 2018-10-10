#!/bin/bash
# Jose Ramon Castelo
#--------------------------------------
# Comando mcal
#--------------------------------------

#- Variables de valores a usar
MESAHORA=`date +%m`   #- Mes actual
AGNOAHORA=`date +%Y`  #- Agno actual

#- Variables a contener los parametros
AGNO=${AGNOAHORA}     #- Variable que va a recibir el parametro agno
MES=${MESAHORA}       #- Variable que va a recibir el parametro mes

#- Switchs de control
SWSALIR=0             #- Finalizar script
SWAGNO=0              #- Variable AGNO asignada
SWMES=0               #- Variable MES asignada

#- Control de parametros
case $# in 
  1) 
    #- Un parametro 
    case $1 in
      "-help") 
              #- Muestra la ayuda solo si hay un parametro, en caso contrario daria error
              echo "-----------------------------------------------------" 1>&2
              echo "- EJERCCIO 6.5" 1>&2
              echo "  Jose Ramon Castelo" 1>&2
              echo "-----------------------------------------------------" 1>&2
              echo -e "$0 \t[-help] muestra ayuda." 1>&2
              echo -e "   \t\t[<mes>] [<agno>] si falta alguno coge el actual."  1>&2
              echo -e "   \t\t[<mes>] [<agno>] si falta alguno coge el actual."  1>&2
              echo -e "   \t\t\t[<mes>] puede tener los tres primeros caracteres del nombre en ingles." 1>&2
              SWSALIR=1;;
      [1-9]) 
              #- Si el valor es entre 1 y 9 es un mes
              MES=${1} ;;
      1[0-2])
              #- Si el valor esta entre 10 y 12 es un mes
              MES=${1} ;;
      jan|ene|feb|mar|apr|abr|may|jun|jul|aug|ago|sep|oct|nov|dec|dic) 
              #- El nombre del mes en castellano e ingles
              MES=${1} ;;
      *) 
              #- En cualquier otro caso comprueba si es un numero y si es asi se lo asigna al agno
              #- y no le pone ningun valor al mes para que muestre el agno completo.
              #- En caso contrario muestra un mensaje de error.
              if [ $1 -gt 12 2>/dev/null ]   
                then 
                  AGNO=${1}
                  unset MES
                else
                  echo "Error parametro \"${1}\""
                  SWSALIR=1
              fi;;
   esac
   ;;
  2) 
    #- Dos parametros
    #
    #- Anaiza el primer parametro
    case $1 in
      [1-9]) 
              #- Si es entre 1 y 9 es un mes
              MES=${1} 
              SWMES=1 ;;
      1[0-2]) 
              #- Si es entre 10 y 12 es un mes
              MES=${1}
              SWMES=1 ;;
      jan|ene|feb|mar|apr|abr|may|jun|jul|aug|ago|sep|oct|nov|dec|dic) 
              #- El nombre del mes en castellano e ingles
              MES=${1} 
              SWMES=1 ;;
      *) 
              #- En cualquier otro caso comprueba si es un numero y si es asi se lo asigna al agno
              #- en caso contrario muestra un error.
              if [ $1 -gt 12 2>/dev/null ]  
                then 
                  AGNO=${1}  
                  SWAGNO=1
                else
                  echo "Error parametro \"${1}\""
                  SWSALIR=1
              fi;;
   esac

   #- Si no ha habido error analiza el segundo parametro
   if [ ${SWSALIR} -eq 0 ]
    then
      case $2 in
        [1-9])
              #- Si es entre 1 y 9 y no hay mes asignado, asigna a mes, en caso contrario a agno
              if [ ${SWMES} -eq 0 ] 
                then 
                  MES=${2} 
                else 
                  AGNO=${2}
              fi ;;
      1[0-2]) 
              #- Si es entre 10 y 12 y no hay mes asignado, asigna a mes, en caso contrario a agno
              if [ ${SWMES} -eq 0 ] 
                then 
                  MES=${2}
                else 
                  AGNO=${2}
              fi ;;
      jan|ene|feb|mar|apr|abr|may|jun|jul|aug|ago|sep|oct|nov|dec|dic) 
              #- Si no hay mes asignado, asigna el nombre del mes, en caso contrario muestra un error
              if [ ${SWMES} -eq 0 ] 
                then 
                  MES=${2}
                else
                  echo "Error, mes ya asignado en otro parametro."
                  SWSALIR=1
              fi ;;
      *) 
              #- En cualquier otro caso comprueba si no se ha asignado AGNO en el primer parametro 
              #- y que el valor es un numero y si es asi se lo asigna al agno
              #- en caso contrario muestra un mensaje de error.
              if [ ${SWAGNO} -eq 0 -a $2 -gt 12 2>/dev/null ]
                then 
                  AGNO=${2}
                else
                  echo "Error parametro \"${2}\""
                  SWSALIR=1
              fi;;
      esac
   fi
   ;;
esac

#- Si no se ha producido un error muestra el resultado
if [ ${SWSALIR} -eq 0 ]
then
  cal ${MES} ${AGNO}
  exit $?
else
  exit 1
fi
