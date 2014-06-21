## Objspace Viewer

WIP Sinatra/AR app to view/analyze heapdumps from Ruby's ObjectSpace.dump_all.

## Wat

This is a simple sinatra and ActiveRecord based web application meant for running locally. It has a tool for importing your a heap dump into a postgres DB (or probably any AR adaptable DB) and then navigating and viewing in a simple web view.

![http://www.quirkey.com/skitch/Fullscreen_6_21_14__11_25_AM.jpg](http://www.quirkey.com/skitch/Fullscreen_6_21_14__11_25_AM.jpg)

## Setup

Assuming you have Ruby (latest), Rubygems, and a running PostgreSQL server.

```
git clone https://github.com/quirkey/objspace_viewer
cd objspace_viewer
bundle install --binstubs
createdb objspace_development
./bin/rake db:migrate
./bin/shotgun
# Running on localhost:9393
```

## How

First, get a dump from a server. For this we've been using rbtrace to attach to the server and run the dump.

```
$ ./bin/rbtrace -p [RUBY_PROCESS_PID] -e 'GC.start(full_mark: true); require “objspace”; ObjectSpace.dump_all(output: File.open(“heap.json","w"))'
```

This should attach and eventually heap.json should be created and filled with your dump.

```
$ ls -lh heap.json 
-rw-r--r--  1 aaronquint  staff    87M Jun 16 21:52 heap.json
```

Once you have the dump locally:

```
cd objspace_development
./scripts/import heap.json
```

This will take a while depending how large your dump is.

Then you should see the data at http://localhost:9393

### Caveats

This is a known WIP. Please be gentle.
