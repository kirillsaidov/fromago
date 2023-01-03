module menu.submenu.salting.time;

// the meta gtkd package
import meta;

void calculateSaltingTime() {
    // calculateSaltingTime window
    new DialogWindow(mainWindow, 
        lang["Salting Time Calc"].str, 
        [lang["Calculate"].str, lang["Clear"].str, lang["Close"].str], 
        [ResponseType.YES, ResponseType.REJECT, ResponseType.CANCEL],
        new CalculatorSaltingTime()
    );
}


// solution concentration calculator
class CalculatorSaltingTime : DialogForm {
    import std.conv: to;
    import std.array: split;
    import core.time: minutes;
    import std.datetime.systime : SysTime, Clock;
    
    // variables
    private {
        // 'what' labels
        PadLabel labelConcentration;
        PadLabel labelRequiredTime;
        PadLabel labelCheeseTotalWeight;
        PadLabel labelTotalSaltingTime;
        PadLabel labelEndSaltingTimeFromNow;
        
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
        PadEntry entryEndSaltingTimeFromNow;
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

        labelRequiredTime = new PadLabel(BoxJustify.Left, lang["Required time"].str);
        attach(labelRequiredTime, 0, 1, 1, 1);

        labelCheeseTotalWeight = new PadLabel(BoxJustify.Left, lang["Cheese total weight"].str);
        attach(labelCheeseTotalWeight, 0, 2, 1, 1);
        
        labelTotalSaltingTime = new PadLabel(BoxJustify.Left, lang["Total salting time"].str);
        attach(labelTotalSaltingTime, 0, 3, 1, 1);

        labelEndSaltingTimeFromNow = new PadLabel(BoxJustify.Left, lang["End salting time"].str);
        attach(labelEndSaltingTimeFromNow, 0, 4, 1, 1);
        
        // column 2
        entryConcentration = new PadEntry(BoxJustify.Left, "0");
        attach(entryConcentration, 1, 0, 1, 1);

        entryRequiredTime = new PadEntry(BoxJustify.Left, "0");
        attach(entryRequiredTime, 1, 1, 1, 1);

        entryCheeseTotalWeight = new PadEntry(BoxJustify.Left, "0");
        attach(entryCheeseTotalWeight, 1, 2, 1, 1);
        
        entryTotalSaltingTime = new PadEntry(BoxJustify.Left, "0");
        attach(entryTotalSaltingTime, 1, 3, 1, 1);

        entryEndSaltingTimeFromNow = new PadEntry(BoxJustify.Left, Clock.currTime.toISOExtString().split(".")[0]);
        attach(entryEndSaltingTimeFromNow, 1, 4, 1, 1);
                
        // column 3
        labelConcentrationUnit = new PadLabel(BoxJustify.Left, "%");
        attach(labelConcentrationUnit, 2, 0, 1, 1);

        labelRequiredTimeUnit = new PadLabel(BoxJustify.Left, lang["mins per 100 grams"].str);
        attach(labelRequiredTimeUnit, 2, 1, 1, 1);

        labelCheeseTotalWeightUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
        attach(labelCheeseTotalWeightUnit, 2, 2, 1, 1);
        
        labelTotalSaltingTimeUnit = new PadLabel(BoxJustify.Left, lang["h-hours, m-minutes"].str);
        attach(labelTotalSaltingTimeUnit, 2, 3, 1, 1);
        
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
                    
                    // if concentration is 0, do nothing
                    if(!data["%"] || data["%"] == 0) {
                        return;
                    }
                    
                    // // calculations
                    // auto temp_coef = calcCoefficient(data["time"], data["%"]);
                    // if(data["%"] && data["time"] && data["weight"]) {
                    //     // calculating salting time
                    //     auto temp_saltingTime = calcTotalSaltingTimeReadable(data["weight"], data["%"], temp_coef);
                        
                    //     entryTotalSaltingTime.setText(temp_saltingTime);
                    // } else if(data["%"] && !data["time"]) {
                    //     // calculating required time
                    //     auto temp_requiredTime = calcRequiredTime(data["%"], coef);
                        
                    //     // update required time
                    //     entryRequiredTime.setText(temp_requiredTime);

                    //     // updat end salting time
                    //     // endSaltingTime = Clock.currTime();
                    //     // endSaltingTime += 
                    // }
                    
                    // coef = ((temp_coef == 0) ? (coef) : (temp_coef));

                    // calculations
                    if(data["%"] && data["time"] && data["weight"]) {
                        // 0. calculate salting time coefficient
                        immutable coef = calcCoefficient(data["time"], data["%"]);

                        // 1. calculate required salting time amount
                        immutable rstAmount = calcRequiredSaltingTimeAmount(data["%"], coef);

                        // 2. convert to readable format
                        immutable rstAmountReadable = convertRequiredSaltingTimeToReadable(rstAmount);

                        // 3. calculate end salting time
                        immutable endSaltingTimeReadable = calcEndSaltingTimeReadable(rstAmount);

                        // 4. update salting time entry with end salting time label
                        entryTotalSaltingTime.setText(rstAmountReadable);
                        entryEndSaltingTimeFromNow.setText(endSaltingTimeReadable);
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
        entryTotalSaltingTime.setText("0");
        entryCheeseTotalWeight.setText("0");
        entryRequiredTime.setText("0");
        entryEndSaltingTimeFromNow.setText(Clock.currTime.toISOExtString());
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

    /// calculating required salting time amount
    private ulong calcRequiredSaltingTimeAmount(in float concentration, in float weight) {
        return cast(ulong)(weight / 100 * concentration / 60);
    }

    /// calculates end salting time and converts it to a readable human-friendly format
    private string calcEndSaltingTimeReadable(in ulong rstAmount) {
        SysTime currentTime = Clock.currTime();
        currentTime += rstAmount.minutes();
        return currentTime.toISOExtString().split(".")[0];
    }
    
    /// convert salting time amount to a readable human-friendly format
    private string convertRequiredSaltingTimeToReadable(in ulong rstAmount) {
        import std;
        immutable rstPeriod = rstAmount.to!float / 60.0;
        writeln(rstAmount);
        writeln(rstPeriod);
        immutable hours = rstPeriod.to!ulong;
        immutable minutes = to!ulong((rstPeriod - hours) * 60);
        
        return (to!string(hours) ~ "h " ~ to!string(minutes) ~ "m");
    }

    // calculate salting time amount
    private ulong calcTotalSaltingTime(float weight, float concentration, float coef) {
        return cast(ulong)(weight / 100 * concentration * coef / 60);
    }
}





