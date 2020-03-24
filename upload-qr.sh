#!/bin/bash

key=$(curl -F "file=@$1" https://file.io | cut -d ',' -f 2 |  cut -d '"' -f 4)
link="https://file.io/$key"
echo $link
qrencode -s 15 -m 2 -o - $link | feh -
