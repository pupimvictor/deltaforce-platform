    1  k get no
    2  echo $HTTPS_PROXY 
    3  sudo ./open_tunnel.sh 
    4  k get no
    5  echo $HTTPS_PROXY 
    6  sudo nmap -p 1080 192.168.0.0/24 --open
    7  sudo apt-get install nmap
    8  sudo nmap -p 1080 192.168.0.0/24 --open
    9  sudo nmap localhost --open
   10  k get no
   11  sudo cp /home/operator/.kube/config ~/
   12  cd 
   13  ls
   14  mkdir .kube
   15  mv config .kube/
   16  k get po
   17  chowm .kube/config
   18  sudo chowm .kube/config
   19  sudo chown .kube/config
   20  sudo chown user4 .kube/config
   21  k get po
   22  k get no
   23  k config get-contexts
   24  k config use-context sbx
   25  k get po
   26  k get no
   27  history 
   28  history > history.bash
