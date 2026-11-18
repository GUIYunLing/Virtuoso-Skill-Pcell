procedure(PcDefine(lib cell)
    let(()
        PcellId=pcDefinePCell(list(ddGetObj(lib) cell "layout")
            (
                (Pw float 4.0)
                (Ps float 1.0)
                (Tr int 7)
                (Ra float 1.0)
            )
           
        let((cv tf tfId snapGrid temp diagPathWidth OutsideMainPath1Pt1 OutsideMainPath1Pt2 OutsideMainPath1Pt3 OutsideMainPath1Pt4
            OutsideMainPath1 OutsideMainPath1X OutsideMainPath1PointList Pt1 Pt2 OutsideMainPath1TopPt OutsideMainPath1BomPt GradientPath1
            OuterPath1 OuterPath1_last OuterPath1_45X OutsideMainPathMirror1 OutsideMainPathMirror1X OutsideMainPathMirror1PointList
            InsideMainPath1Pt1 InsideMainPath1Pt2 InsideMainPath1Pt2x InsideMainPath1Pt3 InsideMainPath1Pt4 InsideMainPath1_1 InsideMainPath1X
            InsideMainPath1 InsideMainPath1PointList InsideMainPathMirror1 InsideMainPathMirror1PointList InsideMainPath1BomPt InsideMainPath1TopPt
            PathcircleSpace1 MainPath1Pt1 MainPath1Pt2 MainPath1Pt3 MainPath1Pt4 MainPath1 MainPath1X MainPath1TopPt MainPath1BomPt PathcircleSpace2
            MainPath2 MainPath2X MainPath2BK MainPathMirror2 PointListMirror2 MainPath2Pt1 MainPath2Pt2 MainPath2Pt3 MainPath2Pt4 MainPath2TopPt
            MainPath2BomPt GradientPath2 OuterPath2 OuterPath2_45X OuterPath2_last List1 List2 PointList2 OverLapArea time time_num old_time)
            cv=pcCellView
            tfId=techGetTechFile(ddGetObj("tsmcN28"))
            ;tfId=techGetTechFile(cv)
            snapGrid=techGetMfgGridResolution(tfId)
        
        temp=(Pw-2.5)*0.5
        diagPathWidth=ceiling(2.5*sqrt(2)/(snapGrid*2)*(snapGrid*2))

    (old_time = "Apr  3 12:49:06 2026") 
    (time_num = stringToTime(old_time))
    (time = stringToTime(getCurrentTime())) 
    if((t)
        then

   
        case(Tr
          
