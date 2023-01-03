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
			lang["Calculate the solution concentration"].str,
			240, 30,
			&calculateSolutionConcentration
		),
		new CalcButton(
			lang["Calculate salting time"].str,
			240, 30,
			&calculateSaltingTime
		),
		new CalcButton(
			lang["Calculate cheese price"].str,
			240, 30,
			&calculateCheesePrice
		)
	];
}

// return all 'Help' submenu items
MenuItem[] calculatorSubmenuItems() {
	return [
		new SubmenuItem(lang["Calculate the solution concentration"].str, 
			(MenuItem mi) {
				mi.addOnActivate(
					(mi) {
						calculateSolutionConcentration();
					}
				);
			}
		), 
		new SubmenuItem(lang["Calculate salting time"].str, 
			(mi) {
				mi.addOnActivate(
					(mi) {
						calculateSaltingTime();
					}
				);
			}
		), 
		new SubmenuItem(lang["Calculate cheese price"].str, 
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
		new SubmenuItem(lang["About"].str,		
			(mi) {
				mi.addOnActivate((mi) {
					Window about = new Window(lang["About"].str, 360, 210, 
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
		new SubmenuItem(lang["Quit"].str, 
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
		new SubmenuItem(lang["English"].str, 
			(mi) {
				mi.addOnActivate(
					(mi) {
						// if language config was updated successfully, restart the app
						if(changeLangConfig(LangCode.English)) {
							new DialogWindow(mainWindow, 
								lang["Info!"].str, 
								[lang["Quit now"].str, lang["OK"].str], 
								[ResponseType.YES, ResponseType.NO],
								new CustomDialogAction(lang["Interface language"].str,
									(r, d) {
										switch(r) with(ResponseType) {
											case YES:
												{	
													relaunch = true;
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
		new SubmenuItem(lang["Russian"].str, 
			(mi) {
				mi.addOnActivate(
					(mi) {
						// if language config was updated successfully, restart the app
						if(changeLangConfig(LangCode.Russian)) {
							new DialogWindow(mainWindow, 
								lang["Info!"].str, 
								[lang["Quit now"].str, lang["OK"].str], 
								[ResponseType.YES, ResponseType.NO],
								new CustomDialogAction(lang["Interface language"].str,
									(r, d) {
										switch(r) with(ResponseType) {
											case YES:
												{
													relaunch = true;
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
		new SubmenuItem(lang["Documentation"].str, 
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






