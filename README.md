# nmap-http-screenshot
Modified nmap script from Trustwave to work with SSL / not hang and use CPU-independent wkhtmltoimage
(original script @https://github.com/SpiderLabs/Nmap-Tools/blob/master/NSE/http-screenshot.nse)

To use, copy it in Nmap's scripts folder and:

nmap -sS --script=http-screenshot -d -iL targets.txt 
