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



// Vala uses a syntax similar to C#. Anything that's in a namespace can be included by doing "using _NAMESPACE_";
// We include GTK here because we want to build a Hello World Window.
using Gtk;

//Next we define our own namespace to hold our application.
namespace eComics {
    
    //Here we create our main application class. We derive from Granite.Application because it includes
    //many helper functions for us. It also includes a Granite window which is based off of the 
    //Elementary Human Interface Guildlines. You'll see in the future how much it helps us.
    public class eComics_MW : Granite.Application {
        
        //Before we get into the constructor functions. We need to define any classwide variables.
        //Here we're going to define the MainWindow variable. We'll be assigning the GTK Window to this.
        public Granite.Widgets.BasicDialog m_window;
        public Gtk.ToolItem		    main_title;
        public Gtk.Label		    mw_title;
        public Gtk.Box			    main_content; // Used to contain the toolbar and content_box
        public Gtk.Box			    content_box; // Used to display content.


        //Here we create the construct function for our class. Vala uses "construct" as a constructor
        //function. In this construct we define many variable that are needed for granite.
        //As time goes on we'll show that granite will take these variables and construct an about
        //dialog just for us.
        construct {
            // Your Program's Name
            program_name        = "eComics";

            //The Executable name for your program.
            exec_name           = "eComics";
            
            //The years your application is copyright.
            app_years           = "2013";

            //The icon your application uses.
            //This icon is usually stored within the "/usr/share/icons/elementary" path.
            //Put your icon in each of the respected resolution folders to enable it's use.
            app_icon            = "application-default-icon";

            //This defines the name of our desktop file. This file is used by launchers, docks,
            //and desktop environments to display an icon. We'll cover this later.
            app_launcher        = "eComics.desktop";

            //This is a unique ID to your application. A traditional way is to do
            // com/net/org (dot) your companies name (dot) your applications name
            //For here we have "Organization.Elementary.GraniteHello"
            application_id      = "org.elementary.eComics";
            

            //These are very straight forward.
            //main_url = The URL linking to your website.
            main_url            = "http://christophertimberlake.com/#/post/39298284501/so-you-want-to-develop-for-elementary-os";

            //bug_url = The URL Linking to your bug tracker.
            bug_url             = "http://christophertimberlake.com/#/post/39298284501/so-you-want-to-develop-for-elementary-os";

            //help_url = The URL to your helpfiles.
            help_url            = "http://christophertimberlake.com/#/post/39298284501/so-you-want-to-develop-for-elementary-os";

            //translate_url = the URL to your translation documents.
            translate_url       = "http://christophertimberlake.com/#/post/39298284501/so-you-want-to-develop-for-elementary-os";

 
	   const string app_license_name = "MIT License";
	   const Gtk.License app_license = License.MIT_X11;
	   

        }
        
        //This is another constructor. We can put GTK Overrides here...
        public eComics_MW(){

        }
        

        //This is our function to "activate" the GTK App. Here is where we define our startup functions.
        //Splash Screen? Initial Plugin Loading? Initial Window building? All of that goes here.
        public override void activate (){

            uint8[] contents;
	    string etag_out;
	    try {
		File file = File.new_for_path(Environment.get_current_dir ()+"/assets/app.css");
		file.load_contents (null, out contents, out etag_out);
	    }
	    catch(GLib.Error err){
		print("ERROR LOADING CSS FILE. EXITING\n");
		print(err.message);
	    }
            
            Granite.Widgets.Utils.set_theming_for_screen (Gdk.Screen.get_default(), (string)contents, Gtk.STYLE_PROVIDER_PRIORITY_USER);

            this.m_window = new Granite.Widgets.BasicDialog();
            // This sets the Window as our Main Application Window.
            this.m_window.set_application(this);

            //This sets our window's default size. 800 px width by 600 px height
            m_window.height_request = 600;
            m_window.width_request = 800;

	    main_content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            
            //Make the toolbar!
            var toolbar = new Gtk.Toolbar();
            
            var close = new Gtk.Button ();
	    close.set_image(new Gtk.Image.from_file("/usr/share/themes/elementary/metacity-1/close.svg"));
            Gtk.ToolItem close_t = new Gtk.ToolItem();
            close_t.add(close);
            
            // EXIT BUTTON
            close.clicked.connect (() => m_window.destroy ());
            
            // MENU/VIEW MODEBUTTON
            var menu_t = new ToolModeButton();
            
            //var icon = new Gtk.Image.from_pixbuf (Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("view-list-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            //Gtk.Button menu = new Gtk.Button();
            //menu.set_image(icon);
            //Gtk.ToolItem menu_t = new Gtk.ToolItem();
            //menu_t.add(menu);
            //menu_t.margin_left = 10;
            var menu = menu_t.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("view-list-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            var view1 = menu_t.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("view-filter-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            var view2 = menu_t.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("view-coverflow-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            menu_t.show_all();
            menu_t.margin_left = 10;
            
            menu.clicked.connect(() => {
    		this.set_content(new Comic_Selection());
            });
            
            // MODE BUTTON
            var mode = new ToolModeButton();
            mode.margin_left = 10;
            var btn1 = mode.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-first-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            var btn2 = mode.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-previous-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            var btn3 = mode.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-next-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            var btn4 = mode.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("go-last-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            mode.show_all();
            
            btn1.clicked.connect (() => {
                Comic_Manager.current_comic.First_Comic();

            });
            btn2.clicked.connect (() => {
                Comic_Manager.current_comic.Prev_Comic();

            });
            btn3.clicked.connect (() => {
                Comic_Manager.current_comic.Next_Comic();

            });
            btn4.clicked.connect (() => {
                Comic_Manager.current_comic.Last_Comic();

            });
            
            // TITLE
            mw_title = new Gtk.Label(program_name);
            mw_title.override_font(Pango.FontDescription.from_string("bold"));
            main_title = new Gtk.ToolItem();
            main_title.add(mw_title);
            main_title.set_expand(true);
            main_title.margin_right = 160;
            
            // ADD BUTTON
            var add_icon = new Gtk.Image.from_pixbuf (Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("list-add-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            Gtk.Button add = new Gtk.Button();
            add.set_image(add_icon);
            Gtk.ToolItem add_t = new Gtk.ToolItem();
            add_t.add(add);
            add_t.margin_left = 10;
            
            // SHARE BUTTON
            var share_icon = new Gtk.Image.from_pixbuf (Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("document-export-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            Gtk.Button share = new Gtk.Button();
            share.set_image(share_icon);
            Gtk.ToolItem share_t = new Gtk.ToolItem();
            share_t.add(share);
            share_t.margin_left = 10;
            
            // Share/Add Buttons
            var sadd = new ToolModeButton();
            var addbtn = sadd.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("list-add-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            var sharebtn = sadd.Add_Button("", Gtk.IconTheme.get_default ().lookup_by_gicon (new ThemedIcon ("document-export-symbolic"), 16, 0).load_symbolic ({0.33, 0.33, 0.33, 0.33}));
            sadd.show_all();
            
            
            // Fullscreen
            var maximize = new Gtk.Button ();
	    maximize.set_image(new Gtk.Image.from_file("/usr/share/themes/elementary/metacity-1/maximize.svg"));
            Gtk.ToolItem maximize_t = new Gtk.ToolItem();
            maximize_t.add(maximize);
            maximize.clicked.connect (() => this.toggle_maximize() );
            maximize_t.margin_left = 10;
            
            toolbar.add(close_t);
            toolbar.add(menu_t);
            toolbar.add(mode);
	    toolbar.add(main_title);
	    toolbar.add(sadd);
	    toolbar.add(maximize_t);

            
            
            //This adds the button to the main window.  
            main_content.pack_start(toolbar, false, false, 0);
            
            content_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            //Open the Comic's Selection!
            content_box.pack_start(new Comic_Selection(), true, true, 0);
            main_content.pack_start(content_box, true, true, 0);
                      
            m_window.add_content(main_content);
            //This forces the window to be shown.
            this.m_window.show_all();
            this.m_window.fullscreen();
            
    	    //Sent the window to the Comic Manager so it knows whats up.
	    Comic_Manager.Set_MainWindow(this);
        }
        
        public void empty_content(){
            var content_list = content_box.get_children();

            content_list.foreach((entry) => {
    		entry.destroy();               
            });
        }
        
        // This is to check and see if it's maximized. If so, Minimize.
        public void toggle_maximize(){
          /*  if(this.maximized == "false"){
                this.maximize ();
                this.maximized = "true";
            } else {
                this.unmaximize ();
                this.maximized = "false" ; 
            } */
        }
        
        
        /*
         * This function is used to set the main content inside the window.
         * This is required because the toolbar is also in the same box!
         */
 	 public void set_content(Gtk.Widget widget){
 	    this.empty_content();
 	    this.content_box.pack_start(widget, true, true, 0);
 	    this.content_box.show_all();
 	 
 	 }
    }
}



// Now that our application and window are defined, we have to call them through the main loop.
// We do this by starting with a main function. You could theoretically include all the code above
// in a main function. However it doesn't make for clean code and you wont be able to take part
// in all of granite's cool features.

// All main loop functions should start as an int. You can do self-checks within the app and 
// return 0 to force the app to close in the event of an issue.
public static int main(string[] args){

    //We need to tell GTK To start. Even though we've written all the code above. None of it
    //is started yet. So we need to start GTK then run our code.
    Gtk.init(ref args);

    //Lets assign our Application Class and Namespace to a variable. You always call it by
    // var VarName = new NameSpace.Class();
    //The Classname and Namespace Name do not have to be identical. They can be different.
    var eComics = new eComics.eComics_MW();

    //Now remember how this is an Int? Instead of returning a number we're going to return our window.
    return eComics.run(args);
}
