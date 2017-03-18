#!/bin/bash

echo " "
echo "--------------------------------------------------------------------------------------------"
echo "  "
echo " [ Testing getx ........  ] "

#ocrws=http://www.getx.com/ocrws/tpfcloud/ocr/upload
#nlpws=http://www.getx.com/nlpws/tpfcloud/nlp/

ocrws=http://0.0.0.0:32776/ocrws/tpfcloud/ocr/upload
nlpws=http://0.0.0.0:32777/nlpws/tpfcloud/nlp/

allFiles=$(ls -1 ./images/ | wc -l)

for ((i=1; i <3;i++))
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
echo " [ Listo !! ;)  ] "


