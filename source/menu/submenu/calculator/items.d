module menu.submenu.calculator.items;

// the meta gtkd package
import meta;

// calculator submenu
import menu.submenu.calculator.solution.concentration;

// return all 'Help' submenu items
MenuItem[] calculatorSubmenuItems() {
	return [
		new SolutionConcentrationItem()
	];
}

class SolutionConcentrationItem : MenuItem {
	immutable label = "Calculate the solution concentration";
	
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