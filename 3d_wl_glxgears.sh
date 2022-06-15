export http_proxy="http://proxy-chain.intel.com:911/"
export https_proxy="http://proxy-chain.intel.com:912/"

yes | sudo apt-get update
yes | sudo apt-get install xserver-xorg x11vnc
yes | sudo apt install mesa-utils
yes | sudo apt-get install glmark2

wget https://gfx-assets.fm.intel.com/artifactory/gfx-sns-linux-fm/gfx-sns-linux-fm/ATS_M/3D_WL/V1/artifacts/3d_files.tar
tar -xvf 3d_files.tar
cd 3d_files

sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config



sudo usermod -aG render gta
sudo usermod -aG video gta
#below command is to start a new shell
sudo exec bash


cd /home/gta/3d_files
sudo dpkg -i xserver-xorg-video-dummy_10196-0.3.8.u20.04_amd64.deb
sudo cp 10-intel.conf /usr/share/X11/xorg.conf.d/10-intel.conf

X -sharevts &
x11vnc -display :0 -shared &

#export display is needed to bypass the default display and use the Headless Display
export DISPLAY=:0

#Start the 3D Application 
glxgears 2>&1 | gears.log

sleep 5

grep "Running synchronized to the vertical refresh." gears.log

result=$?
if [ $result -ne 0 ]
then
	exit 1
fi


