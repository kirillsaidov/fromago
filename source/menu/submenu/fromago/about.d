module menu.submenu.fromago.about;

// the meta gtkd package
import meta;

// for displaying text
import gtk.DrawingArea;
import cairo.Context;

// AboutWindow window app
class AboutWindow : MainWindow {
	// variables
	Main main;
	
	this(const string windowTitle, const int windowWidth, const int windowHeight, string[] args = null) {
		// init a new window thread
		main.init(args);
		
		// call the parent constructor
		super(windowTitle);
		
		// set window size
		setSizeRequest(windowWidth, windowHeight);
		
		// attach onDestroy function
		addOnDestroy(&quitApp);	
				
		// add gui box and TextDrawingArea to it
		add(new GUIBox!(TextDrawingArea)(Orientation.VERTICAL, 10, new TextDrawingArea(), true, true, 0));
		
		// run the app
		showAll();
		
		// run
		main.run();
	}
	
	void quitApp(Widget widget) {		
		// quit
		main.quit();
	}
}

// text drawing area
class TextDrawingArea : DrawingArea {
	// area assigned to to DrawingArea by its parent
	GtkAllocation size;
	cairo_text_extents_t extents;
	
	// fonts list
	immutable string[] fonts = [
		"Arial", // the header
		"Arial"  // the rest of the text
	];
	
	// about text
	immutable string[] text = [
		// the header
		"Fromago Calc v1.0",
	
		// the rest of the text
		"Fromago is a ratio calculator for cooking cheese. It",
		"can calculate the solution concentration, the required",
		"substance quantity for a solution and much more!",
		"",
		"For more information, check out the documentation",
		"located at Help => Documentation",
		"",
		"Copyright 2021 © Kirill Saidov"
	];
		
	// constructor
	this() {
		addOnDraw(&onDraw);
	}
	
	bool onDraw(Scoped!Context context, Widget w) {
		// distance between lines of text
		immutable int ymarginInterval = 20;
		int ymargin = 30;
		
		// distance from the left border of window
		immutable int xmargin = 20;
		
		// get the DrawingArea's Pixbuf using the dimensions allocated by the DrawingArea's parent
		getAllocation(size);
		
		// set up header font
		context.selectFontFace(fonts[0], CairoFontSlant.NORMAL, CairoFontWeight.BOLD);
		context.setFontSize(18);
		context.setSourceRgb(0.0, 0.0, 0.0);
		
		// print a header
		context.moveTo(xmargin, ymargin);
		context.showText(text[0]);
		
		// move the context down
		ymargin += ymargin;
		context.moveTo(xmargin, ymargin);
		
		// set up another font...
		context.selectFontFace(fonts[1], CairoFontSlant.NORMAL, CairoFontWeight.NORMAL);
		context.setFontSize(14);
		context.setSourceRgb(0.0, 0.0, 0.0);
		
		// draw the rest of the text
		foreach(i, t; text) {
			// skip the header
			if(i == 0) { continue; }
			
			// display a line
			context.showText(text[i]);
			
			// move the context down
			ymargin += ymarginInterval;
			context.moveTo(xmargin, ymargin);
		}
		
		return true;
	}
	
}


















