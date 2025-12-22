/// @description Update the frame buffer

if (webm_exists(v)) {
  if (webm_is_playing(v)) {
    webm_position = webm_get_playtime(v);
    webm_grab_frame_buffer(v, buffer_get_address(buff));
  } else if (webm_position >= webm_get_duration(v) && webm_get_duration(v) > 0) {
    game_end();
  }
}

var _window = WindowGetCloseButton();
if (_window != -1) WindowDestroy(_window);