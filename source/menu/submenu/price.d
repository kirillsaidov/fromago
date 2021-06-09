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
		PadLabel labelEmpty;
		PadLabel labelCalculateFor;
		PadLabel labelCheeseWeight;
		PadLabel labelTotalPrice;
		
		// unit measure labels
		PadLabel labelCostUnit;
		PadLabel labelCheeseTotalWeightUnit;
		PadLabel labelMarkupCoefUnit;
		PadLabel labelPriceUnit;
		PadLabel labelCheeseWeightUnit;
		PadLabel labelTotalPriceUnit;

		// entry text box
		PadEntry entryCost;
		PadEntry entryCheeseTotalWeight;
		PadEntry entryMarkupCoef;
		PadEntry entryPrice;
		PadEntry entryCheeseWeight;
		PadEntry entryTotalPrice;
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
		
		labelCheeseWeight = new PadLabel(BoxJustify.Left, lang["Cheese weight"].str);
		attach(labelCheeseWeight, 0, 6, 1, 1);
		
		labelTotalPrice = new PadLabel(BoxJustify.Left, lang["Total price"].str);
		attach(labelTotalPrice, 0, 7, 1, 1);
		
		// column 2
		entryCost = new PadEntry(BoxJustify.Left, "0");
		attach(entryCost, 1, 0, 1, 1);

		entryCheeseTotalWeight = new PadEntry(BoxJustify.Left, "0");
		attach(entryCheeseTotalWeight, 1, 1, 1, 1);

		entryMarkupCoef = new PadEntry(BoxJustify.Left, "50");
		attach(entryMarkupCoef, 1, 2, 1, 1);
		
		entryPrice = new PadEntry(BoxJustify.Left, "0");
		attach(entryPrice, 1, 3, 1, 1);
		
		labelEmpty = new PadLabel(BoxJustify.Left, "");
		attach(labelEmpty, 1, 4, 1, 1);
		
		labelCalculateFor = new PadLabel(BoxJustify.Center, lang["CALCULATE FOR"].str);
		attach(labelCalculateFor, 1, 5, 1, 1);
		
		entryCheeseWeight = new PadEntry(BoxJustify.Left, "0");
		attach(entryCheeseWeight, 1, 6, 1, 1);
		
		entryTotalPrice = new PadEntry(BoxJustify.Left, "0");
		attach(entryTotalPrice, 1, 7, 1, 1);
				
		// column 3
		labelCostUnit = new PadLabel(BoxJustify.Left, lang["units"].str);
		attach(labelCostUnit, 2, 0, 1, 1);

		labelCheeseTotalWeightUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
		attach(labelCheeseTotalWeightUnit, 2, 1, 1, 1);

		labelMarkupCoefUnit = new PadLabel(BoxJustify.Left, "%");
		attach(labelMarkupCoefUnit, 2, 2, 1, 1);
		
		labelPriceUnit = new PadLabel(BoxJustify.Left, lang["per 100 grams"].str);
		attach(labelPriceUnit, 2, 3, 1, 1);	
		
		labelCheeseWeightUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
		attach(labelCheeseWeightUnit, 2, 6, 1, 1);
		
		labelTotalPriceUnit = new PadLabel(BoxJustify.Left, lang["units"].str);
		attach(labelTotalPriceUnit, 2, 7, 1, 1);
		
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
					
					// CALCULATE PRICE
					auto price = calcPrice(data["cost"], data["weight"], data["markup"]);
					entryPrice.setText(price);
					
					// if markup coef is empty, set it to 0
					if(!data["markup"]) {
						entryMarkupCoef.setText("0");
					}

					// CALCULATE TOTAL PRICE
					if(data["price"]) {
						auto totalPrice = calcTotalPrice(data["cheese weight"], data["price"]);
						entryTotalPrice.setText(totalPrice);
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
		entryCheeseWeight.setText("0");
		entryTotalPrice.setText("0");
	}
	
	// get all data
	private float[string] getData() {
		return to!(float[string])([
			"cost" : entryCost.getText().replaceEmptyWith("0").strTo!float(),
			"weight" : entryCheeseTotalWeight.getText().replaceEmptyWith("0").strTo!float(),
			"markup" : entryMarkupCoef.getText().replaceEmptyWith("0").strTo!float(),
			"price" : entryPrice.getText().replaceEmptyWith("0").strTo!float(),
			"cheese weight" : entryCheeseWeight.getText().replaceEmptyWith("0").strTo!float(),
			"total price" : 0,
		]);
	}
	
	// calculating price per 100 grams
	private string calcPrice(float cost, float weight, float markup) {
		// FORMULA: price = (cost / weight) * 100 * ((100 + markup) / 100)
		return (to!string((cost / weight) * (100 + markup)));
	}
	
	// calculating total price for custom weight given price per 100 grams
	private string calcTotalPrice(float weight, float price) {
		return (to!string(weight * price / 100));
	}
}





