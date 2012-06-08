/* 
Copyright (c) 2011 by Simon Schneegans

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>. 
*/

namespace GnomePie {

public class MenuItem {

    public string label;
    public string icon_name;
    
    public MenuItem(string label, string icon_name) {
        this.label = label;
        this.icon_name = icon_name;
    }
    
    public void draw(Cairo.Context ctx, Gtk.Window window, int center_x, int center_y, int position, bool prelight) {
        
        int radius = 50;
        
        int pivot_x, pivot_y;
        int pos_x, pos_y;
        
        int width = 150, height = 30;
        int label_x;
        
        switch (position) {
            case 0: {
                pivot_x = center_x - (int)(radius*0.707106781);
                pivot_y = center_y - (int)(radius*0.707106781);
                width += (int)(radius*0.292893219);
                label_x = pivot_x - width + 5;
                pos_x = pivot_x - width;
                pos_y = pivot_y - height/2;
                break;
            } case 2: {
                pivot_x = center_x - radius;
                pivot_y = center_y;
                label_x = pivot_x - width + 5;
                pos_x = pivot_x - width;
                pos_y = pivot_y - height/2;
                break;
            } case 4: {
                pivot_x = center_x - (int)(radius*0.707106781);
                pivot_y = center_y + (int)(radius*0.707106781);
                width += (int)(radius*0.292893219);
                label_x = pivot_x - width + 5;
                pos_x = pivot_x - width;
                pos_y = pivot_y - height/2;
                break;
            } case 1: {
                pivot_x = center_x + (int)(radius*0.707106781);
                pivot_y = center_y - (int)(radius*0.707106781);
                width += (int)(radius*0.292893219);
                label_x = pivot_x - 15 + (int)(radius*0.292893219);
                pos_x = pivot_x;
                pos_y = pivot_y - height/2;
                break;
            } case 3: {
                pivot_x = center_x + radius;
                pivot_y = center_y;
                label_x = pivot_x - 15;
                pos_x = pivot_x;
                pos_y = pivot_y - height/2;
                break;
            } default: {
                pivot_x = center_x + (int)(radius*0.707106781);
                pivot_y = center_y + (int)(radius*0.707106781);
                width += (int)(radius*0.292893219);
                label_x = pivot_x - 15 + (int)(radius*0.292893219);
                pos_x = pivot_x;
                pos_y = pivot_y - height/2;
                break;
            }
        }
        
        render_shadowed_rectangle(ctx, window, pos_x, pos_y, width, height);
        
        window.get_style_context().add_class(Gtk.STYLE_CLASS_MENUITEM);
        
        if (prelight) {
            window.get_style_context().set_state(Gtk.StateFlags.ACTIVE);
            window.get_style_context().render_background(ctx, pos_x+1, pos_y, width-2, height);
        } 
        
        window.get_style_context().remove_class(Gtk.STYLE_CLASS_MENUITEM);
        window.get_style_context().add_class(Gtk.STYLE_CLASS_RADIO);
        window.get_style_context().render_option(ctx, pivot_x-17, pivot_y-17, 34, 34);
        window.get_style_context().remove_class(Gtk.STYLE_CLASS_RADIO);
        window.get_style_context().add_class(Gtk.STYLE_CLASS_MENUITEM);
        
        var layout = window.create_pango_layout(label);
        if (position == 1 || position == 3 || position == 5)
            layout.set_alignment(Pango.Alignment.RIGHT);
        layout.set_width((int)(150.0*Pango.SCALE));
        window.get_style_context().render_layout(ctx, label_x+4, pos_y+8, layout);
        
        if (icon_name != "") {
            var icon = new Icon(icon_name, 20);
            window.get_style_context().render_icon(ctx, icon.to_pixbuf(), pivot_x-10, pivot_y-10);
        }
        
        window.get_style_context().remove_class(Gtk.STYLE_CLASS_MENUITEM);
        window.get_style_context().set_state(Gtk.StateFlags.NORMAL);   
    }
    
    private void render_shadowed_rectangle(Cairo.Context ctx, Gtk.Window window, int x, int y, int width, int height) {
        
        window.get_style_context().add_class(Gtk.STYLE_CLASS_MENU);
    
        int radius = 4;
        int offset_x = 0;
        int offset_y = 1;
        
        double r = 0.0;
        double g = 0.0;
        double b = 0.0;
        double a = 0.5;
        
        var left = new Cairo.Pattern.linear(x+offset_x + radius/2, 0, x+offset_x - radius/2, 0);
            left.add_color_stop_rgba(0.0, r, g, b, a);
            left.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(left);
            ctx.rectangle(x+offset_x - radius/2, 
                          y+offset_y + radius/2, 
                          radius, 
                          height-radius);
            ctx.fill();
            
        var right = new Cairo.Pattern.linear(x+offset_x - radius/2 + width, 0, x+offset_x + radius/2 + width, 0);
            right.add_color_stop_rgba(0.0, r, g, b, a);
            right.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(right);
            ctx.rectangle(x+offset_x - radius/2 + width, 
                          y+offset_y + radius/2, 
                          radius, 
                          height-radius);
            ctx.fill();
            
        var top = new Cairo.Pattern.linear(0, y+offset_y + radius/2, 0, y+offset_y - radius/2);
            top.add_color_stop_rgba(0.0, r, g, b, a);
            top.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(top);
            ctx.rectangle(x+offset_x + radius/2, 
                          y+offset_y - radius/2, 
                          width-radius, 
                          radius);
            ctx.fill();
            
        var bottom = new Cairo.Pattern.linear(0, y+offset_y - radius/2 + height, 0, y+offset_y + radius/2 + height);
            bottom.add_color_stop_rgba(0.0, r, g, b, a);
            bottom.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(bottom);
            ctx.rectangle(x+offset_x + radius/2, 
                          y+offset_y - radius/2 + height, 
                          width-radius, 
                          radius);
            ctx.fill();
            
        var topleft = new Cairo.Pattern.radial(x+offset_x + radius/2, y+offset_y + radius/2, 0,
                                               x+offset_x + radius/2, y+offset_y + radius/2, radius);
            topleft.add_color_stop_rgba(0.0, r, g, b, a);
            topleft.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(topleft);
            ctx.rectangle(x+offset_x - radius/2, 
                          y+offset_y - radius/2, 
                          radius, 
                          radius);
            ctx.fill();
            
        var topright = new Cairo.Pattern.radial(x+offset_x - radius/2 + width, y+offset_y + radius/2, 0,
                                                x+offset_x - radius/2 + width, y+offset_y + radius/2, radius);
            topright.add_color_stop_rgba(0.0, r, g, b, a);
            topright.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(topright);
            ctx.rectangle(x+offset_x - radius/2 + width, 
                          y+offset_y - radius/2, 
                          radius, 
                          radius);
            ctx.fill();
            
        var bottomleft = new Cairo.Pattern.radial(x+offset_x + radius/2, y+offset_y - radius/2 + height, 0,
                                                  x+offset_x + radius/2, y+offset_y - radius/2 + height, radius);
            bottomleft.add_color_stop_rgba(0.0, r, g, b, a);
            bottomleft.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(bottomleft);
            ctx.rectangle(x+offset_x - radius/2, 
                          y+offset_y - radius/2 + height, 
                          radius, 
                          radius);
            ctx.fill();
            
        var bottomright = new Cairo.Pattern.radial(x+offset_x - radius/2 + width, y+offset_y - radius/2 + height, 0,
                                                   x+offset_x - radius/2 + width, y+offset_y - radius/2 + height, radius);
            bottomright.add_color_stop_rgba(0.0, r, g, b, a);
            bottomright.add_color_stop_rgba(1.0, r, g, b, 0.0);
            
            ctx.set_source(bottomright);
            ctx.rectangle(x+offset_x - radius/2 + width, 
                          y+offset_y - radius/2 + height, 
                          radius, 
                          radius);
            ctx.fill();
        
        window.get_style_context().render_background(ctx, x, y, width, height);
        window.get_style_context().render_frame(ctx, x, y, width, height);
        
        window.get_style_context().remove_class(Gtk.STYLE_CLASS_MENU);
    }
    
    
}

}
