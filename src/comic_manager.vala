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


/* Classname: Comic_Manager
 * 
 * Here is the beef! Comic_Manager is what loads all of the comic viewers, it also provides a list of all comic viewers for the Comic_Selection.
 * 
 *
 */


namespace eComics {
    
    public class Comic_Manager : GLib.Object {
	public static eComics_MW main_window;
	public static Comic_Connector current_comic;
	
	public static Comic_Manager(){
	
	}
	
	public static void Set_MainWindow(eComics_MW main){
	    Comic_Manager.main_window = main;
	}
	
	public static void Open_Comic(string title){
	    switch(title){
		default:
		    Comic_Manager.main_window.set_content(new Gtk.Label("RUH ROH! We were unable to load this comic!"));
		    break;
		case "XKCD":
		    current_comic = new XKCD_Connector();
		    print("SELECTING XKCD");
		    current_comic.Retrieve_Comic(1);
		    break;
	    }
	}
    }
}
        
