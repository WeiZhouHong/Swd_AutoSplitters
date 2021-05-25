/*
Xuan-Yuan Sword 3 The Scar of the Sky(SWD3E) - ASL primarily by master_fiora
This ASL is compatible with Xuan-Yuan Sword 3 The Scar of the Sky: V2.0 DVD (TW)
最後更新日期：2021/05/23
*/

state("swd3eDvd", "2.00 DVD(TW)"){	
	byte C1_level: "swd3eDvd.exe", 0xC7F2C;	//阿仇等級
	byte f8_pause: "swd3eDvd.exe", 0xE9CF0; //遊戲是否暫停
	uint map: "swd3eDvd.exe", 0xC6178;	//所在地圖編號
	uint mov: "swd3eDvd.exe", 0x17B60C;	//動畫判定
}


startup{
	settings.Add("20200927 Release notes: 隱藏絕技經驗顯示列印(Swd3e-Autosplitter.log)", false);
	settings.Add("Show Skill EXP", false);
	settings.Add("Pause during F8", true);
	
	vars.ASLVersion = "1.04";
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

}

init
{	
	//gamestate
	refreshRate = 33; //same value as game-fpsrate
	vars.kill = 0; 	//解決敵人數
	
}


update{
	if(current.C1_skill > old.C1_skill && settings["Show Skill EXP"]){
		vars.kill = vars.kill + 1;
		vars.log("殺敵數：" + vars.kill + "，隱藏經驗：" + current.C1_skill );	
	}
	else if(current.map != old.map){
		vars.nextmap = true;
	}
}


isLoading{
	if(current.f8_pause == 0){
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

