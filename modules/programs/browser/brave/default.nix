{...}: {
  programs.brave = {
    enable = true;
    commandLineArgs = [
      # VA-API hardware acceleration
      "--enable-accelerated-video-decode"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,CanvasOopRasterization"
      # Privacy
      "--disable-features=MediaRouter,OptimizationHints,AutofillSavePaymentMethods,WaylandWpColorManagerV1"
    ];
    extensions = let
      ids = [
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      ];
    in
      map (id: {inherit id;}) ids;
  };
}
