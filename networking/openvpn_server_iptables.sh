# Allow TUN interface connections to OpenVPN server
iptables -A INPUT -i tun+ -j ACCEPT
#iptables -A OUTPUT -o tun+ -j ACCEPT # If default iptables OUTPUT value is not ACCEPT

# Allow TUN interface connections to be forwarded through other interfaces
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -o ens2 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i ens2 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT

# NAT the VPN client traffic to the internet
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o ens2 -j MASQUERADE

# Forward ports to clients
iptables -t nat -A PREROUTING -p tcp -i ens2 --dport 80 -j DNAT --to-destination 10.8.0.6:80
iptables -A FORWARD -p tcp -d 10.8.0.6 --dport 80 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p udp -i ens2 --dport 1337 -j DNAT --to-destination 10.8.0.6:1337
iptables -A FORWARD -p udp -d 10.8.0.6 --dport 1337 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
