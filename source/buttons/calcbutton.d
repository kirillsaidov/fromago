module buttons.calcbutton;

// the meta gtkd package
import meta;

class CalcButton : Button {
	// constructor
	this(const string label, const int width, const int height, void function() onPressed) {
		// calling parent's constructor
		super(label);
		
		// button size
		setSizeRequest(width, height);

		// attaching onPressed button
		addOnClicked(delegate void(_) { onPressed(); });
	}
}