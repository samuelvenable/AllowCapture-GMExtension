/// @description Draw the frame to the screen

draw_set_color(c_white);
display_set_gui_size(window_get_width(), window_get_height());

// rembember to check if webm exists when interacting with webm.
// if you get a crash it is likely because you a trying to interact
// with memory that no longer exists or doesn't exist yet (webm).
if (webm_exists(v)) {

  if (!surface_exists(surf)) {
    // create a squeaky clean totally empty surface for our needs.
    surf = surface_create(w, h);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
  }

  // then we just slap the webm frame on that surf.
  buffer_set_surface(buff, surf, 0);
  draw_surface_stretched(surf, 0, 0, window_get_width(), window_get_height());
 
  draw_set_alpha(0.75);
  draw_set_color(c_black);
  draw_rectangle(0, window_get_height() - string_height(filename_name(fname)), 
  window_get_width(), window_get_height(), false);
  
  draw_set_alpha(0.15);
  draw_set_color(c_ltgray);
  draw_rectangle(0, window_get_height() - string_height(filename_name(fname)), 
  window_get_width() * (webm_position / webm_get_duration(v)), 
  window_get_height(), false);

  draw_set_alpha(1);
  draw_set_font(fnt_example);
  draw_set_color(c_white);
  draw_set_halign(fa_center);
  draw_set_valign(fa_bottom);
  draw_text(window_get_width() / 2, window_get_height(), filename_name(fname));

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

}
