/*
Xuan-Yuan Sword 3 Beyond the Clouds and Mountains(SWD3) - ASL primarily by master_fiora
This ASL is compatible with Xuan-Yuan Sword 3 Beyond the Clouds and Mountains versions: V1.02DVD 
*/

state("swd3", "1.02DVD"){
	byte septem_level: "swd3.exe", 0xAB7BC;
	byte septem_exp: "swd3.exe", 0xAB790;
	uint money: "swd3.exe", 0xACBD0;
	uint map: "swd3.exe", 0xA9A10;
	uint weapon: "swd3.exe", 0xC8AD0, 0x4;
	byte f8_pause: "swd3.exe", 0xCC2AC;
	int bossHP : "swd3.exe", 0x12803C, 0x64; 
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
	vars.ASLVersion = "2020-08-15 for SWD3 DVD1.02";

	settings.Add("Pause during F8", true);
	settings.Add("First inf.money Split", true);
	
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
	if(current.map == 341){   //final ending
		return true;
	}
	else{
		return false;
	}

}
