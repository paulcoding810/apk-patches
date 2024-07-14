
# Trace

- shoud hide `activities/MainActivity;->N:Landroid/view/View;` (home top bar icon)
- if vip => put `kmgJSgyY=true` in SharePreferences
- return true if querying kmgJSgyY

```sh
    const/4 v1, 0x1

    const-string v0, "com.inshot.screenrecorder.removeads"

    invoke-interface {p1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    :cond_1
    const-string p1, "kmgJSgyY"

    invoke-static {p1, v1}, Lza3;->d(Ljava/lang/String;Z)V
    ```
