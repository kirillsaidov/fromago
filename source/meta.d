module meta;

// import mostly used GTKD
public import gtk.MainWindow;
public import gtk.Box;
public import gtk.Main;
public import gtk.Menu;
public import gtk.Button;
public import gtk.MenuBar;
public import gtk.MenuItem;
public import gtk.Widget;
public import gtk.Layout;
public import gtk.ScrolledWindow;
public import gdk.Event;

immutable windowWidth = 640;
immutable windowHeight = 480;

// GUI window app
class Window : MainWindow {
	// main window thread
	private Main main;
	
	this(const string windowTitle, const int windowWidth, const int windowHeight, void function(MainWindow) addElements, string[] args = null) {
		// init main
		main = Main();
		
		// init main window thread
		main.init(args);
		
		// call the parent constructor
		super(windowTitle);
		
		// set window size
		setSizeRequest(windowWidth, windowHeight);
		
		// attach onDestroy function
		addOnDestroy(&quitApp);
		
		// add gui elements
		addElements(this);
				
		// display the window
		showAll();
		
		// run the app
		main.run();
	}
	
	// quit
	void quitApp(Widget widget) {		
		main.quit();
	}
	
	// set Main
	void setMainThread(ref Main m) {
		this.main = m;
	}
	
	// get Main
	Main getMainThread() {
		return main;
	}
}

// a box
class GUIBox : Box {	
	this(const Orientation o, const int opadding, void function(Box) addElements) {
		// calling parent's constructor
		super(o, opadding);
		
		// packing the element in the window
		addElements(this);	
	}
}

class SubmenuItem : MenuItem {	
	// constructor
	this(const string label, void function(MenuItem) addActions) {
		// calling parent's constructor
		super(label);
		
		addActions(this);
	}
}







