# OptCarrot for measuring the Mac Tax

OptCarrot is a great CPU benchmark. So for measuring the differences between
Ruby on Mac and Linux, it's an obvious go-to.

## RubyProf

You can run OptCarrot in benchmark mode under RubyProf:

    RUBYOPT="-Ilib -r./tools/shim" ruby-prof bin/optcarrot -- --benchmark examples/Lan_Master.nes

It'll take awhile, it'll run at (on my Macbook Pro) 1.9 fps, but it'll also
get the right checksum. So it seems to work.
