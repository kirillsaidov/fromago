module config;

import std.string: strip;
import std.stdio: File, readln;
import std.file: exists, mkdir;
import std.path: buildPath;
import std.conv: to;

// public variables
public {
	// language code (localization)
	LangCode languageCode = LangCode.English;
	
	// language codes
	enum LangCode: ubyte {
		English = 0,
		Russian, 
	}
	
	// sets up a config directory for the application
	void configSetup() {
		// check if config directory exists
		if(!configdir.exists) {
			configdir.mkdir;
		}
	
		languageCode = loadLangConfig();
	}
	
	// changes the language of Fromago and saves it
	bool changeLangConfig(LangCode langCode) {		
		if(languageCode != langCode) {
			saveLangConfig(langCode);
			return true;
		}
		
		return false;
	}
}

private {
	// config directories and files
	immutable string configdir = ".config";
	immutable string configlang = "lang.config";
	immutable string path_configlang = buildPath(configdir, configlang);

	// returns the code of the language (it looks for language.config file in )
	LangCode loadLangConfig() {	
		// check if file exists, if not, create the file; get the lang code
		LangCode langCode = LangCode.English;
		if(!path_configlang.exists) {
			auto file = File(path_configlang, "w");
			file.write(LangCode.English);
			file.close();
		} else {
			auto file = File(path_configlang, "r");
			langCode = file.readln().strip().to!LangCode;
			file.close();
		}
	
		return langCode;
	}
	
	// save file config
	void saveLangConfig(LangCode langCode) {		
		// save the config
		auto file = File(path_configlang, "w");
		file.write(langCode);
		file.close();
	}
}








