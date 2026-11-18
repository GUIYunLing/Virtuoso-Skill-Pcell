
procedure(SnapToMinSpacing(paraList)
  prog((minSpacing snappedParaList para)
    minSpacing = 0.005 
    snappedParaList = list()
    for(i 0 length(paraList)-1
      if(abs(modf(float(nth(i paraList)) minSpacing) - minSpacing) < 1e-10 then
        para = nth(i paraList)
      else
        para = nth(i paraList) - modf(float(nth(i paraList)) minSpacing)
      )
      snappedParaList = appendl(snappedParaList para)
    )
    return(snappedParaList)
  ); end prog
); end procedure
