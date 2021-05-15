module meta;

// import mostly used GTKD
public import gtk.MainWindow;
public import gtk.Box;
public import gtk.Main;
public import gtk.Menu;
public import gtk.MenuBar;
public import gtk.MenuItem;
public import gtk.Widget;
public import gtk.Layout;
public import gtk.ScrolledWindow;
public import gdk.Event;

immutable windowWidth = 640;
immutable windowHeight = 480;

// a box
class GUIBox(T) : Box {	
	this(const Orientation o, const int opadding, T element, const bool expand = false, const bool fill = false, const int padding = 0) {
		// calling parent's constructor
		super(o, opadding);
		
		// packing the element in the window
		packStart(element, expand, fill, padding);		
	}
}



