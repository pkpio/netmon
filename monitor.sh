######################################
# Author   : Praveen Kumar Pendyala
# Created  : 28 June 2014
# Modified : 29 June 2014
# License  : GPL v2
######################################


#############    Parameters    #############

# Ping destination. Default: 208.67.222.222
host=208.67.222.222

# Wait time (seconds) before next ping. Default: 57
wait=57

# Count in each ping (ping -c C). Default: 2
# Average of these many pings will be logged
c=2  #Pings per test

# Message appended to timestamp when it's a hit
hit_msg=" ---- hit   ----- "

# Message appended to timestamp when it's a fail
fail_msg=" ---- fail"

############  END OF PARAMS ##############


echo "Ping monitoring with " $host >log

# Initial messages
echo -e "\nNetwork monitoring started. Check log file."
echo -e "Ping running...."
echo -e "\n\n ========= Logging started ========== \n" >>log

# Continious monitoring starts
while true; do

	# Attempt ping and extract times to $result.
	# Ping errors, if any, are appended to log
	result=$(ping -c $c $host 2>>log | tail -1 | awk '{print $4}')

	# Check if ping actually returned times
	if [ "$result" != "" ]; then
		avg=$(echo $result | cut -d '/' -f 2)       
		echo $(date) $hit_msg $avg" ms"  >> log

	# Handle errors
	else
		echo $(date) $fail_msg  >> log
	fi

	# wait before next run
	sleep $wait

done
