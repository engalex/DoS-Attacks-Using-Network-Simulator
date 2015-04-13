
rm drop.dat
rm systhroughput.dat
rm linkthroughput.dat
rm packetdrop.dat
#rm output.txt

awk -f drop.awk out.tr > drop.dat
awk -f systhroughput.awk out.tr > systhroughput.dat
awk -f linkthroughput.awk out.tr > linkthroughput.dat
awk -f packetdrop.awk out.tr > packetdrop.dat
#awk -f drop.awk out.tr > output.txt

gnuplot << EOF
	set term png
	set output "packetdrop.png"
	set xlabel "Time"
	set ylabel "Number of packets dropped"
	set title "Number of packets dropped vs Time"
	set xrange [0:100]
	#set yrange [0:5]
	set style data histograms
	plot "packetdrop.dat" using 2
EOF


gnuplot << EOF
	set term png
	set output "systhroughput.png"
	set xlabel "Time"
	set ylabel "Throughput"
	set title "Throughput vs Time"
	set xrange [0:100]
	#set yrange [0:170]
	set style data histograms
	plot "systhroughput.dat" using 2
EOF

gnuplot << EOF
	set term png
	set output "linkthroughput.png"
	set xlabel "Time"
	set ylabel "Throughput"
	set title "Throughput vs Time of link 2-3"
	set xrange [0:100]
	#set yrange [0:80]
	set style data histograms
	plot "linkthroughput.dat" using 2
EOF


gnuplot << EOF
	set term png
	set output "drop.png"
	set xlabel "Time"
	set ylabel "Probability"
	set title "Probability of packet being dropped"
	#set xrange [0:100]
	#set yrange [0:0.25]
	plot "drop.dat" lt 3 lc 3 
EOF



gnuplot << EOF
	set term png
	set output "bcd.png"
	plot "drop.dat"
EOF


#exec xgraph drop.dat -t "Number of attack packets" -x "time" -y "Attack" > drop.ps 
#exec xgraph systhroughput.dat -t "Throughput vs Time" -x "time" -y "Throughput" > systhroughput.ps 