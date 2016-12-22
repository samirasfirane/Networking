#Create a simulator object
set ns [new Simulator]

#Create a trace file
set tracefd [open asfirane_valerio.tr w]
$ns trace-all $tracefd


#Define a 'finish' procedure
proc finish {} {
        global ns nf
        
        $ns flush-trace
 #Close the trace file
 #       close $nf

        exit 0
}



#Create twenty seven nodes
for {set i 0} {$i < 28} {incr i} {
        set n($i) [$ns node]
}

#Create a duplex link between the nodes 0,1,2 and 3
$ns duplex-link $n(2) $n(0) 2Mb 40ms DropTail
$ns duplex-link $n(2) $n(4) 2Mb 40ms DropTail
$ns duplex-link $n(3) $n(5) 2Mb 40ms DropTail
$ns duplex-link $n(3) $n(6) 2Mb 40ms DropTail
$ns duplex-link $n(3) $n(1) 8Mb 50ms DropTail
$ns duplex-link $n(3) $n(2) 8Mb 50ms DropTail
$ns duplex-link $n(1) $n(2) 8Mb 50ms DropTail

#Set Queue Size of purple links to 15
$ns queue-limit $n(2) $n(0) 15
$ns queue-limit $n(2) $n(4) 15
$ns queue-limit $n(3) $n(5) 15
$ns queue-limit $n(3) $n(6) 15

#Set Queue Size of black links to 20
$ns queue-limit $n(3) $n(1) 20
$ns queue-limit $n(3) $n(2) 20
$ns queue-limit $n(1) $n(2) 20

#Create links between the nodes 1,7,8,9,10,11 and 12
#Set up Queue Size of red links to 10
for {set i 7} {$i < 13} {incr i} {
        $ns duplex-link $n(1) $n($i) 1Mb 20ms DropTail
        $ns queue-limit $n(1) $n($i) 10 
}

#Create links between the nodes 0,13,14,15 and 16
#Set up Queue Size of red links to 10
for {set i 13} {$i < 17} {incr i} {
        $ns duplex-link $n(0) $n($i) 1Mb 20ms DropTail
        $ns queue-limit $n(0) $n($i) 10
}

#Create links between the nodes 4,17,18,19 and 20
#Set up Queue Size of red links to 10
for {set i 17} {$i < 21} {incr i} {
        $ns duplex-link $n(4) $n($i) 1Mb 20ms DropTail
        $ns queue-limit $n(4) $n($i) 10 
}

#Create links between the nodes 5,21,22,23 and 24	
#Set up Queue Size of red links to 10
for {set i 21} {$i < 25} {incr i} {
        $ns duplex-link $n(5) $n($i) 1Mb 20ms DropTail
        $ns queue-limit $n(5) $n($i) 10  
}

#Create links between the nodes 6,25,26 and 27
#Set up Queue Size of red links to 10
for {set i 25} {$i < 28} {incr i} {
        $ns duplex-link $n(6) $n($i) 1Mb 20ms DropTail
        $ns queue-limit $n(6) $n($i) 10  
}

#Setup 6 TCP connections and attach them to node 9
for {set i 0} {$i < 6} {incr i} {
        set tcp($i) [new Agent/TCP]
        $tcp($i) set class_ 2 
        $ns attach-agent $n(9) $tcp($i) 
}

# create 6 sink for the different nodes
set sink12 [new Agent/TCPSink]
set sink14 [new Agent/TCPSink]
set sink15 [new Agent/TCPSink]
set sink20 [new Agent/TCPSink]
set sink23 [new Agent/TCPSink]
set sink27 [new Agent/TCPSink]

#attach the tcp sinks to their respective nodes
$ns attach-agent $n(12) $sink12
$ns attach-agent $n(14) $sink14
$ns attach-agent $n(15) $sink15
$ns attach-agent $n(20) $sink20
$ns attach-agent $n(23) $sink23
$ns attach-agent $n(27) $sink27

#connect the tcp sink to their respective tcp
$ns connect $tcp(0) $sink12
$ns connect $tcp(1) $sink14
$ns connect $tcp(2) $sink15
$ns connect $tcp(3) $sink20
$ns connect $tcp(4) $sink23
$ns connect $tcp(5) $sink27

#set the 5 tcp connections
for {set i 0} {$i < 6} {incr i} {
       $tcp($i) set fid_ 1 
}

#Setup 5 FTP over 5 TCP connection
for {set i 0} {$i < 6} {incr i} {
       set ftp($i) [new Application/FTP]
       $ftp($i) attach-agent $tcp($i)
       $ftp($i) set type_ FTP
}

#Setup a UDP connection
for {set i 0} {$i < 8} {incr i} {
       set udp($i) [new Agent/UDP]
       $ns attach-agent $n(13) $udp($i)

      }

#Setup a CBR over UDP connection
for {set i 0} {$i < 8} {incr i} {
       set udp($i) [new Agent/UDP]
       $ns attach-agent $n(13) $udp($i)
       set cbr($i) [new Application/Traffic/CBR]
       $cbr($i) set packetSize_ 800
       $cbr($i) set interval_ 0.005
       $cbr($i) set random_ 1
       $cbr($i) attach-agent $udp($i)

      }

#Create links between the nodes 6,25,26 and 27
set null8 [new Agent/Null]
set null11 [new Agent/Null]
set null17 [new Agent/Null]
set null19 [new Agent/Null]
set null21 [new Agent/Null]
set null24 [new Agent/Null]
set null25 [new Agent/Null]
set null26 [new Agent/Null]

#attach UDP agent to respective nodes
$ns attach-agent $n(8) $null8
$ns attach-agent $n(11) $null11
$ns attach-agent $n(17) $null17
$ns attach-agent $n(19) $null19
$ns attach-agent $n(21) $null21
$ns attach-agent $n(24) $null24
$ns attach-agent $n(25) $null25
$ns attach-agent $n(26) $null26

#connect UDP agents to respective sinks
$ns connect $udp(0) $null8
$ns connect $udp(1) $null11
$ns connect $udp(2) $null17
$ns connect $udp(3) $null19
$ns connect $udp(4) $null21
$ns connect $udp(5) $null24
$ns connect $udp(6) $null25
$ns connect $udp(7) $null26

#Define a procedure that attaches a UDP agent to a previously created node
#'node' and attaches an Expoo traffic generator to the agent with the
#characteristic values 'size' for packet size 'burst' for burst time,
#'idle' for idle time and 'rate' for burst peak rate. The procedure connects
#the source with the previously defined traffic sink 'sink' and returns the
#source object.
proc attach-expoo-traffic { node sink size burst idle rate } {
	#Get an instance of the simulator
	set ns [Simulator instance]

	#Create a UDP agent and attach it to the node
	set source [new Agent/UDP]
	$ns attach-agent $node $source

	#Create an Expoo traffic agent and set its configuration parameters
	set traffic [new Application/Traffic/Exponential]
	$traffic set packetSize_ $size
	$traffic set burst_time_ $burst
	$traffic set idle_time_ $idle
	$traffic set rate_ $rate
        
        # Attach traffic source to the traffic generator
        $traffic attach-agent $source
	#Connect the source and the sink
	$ns connect $source $sink
	return $traffic
}

#Create two traffic sinks and attach them to the node 18
set sink10 [new Agent/LossMonitor]
set sink16 [new Agent/LossMonitor]
$ns attach-agent $n(18) $sink10
$ns attach-agent $n(18) $sink16


#Create two traffic sources
set source10 [attach-expoo-traffic $n(10) $sink10 2000 2.5s 1s 1200k]
set source16 [attach-expoo-traffic $n(16) $sink16 2000 2.5s 1s 1200k]

#Schedule events for the CBR agent
$ns at 1.0 "$ftp(0) start"  
$ns at 1.0 "$cbr(0) start"
$ns at 1.0 "$ftp(1) start"
$ns at 2.0 "$cbr(1) start"
$ns at 2.0 "$ftp(2) start"
$ns at 2.0 "$cbr(2) start"
$ns at 3.0 "$cbr(3) start"
$ns at 3.0 "$source10 start"
$ns at 3.0 "$cbr(4) start"
$ns at 4.0 "$cbr(5) start"
$ns at 4.0 "$ftp(3) start"
$ns at 4.0 "$cbr(6) start"
$ns at 5.0 "$ftp(4) start"
$ns at 5.0 "$cbr(7) start" 
$ns at 5.0 "$ftp(5) start"
$ns at 6.0 "$source16 start"
$ns rtmodel-at 7.0 down $n(1) $n(3)
$ns rtmodel-at 8.0 up $n(1) $n(3) 
$ns at 10.0 "$ftp(0) stop"  
$ns at 10.0 "$cbr(0) stop"
$ns at 10.0 "$ftp(1) stop"
$ns at 10.0 "$cbr(1) stop"
$ns at 10.0 "$ftp(2) stop"
$ns at 10.0 "$cbr(2) stop"
$ns at 10.0 "$cbr(3) stop"
$ns at 10.0 "$source10 stop"
$ns at 10.0 "$cbr(4) stop"
$ns at 10.0 "$cbr(5) stop"
$ns at 10.0 "$ftp(3) stop"
$ns at 10.0 "$cbr(6) stop"
$ns at 10.0 "$ftp(4) stop"
$ns at 10.0 "$cbr(7) stop" 
$ns at 10.0 "$ftp(5) stop"
$ns at 10.0 "$source16 stop"

#Call the finish procedure after 10 seconds simulation time
$ns at 10.0 "finish"

#Run the simulation
$ns run