#!/bin/bash 
host="127.0.0.1"
case $1 in 
    zk_max_latency)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_max_latency |awk '{print $2}')
        echo ${zk_status_name}
    ;;
    zk_packets_sent)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_packets_sent|awk '{print $2}')
        echo ${zk_status_name}
    ;;
    zk_packets_received)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_packets_received|awk '{print $2}')
        echo ${zk_status_name}
    ;;
    zk_num_alive_connections)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_num_alive_connections|awk '{print $2}')
        echo ${zk_status_name}
    ;;
    zk_outstanding_requests)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_outstanding_requests|awk '{print $2}')
        echo ${zk_status_name}
    ;;
    zk_znode_count)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_znode_count |awk '{print $2}')
        echo ${zk_status_name}
    ;;
    zk_watch_count)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_watch_count|awk '{print $2}')
        echo ${zk_status_name}
    ;;
    zk_node_count)
        zk_max_latenct=$(echo dump  | nc ${host}  2181 |grep "/brokers/ids" |wc -l)
        echo ${zk_max_latenct}
    ;;
    zk_server_state)
        zk_status_name=$(echo mntr  | nc ${host} 2181|grep zk_server_state|awk '{print $2}')
        if   [ $zk_status_name = leader ];then     #如果是leader输出1，其他输出2
             echo "1"
        else
             echo "2"
        fi
    ;;
    ruok)
        ruok=$(echo ruok  | nc ${host} 2181)   #如果是正常输出1，其他输出2
        if [ $ruok = imok ];then
            echo "1"
        else
            echo "0"
        fi
    ;;
    *)
        echo "Please enter parameters(zk_max_latency|zk_packets_sent|zk_packets_received|zk_num_alive_connections|zk_outstanding_requests|zk_znode_count|zk_watch_count|zk_node_count|zk_server_state|ruok)"
esac
