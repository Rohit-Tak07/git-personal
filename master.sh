#!/bin/bash
#
# Setup for Control Plane (Master) servers

swapoff -a

MASTER_IP="10.0.0.3"
NODENAME=$(hostname -s)
POD_CIDR="172.16.0.0/16"

apt update -y
sudo kubeadm config images pull

echo ""
echo  "\033[4mPreflight Check Passed: Downloaded All Required Images.\033[0m"
echo  "\033[4mNow running kubeadm init.\033[0m"
echo ""

sudo kubeadm init --apiserver-advertise-address=$MASTER_IP --apiserver-cert-extra-sans=$MASTER_IP --pod-network-cidr=$POD_CIDR --node-name "$NODENAME" --ignore-preflight-errors Swap

mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

# OPTION - 1 Install Calico overlay network

echo
echo
echo "********"
echo "Install Pod Network - calico or flannel"
echo "********"
echo
echo
echo "for calico ..."
echo "get calico.yaml and apply it"
echo "kubectl apply -f calico.yaml"

# OPTION - 2 Install Flannel overlay network
echo "for flannel ..."
echo "get instructions from flannel-install-steps file"