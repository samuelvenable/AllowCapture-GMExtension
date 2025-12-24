# AllowCapture GameMaker Extension

Allows GameMaker Projects to Work with the [WindowCapture Extension](https://github.com/samuelvenable/WindowCapture-GMExtension)

Things that don't work right now, and will fail silently when attempted:

- Fullscreen Window
- Borderless Window
- Resizeable Window
- Draw GUI Events

Handle all your GUI drawing in the regular Draw Events instead of the Draw GUI Events. This is what older / legacy versions of GM had to do anyway. For your project, you will need to create a persistent controller object that will launch all of its events for the entire duration of your game. This means the object should be created in the first room your game opens in, and the controller object should not be destroyed or deactivated. There should be only one instance of the controller object at a time; during the Game Restart Event, make sure no additional instances are created, to prevent duplicate code execution. In the Create Event code of your persistent controller object, use this snippet:
```gml
winex = -1; wbuff = -1; wsurf = -1;
wchan = buffer_sizeof(buffer_u64);
```

At the end of all your Draw Event code in your persistent controller object, use this snippet:

```gml
wsurf = application_surface;
if (surface_exists(wsurf)) {
  if (buffer_exists(wbuff) && wbuff != -1) buffer_delete(wbuff);
  wbuff = buffer_create(wchan * surface_get_width(wsurf) * surface_get_height(wsurf), buffer_fixed, wchan);
  buffer_get_surface(wbuff, wsurf, 0);
  if (winex < 0) {
    winex = WindowCreate("EmbeddedWindow", buffer_get_address(wbuff), surface_get_width(wsurf), surface_get_height(wsurf));
    WindowSetParentWindow(winex, window_handle());
  } else {
    WindowUpdate(winex, buffer_get_address(wbuff), surface_get_width(wsurf), surface_get_height(wsurf));
    WindowSetParentWindow(winex, window_handle());
  }
}
```

In the Step Event code of your persistent controller object, use this snippet:
```gml
var _window = WindowGetCloseButton();
if (_window != -1) WindowDestroy(_window);
```

Mouse input does work, but you need to use the Global Mouse Events, with a few caveats:

- You need to do all mouse position detection with `display_mouse_get_x()` and `display_mouse_get_y()`.
- This means you can't detect mouse positions with `window_mouse_get_x()` or `window_mouse_get_y()`.
- This means you can't detect mouse positions with `mouse_x` or `mouse_y`.
- An example code snippet of a mouse hit-box detection code which works:
```gml
if (display_mouse_get_x() >= window_get_x() + 64 &&
  display_mouse_get_y() >= window_get_y() + 64 &&
  display_mouse_get_x() <= window_get_x() + window_get_width() - 64 &&
  display_mouse_get_y() <= window_get_y() + window_get_height() - 64) {
  // inside hit-box, window bounds with 64-pixel letterbox.
}
```

It is not ideal for projects which want precise mouse collision detection on sprite masks, but it should not matter for most real-world use cases. Worst-case scenario, you will need to do a little more math in your code to acheive the same mouse detection GM would normally handle for you. Please report bugs on GitHub or contact me on Discord. My username / handle on both websites is @`samuelvenable`.

The demo in this repository uses my WebMPlayer Extension to demonstate basic usage with a minimal project.
