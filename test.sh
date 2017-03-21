#!/bin/bash

echo " "
echo "--------------------------------------------------------------------------------------------"
echo "  "
echo " [ Ejecutando GETX  ] "
echo "  "

ocrws=http://www.getx.com:33000/ocrws/tpfcloud/ocr/upload
nlpws=http://www.getx.com:33100/nlpws/tpfcloud/nlp/


allFiles=$(ls -1 ./images/ | wc -l)

for ((i=1; i <2;i++))
do
	for (( myFile=1; myFile <=allFiles;myFile++))
		do
		resource="$PWD/images/$myFile.jpg"
		java -jar getx.jar $resource $ocrws $nlpws
		done
done

echo " "
echo "--------------------------------------------------------------------------------------------"
echo "  "
echo " [ Fin !!   ] "


