module menu.menubar;

// the meta gtkd package
import meta;

// the menu bar itself
class FromagoMenuBar : MenuBar {
	// constructor
	this() {
		// calling the parent's constructor
		super();
		
		// adding a 'Fromago' submenu header dropdown list and its submenu items
		append(new MenuHeader(lang["Fromago"].str, new Submenu(fromagoSubmenuItems())));
				
		// adding a 'Calculator' submenu header dropdown list and its submenu items
		append(new MenuHeader(lang["Calculator"].str, new Submenu(calculatorSubmenuItems())));
		
		// adding a 'Language' submenu header dropdown list and its submenu items
		append(new MenuHeader(lang["Language"].str, new Submenu(languageSubmenuItems())));
		
		// adding a 'Help' submenu header dropdown list and its submenu items
		append(new MenuHeader(lang["Help"].str, new Submenu(helpSubmenuItems())));
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










