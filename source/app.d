module app;

// the meta gtkd package
import meta;

import menu.menubar;

void main(string[] args) {
	// init GTK
	Main.init(args);
	
	// custom gui
	GUI gui = new GUI();
	
	// run GTK
	Main.run();
}

// GUI window app
class GUI : MainWindow {
	// variables
	immutable windowTitle = "Fromago Calc";
	immutable windowWidth = 640;
	immutable windowHeight = 480;
		
	this() {
		// call the parent constructor
		super(windowTitle);
		
		// attach onDestroy function
		addOnDestroy(&quitApp);	
		
		// set window size
		setSizeRequest(windowWidth, windowHeight);
		
		// add gui box
		GUIBox guibox = new GUIBox();
		add(guibox);
		
		// run the app
		showAll();
	}
	
		
	void quitApp(Widget widget) {		
		// quit
		Main.quit();
	}
}

// menu bar box
class GUIBox : Box {
	immutable padding = 10;
	
	this() {
		// calling parent's constructor
		super(Orientation.VERTICAL, padding);
		
		// creating a menu bar
		FromagoMenuBar menuBar = new FromagoMenuBar();
    	packStart(menuBar, false, false, 0);		
	}
}









