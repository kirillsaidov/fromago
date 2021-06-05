module menu.submenu.price;

// the meta gtkd package
import meta;

void calculateCheesePrice() {
	// calculateCheesePrice window
	new DialogWindow(mainWindow, 
		lang["Price Calc"].str, 
		[lang["Calculate"].str, lang["Clear"].str, lang["Close"].str], 
		[ResponseType.YES, ResponseType.REJECT, ResponseType.CANCEL],
		new CalculatorCheesePrice()
	);
}


// solution concentration calculator
class CalculatorCheesePrice : DialogForm {
	import std.conv: to;
	
	// variables
	private {
		// 'what' labels
		PadLabel labelCost;
		PadLabel labelCheeseTotalWeight;
		PadLabel labelMarkupCoef;
		PadLabel labelPrice;
		
		// unit measure labels
		PadLabel labelCostUnit;
		PadLabel labelCheeseTotalWeightUnit;
		PadLabel labelMarkupCoefUnit;
		PadLabel labelPriceUnit;

		// entry text box
		PadEntry entryCost;
		PadEntry entryCheeseTotalWeight;
		PadEntry entryMarkupCoef;
		PadEntry entryPrice;
	}
	
	
	//constructor
	this(int borderWidth = 7, int marginBottom = 7) {
		// calling parent's constructor
		super();
		
		// border width
		setBorderWidth(borderWidth);
		
		// column 1
		labelCost = new PadLabel(BoxJustify.Left, lang["Cost of production"].str);
		attach(labelCost, 0, 0, 1, 1);

		labelCheeseTotalWeight = new PadLabel(BoxJustify.Left, lang["Cheese total weight"].str);
		attach(labelCheeseTotalWeight, 0, 1, 1, 1);

		labelMarkupCoef = new PadLabel(BoxJustify.Left, lang["Markup coefficient"].str);
		attach(labelMarkupCoef, 0, 2, 1, 1);
		
		labelPrice = new PadLabel(BoxJustify.Left, lang["Price"].str);
		attach(labelPrice, 0, 3, 1, 1);
		
		// column 2
		entryCost = new PadEntry(BoxJustify.Left, "0");
		attach(entryCost, 1, 0, 1, 1);

		entryCheeseTotalWeight = new PadEntry(BoxJustify.Left, "0");
		attach(entryCheeseTotalWeight, 1, 1, 1, 1);

		entryMarkupCoef = new PadEntry(BoxJustify.Left, "50");
		attach(entryMarkupCoef, 1, 2, 1, 1);
		
		entryPrice = new PadEntry(BoxJustify.Left, "0");
		attach(entryPrice, 1, 3, 1, 1);
				
		// column 3
		labelCostUnit = new PadLabel(BoxJustify.Left, lang["units"].str);
		attach(labelCostUnit, 2, 0, 1, 1);

		labelCheeseTotalWeightUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
		attach(labelCheeseTotalWeightUnit, 2, 1, 1, 1);

		labelMarkupCoefUnit = new PadLabel(BoxJustify.Left, "%");
		attach(labelMarkupCoefUnit, 2, 2, 1, 1);
		
		labelPriceUnit = new PadLabel(BoxJustify.Left, lang["per 100 grams"].str);
		attach(labelPriceUnit, 2, 3, 1, 1);
		
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
					
					// if either is 0 (empty), do nothing
					if(!data["cost"] && !data["weight"]) {
						return;
					}
					
					// calculate price
					auto price = calcPrice(data["cost"], data["weight"], data["markup"]);
					entryPrice.setText(price);
					
					// if markup coef is empty, set it to 0
					if(!data["markup"]) {
						entryMarkupCoef.setText("0");
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
		entryCost.setText("0");
		entryPrice.setText("0");
		entryMarkupCoef.setText("50");
		entryCheeseTotalWeight.setText("0");
	}
	
	// get all data
	private float[string] getData() {
		return to!(float[string])([
			"cost" : entryCost.getText().replaceEmptyWith("0").strTo!float(),
			"weight" : entryCheeseTotalWeight.getText().replaceEmptyWith("0").strTo!float(),
			"markup" : entryMarkupCoef.getText().replaceEmptyWith("0").strTo!float(),
			"price" : 0
		]);
	}
	
	// calculating new required time
	private string calcPrice(float cost, float weight, float markup) {
		// FORMULA: price = (cost / weight) * 100 * ((100 + markup) / 100)
		return (to!string((cost / weight) * (100 + markup)));
	}
}





