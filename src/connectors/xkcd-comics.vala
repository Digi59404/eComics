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


/* Classname: XKCD_Connector
 * 
 * 
 *
 */
 
 namespace eComics {
    
    public class XKCD_Connector : Comic_Connector {
	public int current_issue = 1;
    
	public XKCD_Connector(){
	
	}
	
	public override void Retrieve_Comic(int issue=1){
	    uint8[] site_contents;
	    string etag_out;
	    uint8[] img_contents;
	    
	    var site = GLib.File.new_for_uri("http://xkcd.com/"+issue.to_string()+"/");
	    site.load_contents(null, out site_contents, out etag_out);
	    
	    try {
		//Image URL (for hotlinking/embedding): http://imgs.xkcd.com/comics/expedition.png
		var regex_len = """http://imgs\.xkcd\.com/comics/+.+\.png""";
		Regex regex = new Regex ("""http://imgs\.xkcd\.com/comics/*.*\.[a-zA-Z][a-zA-Z][a-zA-Z]""");
		
		GLib.MatchInfo match;
		if (regex.match ((string)site_contents, 0, out match)){

			var img_site = GLib.File.new_for_uri(match.fetch(0));
			img_site.load_contents(null, out img_contents, out etag_out);
			
			var img_pixbuf_ldr = new Gdk.PixbufLoader();
			img_pixbuf_ldr.write(img_contents);
			img_pixbuf_ldr.close();
			
			Comic_Manager.main_window.set_content(new Gtk.Image.from_pixbuf(img_pixbuf_ldr.get_pixbuf()));
			
			this.current_issue = issue;
		} else {
		    Comic_Manager.main_window.set_content(new Gtk.Label("RUH ROH! We were unable to load this comic!")); 
		}
		
	    } catch (RegexError e){
		Comic_Manager.main_window.set_content(new Gtk.Label("RUH ROH! We were unable to load this comic!"));
		print("COMIC LOAD ERROR: "+e.message);
	    }   
	}
	
	public override void First_Comic(){
	    this.Retrieve_Comic(1);
	}
	public override void Prev_Comic(){
	    if(this.current_issue == 1){
		return;
	    } else {
		var next_comic = this.current_issue - 1;
		this.Retrieve_Comic(next_comic);
	    }
	
	}
	public override void Next_Comic(){
	    var next_comic = this.current_issue + 1;
	    this.Retrieve_Comic(next_comic);
	}
	public override void Last_Comic(){
	    //ToDo
	}
    }
}
        
