/* Classname: Comic_Manager
 * 
 * Here is the beef! Comic_Manager is what loads all of the comic viewers, it also provides a list of all comic viewers for the Comic_Selection.
 * 
 *
 */


namespace eComics {
    
    public class Comic_Manager : GLib.Object {
	public static eComics_MW main_window;
	
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
	    }
	}
    }
}
        
