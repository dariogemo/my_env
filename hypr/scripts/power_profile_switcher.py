#!/usr/bin/env python3

import gi
import subprocess
import os
import sys
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib, Gdk

class PowerProfileSelector(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Power Profile Selector")
        self.set_border_width(10)
        self.set_default_size(300, 150)
        self.set_position(Gtk.WindowPosition.MOUSE)
        self.set_keep_above(True)
        self.set_decorated(False)
        
        # Make the window close when focus is lost
        self.connect("focus-out-event", self.on_focus_out)
        
        # Get current profile
        self.current_profile = self.get_current_profile()
        
        # Create a vertical box to hold our buttons
        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.add(vbox)
        
        # Add a title label
        title_label = Gtk.Label(label="Select Power Profile")
        title_label.set_markup("<b>Select Power Profile</b>")
        vbox.pack_start(title_label, False, False, 5)
        
        # Add radio buttons for each profile
        self.power_saver_btn = Gtk.RadioButton(label="Power Saver")
        vbox.pack_start(self.power_saver_btn, False, False, 0)
        
        self.balanced_btn = Gtk.RadioButton.new_from_widget(self.power_saver_btn)
        self.balanced_btn.set_label("Balanced")
        vbox.pack_start(self.balanced_btn, False, False, 0)
        
        self.performance_btn = Gtk.RadioButton.new_from_widget(self.power_saver_btn)
        self.performance_btn.set_label("Performance")
        vbox.pack_start(self.performance_btn, False, False, 0)
        
        # Set the active button based on current profile
        if self.current_profile == "power-saver":
            self.power_saver_btn.set_active(True)
        elif self.current_profile == "balanced":
            self.balanced_btn.set_active(True)
        elif self.current_profile == "performance":
            self.performance_btn.set_active(True)
        
        # Connect signals
        self.power_saver_btn.connect("toggled", self.on_profile_changed, "power-saver")
        self.balanced_btn.connect("toggled", self.on_profile_changed, "balanced")
        self.performance_btn.connect("toggled", self.on_profile_changed, "performance")
        
        # Add CSS for styling
        self.apply_css()
        
    def apply_css(self):
        css_provider = Gtk.CssProvider()
        css = """
        window {
            background-color: #2d2d2d;
            color: #ffffff;
            border-radius: 5px;
            border: 1px solid #444444;
        }
        label {
            color: #ffffff;
        }
        radiobutton {
            color: #ffffff;
        }
        radiobutton:active {
            color: #4285f4;
        }
        radiobutton:checked {
            color: #4285f4;
        }
        """
        css_provider.load_from_data(css.encode())
        
        screen = Gdk.Screen.get_default()
        style_context = Gtk.StyleContext()
        style_context.add_provider_for_screen(
            screen, 
            css_provider, 
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
    
    def get_current_profile(self):
        try:
            result = subprocess.run(
                ["powerprofilesctl", "get"],
                capture_output=True, 
                text=True, 
                check=True
            )
            return result.stdout.strip()
        except subprocess.CalledProcessError:
            return "unknown"
    
    def on_profile_changed(self, button, profile):
        if button.get_active():
            try:
                subprocess.run(
                    ["powerprofilesctl", "set", profile], 
                    check=True
                )
                self.current_profile = profile
            except subprocess.CalledProcessError as e:
                print(f"Error changing profile: {e}", file=sys.stderr)
    
    def on_focus_out(self, widget, event):
        self.close()
        return True

def main():
    win = PowerProfileSelector()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

