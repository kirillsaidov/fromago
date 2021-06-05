module layout;

// the meta gtkd package
import meta;

// the submenu
import menu.submenu.about;
import menu.submenu.solution.concentration;
import menu.submenu.salting.time;
import menu.submenu.price;

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
			"Calculate salting time",
			240, 30,
			&calculateSaltingTime
		),
		new CalcButton(
			"Calculate cheese price",
			240, 30,
			&calculateCheesePrice
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
		new SubmenuItem("Calculate salting time", 
			(mi) {
				mi.addOnActivate(
					(mi) {
						calculateSaltingTime();
					}
				);
			}
		), 
		new SubmenuItem("Calculate cheese price", 
			(mi) {
				mi.addOnActivate(
					(mi) {
						calculateCheesePrice();
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
		new SeparatorMenuItem(),
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

// return all 'Language' submenu items
MenuItem[] languageSubmenuItems() {
	return [
		new SubmenuItem("English", 
			(mi) {
				mi.addOnActivate(
					(mi) {
						// if language config was updated successfully, restart the app
						if(changeLangConfig(LangCode.English)) {
							new DialogWindow(mainWindow, 
								"Info!", 
								["Quit now", "OK"], 
								[ResponseType.YES, ResponseType.NO],
								new CustomDialogAction("Interface language has been changed! Restart required for changes to take place!",
									(r, d) {
										switch(r) with(ResponseType) {
											case YES:
												{
													Main.quit();
												}
												break;
											case NO:
												{
													d.destroy();
												}
												break;
											default:
												break;
										}
									}
								)
							);					
						}
					}
				);
			}
		),
		new SubmenuItem("Russian", 
			(mi) {
				mi.addOnActivate(
					(mi) {
						// if language config was updated successfully, restart the app
						if(changeLangConfig(LangCode.Russian)) {
							new DialogWindow(mainWindow, 
								"Info!", 
								["Quit now", "OK"], 
								[ResponseType.YES, ResponseType.NO],
								new CustomDialogAction("Interface language has been changed! Restart required for changes to take place!",
									(r, d) {
										switch(r) with(ResponseType) {
											case YES:
												{
													Main.quit();
												}
												break;
											case NO:
												{
													d.destroy();
												}
												break;
											default:
												break;
										}
									}
								)
							);
						}
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






