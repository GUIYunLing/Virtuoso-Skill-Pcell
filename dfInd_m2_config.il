;; ============================================================================
;; Parameters and configuration tables
;; ----------------------------------------------------------------------------
;; Geometry constants that used to be written into every branch are
;; collected here as data: ring pitch and width, via columns per turn, and
;; the turn-dependent via multiplicity. A technology change touches only
;; this file.
;; Provides: dfIndCfgTr7, dfIndViaColsTr7, dfIndVia4MulPos, dfIndVia4MulNeg,
;; dfIndVia4Tr
;; Loaded by the loader script; loading this file alone is harmless, calling
;; it alone is not.
;; ============================================================================
;; Return the geometry parameter table shared by all turns.
procedure(dfIndCfgTr7()
  let((cfg)
    cfg = ncons(nil)
    cfg->turns     = 7
    cfg->kStart    = 0
    cfg->yHalf     = 50.0
    cfg->xInner    = 25.0
    cfg->xOuter    = 68.0
    cfg->xDiag     = 75.0
    cfg->xLast     = 88.0
    cfg->wTail     = 2.5
    cfg->gradStep  = 2.5
    cfg->axisPair  = 150.0
    cfg
  );let
);proc

;; Return the via column and row coordinates for one half.
procedure(dfIndViaColsTr7()
  let((inner outer)
    inner = list(
      list(63.5 23.0)
      list(63.5 28.0) list(63.5 28.0)
      list(63.5 33.0) list(63.5 33.0)
      list(63.5 38.0) list(63.5 38.0)
      list(63.5 43.0)
      list(63.5 48.0) list(63.5 48.0)
      list(66.5 23.0)
      list(66.5 28.0) list(66.5 28.0)
      list(66.5 33.0) list(66.5 33.0)
      list(66.5 38.0) list(66.5 38.0)
      list(66.5 43.0)
      list(66.5 48.0) list(66.5 48.0)
      list(69.5 23.0)
      list(69.5 28.0) list(69.5 28.0)
      list(69.5 33.0) list(69.5 33.0)
      list(69.5 38.0) list(69.5 38.0)
      list(69.5 43.0)
      list(69.5 48.0) list(69.5 48.0)
    )
    outer = list(
      list(79.0 -43.0) list(79.0 -43.0)
      list(79.0 -38.0)
      list(79.0 -33.0) list(79.0 -33.0)
      list(79.0 -28.0) list(79.0 -28.0)
      list(79.0 -23.0)
      list(79.0 -18.0)
      list(82.0 -43.0) list(82.0 -43.0)
      list(82.0 -38.0)
      list(82.0 -33.0) list(82.0 -33.0)
      list(82.0 -28.0) list(82.0 -28.0)
      list(82.0 -23.0)
      list(82.0 -18.0)
      list(85.0 -43.0) list(85.0 -43.0)
      list(85.0 -38.0)
      list(85.0 -33.0) list(85.0 -33.0)
      list(85.0 -28.0) list(85.0 -28.0)
      list(85.0 -23.0)
      list(85.0 -18.0)
    )
    append(inner outer)
  );let
);proc

;; Via multiplicity per row, positive side.
procedure(dfIndVia4MulPos(Tr)
  case(Tr
    (7 list(1 2 2 2 1 2))
    (5 list(2 4 1 2))
    (3 list(1 2))
    (t  nil))
);proc

;; Via multiplicity per row, negative side.
procedure(dfIndVia4MulNeg(Tr)
  case(Tr
    (7 list(1 1 2 2 1 2))
    (5 list(1 1 1 1))
    (3 list(1 1))
    (t  nil))
);proc

;; Emit every via array for the given turn count.
procedure(dfIndVia4Tr(Tr Ra)
  let((d mPos mNeg out i y xk m k)
    mPos = dfIndVia4MulPos(Tr)
    mNeg = dfIndVia4MulNeg(Tr)
    out  = nil
    i = 0
    foreach(m mPos
      y = 23.0 + 5.0*i
      foreach(xk list(63.5 66.5 69.5)
        for(k 1 m
          out = cons(list(xk y) out)))
      i = i + 1)
    i = 0
    foreach(m mNeg
      y = -18.0 - 5.0*i
      foreach(xk list(79.0 82.0 85.0)
        for(k 1 m
          out = cons(list(xk y) out)))
      i = i + 1)
    out
  );let
);proc
