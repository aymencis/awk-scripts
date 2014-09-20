BEGIN { 
 init=0 ;
  i=0;
init1=0 ;
  i1=0;
i2=0;
}
{ 
action = $1;
time = $2;
from = $3;
to = $4;
type = $5;
pktsize = $6;
flow_id = $8;
src= $9;
dst = $10 ;
seq_no = $11;
packet_id= $12;
 
if ( action == "r" && from==12 && to==19 && flow_id==41) {
   pkt_byte_sum[i+1]=pkt_byte_sum[i] + pktsize;
 
if (init==0) {
           start_time = time;
	   init = 1;
             }
end_time[i] = time;
i= i+1 ;
        }
 
if ( action == "r" && from==12 && to==20 && flow_id==42) {
   pkt_byte_sum1[i1+1]=pkt_byte_sum1[i1] + pktsize;
 
if (init==0) {
           start_time = time;
	   init = 1;
             }
end_time1[i1] = time;
i1= i1+1 ;
        }
if ( action == "r" && from==12 && to==21 && flow_id==43) {
   pkt_byte_sum2[i2+1]=pkt_byte_sum2[i2] + pktsize;
 
if (init==0) {
           start_time = time;
	   init = 1;
             }
end_time2[i2] = time;
i2= i2+1 ;
        }
 
}
END {
printf("%.2f\t%.2f\n" , end_time[0]  ,0 ) > "throughput_cbr_tcp";
for (j=1 ; j<i ; j++){
th =( pkt_byte_sum[j]/ (end_time[j]-start_time))*8/1000000;
printf("%.2f\t%.2f\n" , end_time[j]  ,th ) > "throughput_cbr_tcp";
}
printf("%.2f\t%.2f\n" , end_time[i-1], 0) > "throughput_cbr_tcp";
 
 
 
printf("%.2f\t%.2f\n" , end_time1[0]  ,0 ) > "throughput_cbr_64";
for (j=1 ; j<i1 ; j++){
th1 =( pkt_byte_sum1[j]/ (end_time1[j]-start_time))*8/1000000;
printf("%.2f\t%.2f\n" , end_time1[j]  ,th1 ) > "throughput_cbr_64";
}
printf("%.2f\t%.2f\n" , end_time1[j-1], 0) > "throughput_cbr_64";
 
 
 
printf("%.2f\t%.2f\n" , end_time2[0]  ,0 ) > "throughput_cbr_800";
for (j=1 ; j<i2 ; j++){
th2 =( pkt_byte_sum2[j]/ (end_time2[j]-start_time))*8/1000000;
printf("%.2f\t%.2f\n" , end_time2[j]  ,th2 ) > "throughput_cbr_800";
}
printf("%.2f\t%.2f\n" , end_time2[j-1], 0) > "throughput_cbr_800";
 
}
 
 
