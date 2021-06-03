module meta;

// import mostly used GTKD
public import gtk.MainWindow;
public import gtk.Box;
public import gtk.Main;
public import gtk.Menu;
public import gtk.Button;
public import gtk.MenuBar;
public import gtk.MenuItem;
public import gtk.SeparatorMenuItem;
public import gtk.Widget;
public import gtk.Dialog;
public import gtk.Layout;
public import gtk.Grid;
public import gtk.Entry;
public import gtk.Label;
public import gtk.ScrolledWindow;
public import gdk.Event;

// my layout config
public import config;

//window dimensions
immutable windowWidth = 640;
immutable windowHeight = 480;

// main window
Window mainWindow;

// justify (box)
enum BoxJustify {
	Left, Right, Center
}

/* ******************************* MAIN WINDOW AND GUI BOXES ******************************* */

// GUI window
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

// a box (container) containing gui elements
class GUIBox : Box {	
	this(const Orientation o, const int opadding, void function(Box) addElements) {
		// calling parent's constructor
		super(o, opadding);
		
		// packing the element in the window
		addElements(this);	
	}
}

// horizontal box
class HBox : Box {
	// constructor
	this(Widget widget, BoxJustify justify, bool expand = false, bool fill = false, int padding = 0, int borderWidth = 7) {
		// calling parent's constructor
		super(Orientation.HORIZONTAL, 0);
		
		// add an element based off justify enum
		with(BoxJustify) {
			if(justify == Left) {
				packStart(widget, expand, fill, padding);
			} else if(justify == Right) {
				packEnd(widget, expand, fill, padding);
			} else {
				add(widget);
			}
		}
		
		// border width
		setBorderWidth(borderWidth);
	}
}

// label box
class PadLabel : HBox {
	// constructor 
	this(BoxJustify justify, const string text = null) {
		super(new Label(text), justify);
	}
}

class PadEntry : HBox {
	// variables
	private Entry entry;
	
	// constructor
	this(BoxJustify justify, const string text = "") {
		// create a new entry
		entry = new Entry(text);
		
		// calling parent's constructor
		super(entry, justify);
	}
	
	// visibily
	void setVisibility(bool state) {
		entry.setVisibility(state);
	}
	
	// character width
	void setWidthChars(int width) {
		entry.setWidthChars(width);
	}
	
	// get data
	string getText() {
		return entry.getText();
	}
	
	// set text
	void setText(const string text) {
		entry.setText(text);
	}
}

/* ************************************* SUBMENU ITEMS ************************************* */

// a submenu item that is attached to a menu header (menu header is attached to menu bar)
class SubmenuItem : MenuItem {	
	// constructor
	this(const string label, void function(MenuItem) addActions) {
		// calling parent's constructor
		super(label);
		
		addActions(this);
	}
}

/* ************************************* DIALOG WINDOW ************************************* */

// dialog interface
interface IDialog {
	void onAction(int, Dialog);
	Grid getInstance();
}

// a dialog form that is inherited by custom dialogs 
// (it is an instruction, on what and how to draw, what to do) 
abstract class DialogForm: Grid, IDialog {}

// a dialog window that accepts a dialog form and executes it
class DialogWindow : Dialog {
	// constructor
	this(Window parent, const string dialogTitle, string[] buttons, ResponseType[] responseType, DialogForm d) {
		// calling parent constructor
		super(dialogTitle, parent, DialogFlags.MODAL | DialogFlags.DESTROY_WITH_PARENT, buttons, responseType);
		
		// create new content area
		getContentArea().add(d.getInstance);
		getContentArea().showAll();
				
		// addActions
		addOnResponse(&d.onAction);
		
		// run and quit
		run();
	}
}

/* ************************************ OTHER FUNCTIONS ************************************ */

// convert a decimal number string to float
float strTo(T)(const string text) {
	import std.array: replace;
	import std.conv: to;
	
	return (text.replace(",", ".").to!T);
}

string replaceEmptyWith(const string oldValue, const string newValue) {
	import std.array: empty;
	
	if(oldValue.empty) {
		return newValue;
	}
	return oldValue;
}




