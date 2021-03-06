# /usr/bin/bash
endc='\E[0m'
enda='\033[0m'
blue='\e[1;34m'
cyan='\e[1;36m'
red='\e[1;31m'
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'

sleep 1

trap 'printf "\n"; stop; exit 1' 2

dependencies() {

command -v curl > /dev/null 2>&1 || { echo >&2 "Curl nya mana? ketik perintah 'apt install curl."; exit 1; }

}

stop() {

if [[ -e hashpart* ]]; then
rm -rf hashpart*
fi
if [[ -e result0_* ]]; then
rm -rf result0_*
fi
if [[ -e sum_result0 ]]; then
rm -rf sum_result0
fi
}

function result {
if [[ -e sum_result0 ]]; then
rm -rf found.txt not_found.txt

for line in $(cat $1); do
c1=$(grep -o ''$line' <b>.*' sum_result0  | cut -d '<' -f1)
c2=$(grep -o ''$line' <b>.*' sum_result0  | cut -d '>' -f2)

if [[ $c2 != '' ]]; then
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m]\e[0m ketemu \e[1;92m%s\e[0m: \e[1;77m%s\e[0m\n" $c2
printf "%s:%s\n" $c1 $c2 >> found.txt

else
printf "\e[1;77m[\e[0m\e[1;93m-\e[0m\e[1;77m]\e[0m \e[1;92m%s\e[0m:\e[1;93m Gak ditemukan sayang\e[0m\n" $line
printf "%s\n" $line >> not_found.txt

fi
done
rm -rf sum_result0
fi

count_found=$(wc -l found.txt | cut -d " " -f1)
count_nfound=0
printf "\n\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m]\e[0m \e[1;93mResults\e[0m: \e[1;77m%s/%s\e[0m\n" $count_found $total_hash
printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m]\e[0m \e[1;93mSaved\e[0m:\e[1;77m found.txt / not_found.txt\e[0m\n\n"
}

function hashfile {
total_hash=$(wc -l $1 | cut -d " " -f1)
printf "\n\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m]\e[0m \e[1;92mTotal hashs\e[0m: \e[1;77m%s\e[0m\n" $total_hash
printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m]\e[0m \e[1;93mTunggu sebentar lur :v\e[0m\n\n"
split -l 400 $1 hashpart

for hash_split in $(ls hashpart*); do
var=$(cat $hash_split | sed 's/$/ %0D%0A/' | tr '\n' ' ' | tr -d ' ')
curl -i -s -k  -X $'POST'     -H $'User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0' -H $'Referer: https://md5decrypt.net/' -H $'Upgrade-Insecure-Requests: 1' -H $'Content-Type: application/x-www-form-urlencoded'     --data-binary $'hash='$var'&decrypt=D%C3%A9crypter'     $'https://md5decrypt.net/' >> result0_$hash_split
done
cat result0_* >> sum_result0
rm -rf result0_*
rm -rf hashpart*
result $1
}

function hashstring {

curl -i -s -k  -X $'POST'     -H $'User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0' -H $'Referer: https://md5decrypt.net/' -H $'Upgrade-Insecure-Requests: 1' -H $'Content-Type: application/x-www-form-urlencoded'     --data-binary $'hash='$1'&decrypt=D%C3%A9crypter'     $'https://md5decrypt.net/' >> sum_result0

c1=$(grep -o ''$1' : <b>.*' sum_result0  | cut -d ':' -f1)
c2=$(grep -o ''$1' : <b>.*' sum_result0  | cut -d '>' -f2)

if [[ $c2 != '' ]]; then
printf "\n\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m]\e[0m result: \e[1;77m%s\e[0m \e[1;92m%s\e[0m\n\n" $c2
else
printf "\n\e[1;77m[\e[0m\e[1;93m-\e[0m\e[1;77m]\e[0m \e[1;77m%s\e[0m:\e[1;93m Not Found\e[0m\n\n" $1
fi
rm -rf sum_result0

}

dependencies
if [[ -e $1 ]];then

hashfile $1
elif [[ $# != 1 ]];then
printf "\033[37;1m[\033[33;1m!\033[37;1m] \033[37;1m use tools : \033[32;1m bash hash.sh \033[37;1m[ \033[31;1mmd5 \033[37;1m]\n"

else

hashstring $1
fi


