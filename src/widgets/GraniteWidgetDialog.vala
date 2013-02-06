
//
//  Copyright (C) 2011 Adrien Plazas
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
//  Authors:
//      Adrien Plazas <kekun.plazas@laposte.net>
//  Artists:
//      Daniel Foré <daniel@elementaryos.org>
//

using Gtk;
using Gdk;

public class Granite.Widgets.BasicDialog : Gtk.Dialog
{

    /**
     * The name of the program.
     */
    public string dialog_name {
        set { _program_name = value; this.name_label.set_text(value); }
        get { return _program_name; }
    }
    string _program_name = "";
    // Signals
    public virtual signal bool activate_link (string uri) {
        // Improve error management FIXME
        bool result = false;
        if (uri != null)
        {
            try {
                result = Gtk.show_uri(get_screen(), uri, Gtk.get_current_event_time());
            } catch (Error err) {
                stderr.printf ("Unable to open the URI: %s", err.message);
            }
        }
        return result;
    }

    // UI elements
    private Label name_label;
    private Button close_button;

    private Granite.Drawing.BufferSurface buffer;
    public Box main_box;
    public Box content_box;

    int shadow_blur = 15;
    int shadow_x    = 0;
    int shadow_y    = 2;
    double shadow_alpha = 0.3;

    private const string STYLESHEET = """
        * {
            -GtkDialog-action-area-border: 12px;
            -GtkDialog-button-spacing: 10px;
            -GtkDialog-content-area-border: 0;
        }
    """;

    /**
     * Creates a new Granite.AboutDialog
     */
    public BasicDialog()
    {
        title = "";
        has_resize_grip = false;
        resizable = false;
        deletable = false; // Hide the window's close button when possible
        set_default_response(ResponseType.CANCEL);


        Granite.Widgets.Utils.set_theming (this, STYLESHEET, null,
                                           Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        // Set the default containers
        main_box = (Box)get_content_area();
        //action_area = (Box)get_action_area();

        var draw_ref = new Gtk.Window ();
        draw_ref.get_style_context ().add_class (StyleClass.CONTENT_VIEW_WINDOW);

       // var title_vbox = new Box(Orientation.HORIZONTAL, 0);
        content_box = new Box(Orientation.VERTICAL, 0);

        // Apply DecoratedWindow's theming
        DecoratedWindow.set_default_theming (draw_ref);

   //     action_area.get_style_context ().add_class (StyleClass.CONTENT_VIEW);
        this.decorated = false;
        this.set_visual (this.get_screen ().get_rgba_visual ());
        this.app_paintable = true;
        //action_area.margin = 4;
        //action_area.margin_bottom = 8;
        
        this.get_content_area ().margin = 18;
        this.get_content_area ().margin_top = 20;
        this.get_content_area ().margin_bottom = 3; 

        this.content_box.width_request = this.width_request;



        Granite.Widgets.Utils.apply_text_style_to_label (TextStyle.H2, name_label);

        main_box.pack_start(content_box, true, true, 0);



        this.height_request = 282;
        this.width_request = 400;

        var w = -1;
        var h = -1;
        this.size_allocate.connect ( () => {
           if (this.get_allocated_width () == w && this.get_allocated_height () == h)
               return;
           w = this.get_allocated_width ();
           h = this.get_allocated_height ();

           this.buffer = new Granite.Drawing.BufferSurface (w, h);

           this.buffer.context.rectangle (shadow_blur + shadow_x,shadow_blur + shadow_y, w - shadow_blur*2 + shadow_x, h - shadow_blur*2 + shadow_y);
           this.buffer.context.set_source_rgba (0, 0, 0, shadow_alpha);
           this.buffer.context.fill ();
           this.buffer.exponential_blur (shadow_blur / 2);

           draw_ref.get_style_context ().render_activity (this.buffer.context, shadow_blur + shadow_x,shadow_blur + shadow_y, w - shadow_blur*2 + shadow_x, h - shadow_blur*2 + shadow_y);
        });

            /*draw the buffer*/
        this.draw.connect ( (ctx) => {
            if (buffer == null)
                return false;

            ctx.set_operator (Cairo.Operator.SOURCE);
            ctx.rectangle (0, 0, w, h);
            ctx.set_source_rgba (0, 0, 0, 0);
            ctx.fill ();

            ctx.set_source_surface (this.buffer.surface, 0, 0);
            ctx.paint ();

            return false;
        });

            /*allow moving the window*/
        this.button_press_event.connect ( (e) => {
            if (e.button == 1) {
                this.begin_move_drag ((int) e.button, (int) e.x_root, (int) e.y_root, e.time);
                return true;
            }
            return false;
        });
        show_all ();
    }

    
    public void add_content(Gtk.Widget widget){
        content_box.pack_start(widget, true, true, 0); //FIXME
        widget.show();
        widget.grab_focus();
    }
}
