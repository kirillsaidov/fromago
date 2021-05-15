module meta;

public import gtk.MainWindow;
public import gtk.Box;
public import gtk.Main;
public import gtk.Menu;
public import gtk.MenuBar;
public import gtk.MenuItem;
public import gtk.Widget;
public import gdk.Event;

enum CalculationType {
	CalculateSolutionPercentage,
	CalculateSubstanceWeight,
	CalculateSolutionWeight,
}

public CalculationType calcType = CalculationType.CalculateSolutionPercentage;

