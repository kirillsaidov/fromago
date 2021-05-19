module menu.submenu.solution.concentration;

// the meta gtkd package
import meta;

void calculateSolutionConcentration() {
	// calculateSolutionConcentration window
	new DialogWindow(mainWindow, 
		"Solution Concentration Calc", 
		["Calculate", "Clear", "Close"], 
		[ResponseType.YES, ResponseType.REJECT, ResponseType.CANCEL],
		new CalculatorSolutionConcentration()
	);
}

// solution concentration calculator
class CalculatorSolutionConcentration : DialogForm {
	import std.conv: to;
	
	// variables
	private {
		// 'what' labels
		PadLabel labelConcentration;
		PadLabel labelSubstanceQuantity;
		PadLabel labelSolventQuantity;
		PadLabel labelSolutionQuantity;
		
		// unit measure labels
		PadLabel labelConcentrationUnit;
		PadLabel labelSubstanceQuantityUnit;
		PadLabel labelSolventQuantityUnit;
		PadLabel labelSolutionQuantityUnit;

		// entry text box
		PadEntry entryConcentration;
		PadEntry entrySubstanceQuantity;
		PadEntry entrySolventQuantity;
		PadEntry entrySolutionQuantity;
	}
	
	
	//constructor
	this(int borderWidth = 7, int marginBottom = 7) {
		// calling parent's constructor
		super();
		
		// border width
		setBorderWidth(borderWidth);
		
		// column 1
		labelConcentration = new PadLabel(BoxJustify.Left, "Solution concentration");
		attach(labelConcentration, 0, 0, 1, 1);

		labelSubstanceQuantity = new PadLabel(BoxJustify.Left, "Substance quantity");
		attach(labelSubstanceQuantity, 0, 1, 1, 1);

		labelSolventQuantity = new PadLabel(BoxJustify.Left, "Solvent quantity");
		attach(labelSolventQuantity, 0, 2, 1, 1);
		
		labelSolutionQuantity = new PadLabel(BoxJustify.Left, "Solution quantity");
		attach(labelSolutionQuantity, 0, 3, 1, 1);
		
		// column 2
		entryConcentration = new PadEntry(BoxJustify.Left, "0");
		attach(entryConcentration, 1, 0, 1, 1);

		entrySubstanceQuantity = new PadEntry(BoxJustify.Left, "0");
		attach(entrySubstanceQuantity, 1, 1, 1, 1);

		entrySolventQuantity = new PadEntry(BoxJustify.Left, "0");
		attach(entrySolventQuantity, 1, 2, 1, 1);
		
		entrySolutionQuantity = new PadEntry(BoxJustify.Left, "0");
		attach(entrySolutionQuantity, 1, 3, 1, 1);
				
		// column 3
		labelConcentrationUnit = new PadLabel(BoxJustify.Left, "%");
		attach(labelConcentrationUnit, 2, 0, 1, 1);

		labelSubstanceQuantityUnit = new PadLabel(BoxJustify.Left, "grams");
		attach(labelSubstanceQuantityUnit, 2, 1, 1, 1);

		labelSolventQuantityUnit = new PadLabel(BoxJustify.Left, "grams");
		attach(labelSolventQuantityUnit, 2, 2, 1, 1);
		
		labelSolutionQuantityUnit = new PadLabel(BoxJustify.Left, "grams");
		attach(labelSolutionQuantityUnit, 2, 3, 1, 1);
		
		// set margin space
		setMarginBottom(7);
	}
	
	// do something on action
	void onAction(int r, Dialog d) {
		import std.stdio: writeln;

		switch(r) with(ResponseType) {
			case YES:
				{
					// get all data from entries
					auto data = getData();
					
					// count number of empty entries
					ubyte zeros = 0;
					foreach(v; data) {
						if(v == 0) { zeros++; }
					}
					
					// if more than 2 entries are zero, do nothing
					if(zeros > 2 && zeros == 0) {
						return;
					}
					
					// calculations
					if(data["substance"] && data["solvent"]) {
						// calculating solution concentration based off substance quantity and solvent quantity
						auto temp_concentration = calcSolutionConcentration(data["substance"], data["solvent"]);
						auto temp_solutionq = calcSolutionQuantity(data["substance"], data["solvent"]);
						
						entryConcentration.setText(temp_concentration);
						entrySolutionQuantity.setText(temp_solutionq);
					} else if(data["%"] && data["solution"]) {
						// calculating substance quantity and solvent quantity
						auto temp_substanceq = calcSubstanceQuantity(data["%"], data["solution"]);
						auto temp_solventq = calcSolventQuantity(strToFloat(temp_substanceq), data["solution"]);
						
						entrySubstanceQuantity.setText(temp_substanceq);
						entrySolventQuantity.setText(temp_solventq);
					} else if(data["substance"] && data["solution"]) { 
						// calculating solution concentration based off substance quantity and solution quantity
						auto temp_solventq = calcSolventQuantity(data["substance"], data["solution"]);
						auto temp_concentration = calcSolutionConcentration(data["substance"], strToFloat(temp_solventq));
						
						entryConcentration.setText(temp_concentration);
						entrySolventQuantity.setText(temp_solventq);
					}
				}
				break;
			case REJECT:
				clearEntries();
				break;
			case CANCEL:
				d.destroy();
				break;
			default:
				break;
		}
	}
	
	// get grid instance
	Grid getInstance() {
		return this;
	}
	
	private void clearEntries() {
		entryConcentration.setText("0");
		entrySolutionQuantity.setText("0");
		entrySolventQuantity.setText("0");
		entrySubstanceQuantity.setText("0");
	}
	
	// get all data
	private float[string] getData() {
		return to!(float[string])([
			"%" : entryConcentration.getText().strToFloat(),
			"substance" : entrySubstanceQuantity.getText().strToFloat(),
			"solvent" : entrySolventQuantity.getText().strToFloat(),
			"solution" : entrySolutionQuantity.getText().strToFloat()
		]);
	}
	
	// calculating solution concentration
	private string calcSolutionConcentration(float substanceq, float solventq) {
		return (to!(string)(100 * substanceq / (substanceq + solventq)));
	}
	
	// calculating solution quantity
	private string calcSolutionQuantity(float substanceq, float solventq) {
		return (to!(string)(substanceq + solventq));
	}
	
	// calculating substance quantity
	private string calcSubstanceQuantity(float concentration, float solutionq) {
		return (to!(string)(solutionq * concentration / 100));
	}
	
	// calculating solvent quantity
	private string calcSolventQuantity(float substanceq, float solutionq) {
		return (to!(string)(solutionq - substanceq));
	}
}







