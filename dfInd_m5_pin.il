;; ============================================================================
;; Pins and labels
;; ----------------------------------------------------------------------------
;; Net, label and pin for every terminal. Each label sits on the same layer
;; as its own pin rectangle, which fixes the layer mismatch present in the
;; original.
;; Provides: dfIndPinBlock
;; Loaded by the loader script; loading this file alone is harmless, calling
;; it alone is not.
;; ============================================================================
;; Create nets, pins and labels for all terminals.
procedure(dfIndPinBlock(cv cfg Pw Ps Ra)
  let((p k yOmpMax yOmpMin y3 y4 y5 x34)
    p = Pw + Ps
    k = cfg->kStart
    yOmpMax = cfg->yHalf*Ra - k*p
    yOmpMin = dfIndShiftY(dfIndRaY(-74.0 Ra) k p Ra)
    y3  = yOmpMax + 20.0
    y4  = y3 + 10.0 + Pw
    y5  = dfIndShiftY(dfIndRaY(-108.0 Ra) k p Ra)
    x34 = dfIndShiftX(137.0 k p)
    dbCreateLabel(cv list("M5" "text") list(-15.0 y5) "P1" "lowerCenter" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P1")
      dbCreateRect(cv "M5" list(-17.5:y5 -12.5:y5+5.0)))
    dbCreateLabel(cv list("M5" "text") list(7.5 y5) "P2" "lowerCenter" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P2")
      dbCreateRect(cv "M5" list(5.0:y5 10.0:y5+5.0)))
    dbCreateLabel(cv list("M5" "text") list(0.0-x34 y4+Pw*0.5) "P3" "centerLeft" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P3")
      dbCreateRect(cv "M5" list(0.0-x34:y4+Pw*0.5-2.5 0.0-x34+10.0:y4+Pw*0.5+2.5)))
    dbCreateLabel(cv list("M5" "text") list(0.0-x34 y3+Pw*0.5) "P4" "centerLeft" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P4")
      dbCreateRect(cv "M5" list(0.0-x34:y3+Pw*0.5-2.5 0.0-x34+10.0:y3+Pw*0.5+2.5)))
    dbCreateLabel(cv list("M5" "text") list(x34 y4+Pw*0.5) "P5" "centerRight" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P5")
      dbCreateRect(cv "M5" list(x34-10.0:y4+Pw*0.5-2.5 x34:y4+Pw*0.5+2.5)))
    dbCreateLabel(cv list("M5" "text") list(x34 y3+Pw*0.5) "P6" "centerRight" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P6")
      dbCreateRect(cv "M5" list(x34-10.0:y3+Pw*0.5-2.5 x34:y3+Pw*0.5+2.5)))
    dbCreateLabel(cv list("M3" "text") list(-25.0 y4+Pw*0.5) "P7" "centerRight" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P7")
      dbCreateRect(cv "M3" list(-25.0-Pw:y4 -25.0:y4+Pw)))
    dbCreateLabel(cv list("M3" "text") list(-25.0 y3+Pw*0.5) "P8" "centerRight" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P8")
      dbCreateRect(cv "M3" list(-25.0-Pw:y3 -25.0:y3+Pw)))
    dbCreateLabel(cv list("M3" "text") list(25.0 y4+Pw*0.5) "P9" "centerLeft" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P9")
      dbCreateRect(cv "M3" list(25.0:y4 25.0+Pw:y4+Pw)))
    dbCreateLabel(cv list("M3" "text") list(25.0 y3+Pw*0.5) "P10" "centerLeft" "R0" "roman" Pw)
    dbCreatePin(dbCreateNet(cv "P10")
      dbCreateRect(cv "M3" list(25.0:y3 25.0+Pw:y3+Pw)))
    t
  );let
);proc
