/// @description Pause toggle

if (webm_exists(v)) {
  if (webm_is_paused(v)) {
    webm_play(v);
  } else {
    webm_pause(v);	
  }
}