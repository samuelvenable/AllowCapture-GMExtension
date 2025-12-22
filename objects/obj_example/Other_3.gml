/// @description Don't forget to *always* free buffers and surfaces.

if (webm_exists(v)) {

  buffer_delete(buff);
  surface_free(surf);

  webm_stop(v);
  webm_delete(v);

}