;; ============================================================================
;; Utilities and geometry primitives
;; ----------------------------------------------------------------------------
;; Manufacturing grid helpers, figure emitters (rectangle, polygon, via) and
;; point transforms (180 degree rotation, X mirror, parameter shift,
;; aspect-ratio offset). Contains no layout rules and can be reused by any
;; generator.
;; Provides: dfIndMfgGrid, dfIndSnapVal, dfIndSnapList, dfIndEmitRect,
;; dfIndEmitPoly, dfIndEmitVia4, dfIndEmitViaDef, dfIndRot180, dfIndFlipX0,
;; dfIndShiftX, dfIndShiftY, dfIndShiftPts, dfIndRaY
;; Loaded by the loader script; loading this file alone is harmless, calling
;; it alone is not.
;; ============================================================================
;; Return the manufacturing grid of the tech file.
procedure(dfIndMfgGrid(cv)
  let((tf g)
    tf = techGetTechFile(cv)
    when(tf
      g = techGetMfgGridResolution(tf))
    unless(g g = 0.005)
    g
  )
);proc

;; Snap one value to the nearest grid point.
procedure(dfIndSnapVal(val grid)
  let((q snapped)
    if(!grid || grid <= 0.0
      then val
      else
        q = round(float(val)/grid)
        snapped = q*grid
        if(abs(snapped - val) < grid*1e-6 then val else snapped))
  )
);proc

;; Snap a list of values to the grid.
procedure(dfIndSnapList(lst grid)
  let((out)
    out = list()
    foreach(v lst out = append(out list(dfIndSnapVal(v grid))))
    out
  )
);proc

;; Create one rectangle on the given layer.
procedure(dfIndEmitRect(cv layer llx lly urx ury)
  dbCreateRect(cv layer list(llx:lly urx:ury))
);proc

;; Create one polygon on the given layer.
procedure(dfIndEmitPoly(cv layer pts)
  let((f)
    f = dbCreatePolygon(cv layer pts)
    f
  );let
);proc

;; Create one cut and its mirrored copy.
procedure(dfIndEmitVia4(cv cx cy)
  let((h)
    h = 0.75
    dbCreateViaShapeArray(cv "VIA4" nil cx-h cy-h 1.5 1.5 1.5 1.5 1 1)
    dbCreateViaShapeArray(cv "VIA4" nil 0.0-cx-h cy-h 1.5 1.5 1.5 1.5 1 1)
    t
  );let
);proc

;; Create one via instance at the given center.
procedure(dfIndEmitViaDef(cv name cx cy h)
  dbCreateViaShapeArray(cv name nil cx-h cy-h h h h*2.0 h*2.0 1 1)
  t
);proc

;; Rotate a point list by 180 degrees about the ring center.
procedure(dfIndRot180(pts)
  let((out)
    out = foreach(mapcar pt pts
      list(150.0 - xCoord(pt) 0.0 - yCoord(pt)))
    out
  );let
);proc

;; Mirror a point list across x = 0.
procedure(dfIndFlipX0(pts)
  let((out)
    out = foreach(mapcar pt pts
      list(0.0 - xCoord(pt) yCoord(pt)))
    out
  );let
);proc

;; Shift an x coordinate inward when turns are removed.
procedure(dfIndShiftX(x kOff p)
  let((d)
    d = kOff*p
    if(x > 120.0 then x - d else if(x < -120.0 then x + d else x))
  );let
);proc

;; Shift a y coordinate inward when turns are removed.
procedure(dfIndShiftY(y kOff p Ra)
  let((d yth)
    d   = kOff*p
    yth = dfIndRaY(20.0 Ra)
    if(y > yth then y - d else if(y < 0.0 - yth then y + d else y))
  );let
);proc

;; Shift a whole outline inward when turns are removed.
procedure(dfIndShiftPts(pts cfg Pw Ps Ra)
  let((p kOff)
    p     = Pw + Ps
    kOff  = cfg->kStart
    foreach(mapcar pt pts
      list(dfIndShiftX(xCoord(pt) kOff p) dfIndShiftY(yCoord(pt) kOff p Ra)))
  );let
);proc

;; Apply the aspect-ratio offset to a y coordinate.
procedure(dfIndRaY(y Ra)
  if(y > 0.0 then y + 50.0*(Ra - 1.0)
  else if(y < 0.0 then y - 50.0*(Ra - 1.0)
  else y))
);proc
