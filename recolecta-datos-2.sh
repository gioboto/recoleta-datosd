#!/bin/bash
#
#script recolecta-datos-2.sh 
# Version : 2.0
#Permite extraer datos de el log sin procesar, según el tipo de dado se guarda en un archvio distinto
#Autor : Ing. Jorge Navarrete
#mail : jorge_n@web.de
#Fecha : 2014-12-09

#script recolecta-datos-2.sh 
#Permite extraer datos de el log sin procesar, según el tipo de dado se guarda en un archvio distinto

echo ================================================
echo Por favor ingrese nombre del archivo a procesar:
echo ================================================
read NAME
PRE="errores-"
ARCHIVO="archivo-"
ARCHIVO1="tempe-"
ARCHIVO2="guardarInforme-"


touch $ARCHIVO$NAME
touch $PRE$NAME

echo "Procesando firmas y tiempos desde log ..."
cat $NAME | grep "operation: sign time:" > $ARCHIVO1$NAME
awk -F '[+/>:]' 'BEGIN{OFS="";}{print $1,":",$2," ",$3," ", $6," ", $7}' $ARCHIVO1$NAME > $ARCHIVO$NAME
rm $ARCHIVO1$NAME

echo "Procesando registros 'HTTPPageGetter,client' (guardarInforme Stopping) y tiempos desde log ..."
cat $NAME | grep "guardarInforme" | grep "Stopping" > $ARCHIVO1$NAME
awk -F '[+/>:]' 'BEGIN{OFS="";}{print $1,":",$2," ",$3," ", $14," ", $9," ", $15}' $ARCHIVO1$NAME > $ARCHIVO2$NAME
rm $ARCHIVO1$NAME


echo "Procesando errores desde log ..."
cat $NAME | grep 'client] #011Exception: InvalidCredentials' >> $PRE$NAME
echo "---------Exception: InvalidCredentials----------"
cat $NAME | grep 'client] #011IOError:' >> $PRE$NAME
echo "---------IOError----------"
cat $NAME | grep 'client] #011ValueError:' >> $PRE$NAME
echo "---------ValueError----------"
cat $NAME | grep '#011ProcessTerminated' >> $PRE$NAME
echo "---------ProcessTerminated----------"
cat $NAME | grep 'client] #011TimeoutError:' >> $PRE$NAME
echo "---------TimeoutError----------"
cat $NAME | grep 'client] Exception: TokenLocked' >> $PRE$NAME
echo "---------TokenLocked----------"
cat $NAME | grep 'client] Exception: TokenNotFound' >> $PRE$NAME
echo "---------TokenNotFound----------"
cat $NAME | grep 'client] NoMatch:' >> $PRE$NAME
echo "---------NoMatch----------"
cat $NAME | grep '011UnicodeDecodeError' >> $PRE$NAME
echo "---------011UnicodeDecodeError----------"
cat $NAME | grep 'Unhandled error in Deferred' >> $PRE$NAME
echo "---------Unhandled error in Deferred----------"
cat $NAME | grep '#011PDFError:' >> $PRE$NAME
echo "---------#011PDFError:----------"
cat $NAME | grep 'NoReader' >> $PRE$NAME
echo "---------NoReader ----------"
cat $NAME | grep '#011Exception: CertificateExpired' >> $PRE$NAME
echo "---------#011Exception: CertificateExpired----------"
cat $NAME | grep '#011HTTPError: Gateway timeout' >> $PRE$NAME
echo "---------#011HTTPError: Gateway timeout----------"
cat $NAME | grep '#011TimeStampingError:' >> $PRE$NAME
echo "---------#011TimeStampingError:----------"
cat $NAME | grep 'ERROR put_remote_file' >> $PRE$NAME
echo "---------ERROR put_remote_file----------"



echo ================================================
echo "Proceso terminado"
echo "se creo el archivo con registros de firmas llamado $ARCHIVO$NAME"
echo "se creo el archivo con errores llamado $PRE$NAME"
echo "Hi $NAME!"
                   
