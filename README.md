network-monitor
===============

Monitor your network / website / device uptime. 
Also supports auto-login to your ISP (Internet Service Provider).

How-to-use
---------------
cd netmon in terminal and execute

```
chmod +x monitor.sh
./monitor.sh
``` 

Background monitoring
--------------
To start background monitoring, execute,

```
screen -dmS netmon ./monitor.sh
```

To stop background monitoring, execute,
```
screen -r netmon
```


Parameters
---------------
The default setup should work well for network monitoring. However if you wish
to monitor a device or server or website, change the parameters to ping. 

1. Open monitor.sh in a text editor
2. There are a bunch of parameters with comments. It should be clear.


ISP login
---------------
This is disabled by default. To enable, set the following params (in ```monitor.sh```),

1. isp_login=1
2. isp_url="your-isp-login-url"
3. isp_usr="your-isp-username"
4. isp_pwd="your-isp-password"

More related params can also be found in the script. 


Working
---------------
1. Logs are monitored into 'log' file created in the dir from where you started the script
2. Closing the terminal would stop monitoring


Author
---------------
Praveen Kumar Pendyala <<praveen@praveenkumar.co.in>> <br>
<http://praveenkumar.co.in>


License
---------------
Licensed under GPL v2
