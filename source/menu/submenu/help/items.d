module menu.submenu.help.items;

// the meta gtkd package
import meta;

// help submenu
import menu.submenu.help.documentation;

// return all 'Help' submenu items
MenuItem[] helpSubmenuItems() {
	return [
		new DocumentationItem()
	];
}

class DocumentationItem : MenuItem {
	immutable label = "Documentation";
	
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