/*
Xuan-Yuan Sword VII - ASL primarily by master_fiora
This ASL is compatible with Xuan-Yuan Sword VII versions
*/

state("SWD7-Win64-Shipping", "Steam 1.04"){
	double igt: "SWD7-Win64-Shipping.exe", 0x3F20160, 0x20, 0xE00, 0x7B8, 0x640, 0x1C8, 0xB0, 0x1B0;
	uint test: "SWD7-Win64-Shipping.exe", 0x0;
}

state("SWD7-Win64-Shipping", "Steam 1.10"){
	double igt: "SWD7-Win64-Shipping.exe", 0x3EAF100, 0x28, 0x2A8, 0x1B0;
	uint test: "SWD7-Win64-Shipping.exe", 0x0;
}

startup{
	settings.Add("20201220 Release notes: V1.10 updated", false);
	settings.Add("Reset on start swd7", true);
	settings.Add("BOSS AutoSplit", true, "BOSS AutoSplit");
		settings.Add("BOSS1", true, "炎顱", "BOSS AutoSplit");
		settings.Add("BOSS2", true, "檮杌", "BOSS AutoSplit");
		settings.Add("BOSS3", true, "鑾魃", "BOSS AutoSplit");
		settings.Add("BOSS4", true, "女丑", "BOSS AutoSplit");
		settings.Add("BOSS5", true, "機獸", "BOSS AutoSplit");
		settings.Add("BOSS6", true, "孫恪", "BOSS AutoSplit");
		settings.Add("BOSS7", true, "乙人", "BOSS AutoSplit");
		settings.Add("BOSS8", true, "琉璃", "BOSS AutoSplit");
		settings.Add("BOSS9", true, "莫煌", "BOSS AutoSplit");
		settings.Add("BOSS10", true, "黑龍", "BOSS AutoSplit");

	vars.ASLVersion = "2020-12-20 for SWD7 V1.10";
	vars.logFilePath = Directory.GetCurrentDirectory() + "\\SWD7-Autosplitter.log"; //same folder as LiveSplit.exe
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
	//gamestate
	refreshRate = 120; //same value as game-fpsrate
	
	byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			exeMD5HashBytes = md5.ComputeHash(s); 
		} 
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	print("MD5Hash: " + MD5Hash.ToString()); //DebugView
	
	if(MD5Hash == "B91C1C166BF32B7642B6308923436C35"){
		version = "Steam 1.04"; 
		vars.log("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}
	else if(MD5Hash == "10BADCA2B382ADDBD6A65F7325A30D08"){
		version = "Steam 1.04"; 
		vars.log("other game version: " + version + " - MD5Hash: " + MD5Hash);	
	}
	else if(MD5Hash == "1A72D3D6D12943DA5BCBF82D983FE05C"){
		version = "Steam 1.10"; 
		vars.log("other game version: " + version + " - MD5Hash: " + MD5Hash);	
	}
	
	else{
		version = "unknown version"; 
		vars.log("Unknown version: " + version + " - MD5Hash: " + MD5Hash);	
	}
}

start
{
    if (current.igt > old.igt && old.igt == 0){
        vars.totalGameTime = 0;
		print("Loading time: " + current.igt.ToString()); //DebugView
        return true;
    }
}

update
{
	//print("Loading time: " + current.igt.ToString()); //DebugView
}

gameTime
{
	return TimeSpan.FromSeconds(current.igt);
}
