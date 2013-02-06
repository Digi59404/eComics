//
//  Copyright (C) 2008 Christian Hergert <chris@dronelabs.com>
//  Copyright (C) 2011 Giulio Collura
//  Copyright (C) 2012 Victor Eduardo <victor@elementaryos.org>
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation; either version 2 of the
// License, or (at your option) any later version.
//
// This is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this program; see the file COPYING.  If not,
// write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
//  Boston, MA 02111-1307, USA.
//


/* MODIFIED BY CHRIS TIMBERLAKE FOR ECOMICS */


namespace Granite.Widgets {

    /**
     * This widget is a multiple option modal switch
     */
    public class RowButton : Gtk.Box {


        public signal void mode_added (int index, Gtk.Widget widget);
        public signal void mode_removed (int index, Gtk.Widget widget);
        public signal void mode_changed (Gtk.Widget widget);

        /**
         * Index of currently selected item.
         */
        public int selected {
            get { return _selected; }
            set { set_active (value); }
        }

        /**
         * Read-only length of current ModeButton
         */
        public uint n_items {
            get { return item_map.size; }
        }

        private int _selected = -1;
        private Gee.HashMap<int, Gtk.Button> item_map;

        /**
         * Makes new ModeButton
         */
        public RowButton () {
            homogeneous = true;
            spacing = 0;
            can_focus = false;

            item_map = new Gee.HashMap<int, Gtk.Button> ();

            var style = get_style_context ();
            style.add_class (Gtk.STYLE_CLASS_LINKED);
            style.add_class ("raised"); // needed for toolbars
        }

        /**
         * Appends Pixbuf to ModeButton
         *
         * @param pixbuf Gdk.Pixbuf to append to ModeButton
         */
        public Gtk.Button append_pixbuf (Gdk.Pixbuf pixbuf) {
            return append (new Gtk.Image.from_pixbuf (pixbuf));
        }

        /**
         * Appends text to ModeButton
         *
         * @param text text to append to ModeButton
         * @return index of new item
         */
        public Gtk.Button append_text (string text) {
            return append (new Gtk.Label(text));
        }

        /**
         * Appends icon to ModeButton
         *
         * @param icon_name name of icon to append
         * @param size desired size of icon
         * @return index of appended item
         */
        public Gtk.Button append_icon (string icon_name, Gtk.IconSize size) {
            return append (new Gtk.Image.from_icon_name (icon_name, size));
        }

        /**
         * Appends given widget to ModeButton
         *
         * @param w widget to add to ModeButton
         * @return index of new item
         */
        public Gtk.Button append (Gtk.Widget w) {
        
            var item = new Gtk.Button ();
            item.add (w);
            item.width_request = 36;
            

            add (item);
            item.show_all ();

            return item;
        }

        /**
         * Sets item of given index's activity 
         *
         * @param new_active_index index of changed item
         */
        public void set_active (int new_active_index) {
            return_if_fail (item_map.has_key (new_active_index));
            var new_item = item_map[new_active_index] as Gtk.Button;

            if (new_item != null) {

                if (_selected == new_active_index)
                    return;


                _selected = new_active_index;

                mode_changed (new_item.get_child ());
            }
        }

        /**
         * Removes item at given index
         *
         * @param index index of item to remove
         */
        public new void remove (int index) {
            return_if_fail (item_map.has_key (index));
            var item = item_map[index] as Gtk.Button;

            if (item != null) {
             //   assert (item.index == index);
                mode_removed (index, item.get_child ());
                item_map.unset (index);
                item.destroy ();
            }
        }

        /**
         * Clears all children
         */
        public void clear_children () {
            foreach (weak Gtk.Widget button in get_children ()) {
                button.hide ();
                if (button.get_parent () != null)
                    base.remove (button);
            }

            item_map.clear ();

            _selected = -1;
        }
    }
}
