# demux-max-tag

This is a script that proved to be a little bit waste of time although nevertheless I had a lot of fun playing around it.

Its function is to demux a mkv container recursively and, depending on the present streams, repack the container by reconstructing the command for MKVToolnix. In the process the user has the ability to correct tags or naming inside the container by slightly adapting the script.

By definition this script is not portable and needs to be adapted for every different mkv file unless they have the same characteristics (like for example episodes of a season).

The benefit is that the user can correct a single language tag etc for a whole season recursively.
