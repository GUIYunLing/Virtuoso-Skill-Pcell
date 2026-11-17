;; ============================================================================
;; CDF, cell definition and compatibility
;; ----------------------------------------------------------------------------
;; CDF parameters and clamping callback (turn range, width and space limits,
;; proportional scaling), the parameterized cell definition, and the
;; compatibility entry points kept under their original names.
;; Provides: dfIndClampCfg, dfSymIndCallBack, dfSymIndCdf, dfSymIndDefine,
;; dfSymIndPcell, DiffAmpPcell, PcellCdf, CallBack, SnapToMinSpacing
;; Loaded by the loader script; loading this file alone is harmless, calling
;; it alone is not.
;; ============================================================================
;; Return the CDF clamping table for a turn count.
procedure(dfIndClampCfg(Tr)
  case(Tr
    ((7) list(2.5 4.8 1.2 3.5 75.0 13.0 5.0))
    ((5) list(2.5 7.0 1.75 6.25 75.0 13.0 5.0))
    ((3) list(2.6 14.0 1.5 15.0 75.0 5.0 5.0))
    (t nil))
);proc

;; CDF callback: clamp and round the parameter values.
procedure(dfSymIndCallBack()
  let((width space turns ratio c minPw maxPw minPs maxPs limit k b scale)
    width = cdfgData~>Pw~>value
    space = cdfgData~>Ps~>value
    turns = cdfgData~>Tr~>value
    ratio = cdfgData~>Ra~>value

    when(turns < 3
      cdfgData~>Tr~>value = 3
      warn("Number Of Turns is out of range:[3,7]. Set to 3.")
      turns = 3)
    when(turns > 7
      cdfgData~>Tr~>value = 7
      warn("Number Of Turns is out of range:[3,7]. Set to 7.")
      turns = 7)

    c = dfIndClampCfg(turns)
    unless(c return())

    minPw = nth(0 c) maxPw = nth(1 c)
    minPs = nth(2 c) maxPs = nth(3 c)
    limit = nth(4 c) k = nth(5 c) b = nth(6 c)

    when(100.0*ratio <= (width+space)*k + b
      cdfgData~>Ra~>value = int((width+space)*k + b) / 100.0
      warn("Aspect Ratio must be no less than (PathWidth+PathSpace)*%d+%.1f" k b))

    width = max(minPw, min(maxPw, width))
    space = max(minPs, min(maxPs, space))
    when(14.0*width + 13.0*space > limit
      scale = limit / (14.0*width + 13.0*space)
      width = round(max(minPw, min(maxPw, width*scale)) * 100.0) / 100.0
      space = round(max(minPs, min(maxPs, space*scale)) * 100.0) / 100.0
      warn("Pw and Ps adjusted to satisfy 14*Pw+13*Ps <= %.1f (now Pw=%.2f, Ps=%.2f)" limit width space))

    cdfgData~>Pw~>value = int(width*100.0)/100.0
    cdfgData~>Ps~>value = int(space*100.0)/100.0
    t
  );let
);proc

;; Create the CDF parameters and callbacks.
procedure(dfSymIndCdf(lib cell)
  let((cellId cdfId)
    unless(cellId = ddGetObj(lib cell)
      error("dfSymIndCdf: cannot get cell %s/%s" lib cell))
    when(cdfId = cdfGetBaseCellCDF(cellId)
      cdfDeleteCDF(cdfId))
    cdfId = cdfCreateBaseCellCDF(cellId)
    cdfCreateParam(cdfId ?name "Pw" ?prompt "PathWidth(um)"  ?type "float" ?defValue 4.0 ?callback "dfSymIndCallBack()")
    cdfCreateParam(cdfId ?name "Ps" ?prompt "PathSpace(um)"  ?type "float" ?defValue 1.0 ?callback "dfSymIndCallBack()")
    cdfCreateParam(cdfId ?name "Tr" ?prompt "Turns"          ?type "int"   ?defValue 7   ?callback "dfSymIndCallBack()")
    cdfCreateParam(cdfId ?name "Ra" ?prompt "Aspect_Ratio"   ?type "float" ?defValue 1.0 ?callback "dfSymIndCallBack()")
    cdfSaveCDF(cdfId)
    printf("dfSymIndCdf: CDF created for %s/%s (Pw Ps Tr Ra)\n" lib cell)
    t
  );let
);proc

;; Define the parameterized cell.
procedure(dfSymIndDefine(lib cell)
  let((pcellId)
    pcellId = pcDefinePCell(list(ddGetObj(lib) cell "layout")
      (
        (Pw float 4.0)
        (Ps float 1.0)
        (Tr int 7)
        (Ra float 1.0)
      )
      let((cv)
        cv = pcCellView
        dfSymIndEngine(cv Pw Ps Ra Tr)
        t
      );let
    );pcDefinePCell
    printf("dfSymIndDefine: PCell %s/%s defined (Pw Ps Tr Ra)\n" lib cell)
    pcellId
  );let
);proc

;; Define the parameterized cell.
procedure(dfSymIndPcell(lib cell)
  dfSymIndDefine(lib cell)
);proc

;; Compatibility entry: define the cell and its CDF.
procedure(DiffAmpPcell(lib cell)
  dfSymIndDefine(lib cell)
  dfSymIndCdf(lib cell)
  t
);proc

;; Compatibility entry: create the CDF only.
procedure(PcellCdf(lib cell)
  dfSymIndCdf(lib cell)
);proc

;; Compatibility entry: CDF callback.
procedure(CallBack()
  dfSymIndCallBack()
);proc

;; Compatibility entry: snap a value list to the grid.
procedure(SnapToMinSpacing(paraList @optional (grid 0.005))
  dfIndSnapList(paraList grid)
);proc
