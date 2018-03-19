# makefile: tex -> pdf

file_name = paper

auto_tikz_folder = figures

$(file_name).pdf: $(file_name).tex chapters/*.tex
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create pdf
	# will automatically run pdflatex/biber if necessary
	latexmk -xelatex $(file_name).tex

	# clean auxillary files
	latexmk -c $(file_name).tex

$(auto_tikz_folder)/%.pdf: $(auto_tikz_folder)/%.tex
	latexmk -xelatex -cd $<
	latexmk -c $<
	# $< means the name of the first prerequisite
	# %.pdf is a wildcard (every .pdf)

clean:
	-rm $(file_name).log $(file_name).aux $(file_name).bbl $(file_name).bcf $(file_name).blg $(file_name).fdb_latexmk $(file_name).fls $(file_name).out $(file_name).run.xml $(file_name).xdv
