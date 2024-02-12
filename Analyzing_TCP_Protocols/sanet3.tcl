set val(chan) Channel/WirelessChannel;
set val(prop) Propagation/TwoRayGround;
set val(netif) Phy/WirelessPhy;
set val(mac) Mac/802_11 ;
set val(ifq) Queue/DropTail/PriQueue ;
set val(ll) LL;
set val(ant) Antenna/OmniAntenna ;
set val(ifqlen) 50 ;
set val(nn) 7 ;
set val(rp) DSDV ;
set val(x) 1000;
set val(y) 1000;

# Création du simulateur
set ns [new Simulator]
$ns color 2 Rouge
$ns color 1 Bleu

# Création du fichier de trace
set tracefd [open sanet3.tr w]
$ns trace-all $tracefd

# Création du fichier de trace pour Nam
set namtrace [open sanet3.nam w]
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# Création de la topographie
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Création de l'entité divine
create-god $val(nn)

# Configuration des noeuds
set chan_1 [new $val(chan)]
set chan_2 [new $val(chan)]
$ns node-config -adhocRouting $val(rp) \
		-llType $val(ll) \
		-macType $val(mac) \ 
		-ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \ 
                -antType $val(ant) \
                -propType $val(prop) \ 
                -phyType $val(netif) \
                -topoInstance $topo \
                -agentTrace ON \
                -routerTrace ON \
                -macTrace ON \
                -movementTrace OFF \
                -channel $chan_1 \

# Création et positionnement des noeuds
for {set i 0} {$i < 7} {incr i} {
    set ID_($i) $i;
    set node_($i) [$ns node];
    $node_($i) set id $ID_($i);
    $node_($i) random-motion 0;
    $ns initial_node_pos $node_($i) 20;
}

# Réglage des seuils physiques
Phy/WirelessPhy set CPThresh_ 10.0
Phy/WirelessPhy set CSThresh_ 4.4613e-10    ;
Phy/WirelessPhy set RXThresh_ 4.4613e-10    ;

# Positionnement des noeuds spécifiques
$node_(0) set X_ 460.0;
$node_(0) set Y_ 800.0;
$node_(0) set Z_ 0.0;

$node_(1) set X_ 700.0;
$node_(1) set Y_ 800.0;
$node_(1) set Z_ 0.0;

$node_(2) set X_ 575.0;
$node_(2) set Y_ 500.0;
$node_(2) set Z_ 0.0;

$node_(6) set X_ 700.0;
$node_(6) set Y_ 200.0;
$node_(6) set Z_ 0.0;

$node_(5) set X_ 460.0;
$node_(5) set Y_ 200.0;
$node_(5) set Z_ 0.0;

$node_(3) set X_ 575.0;
$node_(3) set Y_ 650.0;
$node_(3) set Z_ 0.0;

$node_(4) set X_ 575.0;
$node_(4) set Y_ 350.0;
$node_(4) set Z_ 0.0;

# Définition des destinations des noeuds
$ns at 0.0 "$node_(0) setdest 460.0 800.0 0.0";
$ns at 0.0 "$node_(1) setdest 700.0 800.0 0.0";
$ns at 0.0 "$node_(2) setdest 575.0 500.0 0.0";
$ns at 0.0 "$node_(6) setdest 700.0 200.0 0.0";
$ns at 0.0 "$node_(5) setdest 460.0 200.0 0.0";
$ns at 0.0 "$node_(3) setdest 575.0 650.0 0.0";
$ns at 0.0 "$node_(4) setdest 575.0 350.0 0.0";

# Définition des noms des noeuds
$ns at 0.0 "$node_(0) label S1";
$ns at 0.0 "$node_(1) label S2";
$ns at 0.0 "$node_(2) label G1";
$ns at 0.0 "$node_(3) label G2";
$ns at 0.0 "$node_(4) label G3";
$ns at 0.0 "$node_(5) label D1";
$ns at 0.0 "$node_(6) label D2";

# Création des agents TCP et des applications
set tcp1 [new Agent/TCP/Newreno];
$tcp1 set class_ 2;
set sink1 [new Agent/TCPSink];
$ns attach-agent $node_(1) $tcp1;
$ns attach-agent $node_(6) $sink1;
$ns connect $tcp1 $sink1;
set ftp1 [new Application/FTP];
$ftp1 attach-agent $tcp1;
$ns at 3.0 "$ftp1 start";
$ns at 590.0 "$ftp1 stop";

set tcp2 [new Agent/TCP/Vegas];
$tcp2 set class_ 1;
set sink2 [new Agent/TCPSink];
$ns attach-agent $node_(0) $tcp2;
$ns attach-agent $node_(5) $sink2;
$ns connect $tcp2 $sink2;
set ftp2 [new Application/FTP];
$ftp2 attach-agent $tcp2;
$ns at 3.0 "$ftp2 start";
$ns at 590.0 "$ftp2 stop";

# Arrêt de la simulation
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns at 600.0 "$node_($i) reset";
}
$ns at 600.0 "stop";
$ns at 600.01 "puts \"SIMULATION TERMINÉE\" ;$ns halt"

# Fonction pour arrêter la simulation et fermer les fichiers de trace
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
}

# Lancement de la simulation
puts "Démarrage de NS"
$ns run
