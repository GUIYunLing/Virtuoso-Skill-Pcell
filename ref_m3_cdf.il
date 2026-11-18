
procedure(PcellCdf(lib cell)
  let((cellId cdfId)
    unless(cellId = ddGetObj(lib cell)
      error("Could not get cell %s." cell)
    )
    when(cdfId = cdfGetBaseCellCDF(cellId)
      cdfDeleteCDF(cdfId)
    )
    cdfId = cdfCreateBaseCellCDF(cellId)

       cdfCreateParam(cdfId
      ?name    "Pw"
      ?prompt  "PathWidth(um)"
      ?type    "float"
      ?defValue 4.0
      ?callback "CallBack()"
    )
   
    cdfCreateParam(cdfId
      ?name    "Ps"
      ?prompt  "PathSpace(um)"
      ?type    "float"
      ?defValue 1.0
      ?callback "CallBack()"
    )
  
    cdfCreateParam(cdfId
      ?name    "Tr"
      ?prompt  "Turns"
      ?type    "int"
      ?defValue 7
      ?callback "CallBack()"
    )
   
    cdfCreateParam(cdfId
      ?name    "Ra"
      ?prompt  "Aspect_Ratio"
      ?type    "float"
      ?defValue 1.0
      ?callback "CallBack()"
    )

    cdfSaveCDF(cdfId)
  ); let
); proc
