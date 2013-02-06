/* Classname: Comic_Selection
 * 
 * The purpose of this class is to allow the user to see a nice mosiac of comics they can see. Say their favorites?
 *
 */

using Gtk;

namespace eComics {

    public Gtk.ListStore model;
    
    public class Comic_Selection : Gtk.Box {
    
	public Comic_Selection(){
	    
	    //Scroll window incase we go big!
	    var scrolled    = new Gtk.ScrolledWindow (null, null);

	    // The Model:
	    model = new Gtk.ListStore (2, typeof (Gdk.Pixbuf), typeof (string));
	    Gtk.TreeIter iter;

		// The IconView:
	    Gtk.IconView view = new Gtk.IconView.with_model (model);
	    view.set_pixbuf_column (0);
	    view.set_text_column (1);
	    view.item_orientation = Gtk.Orientation.VERTICAL;


		// Data:
	    Gdk.Pixbuf pixbuf = view.render_icon (Gtk.Stock.ABOUT, Gtk.IconSize.DIALOG, null);
	    model.append (out iter);
	    model.set (iter, 0, pixbuf, 1, "XKCD");

	    pixbuf = view.render_icon (Gtk.Stock.PRINT, Gtk.IconSize.DIALOG, null);
	    model.append (out iter);
	    model.set (iter, 0, pixbuf, 1, "Failure To Feed");


	    view.selection_changed.connect (() => {
	        List<Gtk.TreePath> paths = view.get_selected_items ();
		Value title;
	        Value icon;

		foreach (Gtk.TreePath path in paths) {
		    bool tmp = model.get_iter (out iter, path);
		    assert (tmp == true);

		    model.get_value (iter, 0, out icon); 
		    model.get_value (iter, 1, out title); 
		    //stdout.printf ("%s: %p\n", (string) title, ((Gdk.Pixbuf) icon));
		    Comic_Manager.Open_Comic((string)title);
		}
	    });
	    
	
	    Gtk.Viewport viewport = new Gtk.Viewport (null, null);
	    viewport.set_size_request (scrolled.width_request, scrolled.height_request);
	    viewport.add(view);
	    scrolled.add (viewport);
	    //Add the scroll window.
	    base.pack_start(scrolled, true, true, 0);
	}

    }
}
        
