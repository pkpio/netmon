######################################
# Author  : Praveen Kumar Pendyala
# Created : 28 June 2014
# License : GPL v2
######################################
echo "Ping failures to open dns (208.67.222.222)" >pinglog
hit=" ---- hit"
fail=" ---- fail"

echo -e "\nNetwork monitoring started. Check logs in pinglog file."
echo -e "Ping running...."
echo -e "\n\n ========= Logging started ========== \n" >>pinglog
while true; do
  if ! ping -c 1 -q 208.67.222.222 >/dev/null;
  then
		time=$(date)
    echo $time$fail  >> pinglog
  else
    time=$(date)
    echo $time$hit  >> pinglog
  fi
  sleep 57
done
