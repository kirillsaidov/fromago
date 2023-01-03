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


/// solution concentration calculator
class CalculatorSaltingTime : DialogForm {
    import std.conv: to;
    import std.array: split;
    import core.time: minutes;
    import std.typecons: tuple;
    import std.datetime: DateTime;
    import std.datetime.systime : SysTime, Clock;
    import std.algorithm: canFind;
    
    // variables
    private {
        // 'what' labels
        PadLabel labelRequiredTime;
        PadLabel labelCheeseTotalWeight;
        PadLabel labelTotalSaltingTime;
        PadLabel labelStartSaltingTime;
        PadLabel labelEndSaltingTime;
        
        // unit measure labels
        PadLabel labelRequiredTimeUnit;
        PadLabel labelCheeseTotalWeightUnit;
        PadLabel labelTotalSaltingTimeUnit;

        // entry text box
        PadEntry entryRequiredTime;
        PadEntry entryCheeseTotalWeight;
        PadEntry entryTotalSaltingTime;
        PadEntry entryStartSaltingTime;
        PadEntry entryEndSaltingTime;
    }
    
    this(int borderWidth = 7, int marginBottom = 7) {
        // calling parent's constructor
        super();
        
        // border width
        setBorderWidth(borderWidth);
        
        // column 1
        labelRequiredTime = new PadLabel(BoxJustify.Left, lang["Required time"].str);
        attach(labelRequiredTime, 0, 0, 1, 1);

        labelCheeseTotalWeight = new PadLabel(BoxJustify.Left, lang["Cheese total weight"].str);
        attach(labelCheeseTotalWeight, 0, 1, 1, 1);
        
        labelTotalSaltingTime = new PadLabel(BoxJustify.Left, lang["Total salting time"].str);
        attach(labelTotalSaltingTime, 0, 2, 1, 1);

        labelStartSaltingTime = new PadLabel(BoxJustify.Left, lang["Start salting time"].str);
        attach(labelStartSaltingTime, 0, 3, 1, 1);

        labelEndSaltingTime = new PadLabel(BoxJustify.Left, lang["End salting time"].str);
        attach(labelEndSaltingTime, 0, 4, 1, 1);
        
        // column 2
        entryRequiredTime = new PadEntry(BoxJustify.Left, "0");
        attach(entryRequiredTime, 1, 0, 1, 1);

        entryCheeseTotalWeight = new PadEntry(BoxJustify.Left, "0");
        attach(entryCheeseTotalWeight, 1, 1, 1, 1);
        
        entryTotalSaltingTime = new PadEntry(BoxJustify.Left, "0");
        attach(entryTotalSaltingTime, 1, 2, 1, 1);

        entryStartSaltingTime = new PadEntry(BoxJustify.Left, Clock.currTime.toISOExtString().split(".")[0]);
        attach(entryStartSaltingTime, 1, 3, 1, 1);

        entryEndSaltingTime = new PadEntry(BoxJustify.Left, Clock.currTime.toISOExtString().split(".")[0]);
        attach(entryEndSaltingTime, 1, 4, 1, 1);
                
        // column 3
        labelRequiredTimeUnit = new PadLabel(BoxJustify.Left, lang["mins per 100 grams"].str);
        attach(labelRequiredTimeUnit, 2, 0, 1, 1);

        labelCheeseTotalWeightUnit = new PadLabel(BoxJustify.Left, lang["grams"].str);
        attach(labelCheeseTotalWeightUnit, 2, 1, 1, 1);
        
        labelTotalSaltingTimeUnit = new PadLabel(BoxJustify.Left, lang["h-hours, m-minutes"].str);
        attach(labelTotalSaltingTimeUnit, 2, 2, 1, 1);
        
        // set margin space
        setMarginBottom(marginBottom);
    }
    
    /// do something on action
    void onAction(int r, Dialog d) {
        switch(r) with(ResponseType) {
            case YES:
                {
                    // get all data from entries
                    auto data = getData();

                    // calculations
                    if(data["required_time"] != 0 && data["weight"] != 0) {
                        // 1. calculate required salting time amount
                        immutable rstAmount = calcRequiredSaltingTimeAmount(data["required_time"], data["weight"]);

                        // 2. convert to readable format
                        immutable rstAmountReadable = convertRequiredSaltingTimeToReadable(rstAmount);

                        // 3. calculate end salting time
                        immutable endSaltingTimeReadable = calcEndSaltingTimeReadable(rstAmount);

                        // 4. update salting time entry with end salting time label
                        entryTotalSaltingTime.setText(rstAmountReadable);
                        entryEndSaltingTime.setText(endSaltingTimeReadable);
                    } else if(data["required_time"] == 0 && data["weight"] == 0 && data["salting_time_amount"] != 0) {
                        // 1. calculate end salting time
                        immutable endSaltingTimeReadable = calcEndSaltingTimeReadable(data["salting_time_amount"].to!ulong);

                        // 2. update salting time entry with end salting time label
                        entryEndSaltingTime.setText(endSaltingTimeReadable);
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
    
    /// get grid instance
    Grid getInstance() {
        return this;
    }
    
    /// sets everything to zero
    private void clearEntries() {
        entryTotalSaltingTime.setText("0");
        entryCheeseTotalWeight.setText("0");
        entryRequiredTime.setText("0");
        entryStartSaltingTime.setText(Clock.currTime.toISOExtString().split(".")[0]);
        entryEndSaltingTime.setText(Clock.currTime.toISOExtString().split(".")[0]);
    }
    
    /// get all data
    private auto getData() {
        return [
            "required_time" : entryRequiredTime.getText().replaceEmptyWith("0").strTo!float(),
            "weight" : entryCheeseTotalWeight.getText().replaceEmptyWith("0").strTo!float(),
            "salting_time_amount": convertSaltingTimeAmountFromReadable(entryTotalSaltingTime.getText()).to!float
        ];
    }

    /++
        Calculating required salting time amount

        Params:
            time = salting time per 100 grams
            weight = total weight
        
        Returns: required total salting time in minutes
    +/
    private ulong calcRequiredSaltingTimeAmount(in float time, in float weight) {
        return cast(ulong)(time * weight / 100);
    }

    /++ 
        Converts salting time amount to a readable human-friendly format XXh YYm

        Params:
            rstAmount = required total salting time in minutes
        
        Returns: "XXh YYm" format
    +/
    private string convertRequiredSaltingTimeToReadable(in ulong rstAmount) {
        immutable rstPeriod = rstAmount.to!float / 60.0;
        immutable hours = rstPeriod.to!ulong;
        immutable minutes = to!ulong((rstPeriod - hours) * 60);
        
        return (to!string(hours) ~ "h " ~ to!string(minutes) ~ "m");
    }

    /++
        Convert human-friendly readable format "XXh YYm" to total salting time amount in minutes

        Params:
            rstAmountString = readable salting time amount format "XXh YYm"
        
        Returns: total salting time amount in minutes
    +/
    private ulong convertSaltingTimeAmountFromReadable(in string rstAmountString) {
        if(rstAmountString.length >= 5 && rstAmountString.length <= 7 && rstAmountString.canFind(" ")) {
            immutable tmp_str_split = rstAmountString.split(" ");
            immutable hours = tmp_str_split[0][0 .. $-1].to!ulong;
            immutable minutes = tmp_str_split[1][0 .. $-1].to!ulong;

            return hours * 60 + minutes;
        }

        return 0;
    }

    /++
        Calculates end salting time and converts it to a readable human-friendly format ISOExtString

        Params:
            rstAmount = required total salting time in minutes

        Returns: ISOExtString
    +/
    private string calcEndSaltingTimeReadable(in ulong rstAmount) {
        SysTime endSaltingTime;
        try {
            endSaltingTime = SysTime.fromISOExtString(entryStartSaltingTime.getText());
        } catch(Exception e) {
            endSaltingTime = Clock.currTime();
        }

        endSaltingTime += rstAmount.minutes();

        return endSaltingTime.toISOExtString().split(".")[0];
    }
}





