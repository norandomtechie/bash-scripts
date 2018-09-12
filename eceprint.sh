# I thought of this when I was sitting on my laptop in MSEE,
# and I wondered - why on Earth should I have to log on to ECN 
# to print one sheet? This script logs into your ECEGrid account 
# via SSH, copies over a file you specify, and uses the lpr 
# command to print your file to the printer you specify.

# This assumes you set a variable ECEACC to your ECEGrid username.
# Example ECEACC="menon18"

# Cons: If you don't have RSA set up, you're gonna end up 
#       entering your password thrice! >_<

# !/bin/bash

FILEPATH=$1
PRINTER=$2

if [[ "$#" -ne 2 ]]; then
        echo "ERROR: I need a file and a printer!"
        echo "Example:"
        echo "eceprint /path/to/file.pdf msee189p2"
        echo
        echo "Printers available include: "
        echo "msee189p(1/2) ee69ps ee65ps"
        exit 1
fi

FILENAME=$(basename "$FILEPATH")
scp $FILEPATH "$ECEACC"@ecegrid.ecn.purdue.edu:~/$FILENAME
ssh "$ECEACC"@ecegrid.ecn.purdue.edu "lpr -P"$PRINTER" "$FILENAME""
ssh "$ECEACC"@ecegrid.ecn.purdue.edu "rm -f "$FILENAME""

exit 0
