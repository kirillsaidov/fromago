module config;

// std lib
import std.json: JSONValue, parseJSON;
import std.string: strip;
import std.stdio: File, readln;
import std.file: exists, mkdirRecurse, getcwd;
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
		if(!getConfigPath.exists) {
			getConfigPath.mkdirRecurse;
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
	immutable string configDir = "Users".buildPath("Shared").buildPath("Fromago");
	immutable string configFileLang = "lang.config";

	// returns the code of the language (it looks for language.config file in )
	LangCode loadLangConfig() {	
		// check if file exists, if not, create the file; get the lang code
		LangCode langCode = LangCode.English;
		if(!getConfigPath.buildPath(configFileLang).exists) {
			auto file = File(getConfigPath.buildPath(configFileLang), "w");
			scope(exit) { file.close(); }
			
			file.writeln(langCode);
		} else {
			auto file = File(getConfigPath.buildPath(configFileLang), "r");
			scope(exit) { file.close(); }
			
			langCode = file.readln.strip.to!LangCode;
		}
	
		return langCode;
	}
	
	// save file config
	void saveLangConfig(LangCode langCode) {		
		// save the config
		auto file = File(getConfigPath.buildPath(configFileLang), "w");
		scope(exit) { file.close(); }
		
		file.writeln(langCode);
	}
	
	// returns path to fromago config directory
	string getConfigPath() {
		return getcwd.buildPath(configDir);
	}
}








