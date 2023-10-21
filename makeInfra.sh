openstack network create network1
openstack subnet create --network network1 --subnet-range 192.168.1.0/24 subnet1
openstack network create network2
openstack subnet create --network network2 --subnet-range 192.168.2.0/24 subnet2
openstack network create network3
openstack subnet create --network network3 --subnet-range 192.168.3.0/24 subnet3
openstack network create presidentialNetwork
openstack subnet create --network presidentialNetwork --subnet-range 192.168.4.0/24 presidentialSubnet
openstack network create grayNetwork
openstack subnet create --network grayNetwork --subnet-range 192.168.100.0/24 graySubnet
openstack router create router1
openstack router create router2
openstack router create router3
openstack router create router4
openstack router add subnet router1 subnet1
openstack router add subnet router2 subnet2
openstack router add subnet router3 subnet3
openstack router add subnet router4 presidentialSubnet
openstack router set --external-gateway MAIN-NAT router1
openstack router set --external-gateway MAIN-NAT router2
openstack router set --external-gateway MAIN-NAT router3
openstack router set --external-gateway MAIN-NAT router4
openstack router add subnet router1 graySubnet
openstack keypair delete grayKey
openstack keypair create --private-key ~/.ssh/id_rsa grayKey
chmod 600 ~/.ssh/id_rsa
openstack keypair show --public-key graykey >> ~/.ssh/authorized_keys
net1=$(openstack network show -c id -f value network1)
net2=$(openstack network show -c id -f value network2)
net3=$(openstack network show -c id -f value network3)
pres=$(openstack network show -c id -f value presidentialNetwork)
gray=$(openstack network show -c id -f value grayNetwork)
nat=$(openstack network show -c id -f value MAIN-NAT)
openstack server create --flavor medium --image WinSrv2019-17763-2022 --user-data prepare-ansible-for-windows --key-name grayKey --nic net-id=$net1,v4-fixed-ip=192.168.1.10 Winserver
openstack server create --flavor medium --image Win10-21H2 --user-data prepare-ansible-for-windows --key-name grayKey --nic net-id=$net1,v4-fixed-ip=192.168.1.11 Win10
openstack server create --flavor medium --image UbuntuJammy2204 --key-name grayKey --nic net-id=$net1,v4-fixed-ip=192.168.1.12 UbuntuWeb
openstack server create --flavor medium --image UbuntuJammy2204 --key-name grayKey --nic net-id=$net1,v4-fixed-ip=192.168.1.13 UbuntuSQL
openstack server create --flavor medium --image UbuntuJammy2204 --key-name grayKey --nic net-id=$net2,v4-fixed-ip=192.168.2.14 UbuntusFTP
openstack server create --flavor medium --image UbuntuJammy2204 --key-name grayKey --nic net-id=$net2,v4-fixed-ip=192.168.2.15 UbuntuSamba
openstack server create --flavor medium --image ArchLinux2022 --key-name grayKey --nic net-id=$net3,v4-fixed-ip=192.168.3.16 Arch
openstack server create --flavor medium --image WinXP-SP0 --user-data prepare-ansible-for-windows --key-name grayKey --nic net-id=$pres,v4-fixed-ip=192.168.4.17 PresidentialBox
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name grayKey --nic net-id=$gray,v4-fixed-ip=192.168.100.10 Scoring
openstack server add fixed ip --fixed-ip-address 192.168.100.11 Control grayNetwork
