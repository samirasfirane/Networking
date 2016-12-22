# Team Members: Samir Asfirane, Javier Valerio
# Date Submitted: April 22nd, 2016
# CS 436 Computer Networking - ns2 Network Simulator
# This program is used to calculate the end-to-end delay for each packet in the 9 -> 27 traffic flow
# Usage: gawk -f 9delay.awk asfirane_valerio.tr

BEGIN {
	highest_packet_id = 0;
}

{

	action = $1;

	time = $2;

	from = $3;

	to = $4;

	type = $5;

	pktsize = $6;

	flow_id = $8;

	src = $9;

	dst = $10;

	seq_no = $11;

	packet_id = $12;

	src_node[packet_id] = $9;
	dest_node[packet_id] = $10;
	
	if ( packet_id > highest_packet_id )

		highest_packet_id = packet_id;


	if ( start_time[packet_id] == 0 )

		start_time[packet_id] = time;


	if ( action != "d" && type == "tcp") {

		if ( action == "r" ) {

			end_time[packet_id] = time;

		}

	} else {

		end_time[packet_id] = -1;

	}

}

END {

	for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ) {
		if (src_node[packet_id] == 9.5 && dest_node[packet_id] == 27.0) {
			start = start_time[packet_id];

			end = end_time[packet_id];

			packet_duration = end - start;
						
			if ( start < end ) printf("%f \t %f\n", start, packet_duration) > "9delay.xls";
		}

	}

}
