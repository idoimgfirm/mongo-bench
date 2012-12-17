# mongobench

Node mongodb benchmark, inspired by felixge/faster-than-c

## Running

simply run `node index.js $directory-$limit[-$concurrency] > $output.tsv`

This will run the library in $directory, so make sure the directory exists and the library therein is correctly installed (`npm install`).

## Graphing

You need `R` and `ggplot2` installed. Simply run `./pngs.r` which will fetch the data to be graphed from the `*.tsv` files.
To compare two different versions, they need to have their own directory (or simply rename it in between).
Graphs are further grouped by $limit. Grouping for $concurrency is not done.
