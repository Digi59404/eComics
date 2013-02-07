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


/* Classname: Comic_Selection
 * 
 * The purpose of this class is to allow the user to see a nice mosiac of comics they can see. Say their favorites?
 *
 */

using Gtk;

namespace eComics {

    public Gtk.ListStore model;
    public Gtk.TreeIter iter;
    
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
	    Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (Environment.get_current_dir ()+"/assets/titles/xkcd.png", 64, 64, true);
	    model.append (out iter);
	    model.set (iter, 0, pixbuf, 1, "XKCD");

	    var pixbuf1 = new Gdk.Pixbuf.from_file_at_scale (Environment.get_current_dir ()+"/assets/titles/ftflogo.png", 64, 64, true);
	    //view.render_icon (Gtk.Stock.PRINT, Gtk.IconSize.DIALOG, null);
	    model.append (out iter);
	    model.set (iter, 0, pixbuf1, 1, "Failure To Feed");


	    view.selection_changed.connect (() => {
	        List<Gtk.TreePath> paths = view.get_selected_items ();
		Value title;
	        Value icon;

		foreach (Gtk.TreePath path in paths) {
		    bool tmp = model.get_iter (out iter, path);
		    assert (tmp == true);

		    model.get_value (iter, 0, out icon); 
		    model.get_value (iter, 1, out title); 
		  //  model.get_value (iter, 2, out name); 
		    //stdout.printf ("%s: %p\n", model.name, ((Gdk.Pixbuf) icon));
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
	
	public void Add_Comic(string title = "MISSING TITLE", string icon = null){
	    var pixbuf1 = new Gdk.Pixbuf.from_file_at_scale (Environment.get_current_dir ()+"/assets/titles/"+icon, 64, 64, true);
	    model.append (out iter);
	    model.set (iter, 0, pixbuf1, 1, title);
	
	}

    }
}
        
