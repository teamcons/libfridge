namespace Fridge {
    public static void say_hello () {
        stdout.printf ("say_hello () called\n");
    }

    /*************************************************/
    /**
    * Persistently check for the data directory and create if there is none
    * Without this, we risk creating our storage in the void
    */
    private static void check_if_datadir () {
        debug ("[STORAGE] do we have a data directory?");
        var dir = File.new_for_path ( Environment.get_user_data_dir ());

        try {
			if (!dir.query_exists ()) {
				dir.make_directory ();
				debug ("[STORAGE] yes we do now");
			}
		} catch (Error e) {
			warning ("[STORAGE] Failed to prepare target data directory: %s\n", e.message);
		}
	}
}
