/* Classname: Comic_Connector
 * 
 * This is a base class for all of the Comic Connector Types. The Comic Connectors are what retrieves the comics and then sends them to Comic_Viewer. 
 * Comic_Viewer is ultimately sent to the main window to be displayed.
 *
 */


namespace eComics {
    
    public class Comic_Connector : GLib.Object {
    
	public Comic_Connector(){
	
	}
	
	public virtual void Retrieve_Comic(string issue){
	
	}
    }
}
        
