module menu.submenu.solution.concentration;

// the meta gtkd package
import meta;

void calculateSolutionConcentration() {
	auto test = new CalculatorSolutionConcentration(1, 2);
	// calculateSolutionConcentration window
	new FromagoDialog(mainWindow, "Solution Concentration Calc", 
		["Calculate", "Close"], 
		[ResponseType.ACCEPT, ResponseType.CANCEL], 
		(d) {
			d.addOnResponse(
				(r, d) {}
			);
		},
		test
	);
}

// solution concentration calculator
class CalculatorSolutionConcentration : Grid {
	// variables
	
	//constructor
	this(int borderWidth = 7, int marginBottom = 7) {
		// calling parent's constructor
		super();
		
		// border width
		setBorderWidth(borderWidth);
		
		PadLabel labelConcentration = new PadLabel(BoxJustify.Left, "Solution concentration");
		attach(labelConcentration, 0, 0, 1, 1);

		PadLabel labelSubstanceQuantity = new PadLabel(BoxJustify.Left, "Substance quantity");
		attach(labelSubstanceQuantity, 0, 1, 1, 1);

		PadLabel labelSolventQuantity = new PadLabel(BoxJustify.Left, "Solvent quantity");
		attach(labelSolventQuantity, 0, 2, 1, 1);
		
		// set margin space
		setMarginBottom(7);
	}
	
	double[] getData() {
		return null;
	}
}







