module config;

// std lib
import std.json: JSONValue, parseJSON;
import std.string: strip;
import std.stdio: File, readln;
import std.file: exists, mkdir;
import std.path: buildPath;
import std.conv: to;

// localization support
import localization;

// public variables
public {
	// language code (localization)
	LangCode languageCode = LangCode.English;
	
	// Localization language
	JSONValue lang;
	
	// language codes
	enum LangCode: string {
		English = "English",
		Russian = "Russian", 
	}
	
	// sets up a config directory for the application
	void configSetup() {
		// check if config directory exists
		if(!configdir.exists) {
			configdir.mkdir;
		}
		
		// get language code (load language config file)
		languageCode = loadLangConfig();
		
		// load localization dictionary
		lang = parseJSON(dictionary)[languageCode];
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








