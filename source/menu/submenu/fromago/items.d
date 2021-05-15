module menu.submenu.fromago.items;

// the meta gtkd package
import meta;

// fromago submenu
import menu.submenu.fromago.about;

// return all 'Fromago' submenu items
auto fromagoSubmenuItems() {
	return [
		new AboutItem(),
		new QuitItem()
	];
}

class QuitItem : MenuItem {
	immutable label = "Quit";
	
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

class AboutItem : MenuItem {
	immutable label = "About";
	
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

