# for l in `echo master patched`; do for t in `echo 100 10000 50000`; do echo -n "$l-$t.tsv "; done; done
tsv_files := master-100.tsv master-10000.tsv master-50000.tsv patched-100.tsv patched-10000.tsv patched-50000.tsv
pngs := jitter.png line.png heap-used.png heap-total.png

all: $(pngs)

%.tsv:
	node index.js $(patsubst %.tsv,%,$@) | tee $@

$(pngs): pngs

pngs: $(tsv_files) pngs.r
	./pngs.r
	rm -f Rplots.pdf

clean:
	rm -f *.tsv *.png

.PHONY: all clean pngs

# --trace-opt --trace-deopt --trace-bailout --trace-gc
# --prof
# node-tick-processor
