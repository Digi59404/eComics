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
	
	public virtual void Retrieve_Comic(int issue){
	
	}
		
        public virtual void First_Comic(){
	
	}
	
	public virtual void Next_Comic(){
	
	}
	
	public virtual void Prev_Comic(){
	
	}
	
	public virtual void Last_Comic(){
	
	}
    }
}
        
