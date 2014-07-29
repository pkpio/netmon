######################################
# Author   : Praveen Kumar Pendyala
# Created  : 28 June 2014
# Modified : 30 June 2014
# License  : GPL v2
######################################


#############    Parameters    #############

# Ping destination. Default: 208.67.222.222
# Default is open dns. Edit to your website or device ip to monitor them.
host=208.67.222.222

# Does your ISP require login and it logs you after sometime? Default=0
# If set to 1, update params in ISPs with login section below.
isp_login=0

# Wait time (seconds) before next ping. Default: 57
wait=57

# Count in each ping (ping -c c). Default: 2
# Average of these many pings will be logged
c=2  #Pings per test

# Message appended to timestamp when it's a hit
hit_msg=" ---- hit   ----- "

# Message appended to timestamp when it's a fail
fail_msg=" ---- fail"


### For ISPs with login ###

# For ISPs that require login, we may get continuous fails when the user has 
# been logged out automatically after certain time. In such cases, we try to 
# login again after set number of successive fails and then continue with the 
# pinging test.

# Successive fails after which we attempt a ISP login. Default=10
fail_limit=10

# ISP login url
isp_url="http://myisp.com/login"

# ISP username
isp_usr="username"

# ISP password
isp_pwd="password"

# ISP other post data, if any. Default:""
isp_mre_post=""

# ISP cookie info
isp_cookies="--save-cookies cookies.txt --keep-session-cookies"

############  END OF PARAMS ##############

# Number of successive fails.
# Once this = $fail_limit we attempt an ISP login (if enabled).
scs_fails=0

echo "Ping monitoring with " $host >log

# Initial messages
echo -e "\nNetwork monitoring started. Check log file."
echo "Ping running...."
echo -e "\n\n ========= Logging started ========== \n" >>log

# Continious monitoring starts
while true; do

	# Attempt ping and extract times to result.
	# Ping errors, if any, are appended to log
	result=$(ping -c $c $host 2>>log | tail -1 | awk '{print $4}')

	# Check if ping actually returned times
	if [ "$result" != "" ]; then
		avg=$(echo $result | cut -d '/' -f 2)       
		echo $(date) $hit_msg $avg" ms"  >> log
		scs_fails=0

	# Handle errors
	else
		echo $(date) $fail_msg  >> log
		scs_fails=$(($scs_fails + 1))
	fi

	# Check if ISP login condition reached
	if [ $isp_login -eq 1 ] && [ $scs_fails -eq $fail_limit ]; then
		echo -e $(date) "Performing ISP login\n" >> log
		postdata="username=$isp_usr&password=$isp_pwd"
		wget $isp_cookies --post-data="$postdata" "$isp_url" 2>> log
	fi

	# wait before next run
	sleep $wait

done
