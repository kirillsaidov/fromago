module menu.menubar;

// the meta gtkd package
import meta;

// the submenu
import menu.submenu.fromago.items;
import menu.submenu.file.items;
import menu.submenu.edit.items;

// the menu bar itself
class FromagoMenuBar : MenuBar {
	// constructor
	this() {
		// calling the parent's constructor
		super();
		
		// adding a 'Fromago' submenu header dropdown list and its submenu items
		append(new MenuHeader("Fromago", new Submenu(fromagoSubmenuItems())));
		
		// adding a 'File' submenu header dropdown list and its submenu items
		append(new MenuHeader("File", new Submenu(fileSubmenuItems())));
		
		// adding a 'Edit' submenu header dropdown list and its submenu items
		append(new MenuHeader("Edit", new Submenu(editSubmenuItems())));
		
		//...
		append(new MenuHeader("Calculator", new Submenu([new QuitItem()])));
		
		// adding a 'Help' submenu header dropdown list and its submenu items
		append(new MenuHeader("Help", new Submenu([
			new AboutItem(), 
			new DocumentationItem()
		])));
	}
}

// a submenu header dropdown list in the menu bar
class MenuHeader : MenuItem {
	// constructor
	this(const string headerTitle, Menu submenu) {
		// calling parent's constructor
		super(headerTitle);
		
		// adding a submenu item
		setSubmenu(submenu);
	}
}

// a submenu containing a list of menu items
class Submenu : Menu {	
	// constructor
	this(MenuItem[] mi) {
		// calling parent's constructor
		super();
		
		// adding an items to submenu
		foreach(s; mi) {
			append(s);
		}
	}
}

/* ------------------------------ Help submenu items ------------------------------- */

// exit label in the 'File' dropdown list
class DocumentationItem : MenuItem {
	immutable quitLabel = "Documentation";
	
	// constructor
	this() {
		// calling parent's constructor
		super(quitLabel);
		addOnActivate(&quit);
	}
	
	// execute when 'Quit' is pressed
	void quit(MenuItem mi) {
		Main.quit();
	}
}

// exit label in the 'File' dropdown list
class AboutItem : MenuItem {
	immutable quitLabel = "About";
	
	// constructor
	this() {
		// calling parent's constructor
		super(quitLabel);
		addOnActivate(&quit);
	}
	
	// execute when 'Quit' is pressed
	void quit(MenuItem mi) {
		Main.quit();
	}
}


