module menu.submenu.edit.items;

// the meta gtkd package
import meta;

// edit submenu
import menu.submenu.edit.changefont;

// return all 'Edit' submenu items
MenuItem[] editSubmenuItems() {
	return [
		new ChangeFont()
	];
}

// new file item in the 'Edit' submenu dropdown list
class ChangeFont : MenuItem {
	immutable label = "Change font";
	
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

