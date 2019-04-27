all: googoutput.txt content.txt stocktickers.txt

googoutput.txt:
	googler --count 25 --time h1 -N "stocks to buy" | egrep 'http' | awk -F'//' '{ print $2 }' |  sed 's/\x1b\[[0-9;]*m//g' > googoutput.txt

content.txt: googoutput.txt
	wget --tries=1 --no-check-certificate -i googoutput.txt -O content.txt 

stocktickers.txt: content.txt
	cat content.txt | sed -e 's/<[^>]*>//g'| egrep -o '[(:][A-Z]{2,4}[)]' |tr -d ":()" | sort | uniq -c | sort -r -n > stocktickers.txt

clean:
	rm -f googoutput.txt content.txt stockticker.txt


