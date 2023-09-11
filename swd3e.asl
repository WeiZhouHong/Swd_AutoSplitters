/*
Xuan-Yuan Sword 3 The Scar of the Sky(SWD3E) - ASL primarily by master_fiora
This ASL is compatible with Xuan-Yuan Sword 3 The Scar of the Sky: V2.0 DVD (TW)
2021/05/23 自動計時開頭與結尾、藥草，F8暫停功能
2023/09/10 由EME編寫時間各分段
*/

state("swd3eDvd", "2.00 DVD(TW)"){	
	byte C1_level: "swd3eDvd.exe", 0xC7F2C;		//阿仇等級
	byte f8_pause: "swd3eDvd.exe", 0xE9CF0; 	//遊戲是否暫停
	byte basil: "swd3eDvd.exe", 0x10E7B8, 0x6; 	//羅勒草
	uint map: "swd3eDvd.exe", 0xC6178;		//所在地圖編號
	uint mov: "swd3eDvd.exe", 0x17B60C;		//動畫判定
        uint enemy_hp1: "swd3eDvd.exe", 0x13C584, 0x68; //敵人血量一號位
        uint enemy_hp2: "swd3eDvd.exe", 0x13F5FC, 0x68; //敵人血量二號位
        uint enemy_hp3: "swd3eDvd.exe", 0x142674, 0x68; //敵人血量三號位
        uint enemy_hp4: "swd3eDvd.exe", 0x1456EC, 0x68; //敵人血量四號位
        uint my_hp1: "swd3eDvd.exe", 0x1377B4; //我方血量一號位
        uint my_hp2: "swd3eDvd.exe", 0x1377B8; //我方血量二號位
        uint my_hp3: "swd3eDvd.exe", 0x1377BC; //我方血量三號位
}


startup{
	settings.Add("20230911 Release", false);
	settings.Add("Show Skill-EXP on log", false);
	settings.Add("羅勒草x100(煉妖最後需看一眼羅勒草)", false);	
	settings.Add("Pause during F8", true);
	
	vars.ASLVersion = "2.0";
	vars.logFilePath = Directory.GetCurrentDirectory() + "\\Swd3e-Autosplitter.log"; //same folder as LiveSplit.exe
	vars.log = (Action<string>)((string logLine) => {
		string time = System.DateTime.Now.ToString("hh:mm:ss");
		System.IO.File.AppendAllText(vars.logFilePath, time + ", " + logLine + "\r\n");
	});
	try{
		vars.log("Play SWD3E (" + vars.ASLVersion + ")");
	}
	catch (System.IO.FileNotFoundException e){
		System.IO.File.Create(vars.logFilePath);
		vars.log("Autosplitter loaded, log file created");
	}
        settings.Add("BOSS");
        settings.Add("EME私心跳船用");
        settings.CurrentDefaultParent = "BOSS";
                settings.Add("鮫精");
                settings.Add("怒意鮫精");
                settings.Add("邪屍骷髏");
                settings.Add("惡虎魔魅");
                settings.Add("阿拉花瓜");
                settings.Add("程咬金");
                settings.Add("楊碩");
                settings.Add("火蝠魚精");
                settings.Add("鵁精");
                settings.Add("秦叔寶");
                settings.Add("氐人族戰士");
              /*  settings.Add("魚蝦蟹");*/
                settings.Add("黑龍王");
                settings.Add("刑天");
                settings.Add("盤古");
                settings.Add("斛律安1");
                settings.Add("上官震遠");
                settings.Add("宇文拓1");
                settings.Add("斛律安2");
                settings.Add("韓騰1");
                settings.Add("盜匪");
                settings.Add("韓騰2");
                settings.Add("宇文拓2");
                settings.Add("宇文拓3");
                settings.Add("尉遲嫣紅");
                settings.Add("單小小");
                settings.Add("獨孤寧珂1");
                settings.Add("獨孤寧珂2");
                settings.Add("魔化師父");
        settings.CurrentDefaultParent = "EME私心跳船用";
                settings.Add("跳船");
}

init
{	
	//gamestate
	refreshRate = 33; //same value as game-fpsrate
	vars.basil = false;

        vars.jiaojing = false;
        vars.angryjiaojing = false;
        vars.skeleton = false;
        vars.tiger = false;
        vars.Yaojin = false;
        vars.Shuo = false;
        vars.fish = false;
        vars.bird = false;
        vars.Shubao = false;
        vars.warrior = false;
        vars.seefood = false;
        vars.dragon = false;
        vars.xingtian = false;
        vars.pangu = false;
        vars.Luan1 = false;
        vars.Zhenyuan = false;
        vars.Yuwentuo1 = false;
        vars.Luan2 = false;
        vars.Teng1 = false;
        vars.robbers = false;
        vars.Teng2 = false;
        vars.Yuwentuo2 = false;
        vars.Yuwentuo3 = true;
        vars.summon = false; //偵測後面四戰是否召喚小怪
        vars.Yenhung = false;
        vars.Xiaoxiao = false;
        vars.Ningke1 = false;
        vars.Ningke2 = false;
        vars.master = false;
        vars.allahu_akbar = false;

        vars.over = false; //戰鬥失敗判定
}


update{
	/*if(current.C1_skill > old.C1_skill && settings["Show Skill EXP"]){
		vars.kill = vars.kill + 1;
		vars.log("殺敵數：" + vars.kill + "，隱藏經驗：" + current.C1_skill );	
	}
	else if(current.map != old.map){
		vars.nextmap = true;
	}*/
        if(settings["鮫精"] && current.map == 26 && current.enemy_hp1 == 750){
                vars.jiaojing = true;
        }
        else if(settings["怒意鮫精"] && current.map == 16 && current.enemy_hp1 == 3000){
                vars.angryjiaojing = true;
        }
        else if(settings["邪屍骷髏"] && current.map == 34 && current.enemy_hp1 == 1800){
                vars.skeleton = true;
        }
        else if(settings["惡虎魔魅"] && current.map == 42 && current.enemy_hp1 == 1800 && current.enemy_hp2 == 2800){
                vars.tiger = true;
        }
        else if(settings["程咬金"] && current.map == 100 && current.enemy_hp1 == 4500){
                vars.Yaojin = true;
        }
        else if(settings["楊碩"] && current.map == 107 && current.enemy_hp1 == 5000){
                vars.Shuo = true;
        }
        else if(settings["火蝠魚精"] && current.map == 507 && current.enemy_hp2 == 2600){
                vars.fish = true;
        }
        else if(settings["鵁精"] && current.map == 111 && current.enemy_hp1 == 8200){
                vars.bird = true;
        }
        else if(settings["秦叔寶"] && current.map == 99 && current.enemy_hp1 == 8000 && current.enemy_hp2 == 6000){
                vars.Shubao = true;
        }
        else if(settings["氐人族戰士"] && current.map == 119 && current.enemy_hp1 == 7200 && current.enemy_hp3 == 7200){
                vars.warrior = true;
        }
        else if(settings["魚蝦蟹"] && current.map == 359 && current.enemy_hp1 == 3800 && current.enemy_hp2 == 5000 && current.enemy_hp3 == 4300){
                vars.seafood = true;
        }
        else if(settings["黑龍王"] && current.map == 358 && current.enemy_hp1 == 8000){
                vars.dragon = true;
        }
        else if(settings["刑天"] && current.map == 164 && current.enemy_hp1 == 15000){
                vars.xingtian = true;
        }
        else if(settings["盤古"] && current.map == 166 && current.enemy_hp1 == 17000){
                vars.pangu = true;
        }
        else if(settings["斛律安1"] && current.map == 199 && current.enemy_hp1 == 20000){
                vars.Luan1 = true;
        }
        else if(settings["上官震遠"] && current.map == 200 && current.enemy_hp1 == 18000){
                vars.Zhenyuan = true;
        }
        else if(settings["宇文拓1"] && current.map == 199 && current.enemy_hp1 == 23000){
                vars.Yuwentuo1 = true;
        }
        else if(settings["斛律安2"] && current.map == 227 && current.enemy_hp1 == 28000){
                vars.Luan2 = true;
        }
        else if(settings["韓騰1"] && current.map == 355 && current.enemy_hp1 == 20000){
                vars.Teng1 = true;
        }
        else if(settings["盜匪"] && current.map == 258 && current.enemy_hp1 == 680 && current.enemy_hp2 == 900 && current.enemy_hp3 == 680){
                vars.robbers = true;
        }
        else if(settings["韓騰2"] && current.map == 420 && current.enemy_hp1 == 30000){
                vars.Teng2 = true;
        }
        else if(settings["宇文拓2"] && current.map == 283 && current.enemy_hp1 >= 5 && current.enemy_hp1 <= 10000){
                vars.Yuwentuo2 = true;
        }
        else if(settings["尉遲嫣紅"] && current.map == 418 && current.enemy_hp1 == 40000){
                vars.summon = 0;
                vars.Yenhung = true;
        }
        else if(settings["尉遲嫣紅"] && current.map == 294 && current.enemy_hp1 == 50000){
                vars.summon = 0;
                vars.Xiaoxiao = true;
        }
        else if(settings["獨孤寧珂1"] && current.map == 584 && current.enemy_hp1 == 42000){
                vars.summon = 0;
                vars.Ningke1 = true;
        }
        else if(settings["獨孤寧珂2"] && current.map == 432 && current.enemy_hp1 == 42000){
                vars.summon = 0;
                vars.Ningke2 = true;
        }
        else if(settings["魔化師父"] && current.map == 414 && current.enemy_hp1 == 80000){
                vars.master = true;
        }
        else if(settings["阿拉花瓜"] && current.map == 52 && current.enemy_hp1 == 300 && current.enemy_hp2 == 300 && current.enemy_hp3 == 300 && current.enemy_hp4 == 300){
                vars.allahu_akbar = true;
        }


        else if(current.my_hp1 + current.my_hp2 + current.my_hp3 == 0){
                vars.jiaojing = false;
                vars.angryjiaojing = false;
                vars.skeleton = false;
                vars.tiger = false;
                vars.Yaojin = false;
                vars.Shuo = false;
                vars.fish = false;
                vars.bird = false;
                vars.Shubao = false;
                vars.warrior = false;
                vars.seefood = false;
                vars.dragon = false;
                vars.pangu = false;
                vars.Zhenyuan = false;
                vars.Luan2 = false;
                vars.Teng1 = false;
                vars.robbers = false;
                vars.Teng2 = false;
                vars.Yuwentuo2 = false;
                vars.summon = false;
                vars.Yenhung = false;
                vars.Xiaoxiao = false;
                vars.Ningke1 = false;
                vars.Ningke2 = false;
                vars.master = false;
                vars.over = false;
        }
}



isLoading{
	if(settings["Pause during F8"] && current.f8_pause == 0){
		return true;
	}
	else{
		return false;
	}
}

start{
	if(current.C1_level == 1 && current.map == 8 && current.mov == 0 && old.mov != 0){
		return true;
	}
	else{
		return false;
	}
}

reset{
	if(current.C1_level == 1 && current.map == 8 && current.mov == 0 && old.mov != 0){
		return true;
	}
	else{
		return false;
	}
}


split{
        if(current.my_hp1 + current.my_hp2 + current.my_hp3 == 0 && old.my_hp1 + old.my_hp2 + old.my_hp3 != 0){vars.over = true;}
        //鮫精
        if(vars.jiaojing == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.jiaojing = false;
                return true;
        }
        //怒意鮫精
        if(vars.angryjiaojing == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.angryjiaojing = false;
                return true;
        }
        //邪屍骷髏
        if(vars.skeleton == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.skeleton = false;
                return true;
        }
        //惡虎魔魅
        if(vars.tiger == true && current.enemy_hp2 == 0 && vars.over == false){
                vars.tiger = false;
                return true;
        }
        //程咬金
        if(vars.Yaojin == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.Yaojin = false;
                return true;
        }
        //楊碩
        if(vars.Shuo == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.Shuo = false;
                return true;
        }
        //火蝠魚精
        if(vars.fish == true && current.enemy_hp2 == 0 && vars.over == false){
                vars.fish = false;
                return true;
        }
        //鵁精
        if(vars.bird == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.bird = false;
                return true;
        }
        //秦叔寶
        if(vars.Shubao == true && current.enemy_hp1 + current.enemy_hp2 == 0 && vars.over == false){
                vars.Shubao = false;
                return true;
        }
        //氐人族戰士
        if(vars.warrior == true && current.enemy_hp1 + current.enemy_hp3 == 0 && vars.over == false){
                vars.warrior = false;
                return true;
        }
       /* //魚蝦蟹
        if(vars.seafood == true && current.enemy_hp1 + current.enemy_hp2 + current.enemy_hp3 == 0 && vars.over == false){
                vars.seafood = false;
                return true;
        }*/
        //黑龍王
        if(vars.dragon == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.dragon = false;
                return true;
        }
        //刑天  
        if(vars.xingtian == true && current.my_hp1 + current.my_hp2 == 0){
                vars.xingtian = false;
                return true;
        }
        //盤古
        if(vars.pangu == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.pangu = false;
                return true;
        }   
        //斛律安1
        if(vars.Luan1 == true && current.my_hp1 + current.my_hp2 + current.my_hp3 == 0){
                vars.Luan1 = false;
                return true;
        }
        //上官震遠
        if(vars.Zhenyuan == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.Zhenyuan = false;
                return true;
        } 
        //宇文拓1
        if(vars.Yuwentuo1 == true && current.my_hp1 + current.my_hp2 + current.my_hp3 == 0){
                vars.Yuwentuo1 = false;
                return true;
        }  
        //斛律安2
        if(vars.Luan2 == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.Luan2 = false;
                return true;
        }
        //韓騰1
        if(vars.Teng1 == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.Teng1 = false;
                return true;
        }  
        //盜匪
        if(vars.robbers == true && current.enemy_hp1 + current.enemy_hp2 + current.enemy_hp3 == 0 && vars.over == false){
                vars.robbers = false;
                return true;
        }  
        //韓騰2
        if(vars.Teng2 == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.Teng2 = false;
                return true;
        }  
        //宇文拓2
        if(vars.Yuwentuo2 == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.Yuwentuo2 = false;
                return true;
        } 
        //宇文拓3        
        if(settings["宇文拓3"] && current.map == 283 && current.enemy_hp1 == 30000 && current.my_hp1 + current.my_hp2 == 0 && vars.Yuwentuo3 == true){
                vars.Yuwentuo3 = false;
                return true;
        } 
        //尉遲嫣紅
        if(vars.Yenhung == true){
                if(old.enemy_hp3 != current.enemy_hp3){
                        vars.summon = true;
                }
                if(vars.summon == false && current.enemy_hp1 == 0 && vars.over == false){
                        vars.Yenhung = false;
                        vars.summon = false;
                        return true;
                }
                else if(vars.summon == true && current.enemy_hp1 + current.enemy_hp2 + current.enemy_hp3 == 0 && vars.over == false){
                        vars.Yenhung = false;
                        vars.summon = false;
                        return true;       
                }
        } 
        //單小小
        if(vars.Xiaoxiao == true){
                if(old.enemy_hp3 != current.enemy_hp3){
                        vars.summon = true;
                }
                if(vars.summon == false && current.enemy_hp1 == 0 && vars.over == false){
                        vars.Xiaoxiao = false;
                        vars.summon = false;
                        return true;
                }
                else if(vars.summon == true && current.enemy_hp1 + current.enemy_hp2 + current.enemy_hp3 == 0 && vars.over == false){
                        vars.Xiaoxiao = false;
                        vars.summon = false;
                        return true;       
                }
        } 
        //獨孤寧珂1
        if(vars.Ningke1 == true){
                if(old.enemy_hp3 != current.enemy_hp3){
                        vars.summon = true;
                }
                if(vars.summon == false && current.enemy_hp1 == 0 && vars.over == false){
                        vars.Ningke1 = false;
                        vars.summon = false;
                        return true;
                }
                else if(vars.summon == true && current.enemy_hp1 + current.enemy_hp2 + current.enemy_hp3 == 0 && vars.over == false){
                        vars.Ningke1 = false;
                        vars.summon = false;
                        return true;       
                }
        } 
        //獨孤寧珂2
        if(vars.Ningke2 == true){
                if(old.enemy_hp3 != current.enemy_hp3){
                        vars.summon = true;
                }
                if(vars.summon == false && current.enemy_hp1 == 0 && vars.over == false){
                        vars.Ningke2 = false;
                        vars.summon = false;
                        return true;
                }
                else if(vars.summon == true && current.enemy_hp1 + current.enemy_hp2 + current.enemy_hp3 == 0 && vars.over == false){
                        vars.Ningke2 = false;
                        vars.summon = false;
                        return true;       
                }
        } 
        //魔化師父
        if(vars.master == true && current.enemy_hp1 == 0 && vars.over == false){
                vars.master = false;
                return true;
        } 
        //阿拉花瓜
        if(vars.allahu_akbar == true && current.enemy_hp1 + current.enemy_hp2 + current.enemy_hp3 + current.enemy_hp4 == 0 && vars.over == false){
                vars.allahu_akbar = false;
                return true;
        } 
        //跳船
        if(settings["跳船"] && old.map == 79 && current.map == 66){
                return true;
        }

	//羅勒草100判定，需再煉妖介面確認羅勒草再離開
	if(settings["羅勒草x100(煉妖最後需看一眼羅勒草)"] && current.basil >= 99 && !vars.basil){  
		vars.basil = true;
		return true;
	}
	//玉兒結局
	if(current.map == 432 && current.mov != 0 && old.mov == 0){  
		return true;
	}
	//小雪結局
	else if(current.map == 412 && current.mov != 0 && old.mov == 0){  
		return true;	
	}
	else{
		return false;
	}
}
