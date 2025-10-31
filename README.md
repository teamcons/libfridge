# libfridge

A simple, hassle-free storage library to keep your data fresh.
Ready out of the box, comprehensive for vala newcomers, and built to be reliable and out of your way.

This library primarily contains:

- StringStorage: Store a string, any size.
- JsonStorage: Store an array of Json.Node or Json.Objects 
- Static variables to keep track of your data files

## Features:
- [x] Smart instancing: Each instance is its own distinct file, and you can let Fridge deal with that.
- [x] Cache: By default a cache lets you access content faster
- [x] Optional error handling: You can connect to the error() signal. If you want to.
- [x] Optional Json: You can rely on pretty pure vala here if you want to keep it light
- [x] Add a contains() method, so people can do if (var in storageinstance)
- [x] Handy: Static values to help you manage your datadir

Wishlist of features:
- [ ] Integrated debounce saving?
- [ ] More agressive trying to load/save in case of errors
- [ ] Optional SQL storage i think? Something stupid: One key one value. Optional like the json one
- [ ] Save to binary?
- [ ] Make shit async for cases with heavy objects?
- [ ] encrypted storage ? using some combined magic of libsecret and some traditional encrypt library? maybe a salt and a randomly generated password? so user only need unlock their keyring, and the random gen gets pulled out invisibly.



## How to use: Crash course

All instances are meant to represent a file on disk. Simply declare:

```
var mystorage = new Fridge.json_storage();
```

Or any variant depending what you want to store... And you are good to go!
Save by doing:

```
mystorage.content = thing_to_save;
```

Access it by doing:

```
var thing_to_load = mystorage.content;
```

## Apps using Fridge:

- [ ] Jorts (https://github.com/ellie-commons/Jorts) 
- [ ] You can expand this list! 


## Build Instructions

First, setup the build directory by running the following command in the project root:

```
meson setup build --prefix=/usr
```

Now change to the `build` directory (`cd build`) for the following commands:

Build libfridge:

```
ninja
```

To install libfridge:

```
ninja install
```


## Add to your meson

With Fridge installed on your puter, simply add to your dependencies:

```
  dependency('libfridge-0.1'),
```


## Add to your flatpak project

Simply copy the in your manifest before your app sources:

```
  - name: libfridge
    buildsystem: meson
    sources:
      - type: git
        url: https://github.com/vala-community/libfridge.git
        tag: 0.0.1
        commit: [NOT DONE YET]
        x-checker-data:
          type: git
          tag-pattern: '^([\d.]+)$'
```

By default JsonStorage is included. If you do not use it, and wish to skip having a json dependency, you can add immediately after the buildsystem line:

```
    config-opts:
      - -Denable_json=false
```


## Documentation

By default, documentation is built by default using [`valadoc`](https://docs.vala.dev/developer-guides/documentation/valadoc-guide.html)

If you would not like to generate documentation for this project, pass the additional `-Denable_valadoc=false` flag to meson then run `ninja` as before.

If you haven't created the build directory, in the project root run:

```
meson setup build --prefix=/usr -Denable_valadoc=false
```

However, if you have already created the build directory, you can run the following command inside the build directory:

```
meson configure -Denable_valadoc=false
```

To enable valadoc documentation generation again, perform the same commands again but replace `false` in `-Denable_valadoc=` with `true`.
