# Become root user
lspci |grep -i wireless

# Update 
yum update

# Install the Kernel Development Packages


yum groupinstall "Development Tools"
yum install redhat-lsb
yum install kernel-devel

useradd tindall

su - tindall

mkdir -p ~/rpmbuild/{BUILD,RPMS,SPECS,SOURCES,SRPMS}
echo -e "%_topdir $(echo $HOME/rpmbuild)\n%dist.el$(lsb_release -s -r|cut -d"." -f1).local" >> ~/.rpmmacros


# Download the Closed source RPM (wl-kmod-6_30_223_*.elrepo.nosrc.rpm ) for the 802.11ac card from below link.  

# For RHEL/CentOS6 - http://ftp.colocall.net/pub/elrepo/elrepo/el6/SRPMS/wl-kmod-6_30_223_141-2.el6.elrepo.nosrc.rpm or  https://1drv.ms/u/s!AriQmQb-LJvf0iSy4UAlHCkHdUFN
# For RHEL/CentOS7 - http://ftp.colocall.net/pub/elrepo/elrepo/el7/SRPMS/wl-kmod-6_30_223_271-1.el7.elrepo.nosrc.rpm or  https://1drv.ms/u/s!AriQmQb-LJvf0iWWA1AuWqDqvLCs
cd ~/rpmbuild
wget http://mirror.rc.usf.edu/elrepo/elrepo/el7/SRPMS/wl-kmod-6_30_223_271-1.el7.elrepo.nosrc.rpm

# Download the Broadcom Driver Source for RHEL / CentOS  6/7

cd SOURCES
wget https://docs.broadcom.com/docs-and-downloads/docs/linux_sta/hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz
cd ../
pwd
# /home/tindall/rpmbuild/

# rpmbuild --rebuild --define 'packager <$USER>' wl-kmod*.nosrc.rpm

exit

rpm -Uvh /home/dell/rpmbuild/RPMS/x86_64/kmod-wl*.rpm

