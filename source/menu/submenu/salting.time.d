module menu.submenu.salting.time;

// the meta gtkd package
import meta;

void calculateSaltingTime() {
	// calculateSaltingTime window
	new DialogWindow(mainWindow, 
		"Salting Time Calc", 
		["Calculate", "Clear", "Close"], 
		[ResponseType.YES, ResponseType.REJECT, ResponseType.CANCEL],
		new CalculatorSaltingTime()
	);
}


// solution concentration calculator
class CalculatorSaltingTime : DialogForm {
	import std.conv: to;
	
	// variables
	private {
		// 'what' labels
		PadLabel labelConcentration;
		PadLabel labelRequiredTime;
		PadLabel labelCheeseTotalWeight;
		PadLabel labelTotalSaltingTime;
		
		// unit measure labels
		PadLabel labelConcentrationUnit;
		PadLabel labelRequiredTimeUnit;
		PadLabel labelCheeseTotalWeightUnit;
		PadLabel labelTotalSaltingTimeUnit;

		// entry text box
		PadEntry entryConcentration;
		PadEntry entryRequiredTime;
		PadEntry entryCheeseTotalWeight;
		PadEntry entryTotalSaltingTime;
		
		// concentration-time coefficient
		private float coef = 0;
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

		labelRequiredTime = new PadLabel(BoxJustify.Left, "Required time");
		attach(labelRequiredTime, 0, 1, 1, 1);

		labelCheeseTotalWeight = new PadLabel(BoxJustify.Left, "Cheese total weight");
		attach(labelCheeseTotalWeight, 0, 2, 1, 1);
		
		labelTotalSaltingTime = new PadLabel(BoxJustify.Left, "Total salting time");
		attach(labelTotalSaltingTime, 0, 3, 1, 1);
		
		// column 2
		entryConcentration = new PadEntry(BoxJustify.Left, "0");
		attach(entryConcentration, 1, 0, 1, 1);

		entryRequiredTime = new PadEntry(BoxJustify.Left, "0");
		attach(entryRequiredTime, 1, 1, 1, 1);

		entryCheeseTotalWeight = new PadEntry(BoxJustify.Left, "0");
		attach(entryCheeseTotalWeight, 1, 2, 1, 1);
		
		entryTotalSaltingTime = new PadEntry(BoxJustify.Left, "0");
		attach(entryTotalSaltingTime, 1, 3, 1, 1);
				
		// column 3
		labelConcentrationUnit = new PadLabel(BoxJustify.Left, "%");
		attach(labelConcentrationUnit, 2, 0, 1, 1);

		labelRequiredTimeUnit = new PadLabel(BoxJustify.Left, "mins per 100 grams");
		attach(labelRequiredTimeUnit, 2, 1, 1, 1);

		labelCheeseTotalWeightUnit = new PadLabel(BoxJustify.Left, "grams");
		attach(labelCheeseTotalWeightUnit, 2, 2, 1, 1);
		
		labelTotalSaltingTimeUnit = new PadLabel(BoxJustify.Left, "h-hours, m-minutes");
		attach(labelTotalSaltingTimeUnit, 2, 3, 1, 1);
		
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
					
					// if concentration is 0, do nothing
					if(!data["%"]) {
						return;
					}
					
					// calculations
					auto temp_coef = calcCoefficient(data["time"], data["%"]);
					if(data["%"] && data["time"] && data["weight"]) {
						// calculating salting time
						auto temp_saltingTime = calcTotalSaltingTimeReadable(data["weight"], data["%"], temp_coef);
						
						entryTotalSaltingTime.setText(temp_saltingTime);
					} else if(data["%"] && !data["time"]) {
						// calculating required time
						auto temp_requiredTime = calcRequiredTime(data["%"], coef);
						
						entryRequiredTime.setText(temp_requiredTime);
					}
					
					coef = ((temp_coef == 0) ? (coef) : (temp_coef));
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
		entryTotalSaltingTime.setText("0");
		entryCheeseTotalWeight.setText("0");
		entryRequiredTime.setText("0");
	}
	
	// get all data
	private float[string] getData() {
		return to!(float[string])([
			"%" : entryConcentration.getText().replaceEmptyWith("0").strTo!float(),
			"time" : entryRequiredTime.getText().replaceEmptyWith("0").strTo!float(),
			"weight" : entryCheeseTotalWeight.getText().replaceEmptyWith("0").strTo!float(),
			"saltingTime" : 0
		]);
	}
	
	// calculating concentration-time coefficient
	private float calcCoefficient(float time, float concentration) {
		return (time / concentration);
	}
	
	// calculating salting time (readable human-friendly format)
	private string calcTotalSaltingTimeReadable(float weight, float concentration, float coef) {
		float salting_time = weight / 100 * concentration * coef / 60;
		float hours = to!float(to!int(salting_time));
		float minutes = (salting_time - hours) * 60;
		
		return (to!string(hours) ~ "h " ~ to!string(minutes) ~ "m");
	}
	
	// calculating salting time
	private string calcTotalSaltingTime(float weight, float concentration, float coef) {
		return (to!string(weight / 100 * concentration * coef / 60));
	}
	
	// calculating new required time
	private string calcRequiredTime(float concentration, float coef) {
		return (to!string(concentration * coef));
	}
}





