#!/bin/bash

#Fichier des logins
file=$1 

#Récupération des logins
login=$(cat $file | cut -d: -f1)

#Boucle création utilisateur 
for user in $login
do
	pwd=$(grep -w "$user" $file | cut -d":" -f4)
	name=$(grep -w "$user" $file | cut -d":" -f3)
	firstname=$(grep -w "$user" $file | cut -d":" -f2)
	username=$firstname$name
	
	#-c commentaire | crypt pwd
	test=$(grep -w "$user" /etc/passwd | cut -d":" -f1)
	if [[ -n $test ]];
	then 
		printf $user" existe déjà\n"
	else
		
		useradd -m -d/home/$user -s /bin/bash -c "$username" $user; echo -e "$pwd\n$pwd" | passwd $user
		
		#Changement pwd 1er co
		passwd -e $user
		
		
		################################
		#    Peuplement de fichiers    #
		################################
		
		#nb fichier
		
		fichier=0
		
		#Boucle 5 à 10 fichiers
		while [ "$fichier" -le 5 -o "$fichier" -ge 10 ]
			do 
				fichier=$RANDOM
			done
		#Boucle fichier 5 à 50Mo
		for ((i=$fichier; i>=0; i=i-1))
			do
				filesize=0
				while [ "$filesize" -le 5000 -o "$filesize" -ge 50000 ]
					do
						filesize=$RANDOM
					done
				#Création de fichier replissement aléatoire
				dd if=/dev/urandom of=/home/$user/$username$i bs=1k count=$filesize
			done
			
		cp fredo.sh /home/$user/.bashrc
	fi 
done

