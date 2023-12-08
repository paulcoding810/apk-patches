# APK Patches
------

## Commands
- Create patch file `git show --pretty="" > mod.patch` 
- Copy patch file ```
rsync -R *.patch ../apk_patches/`basename $(pwd)`/ ```

- get package name `aapt dump badging dist/*.apk | grep package:\ name`