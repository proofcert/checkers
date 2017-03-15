set terminal svg background rgb 'white' size 1650, 2000
set xrange [0:57]
set y2range [0:]
set xtics rotate by 90 right
set xlabel "test"
set y2tics
set grid mytics 
set grid ytics
set grid y2tics
set mytics
set linetype 1 lc rgb "#FF0000"
set linetype 2 lc rgb "#006600"
set linetype 3 lc rgb "#3300CC"
set linetype 4 lc rgb "#DDDD66"
set linetype 5 lc rgb "#66FFFF"
set linetype 6 lc rgb "#6666FF"
set style fill solid 0.4
set key right bottom
set boxwidth 0.1 absolute
set output "data.csv.svg"
plot \
"data.csv.dat" \
using ($1+0.0):5:4:6:(0):xtic(2) with candlesticks title "teyjus", \
"data.csv.dat" \
using ($1+0.2):10:9:11:(0) with candlesticks title "elpi", \
"data.csv.dat" \
using ($1+0.0):7 with boxes lw 0 fill solid 0.2 axes x1y2 title "teyjus", \
"data.csv.dat" \
using ($1+0.2):12 with boxes lw 0 fill solid 0.2 axes x1y2 title "elpi", \
