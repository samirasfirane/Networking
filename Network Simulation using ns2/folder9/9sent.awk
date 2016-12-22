# Team Members: Samir Asfirane, Javier Valerio
# Date Submitted: April 22nd, 2016
# CS 436 Computer Networking - ns2 Network Simulator
# This program is used to calculate the number of packets sent at each 0.5 sec time interval sent from source along the 9 -> 27 traffic flow.
# Usage: gawk -f 9sent.awk asfirane_valerio.tr

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   packets_sent = 0;
}

{
   time2 = $2;
	
	if (time2 - time1 > 0.5) {
		printf("%f \t %f\n", time2, packets_sent) > "9sent.xls";
		time1 = $2;
    }
    
	if (($9 >= 9 && $9 <= 9.9) && $10 == 27) {
		if ($1 == "+" && $5 == "tcp") {
			packets_sent++;
		}
    }
}

END {
   print("********");
   printf("Total number of packets sent: %d\n", packets_sent);
   print("********");
}
