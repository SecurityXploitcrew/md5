<?php
function loading($a){
system("clear");
echo "\nLoading";
for($i=0; $i < 5; $i++){
     echo ". ";
     sleep(1);
 }
}
loading("loading");
echo "\ntext: ";
$b = trim(fgets(STDIN,1024));
echo "md5 : \033[31;1m".md5($b)."\n\033[37;1m";
?>
