BEGIN {
    # Initialization as before
    newreno_sent_pkt = 0
    newvegas_sent_pkt = 0
    newreno_rcv_pkt = 0
    newvegas_rcv_pkt = 0
    startTimeNewreno = 0
    isStartNewreno = 0
    startTimeNewvegas = 0
    isStartNewvegas = 0
    newreno_arrival_rate = 0
    newvegas_arrival_rate = 0
    packet_sent[7] = 0
    packet_recv[7] = 0
    packet_forw[7] = 0
    newreno_loss_over_time[10] = 0
    newvegas_loss_over_time[10] = 0

    # Create arrays to store loss ratios over time
    time_points = 20  # Adjust the number of time points as needed
    time_interval = 30  # Adjust the time interval as needed
}

{
    # Main processing block as before
    event = $1
    time = $2
    node_id = $3
    level = $4
    pkt_type = $7
    
    for (i = 0; i < time_points; i++) {
    
    	if (i * time_interval <= time && time < time_interval * (i + 1)) {

	    if (node_id == "_0_" && pkt_type == "tcp") {
		if (event == "s" && level == "AGT") {
		    packet_sent[0] = packet_sent[0] + 1
		}
		if (event == "r" && level == "AGT") {
		    packet_recv[0] = packet_recv[0] + 1
		}
		if (event == "f") {
		    packet_forw[0] = packet_forw[0] + 1
		}
	    }
	    if (node_id == "_1_" && pkt_type == "tcp") {
		if (event == "s" && level == "AGT") {
		    packet_sent[1] = packet_sent[1] + 1
		}
		if (event == "r" && level == "AGT") {
		    packet_recv[1] = packet_recv[1] + 1
		}
		if (event == "f") {
		    packet_forw[1] = packet_forw[1] + 1
		}
	    }
	    if (node_id == "_2_" && pkt_type == "tcp") {
		if (event == "s" && level == "AGT") {
		    packet_sent[2] = packet_sent[2] + 1
		}
		if (event == "r" && level == "AGT") {
		    packet_recv[2] = packet_recv[2] + 1
		}
		if (event == "f") {
		    packet_forw[2] = packet_forw[2] + 1
		}
	    }
	    if (node_id == "_3_" && pkt_type == "tcp") {
		if (event == "s" && level == "AGT") {
		    packet_sent[3] = packet_sent[3] + 1
		}
		if (event == "r" && level == "AGT") {
		    packet_recv[3] = packet_recv[3] + 1
		}
		if (event == "f") {
		    packet_forw[3] = packet_forw[3] + 1
		}
	    }
	    if (node_id == "_4_" && pkt_type == "tcp") {
		if (event == "s" && level == "AGT") {
		    packet_sent[4] = packet_sent[4] + 1
		}
		if (event == "r" && level == "AGT") {
		    packet_recv[4] = packet_recv[4] + 1
		}
		if (event == "f") {
		    packet_forw[4] = packet_forw[4] + 1
		}
	    }
	    if (node_id == "_5_" && pkt_type == "tcp") {
		if (event == "s" && level == "AGT") {
		    packet_sent[5] = packet_sent[5] + 1
		}
		if (event == "r" && level == "AGT") {
		    packet_recv[5] = packet_recv[5] + 1
		}
		if (event == "f") {
		    packet_forw[5] = packet_forw[5] + 1
		}
	    }
	    if (node_id == "_6_" && pkt_type == "tcp") {
		if (event == "s" && level == "AGT") {
		    packet_sent[6] = packet_sent[6] + 1
		}
		if (event == "r" && level == "AGT") {
		    packet_recv[6] = packet_recv[6] + 1
		}
		if (event == "f") {
		    packet_forw[6] = packet_forw[6] + 1
		}
	    }
	    
	    newreno_sent_pkt = packet_sent[1] - packet_forw[1];
	    newreno_rcv_pkt = packet_recv[6] - packet_forw[6];
	    newvegas_sent_pkt = packet_sent[0] - packet_forw[0];
	    newvegas_rcv_pkt = packet_recv[5] - packet_forw[5];
    
	    newreno_loss_over_time[i] = (newreno_sent_pkt - newreno_rcv_pkt) / newreno_sent_pkt * 100;
	    newvegas_loss_over_time[i] = (newvegas_sent_pkt - newvegas_rcv_pkt) / newvegas_sent_pkt * 100;
    	}
	    
    }
}

END {
    for (i = 0; i < time_points; i++) {
            printf("Time Point %d: NewReno Loss Ratio = %f, NewVegas Loss Ratio = %f\n", i * time_interval, newreno_loss_over_time[i], newvegas_loss_over_time[i]);
    }
}

