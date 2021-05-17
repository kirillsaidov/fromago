module config;

// the meta gtkd package
import meta;

// the submenu
import menu.submenu.about;
import menu.submenu.solution.concentration;
import menu.submenu.substance.quantity;

// buttons
import buttons.calcbutton;

// returns a list of all buttons
auto getAllButtons() {
	return [
		new CalcButton(
			"Calculate the solution concentration",
			240, 30,
			&calculateSolutionConcentration
		),
		new CalcButton(
			"Calculate substance quantity",
			240, 30,
			&calculateSubstanceQuantity
		)
	];
}

// return all 'Help' submenu items
MenuItem[] calculatorSubmenuItems() {
	return [
		new SubmenuItem("Calculate the solution concentration", 
			(MenuItem mi) {
				mi.addOnActivate(
					(mi) {
						calculateSolutionConcentration();
					}
				);
			}
		), 
		new SubmenuItem("Calculate substance quantity", 
			(mi) {
				mi.addOnActivate(
					(mi) {
						calculateSubstanceQuantity();
					}
				);
			}
		)
	];
}

// return all 'Fromago' submenu items
MenuItem[] fromagoSubmenuItems() {
	return [
		new SubmenuItem("About",		
			(mi) {
				mi.addOnActivate((mi) {
					Window about = new Window("About", 360, 210, 
						(mw) {
							mw.add(new GUIBox(Orientation.VERTICAL, 0, (Box b) {
							// packing the element into guibox
							b.packStart(new TextDrawingArea(), true, true, 0);
						}));
					});
				});
			}
		),
		new SubmenuItem("Quit", 
			(mi) {
				mi.addOnActivate(
					(mi) {
						Main.quit();
					}
				);
			}
		)
	];
}

// return all 'Help' submenu items
MenuItem[] helpSubmenuItems() {
	return [
		new SubmenuItem("Documentation", 
			(mi) {
				mi.addOnActivate(
					(mi) {
						Main.quit();
					}
				);
			}
		)
	];
}