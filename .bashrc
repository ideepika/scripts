# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias grep='grep -Hrn'
alias src1='cd ~/ceph-backup/ceph1.0/ceph/src'
alias build1='cd ~/ceph-backup/ceph1.0/ceph/build'

alias srcu='cd ~/ceph-upstream/ceph/src'
alias buildu='cd ~/ceph-upstream/ceph/build'

alias vim='nvim'
alias cpu_use='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias brc='vim ~/.bashrc'
alias jcpp='cd ~/jaeger-client-cpp/examples/'
alias vrc='vim ~/.vimrc'
alias srcb='cd ~/ceph-backup/ceph/src/'
alias buildb='cd ~/ceph-backup/ceph/build/'
alias cjcpp='cd ~/ceph1.0/ceph/jaegertracing/'
alias tracer='vim ~/ceph1.0/ceph/src/include/tracer.h'
alias ssh_sepia='sudo ssh -vv -i /home/d/.ssh/id_rsa \
ideepika@senta04.front.sepia.ceph.com'
alias jaegerUI='docker run -d --name jaeger \
  -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14268:14268 \
  -p 9411:9411 \
  jaegertracing/all-in-one:1.12 --log-level=debug'
alias openvpnsepia='sudo openvpn --config /etc/openvpn/sepia/client.conf --cd \
/etc/openvpn'
alias dockerstop='docker stop $(docker ps -aq)'
alias dockerrm='docker rm $(docker ps -aq)'
