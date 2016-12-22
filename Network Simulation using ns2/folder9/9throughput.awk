# Team Members: Samir Asfirane, Javier Valerio
# Date Submitted: April 22nd, 2016
# CS 436 Computer Networking - ns2 Network Simulator
# This program is used to calculate the throughput for each 0.5 sec time interval along the 9 -> 27 traffic flow.
# Usage: gawk -f 9throughput.awk asfirane_valerio.tr

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   num_packets = 0;
}

{
   time2 = $2;

   if (time2 - time1 > 0.5) {
        throughput = bytes_counter / (time2 - time1);
        printf("%f \t %f\n", time2, throughput) > "9throughput.xls";
        time1 = $2;
        bytes_counter = 0;
   }

        if ( ($9 >= 9.0 && $9 <= 9.9) && $10 == 27.0) {
			if ($1 == "r" && $5 == "tcp") {
				bytes_counter += $6;
				num_packets++;
			}
        }
}

END {
   print("********");
   printf("Total number of packets received: %d\n", num_packets);
   print("********");
}

