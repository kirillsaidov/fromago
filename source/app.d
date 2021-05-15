module app;

// the meta gtkd package
import meta;

import menu.menubar;
import buttons.layout;

void main(string[] args) {
	// main window
	Window mainWindow = new Window("Fromago Calc", windowWidth, windowHeight, (MainWindow mw) {
		// add gui box element
		mw.add(new GUIBox(Orientation.VERTICAL, 0, (Box b) {
			// packing the element into guibox
			b.packStart(new FromagoMenuBar(), false, false, 0);
			b.packStart(new ScrollLayout(), false, false, 5);
		}));
	});
}













