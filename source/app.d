module app;

// the meta gtkd package
import meta;

import menu.menubar;
import buttons.layout;

void main(string[] args) {
	// load Fromago config files
	configSetup();
	
	// main window
	mainWindow = new Window(lang["Fromago Calc"].str, windowWidth, windowHeight, 
		(mw) {
			// add gui box element
			mw.add(new GUIBox(Orientation.VERTICAL, 0, 
				(b) {
					// packing the element into guibox
					b.packStart(new FromagoMenuBar(), false, false, 0);
					b.packStart(new ScrollLayout(
						(sw) {
							sw.add(new ButtonsLayout(getAllButtons(), 16, 9));
						}
					), false, false, 5);
				}
			));
		}
	);
}












