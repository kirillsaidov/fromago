module menu.submenu.file.items;

// the meta gtkd package
import meta;

// file submenu
import menu.submenu.file.newf;
import menu.submenu.file.open;
import menu.submenu.file.close;
import menu.submenu.file.save;
import menu.submenu.file.saveas;

// return all 'File' submenu items
auto fileSubmenuItems() {
	return [
		new NewFileItem(),
		new OpenFileItem(),
		new CloseFileItem(),
		new SaveFileItem(),
		new SaveAsFileItem()
	];
}

// new file item in the 'File' submenu dropdown list
class NewFileItem : MenuItem {
	immutable label = "New file";
	
	// constructor
	this() {
		// calling parent's constructor
		super(label);
		addOnActivate(&onClicked);
	}
	
	// execute when 'onClicked' is pressed
	void onClicked(MenuItem mi) {
		Main.quit();
	}
}

// open file item in the 'Fromago' submenu dropdown list
class OpenFileItem : MenuItem {
	immutable label = "Open file";
	
	// constructor
	this() {
		// calling parent's constructor
		super(label);
		addOnActivate(&onClicked);
	}
	
	// execute when 'onClicked' is pressed
	void onClicked(MenuItem mi) {
		//...
	}
}

// close file item in the 'File' submenu dropdown list
class CloseFileItem : MenuItem {
	immutable label = "Close file";
	
	// constructor
	this() {
		// calling parent's constructor
		super(label);
		addOnActivate(&onClicked);
	}
	
	// execute when 'onClicked' is pressed
	void onClicked(MenuItem mi) {
		Main.quit();
	}
}

// save item in the 'Fromago' submenu dropdown list
class SaveFileItem : MenuItem {
	immutable label = "Save";
	
	// constructor
	this() {
		// calling parent's constructor
		super(label);
		addOnActivate(&onClicked);
	}
	
	// execute when 'onClicked' is pressed
	void onClicked(MenuItem mi) {
		//...
	}
}

// save as item in the 'File' submenu dropdown list
class SaveAsFileItem : MenuItem {
	immutable label = "Save as";
	
	// constructor
	this() {
		// calling parent's constructor
		super(label);
		addOnActivate(&onClicked);
	}
	
	// execute when 'onClicked' is pressed
	void onClicked(MenuItem mi) {
		Main.quit();
	}
}



