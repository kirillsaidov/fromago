module config;

// std lib
import std.json: JSONValue, parseJSON;
import std.string: strip;
import std.stdio: File, readln;
import std.file: exists, mkdirRecurse;
import std.path: buildPath, expandTilde;
import std.conv: to;
import std.process: env = environment;

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
        if(!configDir.exists) {
            configDir.mkdirRecurse;
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
    string configDir;
    enum configFileLang = "lang.config";
    static this() {
        configDir = env.get("HOME", env.get("APPDATA", "USERPROFILE"));
    }

    // returns the code of the language (it looks for language.config file in )
    LangCode loadLangConfig() {	
        // check if file exists, if not, create the file; get the lang code
        LangCode langCode = LangCode.English;
        if(!configDir.buildPath(configFileLang).exists) {
            auto file = File(configDir.buildPath(configFileLang), "w");
            file.writeln(langCode);
            file.close();
        } else {
            auto file = File(configDir.buildPath(configFileLang), "r");            
            langCode = file.readln.strip.to!LangCode;
            file.close();
        }
    
        return langCode;
    }
    
    // save file config
    void saveLangConfig(LangCode langCode) {		
        // save the config
        auto file = File(configDir.buildPath(configFileLang), "w");        
        file.writeln(langCode);
        file.close();
    }
}








