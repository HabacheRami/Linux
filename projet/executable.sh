file=./ug-list.txt
array=( $(find / -perm /6000 -type f 2>/dev/null) )
if [[ -f "$file" ]];
then
	for i in ${array[@]}
	do 	
		# correspondance complete de la ligne
		test=$(grep -x "$i" $file)
		if [[ -z $test ]];
		then
			filedate=$(date -r $i +"%d-%m-%Y %H:%M")
			echo "Avertissement : $i modifiée le $filedate"
		fi
	done
	{ [ "${#array[@]}" -eq 0 ] || printf "%s\n" "${array[@]}"; } > "$file"
fi
