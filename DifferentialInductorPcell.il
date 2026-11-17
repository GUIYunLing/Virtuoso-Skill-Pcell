;; ============================================================================
;; Module loader. Loads the modules in dependency order.
;; ----------------------------------------------------------------------------
;; Usage:
;;   dfIndModDir = "/path/to/src"
;;   load(strcat(dfIndModDir "/DifferentialInducotrPcell.il"))
;; Same interface as the single-file version:
;;   InducotrPcell(lib cell)                  ; cell + CDF
;;   dfSymIndBuild(lib cell Pw Ps Ra Tr)     ; build the geometry
;; ============================================================================

unless(boundp('dfIndModDir)
  dfIndModDir = "."
)

procedure(dfIndLoadModules()
  let((mods path n)
    mods = list(
      "dfInd_m1_util.il"
      "dfInd_m2_config.il"
      "dfInd_m3_winding.il"
      "dfInd_m4_route.il"
      "dfInd_m5_pin.il"
      "dfInd_m6_engine.il"
      "dfInd_m7_cdf.il"
    )
    n = 0
    foreach(m mods
      path = strcat(dfIndModDir "/" m)
      unless(isFileName(path)
        error("dfIndLoadModules: module not found: %s (check dfIndModDir)" path))
      load(path)
      printf("  loaded %s\n" m)
      n++)
    printf("inductor generator: 7 modules / 39 procedures loaded\n")
    t
  );let
);proc

dfIndLoadModules()

