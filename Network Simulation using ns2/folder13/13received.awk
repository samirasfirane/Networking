# Team Members: Samir Asfirane, Javier Valerio
# Date Submitted: April 22nd, 2016
# CS 436 Computer Networking - ns2 Network Simulator
# This program is used to calculate the number of packets received at destination each 0.5 sec time interval along the 13 -> 21 traffic flow.
# Usage: gawk -f 13received.awk asfirane_valerio.tr

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   packets_received = 0;
}

{
   time2 = $2;
	
	if (time2 - time1 > 0.5) {
		printf("%f \t %f\n", time2, packets_received) > "13received.xls";
		time1 = $2;
    }
    
	if ($9 == 13.12 && $10 == 21) {
		if ($1 == "r" && $5 == "cbr") {
			
			packets_received++;
		}
    }
}

END {
   print("********");
   printf("Total number of packets received: %d\n", packets_received);
   print("********");
}
