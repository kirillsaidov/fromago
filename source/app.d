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
		
	this() {
		// call the parent constructor
		super(windowTitle);
		
		// set window size
		setSizeRequest(windowWidth, windowHeight);
		
		// attach onDestroy function
		addOnDestroy(&quitApp);
		
		// attach onScroll function
		addOnScroll(&onScroll);
				
		// add gui box element to it
		GUIBoxMain gbm = new GUIBoxMain();
		add(gbm);
				
		// run the app
		showAll();
	}
		
	void quitApp(Widget widget) {		
		// quit
		Main.quit();
	}
	
	bool onScroll(Event event, Widget widget) {
		// scrolling is false by default
		bool scrolling = false;

		if(event.scroll.direction == ScrollDirection.DOWN) {
			// set scrolling to true
			scrolling = true;
		} else if(event.scroll.direction == ScrollDirection.UP) {
			// set scrolling to true
			scrolling = true;
		}

		return scrolling;
	}
}

class GUIBoxMain : Box {
	this() {
		// calling parent's constructor
		super(Orientation.VERTICAL, 0);

		// packing the element into guibox
		packStart(new FromagoMenuBar(), false, false, 0);
	}
}














