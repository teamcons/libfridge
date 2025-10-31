/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

namespace Fridge {
    private static bool initialized = false;

    /**
     * The number of files detected in the data directory
     * You need to call Fridge.init () or else this will not be initialized
     *
     * Access to files will pollute the data directory with temporary files and
     * pollute the count if it is done after declaring a couple Storage objects,
     * So we can obtain a reliable count only early on. 
     */ 
    public static uint8? file_count { get; private set; default = null;}


    /**
     * The name of all files detected in the data directory
     * You need to call Fridge.init () or else this will not be initialized
     *
     * Access to files will pollute the data directory with temporary files and
     * pollute the count if it is done after declaring a couple Storage objects,
     * So we can obtain a reliable count only early on. 
     */ 
    public static string[]? file_list { get; private set; default = null;}


    /**
     * Hi bud 
     */ 
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
        var dir = GLib.File.new_for_path ( Environment.get_user_data_dir ());

        try {
			if (!dir.query_exists ()) {
				dir.make_directory ();
				debug ("[STORAGE] yes we do now");
			}
		} catch (Error e) {
			warning ("[STORAGE] Failed to prepare target data directory: %s\n", e.message);
		}
	}

    /**
     * Initializes Fridge. If Fridge has already been initialized, the function will return.
     * Retrieves how many files we have in the data directory
     */
    public static void init () {
        if (initialized) {
            return;
        }

        check_if_datadir ();

        try {
            var data_dir = Dir.open (Environment.get_user_data_dir ());
            string? filename = null;
            Fridge.file_count = 0;
            Fridge.file_list = {}            

            while ((filename = data_dir.read_name ()) != null) {
                print (filename);

                Fridge.file_count++;
                Fridge.file_list += filename;
            }

        } catch (Error e) {
            warning ("Cannot read datadir! Is the disk okay? %s\n", e.message);
        }
    }



}
