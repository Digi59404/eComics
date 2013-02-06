/*
Copyright (c) 2013 Chris Timberlake <Chris@TimberlakeTechnologies.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal 
in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/


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
	    /*var btn1_icon = Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-first-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33});
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

            });*/
	    
	    this.add(modebutton);
	}
	
	public Gtk.Button Add_Button(string label = "button", Gdk.Pixbuf icon = null){
	    
	    var btn_icon = icon;
	    var btn = modebutton.append_pixbuf(btn_icon);
	    return btn;
	}
    }
    
}
