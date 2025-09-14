# Hello-Nothing
 A demo of android app development on android

# Instructions
before generating the apk, make sure termux is set up properly for this process, i.e you should have at least done `termux-setup-storage` for access to external files and `yes | pkg up` for ensuring updated packages

`./init.sh` - follow the onscreen instructions for the creation of a keystore. make sure internet connection is available for downloading some external files that are necessary for compilation. additional tips for quick keystore generation :
* for simplicity make the filename and alias the same and short
* create a complicated password, with everything in your keyboard(you dont have to remember it, it's stored in **.vars.ninja**)
* skip entering personal details, and type `yes` at the end
* if failed to create, `rm *.keystore` and try again with `./init.sh`
* note that the keystore is what makes your version of apk different from another one, due to signing, this means that even if you install the same app again but with a different signature, it wont install, you have to manually uninstall the current one and do a fresh install of the new one. updates only work with the same keystore sign.

`. abs.sh` - for loading essential functions for script and apk generation.

`cd hello-world;now-this;targets-rb` - actually builds the apk in puts it in /storage/emulated/0/hello-world.apk
