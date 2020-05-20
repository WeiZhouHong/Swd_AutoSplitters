/*
Xuan-Yuan Sword 3 Beyond the Clouds and Mountains(SWD3) - ASL primarily by master_fiora
This ASL is compatible with Xuan-Yuan Sword 3 Beyond the Clouds and Mountains versions: V1.02CD, V1.02DVD 
*/

state("swd3", "1.02DVD"){
	byte septem_level: "swd3.exe", 0xAB7BC;
	byte septem_exp: "swd3.exe", 0xAB790;
	uint map: "swd3.exe", 0xA9A10;
	byte f8_pause: "swd3.exe", 0xCC2AC;
}

state("swd3", "1.02CD"){ 
	byte septem_level: "swd3.exe", 0xACDFC;
	byte septem_exp: "swd3.exe", 0xACDD0;
	uint map: "swd3.exe", 0xAB050;
	byte f8_pause: "swd3.exe", 0xCAB5C;
}


startup{
	settings.Add("Pause during F8", true);
}

init
{
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
	
	if(MD5Hash == "f022a0de4a45963de56bae9b881419ea"){
		version = "1.02CD";
	}
	else{
		version = "1.02DVD";
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
	if(current.septem_level == 2 && current.septem_exp == 20 && current.map == 81){
		return true;
	}
	else{
		return false;
	}
}

split{
	if(current.map == 341){
		return true;
	}
	else{
		return false;
	}
}