/*
Xuan-Yuan Sword 3 Beyond the Clouds and Mountains(SWD3)
This ASL is compatible with Xuan-Yuan Sword 3 Beyond the Clouds and Mountains versions: V1.02DVD
ASL primarily by master_fiora
2023.10.23 add split by EME
*/

state("swd3", "1.02DVD"){
	byte septem_level: "swd3.exe", 0xAB7BC;
	byte septem_exp: "swd3.exe", 0xAB790;
	uint money: "swd3.exe", 0xACBD0;
	uint map: "swd3.exe", 0xA9A10;
	uint weapon: "swd3.exe", 0xC8AD0, 0x4;
	byte f8_pause: "swd3.exe", 0xCC2AC;
	int bossHP : "swd3.exe", 0x12803C, 0x64; 

        int my_hp1 : "swd3.exe", 0x12027C;
        int my_hp2 : "swd3.exe", 0x120280;
        int my_hp3 : "swd3.exe", 0x120284;
        int my_hp4 : "swd3.exe", 0x120288;
        int enemy_hp1 : "swd3.exe", 0x125514, 0x64;
        int enemy_hp2 : "swd3.exe", 0x12803C, 0x64;
        int enemy_hp3 : "swd3.exe", 0x12AB64, 0x64;
        int satan_hp : "swd3.exe", 0x12FD34;
}

state("swd3", "1.02CD"){ 
	byte septem_level: "swd3.exe", 0xACDFC;
	byte septem_exp: "swd3.exe", 0xACDD0;
	uint money: "swd3.exe", 0xACBD0; //
	uint map: "swd3.exe", 0xAB050;
	uint weapon: "swd3.exe", 0xC8AD0, 0x4;//
	byte f8_pause: "swd3.exe", 0xCAB5C;
	int bossHP : "swd3.exe", 0x12803C, 0x64;  //
	
}


startup{
	vars.ASLVersion = "2023-11-03 for SWD3 DVD1.02";

	settings.Add("Pause during F8", true);
	
	vars.logFilePath = Directory.GetCurrentDirectory() + "\\SWD3-Autosplitter.log"; //same folder as LiveSplit.exe
	vars.log = (Action<string>)((string logLine) => {
		string time = System.DateTime.Now.ToString("dd/MM/yy hh:mm:ss:fff");
		System.IO.File.AppendAllText(vars.logFilePath, time + ": " + logLine + "\r\n");
	});
	try{
		vars.log("ASL file loaded(" + vars.ASLVersion + ")");
	}
	catch (System.IO.FileNotFoundException e){
		System.IO.File.Create(vars.logFilePath);
		vars.log("Autosplitter loaded, log file created");
	}

        settings.Add("BOSS");
        settings.Add("SCENE");
        settings.CurrentDefaultParent = "BOSS";
                settings.Add("梅羅文加軍人");
                settings.Add("獢");
                settings.Add("火刑場麥爾斯");
                settings.Add("修道院院長");
                settings.Add("弒肉妖");
                settings.Add("康那里士1");
                settings.Add("高地骷髏怪");
                settings.Add("姆斯比爾");
                settings.Add("藍魔神本體");
                settings.Add("石猴");
                settings.Add("恐懼之王");
                settings.Add("機關三魔獸1");
                settings.Add("薇達");
                settings.Add("麥爾斯&黑衣大食");
                settings.Add("蜃樓王");
                settings.Add("機關三魔獸2");
                settings.Add("機關三魔獸3");
                settings.Add("木鐵人");
                settings.Add("黃八");
                settings.Add("夜叉悟緣");
                settings.Add("羯羊妖機");
                settings.Add("雨丹子五鬼");
                settings.Add("雨丹子");
                settings.Add("康那里士2");
                settings.Add("撒旦麥爾斯");
                settings.Add("撒旦賽特");
                settings.Add("撒旦");
        settings.CurrentDefaultParent = "SCENE";
                settings.Add("波希頓石像");
                settings.Add("塔德莫爾");
                settings.Add("五年後");
                settings.Add("回現實");
}

init
{
	var nextmap = false;
	var buy = false;
	var nextweapon = false;
	var s_boss = false;
	byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			exeMD5HashBytes = md5.ComputeHash(s); 
		} 
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	print("MD5Hash: " + MD5Hash.ToString()); //Lets DebugView show me the MD5Hash of the game executable
	
	if(MD5Hash == "96595AC57EB3A54FCF57A313805B8C53"){
		version = "1.02DVD SP fixed"; //白金典藏怒氣修正版
		vars.log("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}
	else if(MD5Hash == "6F8A73425107E6E9D1F80F5ADA9C59C5"){
		version = "1.02DVD SP"; //官方白金典藏版
		vars.log("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}
	else if(MD5Hash == "22A6E514F10C4229AA0A1198C67412F9"){
		version = "1.02DVD"; //DVD紀念版
		vars.log("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}
	else if(MD5Hash == "F022A0DE4A45963DE56BAE9B881419EA"){
		version = "1.02CD"; //官方網站更新檔
		vars.log("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}
	else if(MD5Hash == "BA359F975B0E85AEB6A3F249CD8D1643"){
		version = "1.0CD"; //初版
		vars.log("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}
	else{
		version = "other"; //其他版
		vars.log("other game version: " + version + " - MD5Hash: " + MD5Hash);	
	}

        vars.soldier = false;
        vars.Chow = false;
        vars.fireMiles = false;
        vars.abbot = false;
        vars.meateating = false;
        vars.Cornelius1 = false;
        vars.skeleton = false;
        vars.msbull = false;
        vars.blue = false;
        vars.monkey = false;
        vars.fear = false;
        vars.mechanism1 = false;
        vars.Wedar = false;
        vars.Abbasid = false;
        vars.mirage = false;
        vars.mechanism2 = false;
        vars.mechanism3 = false;
        vars.ironman = false;
        vars.Huang8 = false;
        vars.yaksha = false;
        vars.goat = false;
        vars.rain5 = false;
        vars.rain = false;
        vars.Cornelius2 = false;
        vars.satan_Miles = false;
        vars.satan_set = false;
        vars.satan = false;

        vars.Poseidon = false;
        vars.Beirut = false;
}

isLoading{
	if(settings["Pause during F8"] && current.f8_pause == 0){
		return true;
	}
	else{
		return false;
	}
}

update{
	if(current.money != old.money){
		vars.buy = true;
	}
	else if(current.map != old.map){
		vars.nextmap = true;
	}
	else if(current.weapon != old.weapon){
		vars.nextweapon = true;
	}
	else if(current.bossHP != old.bossHP){
		vars.s_boss = true;
	}

        if(settings["梅羅文加軍人"] && current.map == 81 && current.enemy_hp1 == 15){
                vars.soldier = true;
        }
        else if(settings["獢"] && current.map == 32 && current.enemy_hp1 == 120){
                vars.Chow = true;
        }
        else if(settings["火刑場麥爾斯"] && current.map == 20 && current.enemy_hp1 == 160){
                vars.fireMiles = true;   
        }
        else if(settings["修道院院長"] && current.map == 72 && current.enemy_hp1 == 135 && current.enemy_hp2 == 135 && current.enemy_hp3 == 135){
                vars.abbot = true;
        }
        else if(settings["弒肉妖"] && current.map == 118 && current.enemy_hp1 == 480){
                vars.meateating = true;
        }
        else if(settings["康那里士1"] && current.map == 168 && current.enemy_hp1 == 109315248){
                vars.Cornelius1 = true;
        }
        else if(settings["高地骷髏怪"] && current.map == 151 && current.enemy_hp1 == 700){
                vars.skeleton = true;
        }
        else if(settings["姆斯比爾"] && current.map == 50 && current.enemy_hp1 == 109184776){
                vars.msbull = true;
        }
        else if(settings["藍魔神本體"] && current.map == 170 && current.enemy_hp3 == 109645228){
                vars.blue = true;
        }
        else if(settings["石猴"] && current.map == 270 && current.enemy_hp1 == 3500){
                vars.monkey = true;
        }
        else if(settings["恐懼之王"] && current.map == 276 && current.enemy_hp2 == 110105480){
                vars.fear = true;
        }
        else if(settings["機關三魔獸1"] && current.map == 196 && current.enemy_hp1 == 110172016){
                vars.mechanism1 = true;
        }
        else if(settings["薇達"] && current.map == 250 && current.enemy_hp1 == 800){
                vars.Wedar = true;
        } 
        else if(settings["麥爾斯&黑衣大食"] && current.map == 213 && current.enemy_hp1 == 220 && current.enemy_hp2 == 220 & current.enemy_hp3 == 160){
                vars.Abbasid = true;
        }
        else if(settings["蜃樓王"] && current.map == 43 && current.enemy_hp1 == 2500 && current.enemy_hp2 == 3500 && current.enemy_hp3 == 110433160){
                vars.mirage = true;
        }
        else if(settings["機關三魔獸2"] && current.map == 158 && current.enemy_hp1 == 3000 && current.enemy_hp2 == 110172016){
                vars.mechanism2 = true; 
        }
        else if(settings["機關三魔獸3"] && current.map == 283 && current.enemy_hp1 == 3000 && current.enemy_hp2 == 110172016){
                vars.mechanism3 = true;
        }
        else if(settings["木鐵人"] && current.map == 102 && current.enemy_hp1 == 110693804){
                vars.ironman = true;
        }
        else if(settings["黃八"] && current.map == 315 && current.enemy_hp1 == 110892712){
                vars.Huang8 = true;
        } 
        else if(settings["夜叉悟緣"] && current.map == 317 && current.enemy_hp1 == 8000){
                vars.yaksha = true;
        }
        else if(settings["羯羊妖機"] && current.map == 313 && current.enemy_hp1 == 110967448){
                vars.goat = true;
        }
        else if(settings["雨丹子五鬼"] && current.map == 193 && current.enemy_hp1 == 111161056){
                vars.rain5 = true;
        }
        else if(settings["雨丹子"] && current.map == 153 && current.enemy_hp1 == 111164056){
                vars.rain = true;
        }
        else if(settings["康那里士2"] && current.map == 291 && current.enemy_hp1 == 110964948){
                vars.Cornelius2 = true;
        }
        else if(settings["撒旦麥爾斯"] && current.map == 171 && current.enemy_hp1 == 110562832 && current.enemy_hp2 == 110633368 && current.enemy_hp3 == 30000){
                vars.satan_Miles = true;
        }
        else if(settings["撒旦賽特"] && current.map == 318 && current.enemy_hp1 == 112096560 && current.enemy_hp2 == 112162096){
                vars.satan_set = true;
        } 
        else if(settings["撒旦"] && current.map == 337 && current.satan_hp == 41000){
                vars.satan = true;
        }
        
        if(settings["波希頓石像"] && current.map == 178 && current.enemy_hp1 == 109773000 && current.enemy_hp2 == 109772980 && current.enemy_hp3 == 109772990){
                vars.Poseidon = true;
        }
        if(settings["塔德莫爾"] && old.map == 144 && current.map == 200){
                vars.Beirut = true;
        }
}

start{
	if(current.septem_level == 2 && current.septem_exp == 20 && current.map == 81){
		return true;
	}
	else{
		return false;
	}
}

split{
        //梅羅文加軍人
        if(vars.soldier == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.soldier = false;
                return true;
        }
        //獢
        if(vars.Chow == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.Chow = false;
                return true;
        }
        //火刑場麥爾斯
        if(vars.fireMiles == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.fireMiles = false;
                return true;
        }
        //修道院院長
        if(vars.abbot == true && current.enemy_hp2 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.abbot = false;
                return true;
        }
        //弒肉妖
        if(vars.meateating == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.meateating = false;
                return true;
        }
        //移動島康那里士
        if(vars.Cornelius1 == true && current.enemy_hp1 == 109314048 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.Cornelius1 = false;
                return true;
        }
        //高地骷髏怪
        if(vars.skeleton == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.skeleton = false;
                return true;
        }
        //姆斯比爾
        if(vars.msbull == true && current.enemy_hp1 == 109182976 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.msbull = false;
                return true;
        } 
        //藍魔神本體
        if(vars.blue == true && current.enemy_hp3 == 109641728 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.blue = false;
                return true;
        }
        //石猴
        if(vars.monkey == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.monkey = false;
                return true;
        }
        //恐懼之王
        if(vars.fear == true && current.enemy_hp2 == 110100480 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.fear = false;
                return true;
        }
        //機關三魔獸1
        if(vars.mechanism1 == true && current.enemy_hp1 == 110166016 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.mechanism1 = false;
                return true;
        }
        //薇達
        if(vars.Wedar == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.Wedar = false;
                return true;
        }
        //麥爾斯&黑衣大食
        if(vars.Abbasid == true && old.map == 213 && current.map == 108){
                vars.Abbasib = false;
                return true;
        }
        //蜃樓王
        if(vars.mirage == true && current.enemy_hp3 == 110428160 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.mirage = false;
                return true;
        }
        //機關三魔獸2
        if(vars.mechanism2 == true && current.enemy_hp1 == 0 && current.enemy_hp2 == 110166016 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.mechanism2 = false;
                return true;
        }
        //機關三魔獸3
        if(vars.mechanism3 == true && current.enemy_hp1 == 0 && current.enemy_hp2 == 110166016 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.mechanism3 = false;
                return true;
        }
        //木鐵人
        if(vars.ironman == true && current.enemy_hp1 == 110690304 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.ironman = false;
                return true;
        }
        //黃八
        if(vars.Huang8 == true && current.enemy_hp1 == 110886912 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.Huang8 = false;
                return true;
        }
        //夜叉悟緣
        if(vars.yaksha == true && current.enemy_hp1 == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.yaksha = false;
                return true;
        }
        //羯羊妖機
        if(vars.goat == true && current.enemy_hp1 == 110952448 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.goat = false;
                return true;
        }
        //雨丹子五鬼
        if(vars.rain5 == true && current.enemy_hp1 == 111149056 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.rain5 = false;
                return true;
        }
        //雨丹子
        if(vars.rain == true && current.enemy_hp1 == 111149056 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.rain = false;
                return true;
        }
        //宅內康那里士
        if(vars.Cornelius2 == true && current.enemy_hp1 == 110952448 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.Cornelius2 = false; 
                return true;
        }
        //撒旦麥爾斯
        if(vars.satan_Miles == true && current.enemy_hp2 == 110624768 && current.my_hp1 == 0){
                vars.satan_Miles = false;
                return true;
        }
        //撒旦賽特
        if(vars.satan_set == true && current.enemy_hp1 == 112066560 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.satan_set = false;
                return true;
        }
        //撒旦
        if(vars.satan == true && current.satan_hp == 0 && current.my_hp1 + current.my_hp2 + current.my_hp3 + current.my_hp4 != 0){
                vars.satan = false;
                return true;
        }

        //波希頓石像
        if(vars.Poseidon == true && old.map == 188 && current.map == 178){
                vars.Poseidon = false;
                return true;
        }
        //塔德莫爾
        if(vars.Beirut == true && current.map == 269){
                vars.Beirut = false;
                return true; 
        }
        //五年後
        if(settings["五年後"] && old.map == 120 && current.map == 91){
                return true;
        }
        //從五年後回現實
        if(settings["回現實"] && old.map == 194 && current.map == 161){
                return true;
        }

	if(current.map == 341){   //final ending
		return true;
	}
	else{
		return false;
	}

}
