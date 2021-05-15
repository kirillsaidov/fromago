module buttons.layout;

// the meta gtkd package
import meta;

// calc button
import buttons.calcbuttons;

class ScrollLayout : ScrolledWindow {
	// constructor
	this() {
		setSizeRequest(windowWidth, windowHeight);
		
		add(new ButtonsLayout());
	}
}

class ButtonsLayout : Layout {
	// variables
	private const int xmargin = 16; 
	private const int ymargin = 9;
	
	// constructor
	this() {
		// calling parent's constructor
		super(null, null);
		
		// layout size
		setSizeRequest(windowWidth, windowHeight);
		
		// adding buttons
		int ypos = ymargin;
		foreach(button; getAllButtons()) {
			put(button, xmargin, ypos);
			
			ypos += button.getHeight() + ymargin;
		}
		
		//CalcButton
		//put(myButton, buttonX, buttonY);	
	}
}




