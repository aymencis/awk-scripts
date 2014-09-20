BEGIN {
  # Données de la simulation: début à 0, step de 100ms
  record_time = 0.0;
 record_time1 = 0.0;
  time_interval = 0.100;
  received_bytes = 0;
  lost_packets = 0;
  total_received_bytes = 0;
  total_lost_packets = 0;
  received_bytes1 = 0;
  lost_packets1 = 0;
  total_received_bytes1 = 0;
  total_lost_packets1 = 0;
}
{
  action = $1;
  time = $2;
  src = $3;
  dst = $4;
  name = $5;
  size = $6;
  flow_id = $8;
  src_address = $9;
  dst_address = $10;
  seq_no = $11;
  packet_id = $12;
  if ((action == "r" || action == "d") && src == 3 &&  dst == 4 && flow_id == 43) {
    # if received time belong to a new interval
    if (time > (record_time + time_interval)) {
        total_received_bytes = total_received_bytes + received_bytes;
        total_lost_packets = total_lost_packets + lost_packets;
        record_time = record_time + time_interval;
        total = received_bytes * 8 / time_interval /1000000;
        total_lost = lost_packets;
        printf "%f %f %f\n", record_time, total_lost, total > "total_43";
        while (time > (record_time + time_interval)) {
          record_time = record_time + time_interval;
          printf "%f %f %f\n", record_time, 0.0, 0.0 > "total_43";
        }
        # this received packet belong to the next time interval
        if (action == "r") {
          received_bytes = size;
          lost_packets = 0;
        } else if (action == "d") {
 
          received_bytes = 0;
          lost_packets = 1;
        }
    } else {
      # if rcv_time still belong to this time_interval
      if (action == "r") {
        received_bytes = received_bytes + size;
      } else if (action == "d") {
        lost_packets = lost_packets + 1;
        printf "%s\n",$0;
      }
    }
  }
}
END {
  average_throughput = total_received_bytes * 8 / record_time / 1000000;
  printf "Average_throughput: %1.3f (Mbits)\n", average_throughput;
  printf "Total lost packets: %1f\n", total_lost_packets;
}
 
 
