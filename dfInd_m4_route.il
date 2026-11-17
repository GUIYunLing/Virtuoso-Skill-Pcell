;; ============================================================================
;; Routing and transitions
;; ----------------------------------------------------------------------------
;; Shape tables and via arrays from the winding to the terminals, including
;; the differential input section and the metal transitions. The geometry is
;; plain data (layer plus rectangle or polygon), with no conditional logic.
;; Provides: dfIndRouteShapesT7, dfIndRouteViasT7, dfIndRouteBuild
;; Loaded by the loader script; loading this file alone is harmless, calling
;; it alone is not.
;; ============================================================================
;; Return the routing shapes as (layer x1 y1 x2 y2) rows.
procedure(dfIndRouteShapesT7()
  list(
    list("M4" -137.0 84.0 -77.5 88.0)
    list("M4" -87.5 84.0 -77.5 88.0)
    list("M4" -72.5 -83.5 -52.5 -78.5)
    list("M4" -72.5 -50.5 -52.5 -45.5)
    list("M4" -72.5 56.0 -67.5 65.0)
    list("M4" -20.0 -73.75 0.0 -70.25)
    list("M4" -17.5 -108.0 -12.5 -98.0)
    list("M4" 67.5 56.0 72.5 65.0)
    list("M4" 77.5 84.0 87.5 88.0)
    list("M4" 77.5 84.0 137.0 88.0)
    list("M4" 52.5 -83.5 72.5 -78.5)
    list("M4" 52.5 -50.5 72.5 -45.5)
    list("M3" -137.0 70.0 -25.0 74.0)
    list("M3" -137.0 70.0 -127.0 74.0)
    list("M3" -137.0 70.0 -128.999 74.0)
    list("M3" -137.0 84.0 -25.0 88.0)
    list("M3" -137.0 84.0 -127.0 88.0)
    list("M3" -137.0 84.0 -128.999 88.0)
    list("M3" -33.001 70.0 -25.0 74.0)
    list("M3" -33.001 84.0 -25.0 88.0)
    list("M3" -29.0 70.0 -25.0 74.0)
    list("M3" -29.0 84.0 -25.0 88.0)
    list("M3" 25.0 70.0 137.0 74.0)
    list("M3" 25.0 70.0 36.811 74.0)
    list("M3" 25.0 70.0 29.0 74.0)
    list("M3" 25.0 84.0 137.0 88.0)
    list("M3" 25.0 84.0 33.001 88.0)
    list("M3" 25.0 84.0 29.0 88.0)
    list("M3" 127.0 70.0 137.0 74.0)
    list("M3" 127.0 84.0 137.0 88.0)
    list("M3" 128.999 70.0 137.0 74.0)
    list("M3" 128.999 84.0 137.0 88.0)
    list("M5" -137.0 69.5 -127.0 74.5)
    list("M5" -137.0 83.5 -127.0 88.5)
    list("M5" 5.0 -108.0 10.0 -98.0)
    list("M5" 127.0 69.5 137.0 74.5)
    list("M5" 127.0 83.5 137.0 88.5)
  )
);proc

;; Return the routing vias as (name cx cy halfSize) rows.
procedure(dfIndRouteViasT7()
  let((towers v5 out)
    towers = foreach(mapcar c list(
        list(129.0 72.0) list(132.0 72.0) list(135.0 72.0)
        list(129.0 86.0) list(132.0 86.0) list(135.0 86.0)
        list(-135.0 72.0) list(-132.0 72.0) list(-129.0 72.0)
        list(-135.0 86.0) list(-132.0 86.0) list(-129.0 86.0))
      list("VIA3" nth(0 c) nth(1 c) 0.75))
    out = towers
    foreach(c towers
      out = append1(out list("VIA4" nth(1 c) nth(2 c) 0.75)))
    v5 = list(
      list(-134.0 72.0) list(-134.0 86.0) list(-130.0 72.0) list(-130.0 86.0)
      list(-84.5 18.0) list(-84.5 86.0) list(-80.5 18.0) list(-80.5 86.0)
      list(-69.5 18.0) list(-65.5 18.0)
      list(-70.0 58.5) list(-70.0 62.5)
      list(-68.5 -81.0) list(-68.5 -48.0)
      list(-64.5 -81.0) list(-64.5 -48.0)
      list(-60.5 -81.0) list(-60.5 -48.0)
      list(-56.5 -81.0) list(-56.5 -48.0)
      list(-16.0 -72.0) list(-12.0 -72.0) list(-8.0 -72.0) list(-4.0 -72.0)
      list(-15.0 -105.0) list(-15.0 -101.0)
      list(7.5 -105.0) list(7.5 -101.0)
      list(56.5 -81.0) list(56.5 -48.0)
      list(60.5 -81.0) list(60.5 -48.0)
      list(64.5 -81.0) list(64.5 -48.0)
      list(65.5 18.0)
      list(68.5 -81.0) list(68.5 -48.0)
      list(69.5 18.0)
      list(70.0 58.5) list(70.0 62.5)
      list(80.5 18.0) list(80.5 86.0)
      list(84.5 18.0) list(84.5 86.0)
      list(130.0 72.0) list(130.0 86.0)
      list(134.0 72.0) list(134.0 86.0)
    )
    foreach(v v5
      out = append1(out list("VIA5" nth(0 v) nth(1 v) 1.0)))
    out
  );let
);proc

;; Draw the routing shapes, the vias and the pins.
procedure(dfIndRouteBuild(cv cfg Pw Ps Ra)
  let((pts)
    pts = list(
      list(62.5 dfIndRaY(15.0 Ra)) list(72.5 dfIndRaY(15.0 Ra)) list(72.5 dfIndRaY(66.0 Ra))
      list(67.5 dfIndRaY(66.0 Ra)) list(67.5 dfIndRaY(20.0 Ra)) list(62.5 dfIndRaY(20.0 Ra)))
    dfIndEmitPoly(cv "M5" dfIndShiftPts(pts cfg Pw Ps Ra))
    dfIndEmitPoly(cv "M5" dfIndFlipX0(dfIndShiftPts(pts cfg Pw Ps Ra)))
    pts = list(
      list(87.5 dfIndRaY(20.0 Ra)) list(82.5 dfIndRaY(20.0 Ra)) list(82.5 dfIndRaY(83.5 Ra)) list(87.5 dfIndRaY(83.5 Ra))
      list(87.5 dfIndRaY(88.5 Ra)) list(77.5 dfIndRaY(88.5 Ra)) list(77.5 dfIndRaY(15.0 Ra)) list(87.5 dfIndRaY(15.0 Ra)))
    dfIndEmitPoly(cv "M5" dfIndShiftPts(pts cfg Pw Ps Ra))
    dfIndEmitPoly(cv "M5" dfIndFlipX0(dfIndShiftPts(pts cfg Pw Ps Ra)))
    pts = list(
      list(52.5 dfIndRaY(-50.5 Ra)) list(67.5 dfIndRaY(-50.5 Ra)) list(67.5 dfIndRaY(-78.5 Ra)) list(52.5 dfIndRaY(-78.5 Ra))
      list(52.5 dfIndRaY(-83.5 Ra)) list(72.5 dfIndRaY(-83.5 Ra)) list(72.5 dfIndRaY(-45.5 Ra)) list(52.5 dfIndRaY(-45.5 Ra)))
    dfIndEmitPoly(cv "M5" dfIndShiftPts(pts cfg Pw Ps Ra))
    dfIndEmitPoly(cv "M5" dfIndFlipX0(dfIndShiftPts(pts cfg Pw Ps Ra)))
    pts = list(
      list(137.0 dfIndRaY(74.0 Ra)) list(75.0 dfIndRaY(74.0 Ra)) list(68.0 dfIndRaY(67.0 Ra)) list(68.0 dfIndRaY(56.0 Ra))
      list(72.0 dfIndRaY(56.0 Ra)) list(72.0 dfIndRaY(65.0 Ra)) list(77.0 dfIndRaY(70.0 Ra)) list(137.0 dfIndRaY(70.0 Ra)))
    dfIndEmitPoly(cv "M4" dfIndShiftPts(pts cfg Pw Ps Ra))
    dfIndEmitPoly(cv "M4" dfIndFlipX0(dfIndShiftPts(pts cfg Pw Ps Ra)))
    pts = list(
      list(125.0 dfIndRaY(50.0 Ra)) list(82.0 dfIndRaY(50.0 Ra)) list(81.25 dfIndRaY(49.25 Ra)) list(76.75 dfIndRaY(49.25 Ra))
      list(71.75 dfIndRaY(44.25 Ra)) list(62.0 dfIndRaY(44.25 Ra)) list(62.0 dfIndRaY(41.75 Ra)) list(73.25 dfIndRaY(41.75 Ra))
      list(78.25 dfIndRaY(46.75 Ra)) list(81.25 dfIndRaY(46.75 Ra)) list(82.0 dfIndRaY(46.0 Ra)) list(121.0 dfIndRaY(46.0 Ra))
      list(121.0 dfIndRaY(-46.0 Ra)) list(77.5 dfIndRaY(-46.0 Ra)) list(77.5 dfIndRaY(-67.0 Ra)) list(74.5 dfIndRaY(-70.0 Ra))
      list(0.0 dfIndRaY(-70.0 Ra)) list(0.0 dfIndRaY(-74.0 Ra)) list(76.5 dfIndRaY(-74.0 Ra)) list(81.5 dfIndRaY(-69.0 Ra))
      list(81.5 dfIndRaY(-50.0 Ra)) list(125.0 dfIndRaY(-50.0 Ra)))
    dfIndEmitPoly(cv "M4" dfIndShiftPts(pts cfg Pw Ps Ra))
    dfIndEmitPoly(cv "M4" dfIndFlipX0(dfIndShiftPts(pts cfg Pw Ps Ra)))
    pts = list(
      list(0.0 dfIndRaY(-83.0 Ra)) list(0.0 dfIndRaY(-79.0 Ra)) list(-72.5 dfIndRaY(-79.0 Ra)) list(-72.5 dfIndRaY(-83.0 Ra)))
    dfIndEmitPoly(cv "M4" dfIndShiftPts(pts cfg Pw Ps Ra))
    pts = list(
      list(72.5 dfIndRaY(-79.0 Ra)) list(0.0 dfIndRaY(-79.0 Ra)) list(0.0 dfIndRaY(-86.036 Ra)) list(5.0 dfIndRaY(-91.036 Ra))
      list(5.0 dfIndRaY(-108.0 Ra)) list(10.0 dfIndRaY(-108.0 Ra)) list(10.0 dfIndRaY(-88.964 Ra)) list(5.0 dfIndRaY(-83.964 Ra))
      list(5.0 dfIndRaY(-83.0 Ra)) list(72.5 dfIndRaY(-83.0 Ra)))
    dfIndEmitPoly(cv "M4" dfIndShiftPts(pts cfg Pw Ps Ra))
    pts = list(
      list(0.0 dfIndRaY(-69.5 Ra)) list(-20.0 dfIndRaY(-69.5 Ra)) list(-20.0 dfIndRaY(-74.5 Ra)) list(-12.5 dfIndRaY(-74.5 Ra))
      list(-12.5 dfIndRaY(-83.964 Ra)) list(-17.5 dfIndRaY(-88.964 Ra)) list(-17.5 dfIndRaY(-108.0 Ra)) list(-12.5 dfIndRaY(-108.0 Ra))
      list(-12.5 dfIndRaY(-91.036 Ra)) list(-7.5 dfIndRaY(-86.036 Ra)) list(-7.5 dfIndRaY(-74.5 Ra)) list(0.0 dfIndRaY(-74.5 Ra)))
    dfIndEmitPoly(cv "M5" dfIndShiftPts(pts cfg Pw Ps Ra))
    t
  );let
);proc
