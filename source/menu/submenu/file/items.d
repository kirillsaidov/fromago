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



