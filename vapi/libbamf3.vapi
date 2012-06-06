/* libbamf3.vapi generated by vapigen, do not modify. */

namespace Bamf {
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class Application : Bamf.View {
		[CCode (has_construct_function = false)]
		protected Application ();
		public unowned string get_application_type ();
		public unowned string get_desktop_file ();
		public bool get_show_menu_stubs ();
		public unowned GLib.List get_windows ();
		public unowned GLib.Array get_xids ();
		public virtual signal void window_added (Bamf.View p0);
		public virtual signal void window_removed (Bamf.View p0);
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class Control : GLib.Object {
		[CCode (has_construct_function = false)]
		protected Control ();
		public static unowned Bamf.Control get_default ();
		public void insert_desktop_file (string desktop_file);
		public void register_application_for_pid (string application, int32 pid);
		public void register_tab_provider (string path);
		public void set_approver_behavior (int32 behavior);
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class Indicator : Bamf.View {
		[CCode (has_construct_function = false)]
		protected Indicator ();
		public unowned string get_dbus_menu_path ();
		public unowned string get_remote_address ();
		public unowned string get_remote_path ();
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class Matcher : GLib.Object {
		[CCode (has_construct_function = false)]
		protected Matcher ();
		public bool application_is_running (string application);
		public unowned Bamf.Application get_active_application ();
		public unowned Bamf.Window get_active_window ();
		public unowned Bamf.Application get_application_for_desktop_file (string desktop_file_path, bool create_if_not_found);
		public unowned Bamf.Application get_application_for_window (Bamf.Window window);
		public unowned Bamf.Application get_application_for_xid (uint32 xid);
		public unowned GLib.List get_applications ();
		public static unowned Bamf.Matcher get_default ();
		public unowned GLib.List get_running_applications ();
		public unowned GLib.List get_tabs ();
		public unowned GLib.List get_windows ();
		public unowned GLib.Array get_xids_for_application (string application);
		public void register_favorites (string favorites);
		public virtual signal void active_application_changed (GLib.Object p0, GLib.Object p1);
		public virtual signal void active_window_changed (GLib.Object p0, GLib.Object p1);
		public virtual signal void view_closed (GLib.Object p0);
		public virtual signal void view_opened (GLib.Object p0);
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class Tab : Bamf.View {
		[CCode (has_construct_function = false)]
		public Tab (string id, string uri);
		public unowned string get_id ();
		public unowned string get_preview ();
		public unowned string get_uri ();
		public void set_preview (string uri);
		public void set_uri (string uri);
		public virtual void show ();
		[NoAccessorMethod]
		public string id { owned get; set construct; }
		public string preview { get; set; }
		public string uri { get; set construct; }
		public virtual signal void preview_updated ();
		public virtual signal void uri_changed (string new_uri, string p1);
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class TabSource : GLib.Object {
		[CCode (has_construct_function = false)]
		protected TabSource ();
		public unowned string get_tab_ids ();
		public unowned GLib.Array get_tab_preview (string tab_id);
		public unowned string get_tab_uri (string tab_id);
		public uint32 get_tab_xid (string tab_id);
		public virtual void show_tab (string tab_id, GLib.Error error);
		[NoWrapper]
		public virtual unowned string tab_ids ();
		[NoWrapper]
		public virtual unowned GLib.Array tab_preview (string tab_id);
		[NoWrapper]
		public virtual unowned string tab_uri (string tab_id);
		[NoWrapper]
		public virtual uint32 tab_xid (string tab_id);
		[NoAccessorMethod]
		public string id { owned get; set construct; }
		public virtual signal void tab_closed (string p0);
		public virtual signal void tab_opened (string p0);
		public virtual signal void tab_uri_changed (string p0, string p1, string p2);
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class View : GLib.InitiallyUnowned {
		[CCode (has_construct_function = false)]
		protected View ();
		[NoWrapper]
		public virtual Bamf.ClickBehavior click_behavior ();
		public virtual unowned GLib.List get_children ();
		public Bamf.ClickBehavior get_click_suggestion ();
		public virtual unowned string get_icon ();
		public virtual unowned string get_name ();
		public unowned string get_view_type ();
		public virtual bool is_active ();
		public bool is_closed ();
		public virtual bool is_running ();
		public bool is_sticky ();
		public virtual bool is_urgent ();
		[NoWrapper]
		public virtual void set_path (string path);
		public void set_sticky (bool value);
		public bool user_visible ();
		[NoWrapper]
		public virtual unowned string view_type ();
		[NoAccessorMethod]
		public bool active { get; }
		[NoAccessorMethod]
		public string path { owned get; }
		[NoAccessorMethod]
		public bool running { get; }
		[NoAccessorMethod]
		public bool urgent { get; }
		public virtual signal void active_changed (bool active);
		public virtual signal void child_added (Bamf.View child);
		public virtual signal void child_removed (Bamf.View child);
		public virtual signal void closed ();
		public virtual signal void name_changed (string old_name, string new_name);
		public virtual signal void running_changed (bool running);
		public virtual signal void urgent_changed (bool urgent);
		public virtual signal void user_visible_changed (bool user_visible);
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h")]
	public class Window : Bamf.View {
		[CCode (has_construct_function = false)]
		protected Window ();
		public unowned Bamf.Window get_transient ();
		public Bamf.WindowType get_window_type ();
		public uint32 get_xid ();
		public ulong last_active ();
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h", cprefix = "BAMF_CLICK_BEHAVIOR_", has_type_id = false)]
	public enum ClickBehavior {
		NONE,
		OPEN,
		FOCUS,
		FOCUS_ALL,
		MINIMIZE,
		RESTORE,
		RESTORE_ALL,
		PICKER
	}
	[CCode (cheader_filename = "libbamf3/libbamf/libbamf.h", cprefix = "BAMF_WINDOW_", has_type_id = false)]
	public enum WindowType {
		NORMAL,
		DESKTOP,
		DOCK,
		DIALOG,
		TOOLBAR,
		MENU,
		UTILITY,
		SPLASHSCREEN
	}
}
