<?PHP
//��ɫ20152027

//��������ɫ20152027
function getRandColor(){
    $splStr ='';
    $splStr= aspSplit('#990000,#999900,#333366,#663300,#669966,#FF6600,#CC33CC,#993366,#FF0099,#669900,#336699,#99CCCC,#CC3366,#FF9900,#9933FF,#669900,#6699FF,#333366,#99CC66,#996600,#000033,#003300,#330000,#660000,#000099,#330099,#6600FF,#990000,#CC0000,#FF0000,#990066,#FF0066,#CC00CC', ',');
    $getRandColor= $splStr[pHPRand(0, uBound($splStr))];
    return @$getRandColor;
}
?>