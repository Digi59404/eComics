using Gtk;

//Next we define our own namespace to hold our application.
namespace eComics {
    
    //Here we create our main application class. We derive from Granite.Application because it includes
    //many helper functions for us. It also includes a Granite window which is based off of the 
    //Elementary Human Interface Guildlines. You'll see in the future how much it helps us.
    public class ToolModeButton : Gtk.ToolItem {
	public Granite.Widgets.RowButton modebutton;
    
	public ToolModeButton(){
	    modebutton = new Granite.Widgets.RowButton();
	    var btn1_icon = Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-first-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33});
	    var btn1 = modebutton.append_pixbuf(btn1_icon);
	    
	    var btn2_icon = Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-previous-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33});
	    var btn2 = modebutton.append_pixbuf(btn2_icon);
	    
	    var btn3_icon = Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-next-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33});
	    var btn3 = modebutton.append_pixbuf(btn3_icon);
	    
	    var btn4_icon = Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-last-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33});
	    var btn4 = modebutton.append_pixbuf(btn4_icon);
	    
	    btn1.clicked.connect (() => {
                print("HOLY COWS");

            });
            btn2.clicked.connect (() => {
                print("HOLY COWS");

            });
            btn3.clicked.connect (() => {
                print("HOLY COWS");

            });
            btn4.clicked.connect (() => {
                print("HOLY COWS");

            });
	    
	    this.add(modebutton);
	}
    }
    
}
