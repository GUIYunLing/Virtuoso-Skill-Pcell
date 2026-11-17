;; ============================================================================
;; Winding generation
;; ----------------------------------------------------------------------------
;; Given kStart = 7 - Tr and the ring index k, build the outline of one turn
;; and mirror it onto the far side. This is what lets a single loop replace
;; duplicated branches: the turn count only moves the loop bounds and the
;; first-ring offset.
;; Provides: dfIndRingPts, dfIndRingBody, dfIndEmitRing, dfIndEmitRingMirror
;; Loaded by the loader script; loading this file alone is harmless, calling
;; it alone is not.
;; ============================================================================
;; Build the outline points of one turn.
procedure(dfIndRingPts(cfg Pw Ps Ra k tailMode)
  let((p d w yT yB xL xLi xOr xS0 xLst pts)
    p    = Pw + Ps
    w    = cfg->wTail
    d    = (Pw - w)*0.5
    yT   = cfg->yHalf*Ra - k*p
    yB   = 0.0 - yT
    xL   = cfg->xInner + k*p
    xLi  = xL + Pw
    xOr  = cfg->xOuter
    xS0  = cfg->xDiag - p*0.5
    xLst = cfg->xLast

    case(tailMode
      ((2)
        pts = list(
          list(xS0 yT) list(xL yT) list(xL yB) list(xOr yB)
          list(xOr+d yB+d) list(xS0-d yB+d)
          list(xS0-d+p yB+d-p) list(xLst yB+d-p) list(xLst yB+d-p+w)
          list(xS0+d+p yB+d-p+w) list(xS0+d yB+Pw-d)
          list(xOr+d yB+Pw-d) list(xOr yB+Pw)
          list(xLi yB+Pw) list(xLi yT-Pw) list(xS0 yT-Pw)))
      (t
        pts = list(list(xOr yT) list(xL yT) list(xL yB))
        if(tailMode == 0 then
          pts = append(pts list(
            list(xS0 yB) list(xS0 yB+Pw) list(xLi yB+Pw)))
        else
          pts = append(pts list(list(xOr yB) list(xOr+d yB+d)))
          if(tailMode < 0 then
            pts = append(pts list(
              list(xS0-d yB+d) list(xS0-d+p yB+d-p)
              list(xLst yB+d-p) list(xLst yB+d-p+w)
              list(xS0+d+p yB+d-p+w) list(xS0+d yB+Pw-d)))
          else
            pts = append(pts list(
              list(xS0+d yB+d) list(xS0+d+p yB+d+p)
              list(xLst yB+d+p) list(xLst yB+d+p+w)
              list(xS0-d+p yB+d+p+w) list(xS0-d yB+Pw-d)))
          )
          pts = append(pts list(
            list(xOr+d yB+Pw-d) list(xOr yB+Pw) list(xLi yB+Pw)))
        )
        pts = append(pts list(
          list(xLi yT-Pw) list(xOr yT-Pw)
          list(xOr+d yT-Pw+d) list(xS0 yT-Pw+d)
          list(xS0 yT-d) list(xOr+d yT-d)))
      )
    )
    pts
  );let
);proc

;; Emit one turn as a single closed polygon.
procedure(dfIndRingBody(cv cfg Pw Ps Ra k layer tailMode)
  let((f)
    f = dbCreatePolygon(cv layer dfIndRingPts(cfg Pw Ps Ra k tailMode))
    f
  );let
);proc

;; Emit one turn on the near side and its mirrored copy.
procedure(dfIndEmitRing(cv cfg Pw Ps Ra k layer tailMode)
  let((body)
    body = dfIndRingBody(cv cfg Pw Ps Ra k layer tailMode)
    dfIndEmitPoly(cv layer dfIndFlipX0(body~>points))
    t
  );let
);proc

;; Emit one turn on the far side and its mirrored copy.
procedure(dfIndEmitRingMirror(cv cfg Pw Ps Ra k layer tailMode)
  let((pts)
    pts = dfIndRot180(dfIndRingPts(cfg Pw Ps Ra k tailMode))
    dfIndEmitPoly(cv layer pts)
    dfIndEmitPoly(cv layer dfIndFlipX0(pts))
    t
  );let
);proc
