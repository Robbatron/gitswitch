<?php
$to="trigger@recipe.ifttt.com";
$subject="Git Push";
$message="cd /Users/robertdelfs/Documents/Github/Book-Exercises/VueJS-Intro \n git commit -am 'add/commit/push from rpi' && git push";
$from="robbie.delfs@gmail.com";
$headers="From:".$from;
mail($to,$subject,$message,$headers);
echo "Mail Sent.\n";
?>
