#/bin/bash
############################################################################
# This script is used to run command on Mulitple remote hosts simulantenously
# Author: Manpreet Singh
# Email: er.manpreetsingh@gmail.com
############################################################################

# Entering the command to be executed on remote servers
echo "\033[0;32mEnter the command to execute\033[0m"
read command

# To check the enter command is not Null
if [ -z $command ]; then
   echo "\033[0;31mPlease enter the valid command\033[0m"
   exit
else
   continue
fi

# IFS(Internal Field Separator) used to seprate the hostname using ","
IFS=","

# Give the path of the hostname file seprated by "," 
SERVERID=`cat hostname`

# Username that is set to access the server remoted by ssh
USERNAME=ansible

 echo "##################################################"

# For loop to make connections and run the mentioned command
for host in $SERVERID
 do 
 ssh -A $USERNAME@${host} echo "Running Command on ${host}"
 ssh -A $USERNAME@${host} $command 
 echo "##################################################"
done

