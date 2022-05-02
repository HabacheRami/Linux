
find /home/ -maxdepth 1 -type d -exec du -sh {} \; | sort -h | head -5

size=($(du -sb $HOME))
tmp=$((${size[0]}))

to=$(($tmp / 109952627776))
go=$((($tmp - $to * 109952627776) / 1073741824))
mo=$((($tmp - $go * 1073741824) / 1048576))
ko=$((($tmp - $mo * 1048576) / 1024))
o=$((tmp - $to * 109952627776 - $go * 1073741824 - $mo * 1048576 - $ko * 1024))

printf "\nVotre répertoire personnel fait actuellement "$go" Go, "$mo" Mo, "$ko" ko et "$o" octects"

if [ $mo -gt 100 ]
then
	printf "\nAttention, votre répertoire personnel dépasse la limite autorisée de 100Mo !\n"
fi
