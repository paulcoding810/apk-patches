# APK Patches
------

## Commands
- Create patch file `git show --pretty="" > mod.patch` 
- Copy patch file ```
rsync -R mod.patch ../apk_patches/\`basename $(pwd)\`\\ ```
