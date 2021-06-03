module menu.submenu.about;

// the meta gtkd package
import meta;

// for displaying text
import gtk.DrawingArea;
import cairo.Context;

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
		"Fromago Calc v1.1",
	
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


















