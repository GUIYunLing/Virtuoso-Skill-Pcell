;; ============================================================================
;; Engine and direct build entry
;; ----------------------------------------------------------------------------
;; Clears and rebuilds a cellView: parameter checks, grid snap, winding,
;; routing, pins. The direct build and the parameterized cell share this
;; single engine.
;; Provides: dfSymIndEngine, dfSymIndBuild, dfSymIndCell, dfSymIndHelp
;; Loaded by the loader script; loading this file alone is harmless, calling
;; it alone is not.
;; ============================================================================
;; Clear the cellView and rebuild the inductor.
procedure(dfSymIndEngine(cv Pw Ps Ra Tr)
  let((cfg k layer tailMode viaList v p grid)
    unless(Tr == 3 || Tr == 5 || Tr == 7
      error("dfSymIndEngine: Tr must be 3/5/7 (got %d)" Tr))
    unless(Pw > 0.0 error("dfSymIndEngine: Pw must be > 0 (got %L)" Pw))
    unless(Ps > 0.0 error("dfSymIndEngine: Ps must be > 0 (got %L)" Ps))
    unless(Ra > 0.0 error("dfSymIndEngine: Ra must be > 0 (got %L)" Ra))
    grid = dfIndMfgGrid(cv)
    when(grid && grid > 0.0
      let((sp)
        sp = dfIndSnapList(list(Pw Ps Ra) grid)
        unless(equal(sp list(Pw Ps Ra))
          printf("dfSymIndEngine: params snapped to mfg grid %L -> Pw=%L Ps=%L Ra=%L\n"
            grid nth(0 sp) nth(1 sp) nth(2 sp)))
        Pw = nth(0 sp)
        Ps = nth(1 sp)
        Ra = nth(2 sp)))

    let((shapes vias nets)
      shapes = cv~>shapes
      vias   = cv~>vias
      nets   = cv~>nets
      foreach(s shapes dbDeleteObject(s))
      foreach(v vias   dbDeleteObject(v))
      foreach(n nets   dbDeleteObject(n)))

    cfg = dfIndCfgTr7()
    cfg->kStart = 7 - Tr

    for(k cfg->kStart cfg->turns-1
      layer = if(evenp(k) then "M4" else "M3")
      tailMode =
        if(k == 6 then 2
        else if(evenp(k) then
          if(k == cfg->kStart then 0 else -1)
        else
          1))
      dfIndEmitRing(cv cfg Pw Ps Ra k layer tailMode)
      when(k > cfg->kStart
        mirrorMode = if(k == 6 then 0 else if(evenp(k) then 1 else -1))
        dfIndEmitRingMirror(cv cfg Pw Ps Ra k layer mirrorMode)))

    p = Pw + Ps
    foreach(r dfIndRouteShapesT7()
      dfIndEmitRect(cv nth(0 r)
        dfIndShiftX(nth(1 r) cfg->kStart p)
        dfIndShiftY(dfIndRaY(nth(2 r) Ra) cfg->kStart p Ra)
        dfIndShiftX(nth(3 r) cfg->kStart p)
        dfIndShiftY(dfIndRaY(nth(4 r) Ra) cfg->kStart p Ra)))
    dfIndRouteBuild(cv cfg Pw Ps Ra)
    foreach(v dfIndVia4Tr(Tr Ra)
      dfIndEmitVia4(cv nth(0 v) dfIndRaY(nth(1 v) Ra)))
    foreach(r dfIndRouteViasT7()
      dfIndEmitViaDef(cv nth(0 r)
        dfIndShiftX(nth(1 r) cfg->kStart p)
        dfIndShiftY(dfIndRaY(nth(2 r) Ra) cfg->kStart p Ra)
        nth(3 r)))
    dfIndPinBlock(cv cfg Pw Ps Ra)
    t
  );let
);proc

;; Build the inductor directly in a cellView.
procedure(dfSymIndBuild(lib cell @optional (Pw 4.0) (Ps 1.0) (Ra 1.0) (Tr 7))
  let((cv)
    unless(ddGetObj(lib)
      error("dfSymIndBuild: library %s not found" lib))
    cv = dbOpenCellViewByType(lib cell "layout" nil "r")
    unless(cv
      cv = dbOpenCellViewByType(lib cell "layout" "maskLayout" "a"))
    unless(cv
      error("dfSymIndBuild: cannot open/create %s/%s/layout" lib cell))

    dfSymIndEngine(cv Pw Ps Ra Tr)

    dbSave(cv)
    printf("dfSymIndBuild done: %s/%s/layout (Pw=%.3f Ps=%.3f Ra=%.3f Tr=%d)\n" lib cell Pw Ps Ra Tr)
    printf("  shapes = %d, vias = %d\n"
      length(cv~>shapes) length(cv~>vias))
    printf("  Next: open the cellView and compare it against the reference layout\n")
    t
  );let
);proc

;; Build the geometry directly.
procedure(dfSymIndCell(lib cell @optional (Pw 4.0) (Ps 1.0) (Ra 1.0) (Tr 7))
  dfSymIndBuild(lib cell Pw Ps Ra Tr)
);proc

;; Print the available entry points.
procedure(dfSymIndHelp()
  printf("\n=== available entry points ===\n")
  printf("A. build the geometry directly:\n")
  printf("    dfSymIndCell(lib cell)                  ; Pw=4 Ps=1 Ra=1 Tr=7\n")
  printf("    dfSymIndCell(lib cell Pw Ps Ra Tr)      ; parameter order\n")
  printf("B. parameterized cell:\n")
  printf("    dfSymIndPcell(lib cell)                 ; same as dfSymIndDefine\n")
  printf("    dfSymIndCdf(lib cell)                   ; CDF form and callbacks\n")
  printf("Inspect the result:\n")
  printf("    dbOpenCellViewByType(lib cell \"layout\" \"maskLayout\" \"a\")\n")
  printf("Self check:\n")
  printf("    run the same build twice; the result must not change\n")
  printf("Limits: Tr is 3, 5 or 7; Ra > 0; Pw and Ps are clamped by the CDF table.\n")
  printf("=== end of help ===\n\n")
  t
);proc
