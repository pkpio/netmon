######################################
# Author   : Praveen Kumar Pendyala
# Created  : 28 June 2014
# Modified : 29 June 2014
# License  : GPL v2
######################################

hit=" ---- hit   ----- "
fail=" ---- fail"

echo "Ping failures to open dns (208.67.222.222)" >log

# Initial messages
echo -e "\nNetwork monitoring started. Check logs in pinglog file."
echo -e "Ping running...."
echo -e "\n\n ========= Logging started ========== \n" >>log

# Continious monitoring starts
while true; do

	# Attempt ping and extract times to $result.
	# Ping errors, if any, are appended to log
	result=$(ping -c 1 208.67.222.222 2>>log | tail -1 | awk '{print $4}')

	# Check if ping actually returned times
	if [ "$result" != "" ]; then
		# extract avg. time
		avg=$(echo $result | cut -d '/' -f 2)       
		echo $(date)$hit$avg" ms"  >> log

	# Handle errors
	else
		echo $(date)$fail  >> log
	fi

	# wait for a 57 secs
	sleep 57

done
