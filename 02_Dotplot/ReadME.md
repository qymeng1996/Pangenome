# Dotplot

### The Dotplotly Rscript wss edited based on the Doplotly([tpoorten/dotPlotly: Generate an interactive dot plot from mummer or minimap alignments (github.com)](https://github.com/tpoorten/dotPlotly))

input=$1
ref=/public/home/cotton/public_data/cotton_genome/3-79_HAU_v2/Gbarbadense_3-79_HAU_v2.Chr.fa

nucmer4 -t 20 $ref $input -p alignment
delta-filter -1 -l 95 -l 1000 alignment.delta > alignment.delta.filter
show-coords -c alignment.delta.filer > alignment.delta.filter.cor
./DotPlotly.R -i alignment.delta.filter.cor -o alignment -q 1e+06 -m 50000 -l -t -s 
