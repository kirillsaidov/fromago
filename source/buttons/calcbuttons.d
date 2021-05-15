module buttons.calcbuttons;

// the meta gtkd package
import meta;

// returns a list of all buttons
auto getAllButtons() {
	return [
		new CalcButton(
			"Calculate the solution concentration",
			240, 30,
			&calculateSolutionConcentration
		),
		new CalcButton(
			"Calculate substance quantity",
			240, 30,
			&calculateSolutionConcentration
		)
	];
}

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

// calculate solution concentration
void calculateSolutionConcentration() {
	//...
}