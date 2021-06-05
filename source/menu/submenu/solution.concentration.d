module menu.submenu.solution.concentration;

// the meta gtkd package
import meta;

void calculateSolutionConcentration() {
	// calculateSolutionConcentration window
	new DialogWindow(mainWindow, 
		lang["Solution Concentration Calc"].str, 
		[lang["Calculate"].str, lang["Clear"].str, lang["Close"].str], 
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
		labelConcentration = new PadLabel(BoxJustify.Left, lang["Solution concentration"].str);
		attach(labelConcentration, 0, 0, 1, 1);

		labelSubstanceQuantity = new PadLabel(BoxJustify.Left, lang["Substance quantity"].str);
		attach(labelSubstanceQuantity, 0, 1, 1, 1);

		labelSolventQuantity = new PadLabel(BoxJustify.Left, lang["Solvent quantity"].str);
		attach(labelSolventQuantity, 0, 2, 1, 1);
		
		labelSolutionQuantity = new PadLabel(BoxJustify.Left, lang["Solution quantity"].str);
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

		labelSubstanceQuantityUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
		attach(labelSubstanceQuantityUnit, 2, 1, 1, 1);

		labelSolventQuantityUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
		attach(labelSolventQuantityUnit, 2, 2, 1, 1);
		
		labelSolutionQuantityUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
		attach(labelSolutionQuantityUnit, 2, 3, 1, 1);
		
		// set margin space
		setMarginBottom(marginBottom);
	}
	
	// do something on action
	void onAction(int r, Dialog d) {
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
						auto temp_solventq = calcSolventQuantity(strTo!float(temp_substanceq), data["solution"]);
						
						entrySubstanceQuantity.setText(temp_substanceq);
						entrySolventQuantity.setText(temp_solventq);
					} else if(data["substance"] && data["solution"]) { 
						// calculating solution concentration based off substance quantity and solution quantity
						auto temp_solventq = calcSolventQuantity(data["substance"], data["solution"]);
						auto temp_concentration = calcSolutionConcentration(data["substance"], strTo!float(temp_solventq));
						
						entryConcentration.setText(temp_concentration);
						entrySolventQuantity.setText(temp_solventq);
					} else if(data["%"] && data["solvent"]) {
						// calculating substance quantity and solution quantity
						auto temp_solutionq = calcSolutionQuantity2(data["%"], data["solvent"]);
						auto temp_substanceq = calcSubstanceQuantity(data["%"], strTo!float(temp_solutionq));
						
						entrySolutionQuantity.setText(temp_solutionq);
						entrySubstanceQuantity.setText(temp_substanceq);
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
	
	// sets everything to zero
	private void clearEntries() {
		entryConcentration.setText("0");
		entrySolutionQuantity.setText("0");
		entrySolventQuantity.setText("0");
		entrySubstanceQuantity.setText("0");
	}
	
	// get all data
	private float[string] getData() {
		return to!(float[string])([
			"%" : entryConcentration.getText().replaceEmptyWith("0").strTo!float(),
			"substance" : entrySubstanceQuantity.getText().replaceEmptyWith("0").strTo!float(),
			"solvent" : entrySolventQuantity.getText().replaceEmptyWith("0").strTo!float(),
			"solution" : entrySolutionQuantity.getText().replaceEmptyWith("0").strTo!float()
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
	
	// calculating solution quantity based off concetration and solvent quantity
	private string calcSolutionQuantity2(float concentration, float solventq) {
		return (to!(string)(solventq / (1 - concentration / 100)));
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








