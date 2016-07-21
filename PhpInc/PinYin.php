<?PHP
//²âÊÔ»ñµÃVBÄÇ¸öÆ´ÒôÄ£°å
function testGetPY(){
    $c=''; $splStr=''; $i=''; $s=''; $cn=''; $en ='';
    $splStr= aspSplit(getFText('1.txt'), 'End If');
    for( $i= 0 ; $i<= uBound($splStr); $i++){
        $s= $splStr[$i];
        if( inStr($s, '=') > 0 ){
            $cn= mid($s, inStr($s, '"') + 1,-1);
            $cn= mid($cn, 1, inStr($cn, ' ') - 3);

            $en= mid($s, inStr($s, '=') + 1,-1);
            $en= mid($en, 3, inStr($en, vbCrlf()) - 4);
            $c= 'PY(' . $i . ')="' . $cn . '_' . $en . '"';
            Rw($c);
        }
    }
}

//Call PinYin("ÉÏº£ÎÒµÄÃû×Ö½Ðmydd3 ÓÐÏÞ¹«Ë¾", "Æ´Òô")
//Call PinYin(" shang hai wo de ming zi jiao mydd3 you xian gong si  ", "ºº×Ö")
function pinYin($content, $sType){
    $py=aspArray(402); $splStr=''; $en=''; $s=''; $c=''; $i=''; $j=''; $c2=''; $C3=''; $C4=''; $En2=''; $En3=''; $En4 ='';
    $sType= cStr($sType); //×ª³É×Ö·ûÀàÐÍ
    $py[0]= '°¢°¡ß¹àÄï¹ëç…åH_a';
    $py[1]= '°£°¤°¥°¦°§°¨°©°ª°«°¬°­°®°¯ÞßàÈàÉæÈè¨êÓíÁïÍö°_ai';
    $py[2]= '°°°±°²°³°´°µ°¶°·°¸ÚÏÛûÞîáíâÖèñï§ðÆ÷ö_an';
    $py[3]= '°¹°º°»_ang';
    $py[4]= '°¼°½°¾°¿°À°Á°Â°Ã°ÄÛêÞÖà»á®âÚåÛæÁæñéáñúòüöË÷¡÷é_ao';
    $py[5]= '°Å°Æ°Ç°È°É°Ê°Ë°Ì°Í°Î°Ï°Ð°Ñ°Ò°Ó°Ô°Õ°ÖÜØÝÃá±å±îÙôÎöÑ÷É_ba';
    $py[6]= '°×°Ø°Ù°Ú°Û°Ü°Ý°ÞÞãßÂêþ_bai';
    $py[7]= '°ß°à°á°â°ã°ä°å°æ°ç°è°é°ê°ë°ì°íÚæÛàîÓñ£ñ­ô²_ban';
    $py[8]= '°î°ï°ð°ñ°ò°ó°ô°õ°ö°÷°ø°ùÝòäº_bang';
    $py[9]= '°ú°û°ü°ý°þ±¡±¢±£±¤±¥±¦±§±¨±©±ª±«±¬ÝáæßìÒð±ñÙõÀöµ_bao';
    $py[10]= '±­±®±¯±°±±±²±³±´±µ±¶±·±¸±¹±º±»ØÃÚéÚýÝíã£íÕðÇñØöÍ÷¹_bei';
    $py[11]= '±¼±½±¾±¿ÛÎÛÐêÚï¼_ben';
    $py[12]= '±À±Á±Â±Ã±Ä±ÅàÔê´_beng';
    $py[13]= '±Æ±Ç±È±É±Ê±Ë±Ì±Í±Î±Ï±Ð±Ñ±Ò±Ó±Ô±Õ±Ö±×±Ø±Ù±Ú±ÛÝÉ±Ü±ÝØ°ÙÂÜêÝ©ÞµßÁßÙáùâØã¹ääå¨åöåþæ¾æÔèµî¯îéïõñÔóÙóëó÷ô°ôÅõÏ÷Â_bi';
    $py[14]= '±Þ±ß±à±á±â±ã±ä±å±æ±ç±è±éØÒÛÍÜÐâíãêçÂìÔí¾íÜñ¹ñÛòùóÖöý_bian';
    $py[15]= '±ê±ë±ì±íæ»æôè¼ì©ì­ì®ïÚïðñ¦ñÑ÷§÷Ô_biao';
    $py[16]= '±î±ï±ð±ñõ¿_bie';
    $py[17]= '±ò±ó±ô±õ±ö±÷ÙÏáÙçÍçãéÄéëë÷ïÙ÷Æ÷Þ_bin';
    $py[18]= '±ø±ù±ú±û±ü±ý±þ²¡²¢Ù÷ÚûÞð_bing';
    $py[19]= '²£²¤²¥²¦²§²¨²©²ª²«²¬²­²®²¯²°²±²²²³²´²µÙñà£âÄéÞë¢íçîàð¾ô¤õËõÛ_bo';
    $py[20]= '²¶²·²¸²¹²º²»²¼²½²¾²¿²Àß²åÍê³êÎîÐîßõ³_bu';
    $py[21]= '²Áàêíå_ca';
    $py[22]= '²Â²Ã²Ä²Å²Æ²Ç²È²É²Ê²Ë²Ì_cai';
    $py[23]= '²Í²Î²Ï²Ð²Ñ²Ò²Óåîæîè²ôÓ÷õ_can';
    $py[24]= '²Ô²Õ²Ö²×²Ø_cang';
    $py[25]= '²Ù²Ú²Û²Ü²ÝàÐäîó©ô½_cao';
    $py[26]= '²Þ²ß²à²á²ââü_ce';
    $py[27]= 'á¯ä¹_cen';
    $py[28]= '²ã²äàá_ceng';
    $py[29]= '²å²æ²ç²è²é²ê²ë²ì²í²î²ïâªâÇãâæ±è¾é«é¶éßïÊïïñÃ_cha';
    $py[30]= '²ð²ñ²òÙ­îÎðûò²_chai';
    $py[31]= '²ó²ô²õ²ö²÷²ø²ù²ú²û²üÙæÚÆÝÛâÜâãäýå¤åñæ¿æöêèìøïâó¸õð_chan';
    $py[32]= '²ý²þ³¡³¢³£³¤³¥³¦³§³¨³©³ª³«ØöÛËÜÉÝÅáäâêã®ãÑæ½æÏêÆë©öð_chang';
    $py[33]= '³¬³­³®³¯³°³±³²³³³´â÷êËìÌñé_chao';
    $py[34]= '³µ³¶³·³¸³¹³ºÛåíº_che';
    $py[35]= '³»³¼³½³¾³¿³À³Á³Â³Ã³ÄØ÷ÚÈÚßÞÓàÁå·è¡é´í×ö³_chen';
    $py[36]= '³Å³Æ³Ç³È³É³Ê³Ë³Ì³Í³Î³Ï³Ð³Ñ³Ò³ÓØ©ÛôèÇèßëóîªîñîõñÎòÉõ¨_cheng';
    $py[37]= '³Ô³Õ³Ö³×³Ø³Ù³Ú³Û³Ü³Ý³Þ³ß³à³á³â³ãÙÑÛæÜ¯ÜÝß³ßêà´àÍáÜâÁæÊë·íôí÷ð·ñ¡ñÝò¿ó¤ó×óøôùõØ÷Î_chi';
    $py[38]= '³ä³å³æ³ç³èÜûâçã¿ï¥ô©ô¾_chong';
    $py[39]= '³é³ê³ë³ì³í³î³ï³ð³ñ³ò³ó³ôÙ±àüã°ñ¬öÅ_chou';
    $py[40]= '³õ³ö³÷³ø³ù³ú³û³ü³ý³þ´¡´¢´£´¤´¥´¦Ø¡Û»âðãÀç©èÆèúéËñÒòÜõé÷í_chu';
    $py[41]= '´§Þõà¨àÜëúõß_chuai';
    $py[42]= '´¨´©´ª´«´¬´­´®â¶å×çÝë°îËô­_chuan';
    $py[43]= '´¯´°´±´²´³´´âë_chuang';
    $py[44]= '´µ´¶´·´¸´¹Úïé¢é³_chui';
    $py[45]= '´º´»´¼´½´¾´¿´ÀÝ»ðÈòí_chun';
    $py[46]= '´Á´Âê¡õÖöº_chuo';
    $py[47]= '´Ã´Ä´Å´Æ´Ç´È´É´Ê´Ë´Ì´Í´ÎÜëßÚìôðËôÙ_ci';
    $py[48]= '´Ï´Ð´Ñ´Ò´Ó´ÔÜÊäÈæõçýè®èÈ_cong';
    $py[49]= '´Õé¨ê£ëí_cou';
    $py[50]= '´Ö´×´Ø´ÙÝýáÞâ§éãõ¡õ¾õí_cu';
    $py[51]= '´Ú´Û´ÜÙÛß¥ìàïé_cuan';
    $py[52]= '´Ý´Þ´ß´à´á´â´ã´äÝÍßýã²è­éÁë¥ö¿_cui';
    $py[53]= '´å´æ´çââñå_cun';
    $py[54]= '´è´é´ê´ë´ì´íØÈáÏëâï±ïóðîõºõã_cuo';
    $py[55]= '´î´ï´ð´ñ´ò´óÞÇßÕàªâòæ§í³ðãñ×óÎ÷°÷²_da';
    $py[56]= '´ô´õ´ö´÷´ø´ù´ú´û´ü´ý´þµ¡Ü¤ß°ß¾á·åÊææçªçé÷ì_dai';
    $py[57]= 'µ¢µ£µ¤µ¥µ¦µ§µ¨µ©µªµ«µ¬µ­µ®µ¯µ°ÙÙÝÌà¢å£ééêæíñð÷ñõóì_dan';
    $py[58]= 'µ±µ²µ³µ´µµÚÔÛÊÝÐå´í¸ñÉ_dang';
    $py[59]= 'µ¶µ·µ¸µ¹µºµ»µ¼µ½µ¾µ¿µÀµÁß¶âáë®ìâôî_dao';
    $py[60]= 'µÂµÃµÄï½_de';
    $py[61]= 'µÅµÆµÇµÈµÉµÊµËàâáØê­íãïëô£_deng';
    $py[62]= 'µÌµÍµÎµÏµÐµÑµÒµÓµÔµÕµÖµ×µØµÙµÚµÛµÜµÝµÞØµÙáÚ®ÚÐÛ¡Ý¶àÖæ·èÜé¦êëíÆíÚíûïáôÆ÷¾_di';
    $py[63]= 'àÇ_dia';
    $py[64]= 'µßµàµáµâµãµäµåµæµçµèµéµêµëµìµíµîÚçÛãáÛçèîäñ°ñ²ô¡õÚ_dian';
    $py[65]= 'µïµðµñµòµóµôµõµöµ÷îöï¢õõöô_diao';
    $py[66]= 'µøµùµúµûµüµýµþÛìÜ¦Þéà©ëºð¬ñóõÞöø_die';
    $py[67]= '¶¡¶¢¶£¶¤¶¥¶¦¶§¶¨¶©Øêà¤çàëëíÖî®îúðÛñôôú_ding';
    $py[68]= '¶ªîû_diu';
    $py[69]= '¶«¶¬¶­¶®¶¯¶°¶±¶²¶³¶´ÛíßËá´á¼ë±ëËëØíÏð´_dong';
    $py[70]= '¶µ¶¶¶·¶¸¶¹¶º¶»Ýúñ¼ò½óû_dou';
    $py[71]= '¶¼¶½¶¾¶¿¶À¶Á¶Â¶Ã¶Ä¶Å¶Æ¶Ç¶È¶É¶ÊÜ¶à½äÂèüë¹ó¼óÆ÷Ç÷ò_du';
    $py[72]= '¶Ë¶Ì¶Í¶Î¶Ï¶Ðé²ìÑóý_duan';
    $py[73]= '¶Ñ¶Ò¶Ó¶Ôí¡í­íÔïæ_dui';
    $py[74]= '¶Õ¶Ö¶×¶Ø¶Ù¶Ú¶Û¶Ü¶ÝãçìÀí»íâíïõ»_dun';
    $py[75]= '¶Þ¶ß¶à¶á¶â¶ã¶ä¶å¶æ¶ç¶è¶éßÍßáãõç¶èÞîìñÖõâ_duo';
    $py[76]= '¶ê¶ë¶ì¶í¶î¶ï¶ð¶ñ¶ò¶ó¶ô¶õ¶öØ¬ÚÌÛÑÜÃÝ­ÝàßÀãµãÕåíæ¹éîëñï°ïÉðÊò¦öù_e';
    $py[77]= 'ÚÀ_ei';
    $py[78]= '¶÷ÝìÞô_en';
    $py[79]= '¶ø¶ù¶ú¶û¶ü¶ý¶þ·¡Ù¦åÇçíîïð¹öÜ_er';
    $py[80]= '·¢·£·¤·¥·¦·§·¨·©ÛÒíÀ_fa';
    $py[81]= '·ª·«·¬·­·®·¯·°·±·²·³·´·µ·¶···¸·¹·ºÞ¬ÞÀá¦èóìÜî²õì_fan';
    $py[82]= '·»·¼·½·¾·¿·À·Á·Â·Ã·Ä·ÅÚúáÝèÊîÕô³öÐ_fang';
    $py[83]= '·Æ·Ç·È·É·Ê·Ë·Ì·Í·Î·Ï·Ð·ÑÜÀáôã­äÇåúç³é¼ëèì³ìéïÐðòòãóõôäö­öî_fei';
    $py[84]= '·Ò·Ó·Ô·Õ·Ö·×·Ø·Ù·Ú·Û·Ü·Ý·Þ·ß·àÙÇå¯èûö÷÷÷_fen';
    $py[85]= '·á·â·ã·ä·å·æ·ç·è·é·ê·ë·ì·í·î·ïÙºÛºÝ×ßôããí¿_feng';
    $py[86]= '·ð_fo';
    $py[87]= '·ñó¾_fou';
    $py[88]= '·ò·ó·ô·õ·ö·÷·ø·ù·ú·û·ü·ý·þ¸¡¸¢¸£¸¤¸¥¸¦¸§¸¨¸©¸ª¸«¸¬¸­¸®¸¯¸°¸±¸²¸³¸´¸µ¸¶¸·¸¸¸¹¸º¸»¸¼¸½¸¾¸¿¸ÀÙëÙìÛ®Ü½ÜÞÜòÝ³ÝÊÞÔß»á¥âöäæåõæÚæâç¦ç¨èõêçìðíÉíêíëî·ïûð¥ò¶òÝòðòóôïõÃõÆöÖöû_fu';
    $py[89]= '¸Á¸ÂÙ¤ÞÎæØæÙê¸îÅ_ga';
    $py[90]= '¸Ã¸Ä¸Å¸Æ¸Ç¸ÈØ¤ÚëÛòê®êà_gai';
    $py[91]= '¸É¸Ê¸Ë¸Ì¸Í¸Î¸Ï¸Ð¸Ñ¸Ò¸ÓÛáÜÕÞÏß¦ãïäÆä÷ç¤éÏêºí·ðáôû_gan';
    $py[92]= '¸Ô¸Õ¸Ö¸×¸Ø¸Ù¸Ú¸Û¸Üí°î¸óà_gang';
    $py[93]= '¸Ý¸Þ¸ß¸à¸á¸â¸ã¸ä¸å¸æØºÚ¾Û¬Þ»çÉéÀéÂê½ï¯_gao';
    $py[94]= '¸ç¸è¸é¸ê¸ë¸ì¸í¸î¸ï¸ð¸ñ¸ò¸ó¸ô¸õ¸ö¸÷ØªØîÛÁÛÙÜªàÃæüë¡ëõíÑïÓñËò´ô´÷À_ge';
    $py[95]= '¸ø_gei';
    $py[96]= '¸ù¸úØ¨Ý¢ßçôÞ_gen';
    $py[97]= '¸û¸ü¸ý¸þ¹¡¹¢¹£ßìâÙç®öá_geng';
    $py[98]= '¹¤¹¥¹¦¹§¹¨¹©¹ª¹«¹¬¹­¹®¹¯¹°¹±¹²çîëÅò¼ö¡_gong';
    $py[99]= '¹³¹´¹µ¹¶¹·¹¸¹¹¹º¹»ØþÚ¸á¸åÜæÅçÃèÛêíì°óÑóô÷¸_gou';
    $py[100]= '¹¼¹½¹¾¹¿¹À¹Á¹Â¹Ã¹Ä¹Å¹Æ¹Ç¹È¹É¹Ê¹Ë¹Ì¹ÍØÅÚ¬ÝÔßÉáÄãéèôéïêôêöëûì±î­î¹îÜïÀð³ðÀðóòÁôþõýöñ÷½_gu';
    $py[101]= '¹Î¹Ï¹Ð¹Ñ¹Ò¹ÓØÔÚ´èéëÒð»_gua';
    $py[102]= '¹Ô¹Õ¹ÖÞâ_guai';
    $py[103]= '¹×¹Ø¹Ù¹Ú¹Û¹Ü¹Ý¹Þ¹ß¹à¹áÙÄÝ¸ÞèäÊîÂðÙñæ÷¤_guan';
    $py[104]= '¹â¹ã¹äßÛáîèæë×_guang';
    $py[105]= '¹å¹æ¹ç¹è¹é¹ê¹ë¹ì¹í¹î¹ï¹ð¹ñ¹ò¹ó¹ôØÐØÛâÑå³æ£èíêÁêÐð§óþöÙ÷¬_gui';
    $py[106]= '¹õ¹ö¹÷ÙòçµíÞöç_gun';
    $py[107]= '¹ø¹ù¹ú¹û¹ü¹ýÙåÛößÃàþáÆâ£é¤ë½ñøòäòå_guo';
    $py[108]= '¹þîþ_ha';
    $py[109]= 'º¡º¢º£º¤º¥º¦º§àËëÜõ°_hai';
    $py[110]= 'º¨º©ºªº«º¬º­º®º¯º°º±º²º³º´ºµº¶º·º¸º¹ººÚõÝÕÞþå«êÏìÊñüò¥òÀ÷ý_han';
    $py[111]= 'º»º¼º½ãìç¬ñþ_hang';
    $py[112]= 'º¾º¿ºÀºÁºÂºÃºÄºÅºÆÝïÞ¶àÆàãå©å°ê»ð©ò«òº_hao';
    $py[113]= 'ºÇºÈºÉºÊºËºÌºÍºÎºÏºÐºÑºÒºÓºÔºÕºÖº×ºØÚ­ÛÀÛÖàÀãØêÂîÁò¢ôç_he';
    $py[114]= 'ºÙºÚ_hei';
    $py[115]= 'ºÛºÜºÝºÞ_hen';
    $py[116]= 'ºßºàºáºâºãÞ¿çñèì_heng';
    $py[117]= 'ºäºåºæºçºèºéºêºëºìÙäÙêÚ§Ý¦Þ®Þ°ãÈãü_hong';
    $py[118]= 'ºíºîºïºðºñºòºóÜ©ááåËðúóóô×ö×÷¿_hou';
    $py[119]= 'ºôºõºöº÷ºøºùºúºûºüºýºþ»¡»¢»£»¤»¥»¦»§Ùüßüàñá²â©âïã±ä°äïçúéÎéõì²ìÃìÎìæìèìïð­ðÉð×óËõ­õú_hu';
    $py[120]= '»¨»©»ª»«»¬»­»®»¯»°æèèëí¹îü_hua';
    $py[121]= '»±»²»³»´»µõ×_huai';
    $py[122]= '»¶»·»¸»¹»º»»»¼»½»¾»¿»À»Á»Â»ÃÛ¨Û¼ÝÈß§à÷âµä¡ä½äñå¾åÕçÙïÌöé÷ß_huan';
    $py[123]= '»Ä»Å»Æ»Ç»È»É»Ê»Ë»Ì»Í»Î»Ï»Ð»ÑÚòáåäÒäêåØè«ëÁñ¥ó¨óòöü_huang';
    $py[124]= '»Ò»Ó»Ô»Õ»Ö»×»Ø»Ù»Ú»Û»Ü»Ý»Þ»ß»à»á»â»ã»ä»å»æÚ¶ÜîÜöÞ¥ßÔßÜà¹ãÄä§ä«åççÀçõêÍí£ò³ó³÷â_hui';
    $py[125]= '»ç»è»é»ê»ë»ìÚ»âÆãÔäã_hun';
    $py[126]= '»í»î»ï»ð»ñ»ò»ó»ô»õ»öØåÞ½ß«àëâ·îØïÁïìñëó¶_huo';
    $py[127]= '»÷»ø»ù»ú»û»ü»ý»þ¼¡¼¢¼£¼¤¼¥¼¦¼§¼¨¼©¼ª¼«¼¬¼­¼®¼¯¼°¼±¼²¼³¼´¼µ¼¶¼·¼¸¼¹¼º¼»¼¼¼½¼¾¼¿¼À¼Á¼Â¼Ã¼Ä¼Å¼Æ¼Ç¼È¼É¼Ê¼Ë¼Ì¼ÍØ¢Ø½ØÀØÞÙ¥ÙÊÚµÛÔÜ¸ÜÁÜùÝðÞªÞáß´ßÒßâßóá§áÕä©åìæ÷çÜçáé®éêêªê«êéê÷ì´í¶î¿ïúð¢ñ¤ò±óÅóÇôßõÒõÕö«öÝöê÷Ù÷ä_ji';
    $py[128]= '¼Î¼Ï¼Ð¼Ñ¼Ò¼Ó¼Ô¼Õ¼Ö¼×¼Ø¼Ù¼Ú¼Û¼Ü¼Ý¼ÞÛ£Ýçáµä¤åÈçìê©ëÎí¢îòïØðèðýñÊòÌóÕôÂõÊ_jia';
    $py[129]= '¼ß¼à¼á¼â¼ã¼ä¼å¼æ¼ç¼è¼é¼ê¼ë¼ì¼í¼î¼ï¼ð¼ñ¼ò¼ó¼ô¼õ¼ö¼÷¼ø¼ù¼ú¼û¼ü¼ý¼þ½¡½¢½£½¤½¥½¦½§½¨ÙÔÚÉÚÙÝÑÝóÞöàîäÕå¿åÀçÌèÅé¥ê§ê¯êðêùë¦ëìíúïµðÏñÐóÈôåõÂõÝöä÷µ_jian';
    $py[130]= '½©½ª½«½¬½­½®½¯½°½±½²½³½´½µÜüä®ç­çÖêñíäñðôÝôø_jiang';
    $py[131]= '½¶½·½¸½¹½º½»½¼½½½¾½¿½À½Á½Â½Ã½Ä½Å½Æ½Ç½È½É½Ê½Ë½Ì½Í½Î½Ï½Ð½ÑÙ®ÙÕÜ´ÜúÞØàÝá½áèäÐæ¯ë¸ð¨ðÔòÔõ´õÓöÞ_jiao';
    $py[132]= '½Ò½Ó½Ô½Õ½Ö½×½Ø½Ù½Ú½Û½Ü½Ý½Þ½ß½à½á½â½ã½ä½å½æ½ç½è½é½ê½ë½ìÞ×à®àµæ¼æÝèîíÙÚ¦ðÜò¡ò»ôÉöÚ÷º_jie';
    $py[133]= '½í½î½ï½ð½ñ½ò½ó½ô½õ½ö½÷½ø½ù½ú½û½ü½ý½þ¾¡¾¢ÚáÝ£ÝÀàäâËâÛæ¡çÆèªéÈêáêîñÆ_jin';
    $py[134]= '¾£¾¤¾¥¾¦¾§¾¨¾©¾ª¾«¾¬¾­¾®¾¯¾°¾±¾²¾³¾´¾µ¾¶¾·¾¸¾¹¾º¾»ØÙÙÓÚåÝ¼â°ã½ãþåÉåòæºëÂëÖëæìºö¦_jing';
    $py[135]= '¾¼¾½åÄìç_jiong';
    $py[136]= '¾¾¾¿¾À¾Á¾Â¾Ã¾Ä¾Å¾Æ¾Ç¾È¾É¾Ê¾Ë¾Ì¾Í¾ÎÙÖà±ãÎèÑèêð¯ðÕôñ÷Ý_jiu';
    $py[137]= '¾Ï¾Ð¾Ñ¾Ò¾Ó¾Ô¾Õ¾Ö¾×¾Ø¾Ù¾Ú¾Û¾Ü¾Ý¾Þ¾ß¾à¾á¾â¾ã¾ä¾å¾æ¾çÙÆÚªÜÄÜÚÜìÞäåáåðè¢é§é°é·éÙêøì«îÒï¸ñÀñÕôòõ¶õáö´öÂöÄ÷¶_ju';
    $py[138]= '¾è¾é¾ê¾ë¾ì¾í¾îÛ²áúä¸èðîÃïÃïÔöÁ_juan';
    $py[139]= '¾ï¾ð¾ñ¾ò¾ó¾ô¾õ¾ö¾÷¾øØÊØãÚÜÛÇÞ§àÙàåáÈâ±æÞçåèöéÓìßïãõêõû_jue';
    $py[140]= '¾ù¾ú¾û¾ü¾ý¾þ¿¡¿¢¿£¿¤¿¥ÞÜñäóÞ÷å_jun';
    $py[141]= '¿¦¿§¿¨¿©ØûßÇëÌ_ka';
    $py[142]= '¿ª¿«¿¬¿­¿®ØÜÛîÝÜâéâýîøï´ïÇ_kai';
    $py[143]= '¿¯¿°¿±¿²¿³¿´Ù©Ý¨ãÛê¬íèî«_kan';
    $py[144]= '¿µ¿¶¿·¿¸¿¹¿º¿»ØøãÊîÖ_kang';
    $py[145]= '¿¼¿½¿¾¿¿åêèàêûîí_kao';
    $py[146]= '¿À¿Á¿Â¿Ã¿Ä¿Å¿Æ¿Ç¿È¿É¿Ê¿Ë¿Ì¿Í¿Îà¾á³ã¡äÛæìç¼çæéðë´î§îÝï¾ïýðâñ½ò¤òÂòò÷Á_ke';
    $py[147]= '¿Ï¿Ð¿Ñ¿ÒñÌ_ken';
    $py[148]= '¿Ó¿Ôï¬_keng';
    $py[149]= '¿Õ¿Ö¿×¿ØÙÅáÇóí_kong';
    $py[150]= '¿Ù¿Ú¿Û¿ÜÜÒÞ¢ßµíîóØ_kou';
    $py[151]= '¿Ý¿Þ¿ß¿à¿á¿â¿ãØÚÜ¥à·ç«÷¼_ku';
    $py[152]= '¿ä¿å¿æ¿ç¿èÙ¨_kua';
    $py[153]= '¿é¿ê¿ë¿ìØáÛ¦ßàáöëÚ_kuai';
    $py[154]= '¿í¿î÷Å_kuan';
    $py[155]= '¿ï¿ð¿ñ¿ò¿ó¿ô¿õ¿öÚ²Ú¿Ú÷ÛÛÞÅßÑàíæþêÜ_kuang';
    $py[156]= '¿÷¿ø¿ù¿ú¿û¿ü¿ý¿þÀ¡À¢À£Ø¸ØÑÙçÚóÝÞÞñà­à°ã¦ã´åÓêÒî¥ñùòñóñõÍ_kui';
    $py[157]= 'À¤À¥À¦À§ã§ãÍçûï¿õ«öï÷Õ_kun';
    $py[158]= 'À¨À©ÀªÀ«òÒ_kuo';
    $py[159]= 'À¬À­À®À¯À°À±À²ØÝååê¹íÇðø_la';
    $py[160]= 'À³À´ÀµáÁáâäµäþêãêåíùïªñ®ô¥_lai';
    $py[161]= 'À¶À·À¸À¹ÀºÀ»À¼À½À¾À¿ÀÀÀÁÀÂÀÃÀÄá°äíé­ìµî½ïçñÜ_lan';
    $py[162]= 'ÀÅÀÆÀÇÀÈÀÉÀÊÀËÝ¹Ýõà¥ãÏï¶ïüòë_lang';
    $py[163]= 'ÀÌÀÍÀÎÀÏÀÐÀÑÀÒÀÓÀÔßëáÀèáîîï©ðìñìõ²_lao';
    $py[164]= 'ÀÕÀÖØìß·ãî÷¦_le';
    $py[165]= 'À×ÀØÀÙÀÚÀÛÀÜÀÝÀÞÀßÀàÀáÙúÚ³àÏæÐçÐéÛñçõª_lei';
    $py[166]= 'ÀâÀãÀäÜ¨ã¶_leng';
    $py[167]= 'ÀåÀæÀçÀèÀéÀêÀëÀìÀíÀîÀïÀðÀñÀòÀóÀôÀõÀöÀ÷ÀøÀùÀúÀûÀüÀýÀþÁ¡Á¢Á£Á¤Á¥Á¦Á§Á¨Ù³ÙµÛªÛÞÜÂÝ°ÝñÞ¼ß¿à¦à¬áûäàå¢åÎæ²æËæêçÊèÀèÝéöìåíÂîºî¾ï®ð¿ðÝðßòÃòÛó»óÒóöôÏõ·õÈö¨öâ÷¯÷ó_li';
    $py[168]= 'Á©_lia';
    $py[169]= 'ÁªÁ«Á¬Á­Á®Á¯Á°Á±Á²Á³Á´ÁµÁ¶Á·ÝüÞÆäòå¥çöé¬éçì¡ñÍñÏó¹öã_lian';
    $py[170]= 'Á¸Á¹ÁºÁ»Á¼Á½Á¾Á¿ÁÀÁÁÁÂÜ®é£õÔ÷Ë_liang';
    $py[171]= 'ÁÃÁÄÁÅÁÆÁÇÁÈÁÉÁÊÁËÁÌÁÍÁÎÁÏÞ¤ÞÍàÚâ²å¼çÔîÉðÓ_liao';
    $py[172]= 'ÁÐÁÑÁÒÁÓÁÔÙýÛøÞæßÖä£ôóõñ÷à_lie';
    $py[173]= 'ÁÕÁÖÁ×ÁØÁÙÁÚÁÛÁÜÁÝÁÞÁßÝþßøá×âÞãÁåàéÝê¥ì¢î¬ôÔõï÷ë_lin';
    $py[174]= 'ÁàÁáÁâÁãÁäÁåÁæÁçÁèÁéÁêÁëÁìÁíÁîÛ¹ÜßßÊàòãöç±èÚèùê²ñöòÈôáöì_ling';
    $py[175]= 'ÁïÁðÁñÁòÁóÁôÁõÁöÁ÷ÁøÁùä¯åÞæòç¸ì¼ìÖï³ïÖðÒöÌ_liu';
    $py[176]= 'ÁúÁûÁüÁýÁþÂ¡Â¢Â£Â¤ÛâÜ×ãñççèÐëÊíÃñª_long';
    $py[177]= 'Â¥Â¦Â§Â¨Â©ÂªÙÍÝäà¶áÐïÎðüñïò÷÷Ã_lou';
    $py[178]= 'Â«Â¬Â­Â®Â¯Â°Â±Â²Â³Â´ÂµÂ¶Â·Â¸Â¹ÂºÂ»Â¼Â½Â¾Ûäß£ààãòäËäõåÖè´èÓéÖéñéûê¤ëªëÍïåðµðØóüôµöÔ_lu';
    $py[179]= 'ÂÍÂÎÂÏÂÐÂÑÂÒÙõæ®èïð½öÇ_luan';
    $py[180]= 'ÂÕÂÖÂ×ÂØÂÙÂÚÂÛàð_lun';
    $py[181]= 'ÂÜÂÝÂÞÂßÂàÂáÂâÂãÂäÂåÂæÂçÙÀÙùÜýÞûâ¤ãøäðçóé¡ëáïÝñ§öÃ_luo';
    $py[182]= 'Â¿ÂÀÂÁÂÂÂÃÂÄÂÅÂÆÂÇÂÈÂÉÂÊÂËÂÌÞÛãÌéµëöïùñÚ_lu';


    $py[183]= 'ÂÓÂÔï²_lue';
    $py[184]= 'ß¼_m';
    $py[185]= 'ÂèÂéÂêÂëÂìÂíÂîÂïÂðáïè¿ó¡_ma';
    $py[186]= 'ÂñÂòÂóÂôÂõÂöÛ½Ý¤ßéö²_mai';
    $py[187]= 'Â÷ÂøÂùÂúÂûÂüÂýÂþÃ¡Ü¬á£çÏì×ïÜò©òý÷©÷´_man';
    $py[188]= 'Ã¢Ã£Ã¤Ã¥Ã¦Ã§ÚøäÝíËòþ_mang';
    $py[189]= 'Ã¨Ã©ÃªÃ«Ã¬Ã­Ã®Ã¯Ã°Ã±Ã²Ã³ÙóÜâá¹ã÷è£êÄêóë£ì¸í®î¦òúó±÷Ö_mao';
    $py[190]= 'Ã´÷á_me';
    $py[191]= 'ÃµÃ¶Ã·Ã¸Ã¹ÃºÃ»Ã¼Ã½Ã¾Ã¿ÃÀÃÁÃÂÃÃÃÄÝ®áÒâ­ä¼äØé¹ïÑðÌñÇ÷È_mei';
    $py[192]= 'ÃÅÃÆÃÇÞÑìËí¯îÍ_men';
    $py[193]= 'ÃÈÃÉÃÊÃËÃÌÃÍÃÎÃÏÛÂÝùÞ«ãÂëüíæòµòìó·ô»ô¿_meng';
    $py[194]= 'ÃÐÃÑÃÒÃÓÃÔÃÕÃÖÃ×ÃØÃÙÃÚÃÛÃÜÃÝØÂÚ×ÞÂÞÃßäà×â¨ãèåµåôëßìòôÍôé÷ã÷ç_mi';
    $py[195]= 'ÃÞÃßÃàÃáÃâÃãÃäÃåÃæãæäÅäÏëïííö¼_mian';
    $py[196]= 'ÃçÃèÃéÃêÃëÃìÃíÃîß÷åãç¿çÑèÂíµíððÅ_miao';
    $py[197]= 'ÃïÃðØ¿ßãóºóú_mie';
    $py[198]= 'ÃñÃòÃóÃôÃõÃöÜåáºãÉãýçÅçäçëíª÷ª_min';
    $py[199]= 'Ã÷ÃøÃùÃúÃûÃüÚ¤ÜøäéêÔî¨õ¤_ming';
    $py[200]= 'Ãý_miu';
    $py[201]= 'ÃþÄ¡Ä¢Ä£Ä¤Ä¥Ä¦Ä§Ä¨Ä©ÄªÄ«Ä¬Ä­Ä®Ä¯Ä°ÚÓÜÔÝëâÉæÆæÖéâïÒï÷ñ¢ñòõöõø_mo';
    $py[202]= 'Ä±Ä²Ä³Ù°ßèíøòÖöÊ_mou';
    $py[203]= 'Ä´ÄµÄ¶Ä·Ä¸Ä¹ÄºÄ»Ä¼Ä½Ä¾Ä¿ÄÀÄÁÄÂØïÛéÜÙãåë¤îâ_mu';
    $py[204]= 'àÅ_n';
    $py[205]= 'ÄÃÄÄÄÅÄÆÄÇÄÈÄÉÞàëÇïÕñÄ_na';
    $py[206]= 'ÄÊÄËÄÌÄÍÄÎØ¾ÜµÝÁèÍ_nai';
    $py[207]= 'ÄÏÄÐÄÑà«àïéªëîòïôö_nan';
    $py[208]= 'ÄÒß­àìâÎêÙ_nang';
    $py[209]= 'ÄÓÄÔÄÕÄÖÄ×Ø«ÛñßÎâ®è§íÐîóòÍ_nao';
    $py[210]= 'ÄØÚ«_ne';
    $py[211]= 'ÄÙÄÚ_nei';
    $py[212]= 'ÄÛí¥_nen';
    $py[213]= 'ÄÜ_neng';
    $py[214]= 'ÄÝÄÞÄßÄàÄáÄâÄãÄäÄåÄæÄçÙ£Ûèâ¥âõêÇì»íþîêöò_ni';
    $py[215]= 'ÄèÄéÄêÄëÄìÄíÄîØ¥Ûþéýð¤öÓöó_nian';
    $py[216]= 'ÄïÄð_niang';
    $py[217]= 'ÄñÄòÜàæÕëåôÁ_niao';
    $py[218]= 'ÄóÄôÄõÄöÄ÷ÄøÄùÚíÞÁà¿ò¨ô«õæ_nie';
    $py[219]= 'Äú_nin';
    $py[220]= 'ÄûÄüÄýÄþÅ¡Å¢ØúßÌå¸ñ÷_ning';
    $py[221]= 'Å£Å¤Å¥Å¦áðâîæ¤_niu';
    $py[222]= 'Å§Å¨Å©ÅªÙ¯ßæ_nong';
    $py[223]= 'ññ_nou';
    $py[224]= 'Å«Å¬Å­åóæÀæÛæå_nu';
    $py[225]= 'Å¯_nuan';
    $py[226]= 'Å²Å³Å´ÅµÙÐÞùßöï»_nuo';
    $py[227]= 'Å®í¤îÏô¬_nu';
    $py[228]= 'Å°Å±_nue';
    $py[229]= 'Å¶àÞ_o';
    $py[230]= 'Å·Å¸Å¹ÅºÅ»Å¼Å½Ú©âæê±ñî_ou';
    $py[231]= 'Å¾Å¿ÅÀÅÁÅÂÅÃÝâèËóá_pa';
    $py[232]= 'ÅÄÅÅÅÆÅÇÅÈÅÉÙ½Ýåßß_pai';
    $py[233]= 'ÅÊÅËÅÌÅÍÅÎÅÏÅÐÅÑÞÕãÝãúñÈñáó´õç_pan';
    $py[234]= 'ÅÒÅÓÅÔÅÕÅÖäèåÌó¦_pang';
    $py[235]= 'Å×ÅØÅÙÅÚÅÛÅÜÅÝÞËáóâÒëãðå_pao';
    $py[236]= 'ÅÞÅßÅàÅáÅâÅãÅäÅåÅæàÎàúì·ïÂõ¬ö¬_pei';
    $py[237]= 'ÅçÅèäÔ_pen';
    $py[238]= 'ÅéÅêÅëÅìÅíÅîÅïÅðÅñÅòÅóÅôÅõÅöÜ¡àØâñó²_peng';
    $py[239]= 'Å÷ÅøÅùÅúÅûÅüÅýÅþÆ¡Æ¢Æ£Æ¤Æ¥Æ¦Æ§Æ¨Æ©Ø§ØòÚðÚüÛ¯ÛÜÛýÜ±ÜÅß¨àèâÏäÄæÇç¢èÁê¶î¢î¼îëñ±ò·òçõù_pi';
    $py[240]= 'ÆªÆ«Æ¬Æ­ÚÒæéêúëÝôæõä_pian';
    $py[241]= 'Æ®Æ¯Æ°Æ±ØâàÑæÎçÎéèî©óª_piao';
    $py[242]= 'Æ²Æ³ÜÖë­_pie';
    $py[243]= 'Æ´ÆµÆ¶Æ·Æ¸æ°æÉé¯êòò­ò®_pin';
    $py[244]= 'Æ¹ÆºÆ»Æ¼Æ½Æ¾Æ¿ÆÀÆÁÙ·æ³èÒöÒ_ping';
    $py[245]= 'ÆÂÆÃÆÄÆÅÆÆÆÇÆÈÆÉØÏÛ¶çêê·îÇîÞð«óÍ_po';
    $py[246]= 'ÆÊÙöÞå_pou';
    $py[247]= 'ÆËÆÌÆÍÆÎÆÏÆÐÆÑÆÒÆÓÆÔÆÕÆÖÆ×ÆØÆÙÙéàÛäßå§è±ë«ïäïèõë_pu';
    $py[248]= 'ÆÚÆÛÆÜÆÝÆÞÆßÆàÆáÆâÆãÆäÆåÆæÆçÆèÆéÆêÆëÆìÆíÆîÆïÆðÆñÆòÆóÆôÆõÆöÆ÷ÆøÆùÆúÆûÆüÆýØÁÙ¹ÛßÜ»ÜÎÝ½ÝÂÝÝÞ­àÒá¨áªãàä¿æëç²ç÷çùè½èçéÊêÈì¥ì÷í¬íÓñýòÓòàôëôìõè÷¢÷è†¢_qi';
    $py[249]= 'ÆþÇ¡Ç¢ÝÖ÷Ä_qia';
    $py[250]= 'Ç£Ç¤Ç¥Ç¦Ç§Ç¨Ç©ÇªÇ«Ç¬Ç­Ç®Ç¯Ç°Ç±Ç²Ç³Ç´ÇµÇ¶Ç·Ç¸Ù»ÙÝÚäÜ·ÜÍÜçÝ¡Þçá©ã¥ã»å¹åºå½ç×èýëÉí©îÔóé÷Ü_qian';
    $py[251]= 'Ç¹ÇºÇ»Ç¼Ç½Ç¾Ç¿ÇÀãÞæÍéÉê¨ìÁïºïÏïêñßòÞôÇõÄ_qiang';
    $py[252]= 'ÇÁÇÂÇÃÇÄÇÅÇÆÇÇÇÈÇÉÇÊÇËÇÌÇÍÇÎÇÏØäÚ½ÚÛÜñã¸ã¾çØéÔíÍõÎ÷³_qiao';
    $py[253]= 'ÇÐÇÑÇÒÇÓÇÔÛ§ã«æªêüïÆóæ_qie';
    $py[254]= 'ÇÕÇÖÇ×ÇØÇÙÇÚÇÛÇÜÇÝÇÞÇßÜËÞìßÄàºàßäÚéÕï·ñûòûôÀ_qin';
    $py[255]= 'ÇàÇáÇâÇãÇäÇåÇæÇçÇèÇéÇêÇëÇìÜÜàõéÑíàòßóÀóäö¥öë÷ô_qing';
    $py[256]= 'ÇíÇîÚöÜäñ·òËõ¼öÆ_qiong';
    $py[257]= 'ÇïÇðÇñÇòÇóÇôÇõÇöÙ´ÛÏáìåÏåÙé±êäò°òÇòøôÃôÜöú÷ü_qiu';
    $py[258]= 'Ç÷ÇøÇùÇúÇûÇüÇýÇþÈ¡È¢È£È¤È¥Ú°Û¾Þ¡Þ¾á«áéãÖè³êïë¬ëÔìîíáð¶ñ³òÐó½ôð÷ñ_qu';
    $py[259]= 'È¦È§È¨È©ÈªÈ«È¬È­È®È¯È°Ú¹Üõãªç¹éúî°îýòéóÜ_quan';
    $py[260]= 'È±È²È³È´ÈµÈ¶È·È¸ã×ãÚí¨_que';
    $py[261]= 'È¹ÈºåÒ_qun';
    $py[262]= 'È»È¼È½È¾ÜÛòÅ÷×_ran';
    $py[263]= 'È¿ÈÀÈÁÈÂÈÃìüð¦_rang';
    $py[264]= 'ÈÄÈÅÈÆÜéæ¬èã_rao';
    $py[265]= 'ÈÇÈÈ_re';
    $py[266]= 'ÈÉÈÊÈËÈÌÈÍÈÎÈÏÈÐÈÑÈÒØðÜóÝØâ¿éíïþñÅ_ren';
    $py[267]= 'ÈÓÈÔ_reng';
    $py[268]= 'ÈÕ_ri';
    $py[269]= 'ÈÖÈ×ÈØÈÙÈÚÈÛÈÜÈÝÈÞÈßáÉáõéÅëÀòî_rong';
    $py[270]= 'ÈàÈáÈâôÛõå÷·_rou';
    $py[271]= 'ÈãÈäÅ³ÈæÈçÈèÈéÈêÈëÈìÝêÞ¸àéä²äáå¦çÈï¨ñàò¬_ru';
    $py[272]= 'ÈíÈîëÃ_ruan';
    $py[273]= 'ÈïÈðÈñÜÇÞ¨èÄî£ò¸_rui';
    $py[274]= 'ÈòÈó_run';
    $py[275]= 'ÈôÈõÙ¼óè_ruo';
    $py[276]= 'ÈöÈ÷ÈøØ¦ØíêýëÛìª_sa';
    $py[277]= 'ÈùÈúÈûÈüàç_sai';
    $py[278]= 'ÈýÈþÉ¡É¢âÌë§ôÖ_san';
    $py[279]= 'É£É¤É¥Þúíßòª_sang';
    $py[280]= 'É¦É§É¨É©Ü£çÒëýðþöþ_sao';
    $py[281]= 'ÉªÉ«É¬ØÄï¤ð£_se';
    $py[282]= 'É­_sen';
    $py[283]= 'É®_seng';
    $py[284]= 'É¯É°É±É²É³É´ÉµÉ¶É·ßþì¦ï¡ððôÄö®öè_sha';
    $py[285]= 'É¸É¹õ§_shai';
    $py[286]= 'ÉºÉ»É¼É½É¾É¿ÉÀÉÁÉÂÉÃÉÄÉÅÉÆÉÇÉÈÉÉÚ¨Û·ÛïÜÏäúæ©æÓæóëþîÌðÞóµô®õÇ÷­_shan';
    $py[287]= 'ÉÊÉËÉÌÉÍÉÎÉÏÉÐÉÑÛðç´éäìØõü_shang';
    $py[288]= 'ÉÒÉÓÉÔÉÕÉÖÉ×ÉØÉÙÉÚÉÛÉÜÛ¿ÜæäûòÙóâô¹_shao';
    $py[289]= 'ÉÝÉÞÉßÉàÉáÉâÉãÉäÉåÉæÉçÉèØÇÙÜâ¦äÜì¨î´÷ê_she';
    $py[290]= 'ÉéÉêÉëÉìÉíÉîÉïÉðÉñÉòÉóÉôÉõÉöÉ÷ÉøÚ·ÚÅÝ·ßÓäÉé©ëÏïòò×_shen';
    $py[291]= 'ÉùÉúÉûÉüÉýÉþÊ¡Ê¢Ê£Ê¤Ê¥áÓêÉíòóÏ_sheng';
    $py[292]= 'Ê¦Ê§Ê¨Ê©ÊªÊ«Ê¬Ê­Ê®Ê¯Ê°Ê±Ê²Ê³Ê´ÊµÊ¶Ê·Ê¸Ê¹ÊºÊ»Ê¼Ê½Ê¾Ê¿ÊÀÊÁÊÂÊÃÊÄÊÅÊÆÊÇÊÈÊÉÊÊÊËÊÌÊÍÊÎÊÏÊÐÊÑÊÒÊÓÊÔÚÖÛõÝªÝéß±éøêÛìÂîæó§óÂóßõ¹öåöõ_shi';
    $py[293]= 'ÊÕÊÖÊ×ÊØÊÙÊÚÊÛÊÜÊÝÊÞá÷ç·ô¼_shou';
    $py[294]= 'ÊßÊàÊáÊâÊãÊäÊåÊæÊçÊèÊéÊêÊëÊìÊíÊîÊïÊðÊñÊòÊóÊôÊõÊöÊ÷ÊøÊùÊúÊûÊüÊýÊþË¡Ù¿ÛÓÝÄÞóãðäøæ­ç£ë¨ëòì¯ïø_shu';
    $py[295]= 'Ë¢Ë£à§_shua';
    $py[296]= 'Ë¤Ë¥Ë¦Ë§ó°_shuai';
    $py[297]= 'Ë¨Ë©ãÅäÌ_shuan';
    $py[298]= 'ËªË«Ë¬æ×_shuang';
    $py[299]= 'Ë­Ë®Ë¯Ë°_shui';
    $py[300]= 'Ë±Ë²Ë³Ë´_shun';
    $py[301]= 'ËµË¶Ë·Ë¸ÝôÞ÷åùéÃîå_shuo';
    $py[302]= 'Ë¹ËºË»Ë¼Ë½Ë¾Ë¿ËÀËÁËÂËÃËÄËÅËÆËÇËÈØËÙîÛÌßÐãáãôäùæ¦æáçÁìëïÈð¸ñêòÏóÓ_si';
    $py[303]= 'ËÉËÊËËËÌËÍËÎËÏËÐÚ¡Ý¿áÂáÔâìã¤äÁñµ_song';
    $py[304]= 'ËÑËÒËÓËÔÛÅÞ´à²àÕâÈäÑì¬î¤ïËòô_sou';
    $py[305]= 'ËÕËÖË×ËØËÙËÚËÛËÜËÝËÞËßËàÙíÚÕÝøà¼ãºä³óùö¢öÕ_su';
    $py[306]= 'ËáËâËãâ¡_suan';
    $py[307]= 'ËäËåËæËçËèËéËêËëËìËíËîÚÇÝ´å¡åäìÝíõî¡_sui';
    $py[308]= 'ËïËðËñÝ¥áøâ¸é¾öÀ_sun';
    $py[309]= 'ËòËóËôËõËöË÷ËøËùßïàÂàÊæ¶èøíüôÈ_suo';
    $py[310]= 'ËúËûËüËýËþÌ¡Ì¢Ì£Ì¤ãËäâåÝé½îèõÁ÷£_ta';
    $py[311]= 'Ì¥Ì¦Ì§Ì¨Ì©ÌªÌ«Ì¬Ì­Û¢Þ·ëÄìÆîÑõÌöØ_tai';
    $py[312]= 'Ì®Ì¯Ì°Ì±Ì²Ì³Ì´ÌµÌ¶Ì·Ì¸Ì¹ÌºÌ»Ì¼Ì½Ì¾Ì¿Û°ê¼ìþîãïÄ_tan';
    $py[313]= 'ÌÀÌÁÌÂÌÃÌÄÌÅÌÆÌÇÌÈÌÉÌÊÌËÌÌÙÎàûâ¼äçè©éÌï¦ïÛñíó¥ó«ôÊõ±_tang';
    $py[314]= 'ÌÍÌÎÌÏÌÐÌÑÌÒÌÓÌÔÌÕÌÖÌ×Ø»ßûä¬èº÷Ò_tao';
    $py[315]= 'ÌØß¯ìýí«ï«_te';
    $py[316]= 'ÌÙÌÚÌÛÌÜëø_teng';
    $py[317]= 'ÌÝÌÞÌßÌàÌáÌâÌãÌäÌåÌæÌçÌèÌéÌêÌëÙÃÜèã©åÑç°ç¾ðÃñÓõ®_ti';
    $py[318]= 'ÌìÌíÌîÌïÌðÌñÌòÌóÞÝãÃãÙéåî±_tian';
    $py[319]= 'ÌôÌõÌöÌ÷ÌøÙ¬ìöñ»òèóÔôÐö¶öæ÷Ø_tiao';
    $py[320]= 'ÌùÌúÌûÝÆ÷Ñ_tie';
    $py[321]= 'ÌüÌýÌþÍ¡Í¢Í£Í¤Í¥Í¦Í§ÜðÝãæÃèèòÑöª_ting';
    $py[322]= 'Í¨Í©ÍªÍ«Í¬Í­Í®Í¯Í°Í±Í²Í³Í´Ù¡ÙÚÜíàÌâúäüíÅ_tong';
    $py[323]= 'ÍµÍ¶Í·Í¸î×÷»_tou';
    $py[324]= 'Í¹ÍºÍ»Í¼Í½Í¾Í¿ÍÀÍÁÍÂÍÃÜ¢Ý±ÝËîÊõ©_tu';
    $py[325]= 'ÍÄÍÅÞÒåèî¶_tuan';
    $py[326]= 'ÍÆÍÇÍÈÍÉÍÊÍËìÕ_tui';
    $py[327]= 'ÍÌÍÍÍÎÙÛâ½êÕëà_tun';
    $py[328]= 'ÍÏÍÐÍÑÍÒÍÓÍÔÍÕÍÖÍ×ÍØÍÙØ±Ù¢ÛçâÕãûèØéÒíÈóêõ¢õÉö¾_tuo';
    $py[329]= 'ÍÚÍÛÍÜÍÝÍÞÍßÍàØôæ´ëð_wa';
    $py[330]= 'ÍáÍâáË_wai';
    $py[331]= 'ÍãÍäÍåÍæÍçÍèÍéÍêÍëÍìÍíÍîÍïÍðÍñÍòÍóØàÜ¹ÝÒæýçºçþëäîµòê_wan';
    $py[332]= 'ÍôÍõÍöÍ÷ÍøÍùÍúÍûÍüÍýØèã¯éþ÷Í_wang';
    $py[333]= 'ÍþÎ¡Î¢Î£Î¤Î¥Î¦Î§Î¨Î©ÎªÎ«Î¬Î­Î®Î¯Î°Î±Î²Î³Î´ÎµÎ¶Î·Î¸Î¹ÎºÎ»Î¼Î½Î¾Î¿ÎÀÙËÚÃÚñÛ×ÝÚÞ±àøá¡áÍâ«â¬ãÇãíä¢ä¶åÔæ¸çâè¸ê¦ì¿ìÐðôôºöÛ_wei';
    $py[334]= 'ÎÁÎÂÎÃÎÄÎÅÎÆÎÇÎÈÎÉÎÊØØãÓãëè·ö©_wen';
    $py[335]= 'ÎËÎÌÎÍÝîÞ³_weng';
    $py[336]= 'ÎÎÎÏÎÐÎÑÎÒÎÓÎÔÎÕÎÖÙÁÝ«à¸á¢ä×ë¿íÒö»_wo';
    $py[337]= 'Î×ÎØÎÙÎÚÎÛÎÜÎÝÎÞÎßÎàÎáÎâÎãÎäÎåÎæÎçÎèÎéÎêÎëÎìÎíÎîÎïÎðÎñÎòÎóØ£ØõÚãÚùÛØÜÌßíâÐâäâèä´å»åÃåüæÄæðè»êõì¶ìÉðÄðÍðíòÚöÈ÷ù_wu';
    $py[338]= 'ÎôÎõÎöÎ÷ÎøÎùÎúÎûÎüÎýÎþÏ¡Ï¢Ï£Ï¤Ï¥Ï¦Ï§Ï¨Ï©ÏªÏ«Ï¬Ï­Ï®Ï¯Ï°Ï±Ï²Ï³Ï´ÏµÏ¶Ï·Ï¸ÙÒÙâÚôÛ­Ý¾ÝßÝûÞÉßñáãâ¾ãÒä»äÀåïæÒçôéØêØêêì¤ìäìùìûðªñ¶òáó£ó¬ôªô¸ôËôÑôâõµ÷û_xi';
    $py[339]= 'Ï¹ÏºÏ»Ï¼Ï½Ï¾Ï¿ÏÀÏÁÏÂÏÃÏÄÏÅßÈáòåÚè¦èÔíÌóÁ÷ï_xia';
    $py[340]= 'ÏÆÏÇÏÈÏÉÏÊÏËÏÌÏÍÏÎÏÏÏÐÏÑÏÒÏÓÏÔÏÕÏÖÏ×ÏØÏÙÏÚÏÛÏÜÏÝÏÞÏßÙþÜÈÝ²Þºá­áýåßæµë¯ìÞììðÂðïò¹óÚôÌõ£õÐõÑö±_xian';
    $py[341]= 'ÏàÏáÏâÏãÏäÏåÏæÏçÏèÏéÏêÏëÏìÏíÏîÏïÏðÏñÏòÏóÜ¼ÝÙâÃâÔæøç½ó­öß÷Ï_xiang';
    $py[342]= 'ÏôÏõÏöÏ÷ÏøÏùÏúÏûÏüÏýÏþÐ¡Ð¢Ð£Ð¤Ð¥Ð¦Ð§ßØáÅäìåÐæçç¯èÉèÕóãóï÷Ì_xiao';
    $py[343]= 'Ð¨Ð©ÐªÐ«Ð¬Ð­Ð®Ð¯Ð°Ð±Ð²Ð³Ð´ÐµÐ¶Ð·Ð¸Ð¹ÐºÐ»Ð¼ÙÉÙôÛÄÛÆÞ¯ß¢â³âÝäÍå¬åâç¥çÓé¿éÇõó_xie';
    $py[344]= 'Ð½Ð¾Ð¿ÐÀÐÁÐÂÐÃÐÄÐÅÐÆØ¶Ü°ê¿ì§öÎ_xin';
    $py[345]= 'ÐÇÐÈÐÉÐÊÐËÐÌÐÍÐÎÐÏÐÐÐÑÐÒÐÓÐÔÐÕÚêÜôÜþß©ã¬íÊ_xing';
    $py[346]= 'ÐÖÐ×ÐØÐÙÐÚÐÛÐÜÜº_xiong';
    $py[347]= 'ÐÝÐÞÐßÐàÐáÐâÐãÐäÐåßÝá¶âÊâÓäåð¼õ÷÷Û_xiu';
    $py[348]= 'ÐæÐçÐèÐéÐêÐëÐìÐíÐîÐïÐðÐñÐòÐóÐôÐõÐöÐ÷ÐøÚ¼ÛÃÞ£äªäÓçïèòìãñãôÚõ¯_xu';
    $py[349]= 'ÐùÐúÐûÐüÐýÐþÑ¡Ñ¢Ñ£Ñ¤ÙØÚÎÝæÞïãùäÖäöè¯é¸êÑìÅìÓíÛîçïàðç_xuan';
    $py[350]= 'Ñ¥Ñ¦Ñ§Ñ¨Ñ©ÑªÚÊí´õ½÷¨_xue';
    $py[351]= 'Ñ«Ñ¬Ñ­Ñ®Ñ¯Ñ°Ñ±Ñ²Ñ³Ñ´ÑµÑ¶Ñ·Ñ¸ÙãÛ÷Ü÷Þ¦Þ¹á¾áßâ´âþä­ä±êÖñ¿õ¸öà_xun';
    $py[352]= 'Ñ¹ÑºÑ»Ñ¼Ñ½Ñ¾Ñ¿ÑÀÑÁÑÂÑÃÑÄÑÅÑÆÑÇÑÈØóÛëÞëá¬åÂæ«çðèâë²í¼íýðéñâ_ya';
    $py[353]= 'ÑÉÑÊÑËÑÌÑÍÑÎÑÏÑÐÑÑÑÒÑÓÑÔÑÕÑÖÑ×ÑØÑÙÑÚÑÛÑÜÑÝÑÞÑßÑàÑáÑâÑãÑäÑåÑæÑçÑèÑéØÉØÍØßÙ²ÙÈÙðÚÝÛ±Û³Ü¾ÝÎáÃâûãÆäÎäÙåûæÌçüéÜêÌëÙìÍî»óÛõ¦÷Ê÷Ð÷ú_yan';
    $py[354]= 'ÑêÑëÑìÑíÑîÑïÑðÑñÑòÑóÑôÑõÑöÑ÷ÑøÑùÑúáàâóãóì¾ìÈí¦òÕ÷±_yang';
    $py[355]= 'ÑûÑüÑýÑþÒ¡Ò¢Ò£Ò¤Ò¥Ò¦Ò§Ò¨Ò©ÒªÒ«Ø²Ø³ßºáÊáæçÛçòèÃé÷ê×ëÈðÎñºôí÷¥_yao';
    $py[356]= 'Ò¬Ò­Ò®Ò¯Ò°Ò±Ò²Ò³Ò´ÒµÒ¶Ò·Ò¸Ò¹ÒºØÌÚËÚþÞÞêÊìÇîô_ye';
    $py[357]= 'Ò»Ò¼Ò½Ò¾Ò¿ÒÀÒÁÒÂÒÃÒÄÒÅÒÆÒÇÒÈÒÉÒÊÒËÒÌÒÍÒÎÒÏÒÐÒÑÒÒÒÓÒÔÒÕÒÖÒ×ÒØÒÙÒÚÒÛÒÜÒÝÒÞÒßÒàÒáÒâÒãÒäÒåÒæÒçÒèÒéÒêÒëÒìÒíÒîÒïØ×ØæØýÙ«Ú±ÛÝÛüÜ²ÜÓÞ²ÞÄÞÈÞÚß®ß½ß×ßÞàæá»áÚâ¢âÂâøâùã¨äôåÆæäçËéìéóêÝì½ìÚîÆï×ïîðêðùñ¯ñ´òæô¯ôàôèôý÷ð_yi';
    $py[358]= 'ÒðÒñÒòÒóÒôÒõÒöÒ÷ÒøÒùÒúÒûÒüÒýÒþÓ¡Ø·Û´ÛóÜ§ÜáßÅà³áþâ¹ä¦ë³î÷ñ«ò¾ö¯ö¸_yin';
    $py[359]= 'Ó¢Ó£Ó¤Ó¥Ó¦Ó§Ó¨Ó©ÓªÓ«Ó¬Ó­Ó®Ó¯Ó°Ó±Ó²Ó³ÙøÛ«ÜãÝºÝÓÝöÞüàÓâßäÞäëå­çøè¬éºëôðÐñ¨ò£ó¿_ying';
    $py[360]= 'Ó´à¡_yo';
    $py[361]= 'ÓµÓ¶Ó·Ó¸Ó¹ÓºÓ»Ó¼Ó½Ó¾Ó¿ÓÀÓÁÓÂÓÃÙ¸ÛÕÜ­à¯ã¼çßïÞð®÷«÷Ó_yong';
    $py[362]= 'ÓÄÓÅÓÆÓÇÓÈÓÉÓÊÓËÓÌÓÍÓÎÓÏÓÐÓÑÓÒÓÓÓÔÓÕÓÖÓ×ØÕØüÙ§Ý¬Ý¯ÝµÞÌßÏàóå¶èÖéàë»îððàòÄòÊòööÏ÷î÷ø_you';
    $py[363]= 'ÓØÓÙÓÚÓÛÓÜÓÝÓÞÓßÓàÓáÓâÓãÓäÓåÓæÓçÓèÓéÓêÓëÓìÓíÓîÓïÓðÓñÓòÓóÓôÓõÓöÓ÷ÓøÓùÓúÓûÓüÓýÓþÔ¡Ô¢Ô£Ô¤Ô¥Ô¦Ø®Ø¹ØñÙ¶ÚÄÚÍÝÇÝ÷ÞíàôàöáÎáüâÀâÅâ×ãÐå÷åýæ¥æúè¤êÅêìëéì£ìÏìÙìÛí²îÚðÁðÖðõðöñ¾ñÁòâòõóÄô§ô¨ö§ö¹_yu';
    $py[364]= 'Ô§Ô¨Ô©ÔªÔ«Ô¬Ô­Ô®Ô¯Ô°Ô±Ô²Ô³Ô´ÔµÔ¶Ô·Ô¸Ô¹ÔºÛùÜ«ÞòãäæÂè¥éÚë¼íóð°ó¢óîö½_yuan';
    $py[365]= 'Ô»Ô¼Ô½Ô¾Ô¿ÔÀÔÁÔÂÔÃÔÄÙßå®éÐë¾îá_yue';
    $py[366]= 'ÔÅÔÆÔÇÔÈÔÉÔÊÔËÔÌÔÍÔÎÔÏÔÐÛ©Ü¿áñã¢ã³ç¡è¹éæêÀëµ_yun';
    $py[367]= 'ÔÑÔÒÔÓÞÙßÆ_za';
    $py[368]= 'ÔÔÔÕÔÖÔ×ÔØÔÙÔÚáÌçÞ_zai';
    $py[369]= 'ÔÛÔÜÔÝÔÞè¶êÃô¢ôØôõöÉ_zan';
    $py[370]= 'ÔßÔàÔáÞÊæàê°_zang';
    $py[371]= 'ÔâÔãÔäÔåÔæÔçÔèÔéÔêÔëÔìÔíÔîÔïßð_zao';
    $py[372]= 'ÔðÔñÔòÔóØÆØÓßõàýåÅê¾óÐóåô·_ze';
    $py[373]= 'Ôô_zei';
    $py[374]= 'ÔõÚÚ_zen';
    $py[375]= 'ÔöÔ÷ÔøÔù×ÛçÕêµîÀï­_zeng';
    $py[376]= 'ÔúÔûÔüÔýÔþÕ¡Õ¢Õ£Õ¤Õ¥Õ¦Õ§Õ¨Õ©Þêß¸ßåßîíÄðäòÆ÷þ_zha';
    $py[377]= 'ÕªµÔÕ«Õ¬Õ­Õ®Õ¯íÎñ©_zhai';
    $py[378]= 'Õ°Õ±Õ²Õ³Õ´ÕµÕ¶Õ·Õ¸Õ¹ÕºÕ»Õ¼Õ½Õ¾Õ¿ÕÀÚÞÞøì¹_zhan';
    $py[379]= 'ÕÁÕÂÕÃÕÄÕÅÕÆÕÇÕÈÕÉÕÊÕËÕÌÕÍÕÎÕÏØëÛµá¤áÖâ¯æÑè°ó¯_zhang';
    $py[380]= 'ÕÐÕÑÕÒÕÓÕÔÕÕÕÖÕ×ÕØÕÙÚ¯ßúèþîÈóÉ_zhao';
    $py[381]= 'ÕÚÕÛÕÜÕÝÕÞÕßÕàÕáÕâÕãÚØß¡èÏéüíÝðÑñÞòØô÷_zhe';
    $py[382]= 'ÕäÕåÕæÕçÕèÕéÕêÕëÕìÕíÕîÕïÕðÕñÕòÕóÛÚÝèä¥çÇèåé»éôêâëÓëÞìõî³ð¡ð²óð_zhen';
    $py[383]= 'ÕôÕõÕöÕ÷ÕøÕùÕúÕûÕüÕýÕþÖ¡Ö¢Ö£Ö¤Úºá¿áçîÛï£óÝ_zheng';
    $py[384]= 'Ö¥Ö¦Ö§Ö¨Ö©ÖªÖ«Ö¬Ö­Ö®Ö¯Ö°Ö±Ö²Ö³Ö´ÖµÖ¶Ö·Ö¸Ö¹ÖºÖ»Ö¼Ö½Ö¾Ö¿ÖÀÖÁÖÂÖÃÖÄÖÅÖÆÖÇÖÈÖÉÖÊÖËÖÌÖÍÖÎÖÏØ´ÚìÛ¤ÛúÜÆÞýàùâååéåëæïèÎè×èÙèäéòéùêÞëÕëùìíìóíéïôðºðëòÎôêõ¥õÅõÙõÜõôö£_zhi';
    $py[385]= 'ÖÐÖÑÖÒÖÓÖÔÖÕÖÖÖ×ÖØÖÙÖÚÚ£ïñó®ô±õà_zhong';
    $py[386]= 'ÖÛÖÜÖÝÖÞÖßÖàÖáÖâÖãÖäÖåÖæÖçÖèÝ§æ¨æûç§ëÐíØô¦ôü_zhou';
    $py[387]= 'ÖéÖêÖëÖìÖíÖîÖïÖðÖñÖòÖóÖôÖõÖöÖ÷ÖøÖùÖúÖûÖüÖýÖþ×¡×¢×£×¤ØùÙªÛ¥ÜÑÜïä¨ä¾äóèÌéÆéÍìÄîùðæðñóÃóçô¶ôãõî÷æ_zhu';
    $py[388]= '×¥×¦_zhua';
    $py[389]= '×§_zhuai';
    $py[390]= '×¨×©×ª×«×¬×­ßùâÍò§_zhuan';
    $py[391]= '×®×¯×°×±×²×³×´Ù×_zhuang';
    $py[392]= '×µ×¶×·×¸×¹×ºã·æíçÄ_zhui';
    $py[393]= '×»×¼ëÆñ¸_zhun';
    $py[394]= '×½×¾×¿×À×Á×Â×Ã×Ä×Å×Æ×ÇÙ¾ÚÂßªä·äÃåªìúí½ïí_zhuo';
    $py[395]= '×È×É×Ê×Ë×Ì×Í×Î×Ï×Ð×Ñ×Ò×Ó×Ô×Õ×ÖÚÑáÑæ¢æÜç»è÷ê¢êßí§íöïÅïöñèóÊôÒôôõþö¤ö·öö÷Ú_zi';
    $py[396]= '×××Ø×Ù×Ú×Û×Ü×ÝÙÌëêôÕ_zong';
    $py[397]= '×Þ×ß×à×áÚÁÚîÛ¸æãöí_zou';
    $py[398]= '×â×ã×ä×å×æ×ç×è×éÙÞÝÏïß_zu';
    $py[399]= '×ê×ëß¬çÚõò_zuan';
    $py[400]= '×ì×í×î×ïÞ©_zui';
    $py[401]= '×ð×ñß¤é×÷®_zun';
    $py[402]= '×ò×ó×ô×õ×ö×÷×ø×ùÚèßòâôëÑìñ_zuo';

    if( $sType== 'Æ´Òô' ){
        for( $i= 1 ; $i<= len($content); $i++){
            $s= mid($content, $i, 1);
            if( inStr('0123456789_abcdefghijklmnopqrstuvwxyz', $s)== false ){
                for( $j= 0 ; $j<= uBound($py); $j++){
                    if( inStr($py[$j], $s) > 0 ){
                        $en= mid($py[$j], inStrRev($py[$j], '_') + 1,-1);
                        $en= uCase(left($en, 1)) . right($en, len($en) - 1);
                        $s= $en;
                        break;
                    }
                }
            }
            $c= $c . $s;
        }
        $pinYin= $c;
        return @$pinYin;
    }

    if( inStr('|ºº×Ö|ºº×Ö´òÓ¡|', '|' . $sType . '|') > 0 ){
        $content= lCase($content) . ' '; //²»¼Ó¸ö¿Õ¸ñ£¬×îºóÒ»¸ö×Ö×ª»»²»ÁË£¬¹Ö
        $splStr= aspSplit($content, ' ');
        foreach( $splStr as $key=>$s){
            if( $s <> '' ){
                for( $j= 0 ; $j<= uBound($py); $j++){
                    if( inStr($py[$j], '_' . $s) > 0 ){
                        $s= mid($py[$j], 1, 1);
                        break;
                    }
                }
            }
            $c= $c . $s;
        }
        if( $sType== 'ºº×Ö´òÓ¡' ){ aspEcho('Æ´Òô×ªºº×Ö', $c) ;}
        $pinYin= $c;
    }else{
        for( $i= 1 ; $i<= len($content); $i++){
            $s= lCase(mid($content, $i, 1)) ; $En2= '' ; $En3= $s;
            if( inStr('0123456789_abcdefghijklmnopqrstuvwxyz', $s)== false ){
                for( $j= 0 ; $j<= uBound($py); $j++){
                    if( inStr($py[$j], $s) > 0 ){
                        $en= mid($py[$j], inStrRev($py[$j], '_') + 1,-1);
                        $En2= uCase(left($en, 1)) . ' ';
                        $En3= uCase(left($en, 1)) . right($en, len($en) - 1);
                        $En4= $En3 . ' '; //¼Ó¿Õ¸ñ
                        $s= $en . ' ';
                        break;
                    }
                }
            }
            $c= $c . $s;
            $c2= $c2 . $En2;
            $C3= $C3 . $En3;
            $C4= $C4 . $En4;
        }

        if( $sType== '1' ){
            $pinYin= $c;
        }else if( $sType== '2' ){
            $pinYin= $c2;
        }else if( $sType== '3' ){
            $C3= uCase(left($C3, 1)) . mid($C3, 2,-1); //Ê××ÖÄ¸´óÐ´
            $pinYin= $C3;
        }else if( $sType== '4' ){
            $pinYin= $C4;
        }else{
            aspEcho('×ª»»×Ö·û', $content);
            aspEcho('Æ´ÒôÐ¡Ð´', aspTrim($c));
            aspEcho('Ê××ÖÄ¸´óÐ´', aspTrim($C4));
            aspEcho('È¡Ê××ÖÄ¸', aspTrim($c2));
            aspEcho('¹«Ë¾±ê×¼', enToCompany($C4));
            aspEcho('ÎÞ¿Õ¸ñÊ××ÖÄ¸Ð¡Ð´', aspTrim(replace($c, ' ', '')));
            aspEcho('ÎÞ¿Õ¸ñÊ××ÖÄ¸´óÐ´', aspTrim(replace($C3, ' ', '')));
        }
    }
    return @$pinYin;
}

//Æ´Òô
function pinYin2($content){
    $pinYin2= pinYin($content, 'Æ´Òô');
    return @$pinYin2;
}


//´¦Àí¹«Ë¾Ó¢ÎÄµØÖ·
function enToCompany( $content){
    $content= replace($content, 'Shang Hai', 'Shanghai');
    $content= replace($content, 'You Xian Gong Si', ' Co.,Ltd.');
    $enToCompany= aspTrim($content);
    return @$enToCompany;
}


//vbdel start
//
//·±Ìå×ª¼òÌå Simplified Chinese 			'·±Ìå×ª¼òÌåÔÚPHPÀïÊÇÓÐÎÊÌâµÄ£¬PHPÌ«¶ñÐÄÁË
function simplifiedChinese($content){
    $simplifiedChinese=handleTransferChinese($content,1);
    return @$simplifiedChinese;
}
//¼òÌå×ª·±Ìå Simplified transfer
function simplifiedTransfer($content){
    $simplifiedTransfer=handleTransferChinese($content,0);
    return @$simplifiedTransfer;
}
//¼òÌå ·±Ìå ×ª»»    0Îª¼òÌå×ª·±Ìå  1Îª·±Ìå×ª¼òÌå
function handleTransferChinese($content,$sType){
    $zd='';$s='';$splstr='';$splxx ='';
    $zd= '’I|º´,°¨|°},°ª|Ì@,°­|µK,°®|Û,°¹|óa,°À|Ò\,°Â|ŠW,°Ó|‰Î,°Õ|ÁT,°Ú|”[,°Ü|”¡,°ä|îC,°ì|Þk,°í|½O,°ï|ŽÍ,°ó|½‰,°÷|æ^,°ù|Ör,°þ|„ƒ,±¥|ï–,±¦|Œš,±¨|ˆó,±«|õU,±²|Ý…,±´|Ø,±µ|ä^,±·|ªN,±¸|‚ä,±¹|‘v,±Á|¿‡,±Ê|¹P,±Ï|®…,±Ð|”À,±Ò|ŽÅ,±Õ|é],±ß|ß…,±à|¾Ž,±á|ÙH,±ä|×ƒ,±ç|Þq,±è|Þp,±ê|˜Ë,±î|÷M,±ð|„e,±ñ|°T,±ô|žl,±õ|žI,±ö|Ùe,±÷|”P,±ý|ïž,²¦|“Ü,²§|À,²¬|ãK,²µ|ñg,²¹|Ña,²Æ|Ø”,²Î|…¢,²Ï|ÐQ,²Ð|šˆ,²Ñ|‘M,²Ò|‘K,²Ó| N,²Ô|Én,²Õ|Å“,²Ö|‚},²×|œæ,²Þ|Žú,²à|‚È,²á|ƒÔ,²â|œy,²ã|ŒÓ,²ï|ÔŒ,²ó|”v,²ô|“½,²õ|Ïs,²ö|ð’,²÷|×‹,²ø|Àp,²ù|çP,²ú|®a,²û|êU,²ü|î,³¡|ˆö,³¢|‡L,³¤|éL,³¥|ƒ”,³¦|Äc,³§|S,³©|•³,³®|ân,³µ|Ü‡,³¹|Ø,³¾|‰m,³Â|ê,³Ä|Òr,³Å|“Î,³Æ|·Q,³Í|‘Í,³Ï|Õ\,³Ò|òG,³Õ|°V,³Ù|ßt,³Û|ñY,³Ü|u,³Ý|ýX,³ã|Ÿë,³å|›_,³æ|Ïx,³è|Œ™,³ë|® ,³ì|ÜP,³ï|»I,³ñ|¾I,³÷|™»,³ø|N,³ú|äz,³û|ër,´¡|µA,´¢|ƒ¦,´¥|Ó|,´¦|ÌŽ,´«|‚÷,´¯|¯,´³|êJ,´´|„“,´¸|åN,´¿|¼ƒ,´Â|¾b,´Ç|Þo,´Ê|Ô~,´Í|Ùn,´Ï|Â”,´Ð|Ê[,´Ñ|‡è,´Ó|Ä,´Ô|…²,´Õ|œ,´Ú|Üf,´Ü|¸Z,´í|åe,´ï|ß_,´ø|Ž§,´û|ÙJ,µ¥|†Î,µ¦|à,µ§|“Û,µ¨|Ä‘,µ¬|‘„,µ®|ÕQ,µ¯|—,µ±|®”,µ²|“õ,µ³|üh,µ´|ÊŽ,µµ|™n,µ·|“v,µº|u,µ»|¶\,µ¼|Œ§,µÁ|±I,µÆ|Ÿô,µË|à‡,µÐ|”³,µÓ|œì,µÝ|ßf,µÞ|¾†,µß|î,µã|üc,µæ|‰|,µç|ëŠ,µö|áž,µ÷|Õ{,µý|Õ™,µþ|¯B,¶¤|á”,¶¥|í”,¶§|åV,¶©|Ó†,¶ª|G,¶«|–|,¶¯|„Ó,¶°|—,¶³|ƒö,¶¿| Ù,¶À|ªš,¶Á|×x,¶Ä|Ù€,¶Æ|åƒ,¶Í|å‘,¶Ï|”à,¶Ð|¾„,¶Ò|ƒ¶,¶Ó|ê ,¶Ô|Œ¦,¶Ö|‡,¶Ù|îD,¶Û|âg,¶á|ŠZ,¶é|‰™,¶ì|ùZ,¶î|î~,¶ï|Óž,¶ñ|º,¶ö|ðI,¶ù|ƒº,¶û| –,¶ü|ðD,·¡|ÙE,·¢|°l,·§|éy,·©|¬m,·¯|µ\,·°|âC,·³|Ÿ©,··|Øœ,·¹|ïˆ,·Ã|ÔL,·Ä|¼,·É|ïw,·Ì|Õu,·Ï|U,·Ñ|ÙM,·×|¼Š,·Ø|‰ž,·Ü|Š^,·ß|‘,·à|¼S,·á|ØS,·ã|—÷,·æ|äh,·ç|ïL,·è|¯‚,·ë|ñT,·ì|¿p,·í|ÖS,·ï|øP,·ô|Äw,·ø|Ý—,¸§|“á,¸¨|Ýo,¸³|Ùx,¸´|Í,¸º|Ø“,¸¼|Ó‡,¸¾|‹D,¸¿|¿`,¸Ã|Ô“,¸Æ|â},¸Ç|Éw,¸Ë|—U,¸Ï|Ús,¸Ñ|¶’,¸Ó|ÚM,¸Ô|Œù,¸Õ|„‚,¸Ö|ä“,¸Ù|¾V,¸Ú|,¸ä|æ€,¸é|”R,¸ë|ø,¸ó|éw,¸õ|ãt,¸ö|‚€,¸ø|½o,¹¨|ý,¹¬|Œm,¹®|ì–,¹±|Ø•,¹³|ã^,¹µ|œÏ,¹¶|Æˆ,¹¹|˜‹,¹º|Ù,¹»|‰ò,¹Æ|ÐM,¹Ë|î™,¹Ð|„Ž,¹Ò|’ì,¹Ø|êP,¹Û|Ó^,¹Ý|ð^,¹ß|‘T,¹á|Øž,¹ã|V,¹æ|ÒŽ,¹é|šw,¹ê|ý”,¹ë|é|,¹ì|Ü‰,¹î|ÔŽ,¹ó|ÙF,¹ô|„£,¹õ|Ý,¹ö|L,¹ø|å,¹ú|‡ø,¹ý|ß^,º§|ñ”,º«|ín,ºº|h,ºÅ|Ì–,ºÒ|éu,º×|úQ,ºØ|ÙR,ºá|™M,ºä|ÞZ,ºè|ø™,ºì|¼t,ºø|‰Ø,»¤|×o,»¦|œû,»§|‘ô,»©|‡W,»ª|ÈA,»­|®‹,»®|„,»°|Ô’,»³|‘Ñ,»µ|‰Ä,»¶|šg,»·|­h,»¹|ß€,»º|¾,»»|“Q,»½|†¾,»¾|¯ˆ,»À|Ÿ¨,»Á|œo,»Æ|üS,»Ñ|Öe,»Ó|“],»Ô|Ýx,»Ù|š§,»ß|ÙV,»à|·x,»á|•þ,»â| Z,»ã|…R,»ä|ÖM,»å|Õd,»æ|ÀL,»ç|È,»ë|œ†,»ñ|«@,»õ|Ø›,»ö|µœ,»÷|“ô,»ú|™C,»ý|·e,¼¢|ð‡,¼£|ÛE,¼¥|×I,¼¦|ëu,¼¨|¿ƒ,¼©|¾ƒ,¼«|˜O,¼­|Ý‹,¼¶|¼‰,¼·|”D,¼¸|Ž×,¼»|ËE,¼Á|„©,¼Ã|ú,¼Æ|Ó‹,¼Ç|Ó›,¼Ê|ëH,¼Ì|À^,¼Í|¼o,¼Ð|ŠA,¼Ô|Çv,¼Õ|îa,¼Ö|ÙZ,¼Ø|â›,¼Û|ƒr,¼Ý|ñ{,¼ß|šž,¼à|±O,¼á|ˆÔ,¼ã|¹{,¼ä|ég,¼è|ÆD,¼ê|¾},¼ë|ÀO,¼ì|™z,¼î|‰A,¼ï|û|,¼ð|’þ,¼ñ|“ì,¼ò|º†,¼ó|ƒ€,¼õ|œp,¼ö|Ë],¼÷|™‘,¼ø|èb,¼ù|Û`,¼ú|Ùv,¼û|ÒŠ,¼ü|æI,½¢|Åž,½£|„¦,½¤|ðT,½¥|u,½¦|žR,½§|¾,½«|Œ¢,½¬|{,½¯|ÊY,½°|˜ª,½±|ª„,½²|Öv,½´|áu,½º|Äz,½½|²,½¾|òœ,½¿|‹É,½Á|”‡,½Â|ãq,½Ã|³C,½Ä|ƒe,½Å|Ä_,½È|ïœ,½É|ÀU,½Ê|½g,½Î|ÞI,½Ï|Ý^,½×|ëA,½Ú|¹,½à|,½á|½Y,½ë|Õ],½ì|ŒÃ,½ô|¾o,½õ|å\,½ö|ƒH,½÷|Ö”,½ø|ßM,½ú|•x,½ý| a,¾¡|±M,¾¢|„Å,¾£|ÇG,¾¥|Ço,¾¨|öL,¾ª|ó@,¾­|½›,¾±|îi,¾²|ìo,¾µ|çR,¾¶|½,¾·|¯d,¾º|¸‚,¾»|ƒô,¾À|¼m,¾Ç|Žý,¾É|Åf,¾Ô|ñx,¾Ù|Åe,¾Ý|“þ,¾â|ä,¾å|‘Ö,¾ç|„¡,¾é|ùN,¾î|½,¾õ|ÓX,¾ö|›Q,¾÷|ÔE,¾ø|½^,¾û|âx,¾ü|ÜŠ,¿¥|òE,¿ª|é_,¿­|„P,¿Å|îw,¿Ç|š¤,¿Î|Õn,¿Ñ|‰¨,¿Ò|‘©,¿Ù|“¸,¿â|Žì,¿ã|Ñ,¿é|‰K,¿ë|ƒ~,¿í|Œ’,¿ó|µV,¿õ|•ç,¿ö|›r,¿÷|Ì,¿ù|Žh,¿ú|¸Q,À¡|ð,À£|¢,À©|”U,À«|éŸ,À¯|Ïž,À°|ÅD,À³|ÈR,À´|í,Àµ|Ù‡,À¶|Ë{,À¸|™Ú,À¹|”r,Àº|»@,À»|ê@,À¼|Ìm,À½|ž‘,À¾|×Ž,À¿|”ˆ,ÀÀ|Ó[,ÀÁ|‘Ð,ÀÂ|À|,ÀÃ| €,ÀÄ|žE,ÀÅ|¬˜,ÀÌ|“Æ,ÀÍ|„Ú,ÀÔ|³,ÀÖ|˜·,ÀØ|èD,ÀÝ|‰¾,Àà|î,Àá|œI,Àé|»h,Àê|Ø‚,Àë|ëx,Àð|õŽ,Àñ|¶Y,Àö|û,À÷|…–,Àø|„î,Àù|µ[,Àú|šv,Á¤|žr,Á¥|ë`,Á©|‚z,Áª|Â“,Á«|É,Á¬|ßB,Á­|ç ,Á¯|‘z,Á°|i,Á±|ºŸ,Á²|”¿,Á³|Ä˜,Á´|æœ,Áµ|‘Ù,Á¶|Ÿ’,Á·|¾š,Á¸|¼Z,Á¹|›ö,Á½|ƒÉ,Á¾|Ýv,ÁÂ|Õ,ÁÆ|¯Ÿ,ÁÉ|ß|,ÁÍ|ç‚,ÁÔ|«C,ÁÙ|ÅR,ÁÚ|à,ÁÛ|÷[,ÁÝ|„C,ÁÞ|ÙU,Áä|ýg,Áå|â,Áé|ì`,Áë|ŽX,Áì|îI,Áó|ðs,Áõ|„¢,Áú|ýˆ,Áû|Ã@,Áü|‡µ,Áý|»\,Â¢|‰Å,Â¤|ë],Â¥|˜Ç,Â¦|Šä,Â§|“§,Â¨|ºt,Â«|ÌJ,Â¬|±R,Â­|ïB,Â®|],Â¯| t,Â°|“ï,Â±|ûu,Â²|Ì”,Â³|ô”,Â¸|ÙT,Â»|µ“,Â¼|ä›,Â½|ê‘,Â¿|óH,ÂÀ|…Î,ÂÁ|äX,ÂÂ|‚H,ÂÅ|ŒÒ,ÂÆ|¿|,ÂÇ|‘],ÂË|žV,ÂÌ|¾G,ÂÍ|Žn,ÂÎ|”,ÂÏ|Œ\,ÂÐ|ž´,ÂÒ|y,ÂÕ|’à,ÂÖ|Ý†,Â×|‚,ÂØ|ö,ÂÙ|œS,ÂÚ|¾],ÂÛ|Õ“,ÂÜ|Ì},ÂÞ|Á_,Âß|ß‰,Âà|èŒ,Âá|»j,Ââ|ò…,Âæ|ñ˜,Âç|½j,Âè|‹Œ,Âê|¬”,Âë|´a,Âì|Î›,Âí|ñR,Âî|ÁR,Âð|†á,Âò|ÙI,Âó|ûœ,Âô|Ùu,Âõ|ß~,Âö|Ã},Â÷|²m,Âø|ðz,Âù|ÐU,Âú|M,Ã¡|Ö™,Ã¨|Øˆ,Ãª|å^,Ã­|ãT,Ã³|ÙQ,Ã»|›],Ã¾|æV,ÃÅ|éT,ÃÆ|ž,ÃÇ|‚ƒ,ÃÌ|åi,ÃÎ|‰ô,ÃÐ|²[,ÃÕ|Öi,ÃÖ|›,ÃÙ|Ò’,ÃÝ|ƒç,Ãà|¾d,Ãå|¾’,Ãí|R,Ãð|œç,Ãõ|‘‘,Ãö|é},Ãù|øQ,Ãú|ã‘,Ãý|Ö‡,Ä±|Ö\,Ä¶|®€,ÄÅ|…È,ÄÆ|âc,ÄÉ|¼{,ÄÑ|ëy,ÄÓ|“Ï,ÄÔ|ÄX,ÄÕ|À,ÄÖ|ô[,ÄÙ|ðH,ÄÚ|ƒÈ,Äâ|”M,Äå|Ä,Äì|”f,Äð|á„,Äñ|øB,Äô|Â™,Äö|‡§,Ä÷|è‡,Äø|æ‡,Äû|™Ž,Äü|ªŸ,Äþ|ŒŽ,Å¡|”Q,Å¢|ô,Å¥|âo,Å¦|¼~,Å§|Ä“,Å¨|â,Å©|Þr,Å±|¯‘,Åµ|ÖZ,Å·|šW,Å¸|út,Å¹|šª,Å»|‡I,Å½|a,ÅÌ|±P,ÅÓ|ý‹,Å×|’,Åâ|Ùr,Åç|‡Š,Åô|ùi,Æ­|ò_,Æ®|ïh,Æµ|îl,Æ¶|Øš,Æ»|ÌO,Æ¾|‘{,ÆÀ|Ôu,ÆÃ|Š,ÆÄ|îH,ÆË|“ä,ÆÌ|ä,ÆÓ|˜ã,Æ×|×V,ÆÜ|—«,Æê|Äš,Æë|ýR,Æï|òT,Æñ|ØM,Æô|†¢,Æø|šâ,Æú|—‰,Æý|Ó™,Ç£| ¿,Ç¥|âF,Ç¦|ãU,Ç¨|ßw,Ç©|ºž,Ç«|Öt,Ç®|åX,Ç¯|ãQ,Ç±|“,Ç³|œ\,Ç´|×l,Çµ|‰q,Ç¹|˜Œ,Çº|†Ü,Ç½|‰¦,Ç¾|ËN,Ç¿|Š,ÇÀ|“Œ,ÇÂ|æ@,ÇÅ|˜ò,ÇÇ|†Ì,ÇÈ|ƒS,ÇÌ|ÂN,ÇÏ|¸[,ÇÔ|¸`,ÇÕ|šJ,Ç×|ÓH,ÇÞ|Œ‹,Çá|Ýp,Çâ|šä,Çã|ƒA,Çê|í•,Çë|Õˆ,Çì|‘c,Çí|­‚,Çî|¸F,Ç÷|Ú…,Çø|…^,Çû|Ü|,Çý|òŒ,È£|ýx,È§|ïE,È¨|™à,È°|„ñ,È´|…s,Èµ|ùo,È·|´_,ÈÃ|×Œ,ÈÄ|ðˆ,ÈÅ|”_,ÈÆ|À@,ÈÈ|Ÿá,ÈÍ|íg,ÈÏ|ÕJ,ÈÒ|¼x,ÈÙ|˜s,ÈÞ|½q,Èí|Ü›,Èñ|äJ,Èò|éc,Èó|™,È÷|ž¢,Èø|Ë_,Èú|öw,Èü|Ù,É¡|‚ã,É¥|†Ê,É§|ò},É¨|’ß,É¬|­,É±|š¢,É²|„x,É´|¼†,É¸|ºY,É¹|•ñ,É¾|„h,ÉÁ|éW,ÉÂ|êƒ,ÉÄ|Ù ,ÉÉ|¿˜,ÉÊ|‰„,ÉË|‚û,ÉÍ|Ùp,ÉÕ|Ÿý,ÉÜ|½B,ÉÞ|Ùd,Éã|”z,Éå|‘Ø,Éè|ÔO,Éð|¼,Éó|Œ,Éô|‹ð,Éö|ÄI,Éø|B,Éù|Â•,Éþ|ÀK,Ê¤|„Ù,Ê¦|ŽŸ,Ê¨|ª{,Êª|ñ,Ê«|ÔŠ,Ê±|•r,Ê´|Îg,Êµ|Œ,Ê¶|×R,Ê»|ñ‚,ÊÆ|„Ý,ÊÊ|ßm,ÊÍ|áŒ,ÊÎ|ï—,ÊÓ|Ò•,ÊÔ|Ô‡,ÊÙ|‰Û,ÊÞ|«F,Êà|˜Ð,Êä|Ý”,Êé|•ø,Êê|ÚH,Êô|ŒÙ,Êõ|Ðg,Ê÷|˜ä,Êú|ØQ,Êý|”µ,Ë§|Ž›,Ë«|ëp,Ë­|Õl,Ë°|¶,Ë³|í˜,Ëµ|Õf,Ë¶|´T,Ë¸| q,Ë¿|½z,ËÇ|ï•,ËÊ|Â–,ËË|‘Z,ËÌ|íž,ËÏ|ÔA,ËÐ|Õb,ËÓ|”\,ËÕ|ÌK,Ëß|ÔV,Ëà|ÃC,Ëä|ëm,Ëæ|ëS,Ëç|½—,Ëê|šq,Ëï|ŒO,Ëð|“p,Ëñ|¹S,Ëõ|¿s,Ëö|¬,Ëø|æi,Ì¡|«H,Ì¢|“é,Ì¨|Å_,Ì¬|‘B,Ì¯|”‚,Ì°|Ø,Ì±|°c,Ì²|ž©,Ì³|‰¯,Ì·|×T,Ì¸|Õ„,Ì¾|‡@,ÌÀ|œ«,ÌÌ| C,ÌÎ|ý,ÌÐ|½{,ÌÖ|Ó‘,ÌÚ|òv,ÌÜ|Ö`,Ìà|äR,Ìâ|î},Ìå|ów,Ìë|ŒÏ,Ìõ|—l,Ìù|ÙN,Ìú|èF,Ìü|d,Ìý|Â ,Ìþ|ŸN,Í­|ã~,Í³|½y,Í·|î^,Íº|¶d,Í¼|ˆD,ÍÅ|ˆF,ÍÇ|îj,ÍÉ|Í‘,ÍÑ|Ã“,ÍÒ|ør,ÍÔ|ñW,ÍÕ|ñ„,ÍÖ|™E,Íà|Òm,Íä|,Íå|ž³,Íç|îB,Íò|Èf,Íø|¾W,Î¤|íf,Î¥|ß`,Î§|‡ú,Îª|žé,Î«|žH,Î¬|¾S,Î­|È”,Î°|‚¥,Î±|‚Î,Î³|¾•,Î½|Ö^,ÎÀ|Ðl,ÎÂ|œØ,ÎÅ|Â„,ÎÆ|¼y,ÎÈ|·€,ÎÊ|†–,ÎÍ|®Y,ÎÎ|“ë,ÎÏ|Î,ÎÐ|œu,ÎÑ|¸C,ÎÔ|ÅP,ÎØ|†è,ÎÙ|æu,ÎÚ|žõ,ÎÜ|Õ_,ÎÞ|Ÿo,Îß|Ê,Îâ|…Ç,Îë|‰],Îí|ìF,Îñ|„Õ,Îó|Õ`,Îý|åa,Îþ| Þ,Ï®|Òu,Ï°|Á•,Ï³|ãŠ,Ï·|‘ò,Ï¸|¼š,Ïº|Îr,Ï½|Ý ,Ï¿|{,ÏÀ|‚b,ÏÁ|ªM,ÏÃ|B,ÏÅ|‡˜,ÏÊ|õr,ÏË|Àw,ÏÍ|Ùt,ÏÎ|ã•,ÏÐ|ée,ÏÔ|ï@,ÏÕ|ëU,ÏÖ|¬F,Ï×|«I,ÏØ|¿h,ÏÚ|ðW,ÏÛ|Áw,ÏÜ|‘—,Ïß|¾€,Ïá|Žû,Ïâ|è‚,Ïç|àl,Ïê|Ô”,Ïì|í‘,Ïî|í—,Ïô|Ê’,Ïù|‡Ì,Ïú|äN,Ïþ|•Ô,Ð¥|‡[,Ð­|…f,Ð®|’¶,Ð¯|”y,Ð²|Ã{,Ð³|ÖC,Ð´|Œ‘,Ðº|ža,Ð»|Öx,Ð¿|ä\,ÐÆ|á…,ÐË|Åd,Ð×|ƒ´,ÐÚ|›°,Ðâ|äP,Ðå|ÀC,Ðé|Ì“,Ðê|‡u,Ðë|íš,Ðí|ÔS,Ðð|”¢,Ð÷|¾w,Ðø|Àm,Ðù|ÜŽ,Ðü|‘Ò,Ñ¡|ßx,Ñ¢|°_,Ñ¤|½k,Ñ§|ŒW,Ñ«|„×,Ñ¯|Ôƒ,Ñ°|Œ¤,Ñ±|ñZ,Ñµ|Ó–,Ñ¶|Ó,Ñ·|ßd,Ñ¹|‰º,Ñ»|øf,Ñ¼|ø†,ÑÆ|†¡,ÑÇ|†,ÑÈ|Ó ,ÑË|éŽ,ÑÌ|ŸŸ,ÑÎ|û},ÑÏ|‡À,ÑÒ|Žr,ÑÕ|î,ÑÖ|é,ÑÞ|ÆG,Ñá|…’,Ñâ|³Ž,Ñå|©,Ñè|ÖV,Ñé|òž,Ñì|ø„,Ñî|—î,Ñï|“P,Ññ|¯ƒ,Ñô|ê–,Ñ÷|°W,Ñø|ðB,Ñù|˜Ó,Ñþ|¬Ž,Ò¡|“u,Ò¢|ˆò,Ò£|ßb,Ò¤|¸G,Ò¥|Ö{,Ò©|ËŽ,Ò¯| ”,Ò³|í“,Òµ|˜I,Ò¶|È~,Ò½|át,Ò¿|ãž,ÒÃ|îU,ÒÅ|ßz,ÒÇ|ƒx,ÒÏ|Ï,ÒÕ|Ë‡,ÒÚ|ƒ|,Òä|‘›,Òå|Áx,Òè|Ô„,Òé|×h,Òê|Õx,Òë|×g,Òì|®,Òï|À[,Òñ|Êa,Òõ|êŽ,Òø|ãy,Òû|ï‹,Òþ|ë[,Ó£|™Ñ,Ó¤|‹ë,Ó¥|ú—,Ó¦|‘ª,Ó§|Àt,Ó¨|¬“,Ó©|Îž,Óª| I,Ó«|ŸÉ,Ó¬|Ï‰,Ó®|ÚA,Ó±|·f,Ó´|†Ñ,Óµ|“í,Ó¶|‚ò,Ó¸|°b,Ó»|Ûx,Ó½|Ô,ÓÅ|ƒž,ÓÇ|‘n,ÓÊ|à],ÓË|â™,ÓÌ|ªq,ÓÕ|ÕT,Óß|Ý›,Óã|ô~,Óæ|O,Óé|ŠÊ,Óë|Åc,Óì|ŽZ,Óï|ÕZ,Óü|ªz,Óþ|×u,Ô¤|îA,Ô¦|ñS,Ô§|øx,Ô¨|œY,Ô¯|Þ@,Ô°|ˆ@,Ô±|†T,Ô²|ˆA,Ôµ|¾‰,Ô¶|ßh,Ô¼|¼s,Ô¾|ÜS,Ô¿|è€,ÔÁ|»›,ÔÃ|‚,ÔÄ|é†,ÔÇ|ày,ÔÈ|„ò,ÔÉ|ëE,ÔË|ß\,ÔÌ|ÌN,ÔÍ|áj,ÔÎ|•ž,ÔÏ|í,ÔÓ|ës,ÔÖ|žÄ,ÔØ|Ýd,ÔÜ|”€,ÔÝ|•º,ÔÞ|Ù,Ôß|ÚE,Ôà|ÅK,Ôä|è,Ôæ|——,Ôð|ØŸ,Ôñ|“ñ,Ôò|„t,Ôó|É,Ôô|Ù\,Ôù|Ù›,Ôþ|Üˆ,Õ¡|åŽ,Õ¢|él,Õ¤|–Å,Õ©|Ôp,Õ«|ýS,Õ®|‚ù,Õ±|šÖ,Õµ|±K,Õ¶|”Ø,Õ·|Ýš,Õ¸|ä,Õ»|—£,Õ½|‘ð,ÕÀ|¾`,ÕÅ|ˆ,ÕÇ|q,ÕÊ|Ž¤,ÕË|Ù~,ÕÍ|Ã›,ÕÔ|Úw,ÕÝ|ÏU,ÕÞ|ÞH,Õà|æN,Õâ|ß@,Õê|Ø‘,Õë|á˜,Õì|‚É,Õï|Ô\,Õò|æ‚,Õó|ê‡,Õõ|’ê,Õö|± ,Õø|ªb,Õù| Ž,Ö¡|Ž¬,Ö¢|°Y,Ö£|à,Ö¤|×C,Ö¯|¿—,Ö°|Âš,Ö´|ˆÌ,Ö½|¼ˆ,Ö¿|“´,ÖÀ|”S,ÖÄ|ŽÃ,ÖÊ|Ù|,ÖÍ|œþ,ÖÓ|çŠ,ÖÕ|½K,ÖÖ|·N,Ö×|Ä[,ÖÚ|±Š,Öß|Öa,Öá|ÝS,Öå|°™,Öç|•ƒ,Öè|óE,Öí|Øi,Öî|ÖT,Öï|ÕD,Öò| T,Öõ|²š,Öö|‡Ú,Öü|ÙA,Öý|èT,×¤|ñv,×¨|Œ£,×©|´u,×ª|ÞD,×¬|Ù,×®|˜¶,×¯|Çf,×°|Ñb,×±|Šy,×³|‰Ñ,×´| î,×¶|åF,×¸|Ù˜,×¹|‰‹,×º|¾Y,×»|Õ,×¼|œÊ,×Å|Öø,×Ç|á,×È|Æ,×Ê|ÙY,×Õ|n,×Ù|Û™,×Û|¾C,×Ü|¿‚,×Ý|¿v,×Þ|àu,×ç|Ô{,×é|½M,×ê|ã@,Ø¨|ƒ,Øº|²G,ØÂ|Ád,ØÄ|†Ý,ØÇ|…‡,ØÉ|…˜,ØË|P,ØÌ|ìv,ØÍ|ÚI,ØÐ|…Q,ØÑ|…T,ØÓ|Ù‘,ØÙ|„q,ØÛ|„¥,ØÜ|„’,Øñ|‚ø,Øö|‚t,Ø÷|‚á,Øù|Ð,Ù­|ƒŠ,Ù¯|ƒz,Ù±|ƒ‰,Ù²|ƒ°,Ù³|ƒ«,Ù¶|‚R,ÙÇ|ƒf,ÙÌ|‚ô,ÙÍ|ƒE,ÙÎ|ƒ¯,ÙÏ|ƒ†,ÙÐ|ƒ®,ÙÝ|ƒL,Ùá|¼e,Ùä|üZ,Ùæ|‡Ï,Ùì|øD,Ùð|ƒ¼,Ùò|Ð–,Ùô|ÒC,Ùõ|ÅL,Ù÷|·A,Ú¦|Ó“,Ú§|Ó,Ú¨|Ó˜,Ú©|ÖŽ,Úª|Ôn,Ú«|ÔG,Ú¬|Ôb,Ú­|ÔX,Ú®|Ôg,Ú¯|Ôt,Ú°|Ôx,Ú±|Ôr,Ú²|ÕE,Ú³|ÕC,Ú´|ÔŸ,Úµ|Ô‘,Ú¶|Ôœ,Ú·|Ô–,Ú¸|Ô,Ú¹|Ô,Úº|ÕŠ,Ú»|ÕŸ,Ú¼|Ô‚,Ú½|ÕV,Ú¾|Õa,Ú¿|ÕN,ÚÀ|ÕO,ÚÁ|ÕŒ,ÚÂ|ÕŽ,ÚÃ|Õ†,ÚÄ|Õ˜,ÚÅ|Õ”,ÚÆ|Õ~,ÚÇ|Õr,ÚÈ|ÖR,ÚÉ|ÖG,ÚÊ|Öo,ÚË|Ö],ÚÌ|Ö@,ÚÍ|ÖI,ÚÎ|ÖX,ÚÏ|ÖO,ÚÐ|ÖB,ÚÑ|ÖJ,ÚÒ|Õ›,ÚÓ|Öƒ,ÚÔ|×•,ÚÕ|Öq,ÚÖ|Öu,Ú×|Ök,ÚØ|Ö†,ÚÚ|×P,ÚÛ|×S,ÚÜ|×H,ÚÝ|×—,ÚÞ|×d,Úß|×,Úá|Ž„,Úê|ê€,Úí|êŸ,Ú÷|à—,Úù|àw,Úþ|à’,Û£|àP,Û¦|à”,Û©|ài,Ûª|áB,Û»|Æc,Û¼|ŠJ,Û½|„ê,ÛÏ|Ž€,ÛÑ|ˆ×,ÛÛ|‰¿,ÛÞ|‰È,Ûä|‰À,Ûë|ˆº,Ûî|‰N,Ûð|ˆs,Ûõ|‰P,Ûö|ˆå,Û÷|‰_,Ü³|ÆH,Ü¼|ËG,Ü¿|Ê|,ÜÂ|Ëž,ÜÈ|Ç{,ÜÉ|ÈO,ÜÊ|É,ÜÐ|ÆS,ÜÑ|Ær,Ü×|Ìd,Üà|Ê\,Üã|‰L,Üä|Ÿ¦,Üé|Ê,Üê|Éœ,Üñ|Êw,Üö|ËC,Üù|Ëj,Üý| Î,Üþ|œî,Ý¡|Ên,Ý£|Ë|,Ý¥|Ép,Ý¦|È‡,Ýª|ÉP,Ý«|Èn,Ý°|ÉW,Ý²|ËW,Ýµ|Ê~,Ýº|úL,ÝÓ|¿M,ÝÛ|Êr,ÝÞ|Ê‰,Ýä|ÊV,Ýë|ò‡,Ýñ|Ìy,Ýö|æv,Ý÷|Êš,Ýü|Ì`,Ýþ|ÌA,Þ­|ÌI,Þ´|Ë’,Þº|Ì\,ÞÁ|ÌY,ÞÆ|ŠY,ÞÏ|ŒÀ,ÞÑ|’Ð,ÞÒ|“»,ÞØ|“×,Þâ|“,Þè|“¥,Þì|“å,Þó|”d,Þü|”t,ß¢|”X,ß£|”],ß¥|”x,ß¦|“{,ß±|s,ß´|‡\,ß¼|‡`,ß½|‡Ò,ß¿|‡³,ßÂ|†h,ßÃ|†J,ßÌ|‡“,ßÕ|‡},ßØ|‡^,ßÙ|†ô,ßÜ|‡‚,ßà|‡ˆ,ßâ|‡,ßæ|‡,ßé|‡O,ßë|‡Z,ßï|†î,ßõ|‡K,ßù|‡Ê,à¶|‡D,à·|‡¿,à¿|‡Ë,àÈ|‡†,àÎ|Þ\,àÓ|‡Â,àà|‡£,àð|‡÷,àø|Ž®,àü|ŽÎ,àý|Ž¾,àþ|Ž½,á«|ç,á­|s,á°|¹,á´|–,á»|ŽF,á½|þ,á¿|˜,áÀ|÷,áÁ|ˆ,áÉ|ŽV,áÎ|£,áÐ|â,áÛ|Žp,áâ|Æ,áî|«E,áö|ªœ,áø|ªs,áý|ª,â¤|«M,â¨|«J,â¼|ðh,â½|ï‚,â¾|ðq,â¿|ïƒ,âÀ|ï„,âÁ|ï†,âÂ|ï,âÃ|ðA,âÄ|ðG,âÆ|ðQ,âÈ|ðt,âÉ|ðx,âÊ|ð},âË|ð~,âÍ|ð‚,âÐ|T,âÙ|Ùs,âÞ|[,âã|‘Ô,âä|‘“,âæ|‘Y,âé|÷,âê|,âë|í,âø|‘«,âú|‘Q,âû|‘Ã,âü|Å,âý|ð,ã¢|Á,ã¥|‘a,ã«|Ü,ã³|‘C,ã´|‘|,ãÅ|éV,ãÆ|éZ,ãÇ|é,ãÈ|éb,ãÉ|éh,ãÊ|é`,ãË|êY,ãÌ|é‚,ãÍ|é€,ãÎ|ôb,ãÏ|é,ãÐ|é“,ãÑ|é‹,ãÒ|ô],ãÓ|é”,ãÔ|é’,ãÕ|é‘,ãÖ|é˜,ã×|é ,ãØ|êH,ãÙ|êD,ãÚ|êI,ãÛ|êR,ãã|ž–,ãí|œ¿,ãñ|ž{,ãò|žo,ãø|žT,ãþ|›Ü,ä¤|›Ñ,ä¥|œ,ä«|Ò,ä¯|žg,ä°|G,ä±|¡,äµ|œZ,ä¶|¬,äÂ|ž^,äÅ|Æ,äÉ|žc,äË|œO,äÜ|ž—,äÞ|ž],ää|§,äë|žu,äì|žt,äò|ž‡,äþ|ž|,å°|ž®,å¹|òq,åÇ|ßƒ,åÉ|ÞŸ,åÎ|ßŠ,åð|ŒÕ,åò|†,åü|‹³,åý|‹ž,æ©|Š™,æ«|‹I,æ¬|‹Æ,æ®|ŒD,æ´|‹z,æµ|‹¹,æ¿|‹È,æÁ|‹‹,æÈ|‹Ü,æÉ|‹å,æÍ|‹Ô,æÖ|‹ß,æà|ñz,æá|ñ†,æâ|ñ€,æã|ò|,æä|óA,æå|ñw,ææ|ñ~,æç|ò”,æè|ò‘,æé|ñ‰,æê|óP,æë|òU,æì|òS,æí|òK,æî|ò‰,æï|òs,æð|ò\,æñ|òˆ,æò|òt,æó|ò~,æô|òŠ,æõ|ò‹,æö|ò–,æ÷|óK,æø|óJ,æú|¼u,æû|¼q,æü|¼v,æý|¼w,æþ|Àk,ç¡|¼‹,ç¢|¼„,ç£|¼‚,ç¤|½C,ç¥|¼œ,ç¦|¼›,ç§|¿U,ç¨|½E,ç©|½I,çª|½H,ç¬|½W,ç­|½{,ç®|½Ž,ç¯|½‹,ç°|½,ç±|¾c,ç²|¾_,ç³|¾p,çµ|¾i,ç¶|¾E,ç·|¾R,ç¸|¾^,ç¹|¾J,çº|¾U,ç»|¾l,ç¼|¾~,ç½|¾|,ç¾|¾Ÿ,ç¿|¾˜,çÀ|ÀD,çÁ|¾Œ,çÂ|¾œ,çÃ|¾—,çÄ|¿P,çÅ|¾‡,çÆ|¿N,çÇ|¿b,çÈ|¿d,çÉ|¿c,çÊ|¿r,çË|¿O,çÌ|¿V,çÍ|À_,çÎ|¿~,çÏ|¿z,çÐ|¿w,çÑ|¿Š,çÒ|¿‰,çÓ|Ài,çÔ|¿,çÕ|¿•,çÖ|í\,ç×|À`,çØ|ÀR,çÙ|ÀQ,çÚ|Ày,çá|­^,çâ|¬|,çå|«k,çç|­‡,çï|íœ,çô|­t,çõ|¬q,çö|­I,è¨|­a,è¬|­‹,è¶|­‘,è¸|ít,è¹|íy,èº|íw,è¿|˜q,èÀ|™À,èÇ|—–,èÈ|˜º,èÉ|—n,èÎ|™±,èÐ|™É,èÓ|™¾,èÙ|—d,èÝ|™µ,èß|™f,èâ|—¿,èã|˜ï,èå|˜E,èç|˜,èë|˜å,èí|™u,èï|™è,èù|™ô,èü|™³,èý|˜ ,é¡|™å,é¤|˜¡,é­|™ì,é´|™Â,éµ|™°,é·|™Î,éÄ|™‰,éÆ|™½,éÉ|™{,éÖ|™©,éÚ|™´,éÝ|™_,éâ|š{,éä|š‘,éæ|šŒ,éç|šš,éé|š—,éë|š›,éí|Ü,éî|Ü—,éð|ÝV,éñ|Þ_,éò|ÝT,éó|ÝW,éô|ÝF,éö|Þ],é÷|ÝU,éø|ÝY,éù|Ýe,éú|Ýb,éû|Ý`,éü|Ým,éý|Ý‚,éþ|Ýy,ê¡|Ýz,ê¢|Ýw,ê£|Ý,ê¤|ÞA,ê¥|ÞO,ê§|‘â,ê¨|‘ê,ê¯|‘ì,ê±|®T,ê¼|•Ò,êÊ|•Ï,êÍ|•Ÿ,êÓ|•á,êÚ|ÙS,êÛ|ÙB,êÜ|ÙL,êÝ|ÙO,êÞ|Ù—,êß|ÙD,êà|ÙW,êá|ÚB,êâ|Ùc,êã|Ùl,êä|Ùg,êæ|Ùy,êç|ÙŽ,êè|Ò—,êé|ÓJ,êê|Ò ,êë|Ó],êì|ÓD,êí|ÓM,êî|ÓP,êï|ÓU,ë§|šÐ,ëª|šÚ,ë²|šå,ëµ|šè,ë¹| ©,ëÊ|–V,ëÍ|ÅF,ëÖ|Ã„,ëÚ|Ä’,ëá|ÄT,ëï|ìt,ëð|Äe,ë÷|Äœ,ì£|še,ì©|ïR,ìª|ïS,ì«|ïZ,ì¬|ï`,ì­|ïj,ì±|Ýž,ì´|ýW,ìµ|”Ì,ì¾|Ÿ¬,ì¿|Ÿ˜,ìÀ|Ÿõ,ìÁ|ŸÍ,ìÇ|Ÿî,ìË| F,ìâ| c,ìò|¶[,ìõ|µ,ìø|¶U,í¡|‘»,í¨|â,í¯|‘¿,í°|‘ß,í´|Í,í¶|´‰,í¸|´X,íº|³Œ,íÂ|µZ,íÃ|µa,íÌ|³ˆ,íÍ|´“,íÓ|´ƒ,í×|´~,íè|ý,íö|±{,íù|²A,íú|²€,íü|Ã,î´|®Œ,î¼|Á`,î¿|Áb,îÅ|á,îÆ|á,îÇ|á•,îÈ|á“,îÉ|á‘,îÊ|âQ,îË|âA,îÌ|áŸ,îÍ|å{,îÎ|âO,îÏ|âS,îÑ|â,îÒ|â ,îÓ|âk,îÔ|âj,îÕ|â[,îÖ|â‚,î×|â^,îØ|â€,îÙ|âZ,îÚ|â•,îÛ|ã`,îÜ|â’,îÝ|âŽ,îß|â˜,îà|â“,îá|ãX,îâ|ãf,îã|ãg,îä|âš,îå|èp,îæ|â‹,îç|ãC,îè|ãB,îé|ãG,îê|â‰,îë|â”,îì|èI,îí|äD,îî|ã™,îï|ãs,îð|äB,îñ|ä…,îò|äe,îó|çt,îõ|èK,î÷|ãŸ,îø|æz,îù|ã,îú|äb,îû|äA,îü|çf,îý|ãŒ,îþ|ãx,ï¡|æ|,ï¢|ã“,ï£|åP,ï¤|äC,ï¥|ã|,ï¦|ç|,ï§|ä@,ï¨|ãœ,ï©|ç„,ïª|ån,ï«|äˆ,ï¬|çH,ï®|ä‡,ï¯|ä†,ï°|ä~,ï±|äS,ï²|äs,ï¶|äZ,ï·|äu,ï¸|ä|,ï¹|åH,ïº|ä,ï¼|åQ,ï¾|ä˜,ï¿|åK,ïÀ|åd,ïÃ|äŸ,ïÄ|åU,ïÅ|åO,ïÆ|å›,ïÇ|å|,ïÈ|æJ,ïÉ|åŠ,ïÊ|åš,ïË|æ},ïÌ|æD,ïÎ|çU,ïÏ|çI,ïÐ|çš,ïÒ|æŸ,ïÓ|æk,ïÔ|ç,ïÖ|æy,ï×|æ„,ïØ|æ‰,ïÙ|è\,ïÚ|çS,ïÛ|çM,ïÜ|çN,ïÝ|æ ,ïÞ|çO,ïß|æ—,ïà|æ›,ïá|çC,ïâ|ç†,ïä|çh,ïæ|ç…,ïç|è|,ïè|ç’,ïê|çj,ïë|ç‹,ïì|èZ,ïí|èC,ïî|èO,ïð|ès,ïñ|æR,ð£|·w,ð¯|øF,ð°|øS,ð±|ød,ð²|øc,ð³|ø,ð´|ù…,ðµ|ûR,ð¶|øz,ð·|ø|,ð¸|úƒ,ð¹|ø,ðº|úv,ð»|øŽ,ð¼|ø ,ð½|û[,ð¾|ùP,ð¿|ûZ,ðÀ|ù],ðÁ|ùO,ðÂ|ú’,ðÃ|ùY,ðÄ|ù^,ðÆ|ùg,ðÇ|ùl,ðÈ|ù‡,ðÉ|ù–,ðÊ|ù˜,ðË|ú\,ðÍ|úF,ðÎ|ú_,ðÏ|úY,ðÐ|ûW,ðÑ|úp,ðÒ|úw,ðÓ|ú,ðÔ|ú„,ðÕ|ú,ðÖ|ú–,ðØ|ú˜,ðÙ|ûX,ðÜ|°X,ðÝ|°O,ðå|°’,ðì|°A,ðï|°B,ð÷|°D,ðù|¯Ž,ðü|¯›,ñ¨|°`,ñ«|°a,ñ®|°],ñ²|°d,ñ¼|¸],ñÀ|¸M,ñÉ|Òd,ñÍ|Ñž,ñÏ|Òc,ñÚ|Ò@,ñÜ|Òh,ñä|°—,ñï|Âe,ñ÷|Âœ,ñù|Â˜,ñü|í™,ñý|í ,ñþ|î@,ò¡|îR,ò¢|îM,ò£|},ò¤|îW,ò¥|îh,ò¦|î€,ò§|î…,ò¨|ïD,ò©|î”,òª|î‹,ò«|î—,ò­|ïA,ò±|Ïl,ò²|ÏŠ,ò¹|Í˜,òº|Ï–,òÃ|Ï ,òÉ|Ï|,òÌ|Í,òÍ|Ïu,òÏ|Î‡,òÓ|Ï“,òå|ÏX,òî|Ï”,ò÷|ÏN,ó¿|À›,óÆ|ºV,óÈ|¹a,óÖ|»e,óÙ|º`,óÝ|¹~,óå|ºj,óæ|ºD,óê|»X,óì|º„,óï|º,óñ|ºˆ,óý|»f,ô¥|»[,ô¯|Åœ,ôµ|ÆA,ôÁ|ÑU,ôÇ|Áu,ôÌ|¶i,ôÏ|¼c,ôÐ|¼g,ôÖ|¼R,ôê|¿{,ôï|ûŸ,ôõ|ÚŽ,õ¦|á‰,õ§|á‡,õº|ûz,õ»|ÜO,õÄ|Û„,õÈ|ÜV,õÎ|ÜE,õÏ|Û‹,õÑ|Ü],õÒ|ÜQ,õÙ|ÜW,õÜ|ÜU,õæ|Üb,õç|Û˜,õé|ÜX,õï|Ük,õò|Üg,õü|Óx,ö£|Óz,ö¦|ìn,ö¨|ìZ,ö«|ìV,ö°|ì\,ö³|ýZ,ö´|ýe,öµ|ý_,ö¶|ýf,ö·|ýb,ö¸|ýl,ö¹|ýr,öº|ýp,ö»|ý},ö¼|üw,ö½|üx,ö¾|üƒ,öÁ|ëh,öÅ|×‡,öÇ|èŽ,öÉ|çY,öÏ|ôœ,öÐ|ô™,öÔ|÷|,öÕ|·d,öÖ|õV,ö×|÷c,öØ|õT,öÙ|õq,öÚ|õ^,öÛ|õn,öÜ|õb,öÝ|÷q,öÞ|õo,öà|÷\,öá|õ†,öâ|÷~,öã|ö–,öä|öž,öå|öˆ,öæ|öœ,öç|õ…,öè|õ,öé|õŒ,öê|öa,öë|õ›,öì|öN,öí|öO,öî|öE,öï|öH,öð|öK,öò|öF,öó|öT,öô|õ ,öö|õ™,öø|öl,öù|÷{,öú|öq,öû|öv,öü|öm,÷¡|ö—,÷¢|ö’,÷£|ö,÷¤|öŠ,÷¥|öŽ,÷¦|ö˜,÷§|÷B,÷¨|÷L,÷©|ö ,÷¬|÷Z,÷­|÷X,÷®|÷V,÷¯|÷k,÷²|í^,÷µ|íd,÷½|úX,÷Ã|ót,÷Å|óy,÷Æ|óx,÷Ê|ô|,÷Ë|ôu,÷Ï|ð‹,÷Ð|ð,÷Þ|ôW,÷á|üN,÷ò|üt,÷õ|üo,÷ú|ýB';
    $splstr=aspSplit($zd,',');
    foreach( $splstr as $key=>$s){
        if( inStr($s,'|')>0 ){
            $splxx=aspSplit($s,'|');
            if( $sType==1 ){
                $content=replace($content,$splxx[1],$splxx[0]);
            }else{
                $content=replace($content,$splxx[0],$splxx[1]);
            }
        }
    }
    $handleTransferChinese= $content;
    return @$handleTransferChinese;
}



//¼òÌå ·±Ìå ×ª»»    0Îª¼òÌå×ª·±Ìå  1Îª·±Ìå×ª¼òÌå   ÕâÖÖÔÚPHPÀïÔËÐÐ²»ÁË£¬À¬»øPHP
function handleTransferChinese_temp($content,$sType){
    $zd=''; $i=''; $s=''; $c ='';
    $zd= '’Iº´°¨°}°ªÌ@°­µK°®Û°¹óa°ÀÒ\°ÂŠW°Ó‰Î°ÕÁT°Ú”[°Ü”¡°äîC°ìÞk°í½O°ïŽÍ°ó½‰°÷æ^°ùÖr°þ„ƒ±¥ï–±¦Œš±¨ˆó±«õU±²Ý…±´Ø±µä^±·ªN±¸‚ä±¹‘v±Á¿‡±Ê¹P±Ï®…±Ð”À±ÒŽÅ±Õé]±ßß…±à¾Ž±áÙH±ä×ƒ±çÞq±èÞp±ê˜Ë±î÷M±ð„e±ñ°T±ôžl±õžI±öÙe±÷”P±ýïž²¦“Ü²§À²¬ãK²µñg²¹Ña²ÆØ”²Î…¢²ÏÐQ²Ðšˆ²Ñ‘M²Ò‘K²Ó N²ÔÉn²ÕÅ“²Ö‚}²×œæ²ÞŽú²à‚È²áƒÔ²âœy²ãŒÓ²ïÔŒ²ó”v²ô“½²õÏs²öð’²÷×‹²øÀp²ùçP²ú®a²ûêU²üî³¡ˆö³¢‡L³¤éL³¥ƒ”³¦Äc³§S³©•³³®ân³µÜ‡³¹Ø³¾‰m³Âê³ÄÒr³Å“Î³Æ·Q³Í‘Í³ÏÕ\³ÒòG³Õ°V³Ùßt³ÛñY³Üu³ÝýX³ãŸë³å›_³æÏx³èŒ™³ë® ³ìÜP³ï»I³ñ¾I³÷™»³øN³úäz³ûër´¡µA´¢ƒ¦´¥Ó|´¦ÌŽ´«‚÷´¯¯´³êJ´´„“´¸åN´¿¼ƒ´Â¾b´ÇÞo´ÊÔ~´ÍÙn´ÏÂ”´ÐÊ[´Ñ‡è´ÓÄ´Ô…²´Õœ´ÚÜf´Ü¸Z´íåe´ïß_´øŽ§´ûÙJµ¥†Îµ¦àµ§“Ûµ¨Ä‘µ¬‘„µ®ÕQµ¯—µ±®”µ²“õµ³ühµ´ÊŽµµ™nµ·“vµºuµ»¶\µ¼Œ§µÁ±IµÆŸôµËà‡µÐ”³µÓœìµÝßfµÞ¾†µßîµãücµæ‰|µçëŠµöážµ÷Õ{µýÕ™µþ¯B¶¤á”¶¥í”¶§åV¶©Ó†¶ªG¶«–|¶¯„Ó¶°—¶³ƒö¶¿ Ù¶Àªš¶Á×x¶ÄÙ€¶Æåƒ¶Íå‘¶Ï”à¶Ð¾„¶Òƒ¶¶Óê ¶ÔŒ¦¶Ö‡¶ÙîD¶Ûâg¶áŠZ¶é‰™¶ìùZ¶îî~¶ïÓž¶ñº¶öðI¶ùƒº¶û –¶üðD·¡ÙE·¢°l·§éy·©¬m·¯µ\·°âC·³Ÿ©··Øœ·¹ïˆ·ÃÔL·Ä¼·Éïw·ÌÕu·ÏU·ÑÙM·×¼Š·Ø‰ž·ÜŠ^·ß‘·à¼S·áØS·ã—÷·æäh·çïL·è¯‚·ëñT·ì¿p·íÖS·ïøP·ôÄw·øÝ—¸§“á¸¨Ýo¸³Ùx¸´Í¸ºØ“¸¼Ó‡¸¾‹D¸¿¿`¸ÃÔ“¸Æâ}¸ÇÉw¸Ë—U¸ÏÚs¸Ñ¶’¸ÓÚM¸ÔŒù¸Õ„‚¸Öä“¸Ù¾V¸Ú¸äæ€¸é”R¸ëø¸óéw¸õãt¸ö‚€¸ø½o¹¨ý¹¬Œm¹®ì–¹±Ø•¹³ã^¹µœÏ¹¶Æˆ¹¹˜‹¹ºÙ¹»‰ò¹ÆÐM¹Ëî™¹Ð„Ž¹Ò’ì¹ØêP¹ÛÓ^¹Ýð^¹ß‘T¹áØž¹ãV¹æÒŽ¹éšw¹êý”¹ëé|¹ìÜ‰¹îÔŽ¹óÙF¹ô„£¹õÝ¹öL¹øå¹ú‡ø¹ýß^º§ñ”º«ínººhºÅÌ–ºÒéuº×úQºØÙRºá™MºäÞZºèø™ºì¼tºø‰Ø»¤×o»¦œû»§‘ô»©‡W»ªÈA»­®‹»®„»°Ô’»³‘Ñ»µ‰Ä»¶šg»·­h»¹ß€»º¾»»“Q»½†¾»¾¯ˆ»ÀŸ¨»Áœo»ÆüS»ÑÖe»Ó“]»ÔÝx»Ùš§»ßÙV»à·x»á•þ»â Z»ã…R»äÖM»åÕd»æÀL»çÈ»ëœ†»ñ«@»õØ›»öµœ»÷“ô»ú™C»ý·e¼¢ð‡¼£ÛE¼¥×I¼¦ëu¼¨¿ƒ¼©¾ƒ¼«˜O¼­Ý‹¼¶¼‰¼·”D¼¸Ž×¼»ËE¼Á„©¼Ãú¼ÆÓ‹¼ÇÓ›¼ÊëH¼ÌÀ^¼Í¼o¼ÐŠA¼ÔÇv¼Õîa¼ÖÙZ¼Øâ›¼Ûƒr¼Ýñ{¼ßšž¼à±O¼áˆÔ¼ã¹{¼äég¼èÆD¼ê¾}¼ëÀO¼ì™z¼î‰A¼ïû|¼ð’þ¼ñ“ì¼òº†¼óƒ€¼õœp¼öË]¼÷™‘¼øèb¼ùÛ`¼úÙv¼ûÒŠ¼üæI½¢Åž½£„¦½¤ðT½¥u½¦žR½§¾½«Œ¢½¬{½¯ÊY½°˜ª½±ª„½²Öv½´áu½ºÄz½½²½¾òœ½¿‹É½Á”‡½Âãq½Ã³C½Äƒe½ÅÄ_½Èïœ½ÉÀU½Ê½g½ÎÞI½ÏÝ^½×ëA½Ú¹½à½á½Y½ëÕ]½ìŒÃ½ô¾o½õå\½öƒH½÷Ö”½øßM½ú•x½ý a¾¡±M¾¢„Å¾£ÇG¾¥Ço¾¨öL¾ªó@¾­½›¾±îi¾²ìo¾µçR¾¶½¾·¯d¾º¸‚¾»ƒô¾À¼m¾ÇŽý¾ÉÅf¾Ôñx¾ÙÅe¾Ý“þ¾âä¾å‘Ö¾ç„¡¾éùN¾î½¾õÓX¾ö›Q¾÷ÔE¾ø½^¾ûâx¾üÜŠ¿¥òE¿ªé_¿­„P¿Åîw¿Çš¤¿ÎÕn¿Ñ‰¨¿Ò‘©¿Ù“¸¿âŽì¿ãÑ¿é‰K¿ëƒ~¿íŒ’¿óµV¿õ•ç¿ö›r¿÷Ì¿ùŽh¿ú¸QÀ¡ðÀ£¢À©”UÀ«éŸÀ¯ÏžÀ°ÅDÀ³ÈRÀ´íÀµÙ‡À¶Ë{À¸™ÚÀ¹”rÀº»@À»ê@À¼ÌmÀ½ž‘À¾×ŽÀ¿”ˆÀÀÓ[ÀÁ‘ÐÀÂÀ|ÀÃ €ÀÄžEÀÅ¬˜ÀÌ“ÆÀÍ„ÚÀÔ³ÀÖ˜·ÀØèDÀÝ‰¾ÀàîÀáœIÀé»hÀêØ‚ÀëëxÀðõŽÀñ¶YÀöûÀ÷…–Àø„îÀùµ[ÀúšvÁ¤žrÁ¥ë`Á©‚zÁªÂ“Á«ÉÁ¬ßBÁ­ç Á¯‘zÁ°iÁ±ºŸÁ²”¿Á³Ä˜Á´æœÁµ‘ÙÁ¶Ÿ’Á·¾šÁ¸¼ZÁ¹›öÁ½ƒÉÁ¾ÝvÁÂÕÁÆ¯ŸÁÉß|ÁÍç‚ÁÔ«CÁÙÅRÁÚàÁÛ÷[ÁÝ„CÁÞÙUÁäýgÁåâÁéì`ÁëŽXÁìîIÁóðsÁõ„¢ÁúýˆÁûÃ@Áü‡µÁý»\Â¢‰ÅÂ¤ë]Â¥˜ÇÂ¦ŠäÂ§“§Â¨ºtÂ«ÌJÂ¬±RÂ­ïBÂ®]Â¯ tÂ°“ïÂ±ûuÂ²Ì”Â³ô”Â¸ÙTÂ»µ“Â¼ä›Â½ê‘Â¿óHÂÀ…ÎÂÁäXÂÂ‚HÂÅŒÒÂÆ¿|ÂÇ‘]ÂËžVÂÌ¾GÂÍŽnÂÎ”ÂÏŒ\ÂÐž´ÂÒyÂÕ’àÂÖÝ†Â×‚ÂØöÂÙœSÂÚ¾]ÂÛÕ“ÂÜÌ}ÂÞÁ_Âßß‰ÂàèŒÂá»jÂâò…Âæñ˜Âç½jÂè‹ŒÂê¬”Âë´aÂìÎ›ÂíñRÂîÁRÂð†áÂòÙIÂóûœÂôÙuÂõß~ÂöÃ}Â÷²mÂøðzÂùÐUÂúMÃ¡Ö™Ã¨ØˆÃªå^Ã­ãTÃ³ÙQÃ»›]Ã¾æVÃÅéTÃÆžÃÇ‚ƒÃÌåiÃÎ‰ôÃÐ²[ÃÕÖiÃÖ›ÃÙÒ’ÃÝƒçÃà¾dÃå¾’ÃíRÃðœçÃõ‘‘Ãöé}ÃùøQÃúã‘ÃýÖ‡Ä±Ö\Ä¶®€ÄÅ…ÈÄÆâcÄÉ¼{ÄÑëyÄÓ“ÏÄÔÄXÄÕÀÄÖô[ÄÙðHÄÚƒÈÄâ”MÄåÄÄì”fÄðá„ÄñøBÄôÂ™Äö‡§Ä÷è‡Äøæ‡Äû™ŽÄüªŸÄþŒŽÅ¡”QÅ¢ôÅ¥âoÅ¦¼~Å§Ä“Å¨âÅ©ÞrÅ±¯‘ÅµÖZÅ·šWÅ¸útÅ¹šªÅ»‡IÅ½aÅÌ±PÅÓý‹Å×’ÅâÙrÅç‡ŠÅôùiÆ­ò_Æ®ïhÆµîlÆ¶ØšÆ»ÌOÆ¾‘{ÆÀÔuÆÃŠÆÄîHÆË“äÆÌäÆÓ˜ãÆ××VÆÜ—«ÆêÄšÆëýRÆïòTÆñØMÆô†¢ÆøšâÆú—‰ÆýÓ™Ç£ ¿Ç¥âFÇ¦ãUÇ¨ßwÇ©ºžÇ«ÖtÇ®åXÇ¯ãQÇ±“Ç³œ\Ç´×lÇµ‰qÇ¹˜ŒÇº†ÜÇ½‰¦Ç¾ËNÇ¿ŠÇÀ“ŒÇÂæ@ÇÅ˜òÇÇ†ÌÇÈƒSÇÌÂNÇÏ¸[ÇÔ¸`ÇÕšJÇ×ÓHÇÞŒ‹ÇáÝpÇâšäÇãƒAÇêí•ÇëÕˆÇì‘cÇí­‚Çî¸FÇ÷Ú…Çø…^ÇûÜ|ÇýòŒÈ£ýxÈ§ïEÈ¨™àÈ°„ñÈ´…sÈµùoÈ·´_ÈÃ×ŒÈÄðˆÈÅ”_ÈÆÀ@ÈÈŸáÈÍígÈÏÕJÈÒ¼xÈÙ˜sÈÞ½qÈíÜ›ÈñäJÈòécÈó™È÷ž¢ÈøË_ÈúöwÈüÙÉ¡‚ãÉ¥†ÊÉ§ò}É¨’ßÉ¬­É±š¢É²„xÉ´¼†É¸ºYÉ¹•ñÉ¾„hÉÁéWÉÂêƒÉÄÙ ÉÉ¿˜ÉÊ‰„ÉË‚ûÉÍÙpÉÕŸýÉÜ½BÉÞÙdÉã”zÉå‘ØÉèÔOÉð¼ÉóŒÉô‹ðÉöÄIÉøBÉùÂ•ÉþÀKÊ¤„ÙÊ¦ŽŸÊ¨ª{ÊªñÊ«ÔŠÊ±•rÊ´ÎgÊµŒÊ¶×RÊ»ñ‚ÊÆ„ÝÊÊßmÊÍáŒÊÎï—ÊÓÒ•ÊÔÔ‡ÊÙ‰ÛÊÞ«FÊà˜ÐÊäÝ”Êé•øÊêÚHÊôŒÙÊõÐgÊ÷˜äÊúØQÊý”µË§Ž›Ë«ëpË­ÕlË°¶Ë³í˜ËµÕfË¶´TË¸ qË¿½zËÇï•ËÊÂ–ËË‘ZËÌížËÏÔAËÐÕbËÓ”\ËÕÌKËßÔVËàÃCËäëmËæëSËç½—ËêšqËïŒOËð“pËñ¹SËõ¿sËö¬ËøæiÌ¡«HÌ¢“éÌ¨Å_Ì¬‘BÌ¯”‚Ì°ØÌ±°cÌ²ž©Ì³‰¯Ì·×TÌ¸Õ„Ì¾‡@ÌÀœ«ÌÌ CÌÎýÌÐ½{ÌÖÓ‘ÌÚòvÌÜÖ`ÌàäRÌâî}ÌåówÌëŒÏÌõ—lÌùÙNÌúèFÌüdÌýÂ ÌþŸNÍ­ã~Í³½yÍ·î^Íº¶dÍ¼ˆDÍÅˆFÍÇîjÍÉÍ‘ÍÑÃ“ÍÒørÍÔñWÍÕñ„ÍÖ™EÍàÒmÍäÍåž³ÍçîBÍòÈfÍø¾WÎ¤ífÎ¥ß`Î§‡úÎªžéÎ«žHÎ¬¾SÎ­È”Î°‚¥Î±‚ÎÎ³¾•Î½Ö^ÎÀÐlÎÂœØÎÅÂ„ÎÆ¼yÎÈ·€ÎÊ†–ÎÍ®YÎÎ“ëÎÏÎÎÐœuÎÑ¸CÎÔÅPÎØ†èÎÙæuÎÚžõÎÜÕ_ÎÞŸoÎßÊÎâ…ÇÎë‰]ÎíìFÎñ„ÕÎóÕ`ÎýåaÎþ ÞÏ®ÒuÏ°Á•Ï³ãŠÏ·‘òÏ¸¼šÏºÎrÏ½Ý Ï¿{ÏÀ‚bÏÁªMÏÃBÏÅ‡˜ÏÊõrÏËÀwÏÍÙtÏÎã•ÏÐéeÏÔï@ÏÕëUÏÖ¬FÏ×«IÏØ¿hÏÚðWÏÛÁwÏÜ‘—Ïß¾€ÏáŽûÏâè‚ÏçàlÏêÔ”Ïìí‘Ïîí—ÏôÊ’Ïù‡ÌÏúäNÏþ•ÔÐ¥‡[Ð­…fÐ®’¶Ð¯”yÐ²Ã{Ð³ÖCÐ´Œ‘ÐºžaÐ»ÖxÐ¿ä\ÐÆá…ÐËÅdÐ×ƒ´ÐÚ›°ÐâäPÐåÀCÐéÌ“Ðê‡uÐëíšÐíÔSÐð”¢Ð÷¾wÐøÀmÐùÜŽÐü‘ÒÑ¡ßxÑ¢°_Ñ¤½kÑ§ŒWÑ«„×Ñ¯ÔƒÑ°Œ¤Ñ±ñZÑµÓ–Ñ¶ÓÑ·ßdÑ¹‰ºÑ»øfÑ¼ø†ÑÆ†¡ÑÇ†ÑÈÓ ÑËéŽÑÌŸŸÑÎû}ÑÏ‡ÀÑÒŽrÑÕîÑÖéÑÞÆGÑá…’Ñâ³ŽÑå©ÑèÖVÑéòžÑìø„Ñî—îÑï“PÑñ¯ƒÑôê–Ñ÷°WÑøðBÑù˜ÓÑþ¬ŽÒ¡“uÒ¢ˆòÒ£ßbÒ¤¸GÒ¥Ö{Ò©ËŽÒ¯ ”Ò³í“Òµ˜IÒ¶È~Ò½átÒ¿ãžÒÃîUÒÅßzÒÇƒxÒÏÏÒÕË‡ÒÚƒ|Òä‘›ÒåÁxÒèÔ„Òé×hÒêÕxÒë×gÒì®ÒïÀ[ÒñÊaÒõêŽÒøãyÒûï‹Òþë[Ó£™ÑÓ¤‹ëÓ¥ú—Ó¦‘ªÓ§ÀtÓ¨¬“Ó©ÎžÓª IÓ«ŸÉÓ¬Ï‰Ó®ÚAÓ±·fÓ´†ÑÓµ“íÓ¶‚òÓ¸°bÓ»ÛxÓ½ÔÓÅƒžÓÇ‘nÓÊà]ÓËâ™ÓÌªqÓÕÕTÓßÝ›Óãô~ÓæOÓéŠÊÓëÅcÓìŽZÓïÕZÓüªzÓþ×uÔ¤îAÔ¦ñSÔ§øxÔ¨œYÔ¯Þ@Ô°ˆ@Ô±†TÔ²ˆAÔµ¾‰Ô¶ßhÔ¼¼sÔ¾ÜSÔ¿è€ÔÁ»›ÔÃ‚ÔÄé†ÔÇàyÔÈ„òÔÉëEÔËß\ÔÌÌNÔÍájÔÎ•žÔÏíÔÓësÔÖžÄÔØÝdÔÜ”€ÔÝ•ºÔÞÙÔßÚEÔàÅKÔäèÔæ——ÔðØŸÔñ“ñÔò„tÔóÉÔôÙ\ÔùÙ›ÔþÜˆÕ¡åŽÕ¢élÕ¤–ÅÕ©ÔpÕ«ýSÕ®‚ùÕ±šÖÕµ±KÕ¶”ØÕ·ÝšÕ¸äÕ»—£Õ½‘ðÕÀ¾`ÕÅˆÕÇqÕÊŽ¤ÕËÙ~ÕÍÃ›ÕÔÚwÕÝÏUÕÞÞHÕàæNÕâß@ÕêØ‘Õëá˜Õì‚ÉÕïÔ\Õòæ‚Õóê‡Õõ’êÕö± ÕøªbÕù ŽÖ¡Ž¬Ö¢°YÖ£àÖ¤×CÖ¯¿—Ö°ÂšÖ´ˆÌÖ½¼ˆÖ¿“´ÖÀ”SÖÄŽÃÖÊÙ|ÖÍœþÖÓçŠÖÕ½KÖÖ·NÖ×Ä[ÖÚ±ŠÖßÖaÖáÝSÖå°™Öç•ƒÖèóEÖíØiÖîÖTÖïÕDÖò TÖõ²šÖö‡ÚÖüÙAÖýèT×¤ñv×¨Œ£×©´u×ªÞD×¬Ù×®˜¶×¯Çf×°Ñb×±Šy×³‰Ñ×´ î×¶åF×¸Ù˜×¹‰‹×º¾Y×»Õ×¼œÊ×ÅÖø×Çá×ÈÆ×ÊÙY×Õn×ÙÛ™×Û¾C×Ü¿‚×Ý¿v×Þàu×çÔ{×é½M×êã@Ø¨ƒØº²GØÂÁdØÄ†ÝØÇ…‡ØÉ…˜ØËPØÌìvØÍÚIØÐ…QØÑ…TØÓÙ‘ØÙ„qØÛ„¥ØÜ„’Øñ‚øØö‚tØ÷‚áØùÐÙ­ƒŠÙ¯ƒzÙ±ƒ‰Ù²ƒ°Ù³ƒ«Ù¶‚RÙÇƒfÙÌ‚ôÙÍƒEÙÎƒ¯ÙÏƒ†ÙÐƒ®ÙÝƒLÙá¼eÙäüZÙæ‡ÏÙìøDÙðƒ¼ÙòÐ–ÙôÒCÙõÅLÙ÷·AÚ¦Ó“Ú§ÓÚ¨Ó˜Ú©ÖŽÚªÔnÚ«ÔGÚ¬ÔbÚ­ÔXÚ®ÔgÚ¯ÔtÚ°ÔxÚ±ÔrÚ²ÕEÚ³ÕCÚ´ÔŸÚµÔ‘Ú¶ÔœÚ·Ô–Ú¸ÔÚ¹ÔÚºÕŠÚ»ÕŸÚ¼Ô‚Ú½ÕVÚ¾ÕaÚ¿ÕNÚÀÕOÚÁÕŒÚÂÕŽÚÃÕ†ÚÄÕ˜ÚÅÕ”ÚÆÕ~ÚÇÕrÚÈÖRÚÉÖGÚÊÖoÚËÖ]ÚÌÖ@ÚÍÖIÚÎÖXÚÏÖOÚÐÖBÚÑÖJÚÒÕ›ÚÓÖƒÚÔ×•ÚÕÖqÚÖÖuÚ×ÖkÚØÖ†ÚÚ×PÚÛ×SÚÜ×HÚÝ×—ÚÞ×dÚß×ÚáŽ„Úêê€ÚíêŸÚ÷à—ÚùàwÚþà’Û£àPÛ¦à”Û©àiÛªáBÛ»ÆcÛ¼ŠJÛ½„êÛÏŽ€ÛÑˆ×ÛÛ‰¿ÛÞ‰ÈÛä‰ÀÛëˆºÛî‰NÛðˆsÛõ‰PÛöˆåÛ÷‰_Ü³ÆHÜ¼ËGÜ¿Ê|ÜÂËžÜÈÇ{ÜÉÈOÜÊÉÜÐÆSÜÑÆrÜ×ÌdÜàÊ\Üã‰LÜäŸ¦ÜéÊÜêÉœÜñÊwÜöËCÜùËjÜý ÎÜþœîÝ¡ÊnÝ£Ë|Ý¥ÉpÝ¦È‡ÝªÉPÝ«ÈnÝ°ÉWÝ²ËWÝµÊ~ÝºúLÝÓ¿MÝÛÊrÝÞÊ‰ÝäÊVÝëò‡ÝñÌyÝöævÝ÷ÊšÝüÌ`ÝþÌAÞ­ÌIÞ´Ë’ÞºÌ\ÞÁÌYÞÆŠYÞÏŒÀÞÑ’ÐÞÒ“»ÞØ“×Þâ“Þè“¥Þì“åÞó”dÞü”tß¢”Xß£”]ß¥”xß¦“{ß±sß´‡\ß¼‡`ß½‡Òß¿‡³ßÂ†hßÃ†JßÌ‡“ßÕ‡}ßØ‡^ßÙ†ôßÜ‡‚ßà‡ˆßâ‡ßæ‡ßé‡Oßë‡Zßï†îßõ‡Kßù‡Êà¶‡Dà·‡¿à¿‡ËàÈ‡†àÎÞ\àÓ‡Âàà‡£àð‡÷àøŽ®àüŽÎàýŽ¾àþŽ½á«çá­sá°¹á´–á»ŽFá½þá¿˜áÀ÷áÁˆáÉŽVáÎ£áÐâáÛŽpáâÆáî«Eáöªœáøªsáýªâ¤«Mâ¨«Jâ¼ðhâ½ï‚â¾ðqâ¿ïƒâÀï„âÁï†âÂïâÃðAâÄðGâÆðQâÈðtâÉðxâÊð}âËð~âÍð‚âÐTâÙÙsâÞ[âã‘Ôâä‘“âæ‘Yâé÷âêâëíâø‘«âú‘Qâû‘ÃâüÅâýðã¢Áã¥‘aã«Üã³‘Cã´‘|ãÅéVãÆéZãÇéãÈébãÉéhãÊé`ãËêYãÌé‚ãÍé€ãÎôbãÏéãÐé“ãÑé‹ãÒô]ãÓé”ãÔé’ãÕé‘ãÖé˜ã×é ãØêHãÙêDãÚêIãÛêRããž–ãíœ¿ãñž{ãòžoãøžTãþ›Üä¤›Ñä¥œä«Òä¯žgä°Gä±¡äµœZä¶¬äÂž^äÅÆäÉžcäËœOäÜž—äÞž]ää§äëžuäìžtäòž‡äþž|å°ž®å¹òqåÇßƒåÉÞŸåÎßŠåðŒÕåò†åü‹³åý‹žæ©Š™æ«‹Iæ¬‹Ææ®ŒDæ´‹zæµ‹¹æ¿‹ÈæÁ‹‹æÈ‹ÜæÉ‹åæÍ‹ÔæÖ‹ßæàñzæáñ†æâñ€æãò|æäóAæåñwææñ~æçò”æèò‘æéñ‰æêóPæëòUæìòSæíòKæîò‰æïòsæðò\æñòˆæòòtæóò~æôòŠæõò‹æöò–æ÷óKæøóJæú¼uæû¼qæü¼væý¼wæþÀkç¡¼‹ç¢¼„ç£¼‚ç¤½Cç¥¼œç¦¼›ç§¿Uç¨½Eç©½Içª½Hç¬½Wç­½{ç®½Žç¯½‹ç°½ç±¾cç²¾_ç³¾pçµ¾iç¶¾Eç·¾Rç¸¾^ç¹¾Jçº¾Uç»¾lç¼¾~ç½¾|ç¾¾Ÿç¿¾˜çÀÀDçÁ¾ŒçÂ¾œçÃ¾—çÄ¿PçÅ¾‡çÆ¿NçÇ¿bçÈ¿dçÉ¿cçÊ¿rçË¿OçÌ¿VçÍÀ_çÎ¿~çÏ¿zçÐ¿wçÑ¿ŠçÒ¿‰çÓÀiçÔ¿çÕ¿•çÖí\ç×À`çØÀRçÙÀQçÚÀyçá­^çâ¬|çå«kçç­‡çïíœçô­tçõ¬qçö­Iè¨­aè¬­‹è¶­‘è¸ítè¹íyèºíwè¿˜qèÀ™ÀèÇ—–èÈ˜ºèÉ—nèÎ™±èÐ™ÉèÓ™¾èÙ—dèÝ™µèß™fèâ—¿èã˜ïèå˜Eèç˜èë˜åèí™uèï™èèù™ôèü™³èý˜ é¡™åé¤˜¡é­™ìé´™Âéµ™°é·™ÎéÄ™‰éÆ™½éÉ™{éÖ™©éÚ™´éÝ™_éâš{éäš‘éæšŒéçššééš—éëš›éíÜéîÜ—éðÝVéñÞ_éòÝTéóÝWéôÝFéöÞ]é÷ÝUéøÝYéùÝeéúÝbéûÝ`éüÝméýÝ‚éþÝyê¡Ýzê¢Ýwê£Ýê¤ÞAê¥ÞOê§‘âê¨‘êê¯‘ìê±®Tê¼•ÒêÊ•ÏêÍ•ŸêÓ•áêÚÙSêÛÙBêÜÙLêÝÙOêÞÙ—êßÙDêàÙWêáÚBêâÙcêãÙlêäÙgêæÙyêçÙŽêèÒ—êéÓJêêÒ êëÓ]êìÓDêíÓMêîÓPêïÓUë§šÐëªšÚë²šåëµšèë¹ ©ëÊ–VëÍÅFëÖÃ„ëÚÄ’ëáÄTëïìtëðÄeë÷Äœì£šeì©ïRìªïSì«ïZì¬ï`ì­ïjì±Ýžì´ýWìµ”Ìì¾Ÿ¬ì¿Ÿ˜ìÀŸõìÁŸÍìÇŸîìË Fìâ cìò¶[ìõµìø¶Uí¡‘»í¨âí¯‘¿í°‘ßí´Íí¶´‰í¸´Xíº³ŒíÂµZíÃµaíÌ³ˆíÍ´“íÓ´ƒí×´~íèýíö±{íù²Aíú²€íüÃî´®Œî¼Á`î¿ÁbîÅáîÆáîÇá•îÈá“îÉá‘îÊâQîËâAîÌáŸîÍå{îÎâOîÏâSîÑâîÒâ îÓâkîÔâjîÕâ[îÖâ‚î×â^îØâ€îÙâZîÚâ•îÛã`îÜâ’îÝâŽîßâ˜îàâ“îáãXîâãfîããgîäâšîåèpîæâ‹îçãCîèãBîéãGîêâ‰îëâ”îìèIîíäDîîã™îïãsîðäBîñä…îòäeîóçtîõèKî÷ãŸîøæzîùãîúäbîûäAîüçfîýãŒîþãxï¡æ|ï¢ã“ï£åPï¤äCï¥ã|ï¦ç|ï§ä@ï¨ãœï©ç„ïªånï«äˆï¬çHï®ä‡ï¯ä†ï°ä~ï±äSï²äsï¶äZï·äuï¸ä|ï¹åHïºäï¼åQï¾ä˜ï¿åKïÀådïÃäŸïÄåUïÅåOïÆå›ïÇå|ïÈæJïÉåŠïÊåšïËæ}ïÌæDïÎçUïÏçIïÐçšïÒæŸïÓækïÔçïÖæyï×æ„ïØæ‰ïÙè\ïÚçSïÛçMïÜçNïÝæ ïÞçOïßæ—ïàæ›ïáçCïâç†ïäçhïæç…ïçè|ïèç’ïêçjïëç‹ïìèZïíèCïîèOïðèsïñæRð£·wð¯øFð°øSð±ødð²øcð³øð´ù…ðµûRð¶øzð·ø|ð¸úƒð¹øðºúvð»øŽð¼ø ð½û[ð¾ùPð¿ûZðÀù]ðÁùOðÂú’ðÃùYðÄù^ðÆùgðÇùlðÈù‡ðÉù–ðÊù˜ðËú\ðÍúFðÎú_ðÏúYðÐûWðÑúpðÒúwðÓúðÔú„ðÕúðÖú–ðØú˜ðÙûXðÜ°XðÝ°Oðå°’ðì°Aðï°Bð÷°Dðù¯Žðü¯›ñ¨°`ñ«°añ®°]ñ²°dñ¼¸]ñÀ¸MñÉÒdñÍÑžñÏÒcñÚÒ@ñÜÒhñä°—ñïÂeñ÷ÂœñùÂ˜ñüí™ñýí ñþî@ò¡îRò¢îMò£}ò¤îWò¥îhò¦î€ò§î…ò¨ïDò©î”òªî‹ò«î—ò­ïAò±Ïlò²ÏŠò¹Í˜òºÏ–òÃÏ òÉÏ|òÌÍòÍÏuòÏÎ‡òÓÏ“òåÏXòîÏ”ò÷ÏNó¿À›óÆºVóÈ¹aóÖ»eóÙº`óÝ¹~óåºjóæºDóê»Xóìº„óïºóñºˆóý»fô¥»[ô¯ÅœôµÆAôÁÑUôÇÁuôÌ¶iôÏ¼côÐ¼gôÖ¼Rôê¿{ôïûŸôõÚŽõ¦á‰õ§á‡õºûzõ»ÜOõÄÛ„õÈÜVõÎÜEõÏÛ‹õÑÜ]õÒÜQõÙÜWõÜÜUõæÜbõçÛ˜õéÜXõïÜkõòÜgõüÓxö£Ózö¦ìnö¨ìZö«ìVö°ì\ö³ýZö´ýeöµý_ö¶ýfö·ýbö¸ýlö¹ýröºýpö»ý}ö¼üwö½üxö¾üƒöÁëhöÅ×‡öÇèŽöÉçYöÏôœöÐô™öÔ÷|öÕ·döÖõVö×÷cöØõTöÙõqöÚõ^öÛõnöÜõböÝ÷qöÞõoöà÷\öáõ†öâ÷~öãö–öäöžöåöˆöæöœöçõ…öèõöéõŒöêöaöëõ›öìöNöíöOöîöEöïöHöðöKöòöFöóöTöôõ ööõ™öøölöù÷{öúöqöûövöüöm÷¡ö—÷¢ö’÷£ö÷¤öŠ÷¥öŽ÷¦ö˜÷§÷B÷¨÷L÷©ö ÷¬÷Z÷­÷X÷®÷V÷¯÷k÷²í^÷µíd÷½úX÷Ãót÷Åóy÷Æóx÷Êô|÷Ëôu÷Ïð‹÷Ðð÷ÞôW÷áüN÷òüt÷õüo÷úýB';
    for( $i= 1 ; $i<= len($content); $i++){
        $s= mid($content, $i, 1);
        if( inStr($zd, $s) > 0 ){
            if( $sType==1 ){
                $s= mid($zd, inStr($zd, $s) - 1, 1);
            }else{
                $s= mid($zd, inStr($zd, $s) + 1, 1);
            }
        }
        $c= $c . $s;
    }
    $handleTransferChinese_temp= $c;
    return @$handleTransferChinese_temp;
}
//vbdel end
?>