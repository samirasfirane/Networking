# Team Members: Samir Asfirane, Javier Valerio
# Date Submitted: April 22nd, 2016
# CS 436 Computer Networking - ns2 Network Simulator
# This program is used to calculate the number of packets dropped at any hop along the 13 -> 21 traffic flow.
# Usage: gawk -f 13dropped.awk asfirane_valerio.tr

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   packets_dropped = 0;
}

{
   time2 = $2;
	
	if (time2 - time1 > 0.5) {
		printf("%f \t %f\n", time2, packets_dropped) > "13dropped.xls";
		time1 = $2;
    }
    
	if ($9 == 13.12 && $10 == 21) {
		if ($1 == "d" && $5 == "cbr") {
			packets_dropped++;
		}
    }
}

END {
   print("********");
   printf("Total number of packets dropped: %d\n", packets_dropped);
   print("********");
}
