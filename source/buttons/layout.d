module buttons.layout;

// the meta gtkd package
import meta;

// calc button
import buttons.calcbutton;

class ScrollLayout : ScrolledWindow {
	// constructor
	this(void function(ScrolledWindow sw) addLayout) {
		setSizeRequest(windowWidth, windowHeight);
		
		// add a layout
		addLayout(this);
	}
}

class ButtonsLayout : Layout {
	// constructor
	this(CalcButton[] buttons, const int xmargin, const int ymargin) {
		// calling parent's constructor
		super(null, null);
		
		// layout size
		setSizeRequest(windowWidth, windowHeight);
		
		// adding buttons
		int ypos = ymargin;
		foreach(button; buttons) {
			put(button, xmargin, ypos);
			
			ypos += button.getHeight() + ymargin;
		}	
	}
}




