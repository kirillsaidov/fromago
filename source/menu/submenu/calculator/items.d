module menu.submenu.calculator.items;

// the meta gtkd package
import meta;

// calculator submenu
import menu.submenu.calculator.solution.concentration;
import menu.submenu.calculator.substance.quantity;

// return all 'Help' submenu items
MenuItem[] calculatorSubmenuItems() {
	return [
		new SubmenuItem("Calculate the solution concentration", (MenuItem mi) {
			mi.addOnActivate(delegate void(MenuItem mi) {
				calculateSolutionConcentration();
			});
		}), 
		new SubmenuItem("Calculate substance quantity", (MenuItem mi) {
			mi.addOnActivate(delegate void(MenuItem mi) {
				calculateSubstanceQuantity();
			});
		})
	];
}













