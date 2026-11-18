
procedure(CallBack()
  let((width space turns ratio)

   
    width = cdfgData~>Pw~>value
    space = cdfgData~>Ps~>value
    turns = cdfgData~>Tr~>value
    ratio = cdfgData~>Ra~>value

   ;;printf("84")
        
    case(turns
      
      ((7)
        if(100 * ratio <= (width + space) * 13 + 5.0 then
          cdfgData~>Ra~>value = int((width + space) * 13.0 + 5.0) / 100.0
          warn("Aspect Ratio must be no less than (PathWidth+PathSpace)*13+5.0")
        )
          
    _minPw = 2.5
    _maxPw = 4.8
    _minPs = 1.2
    _maxPs = 3.5
 
Pw_in = cdfgData~>Pw~>value
Ps_in = cdfgData~>Ps~>value
Pw = max(_minPw, min(_maxPw, Pw_in))
Ps = max(_minPs, min(_maxPs, Ps_in))

if( 14.0*Pw + 13.0*Ps > 75.0 then
    scale = 75.0 / (14.0*Pw + 13.0*Ps)
    Pw = Pw * scale
    Ps = Ps * scale
    
    Pw = round( max(_minPw, min(_maxPw, Pw)) * 100.0 ) / 100.0
    Ps = round( max(_minPs, min(_maxPs, Ps)) * 100.0 ) / 100.0
    
    warn("Pw and Ps adjusted to satisfy 14*Pw+13*Ps <= 80 (now Pw=%f, Ps=%f)" Pw Ps)
)



cdfgData~>Pw~>value = Pw
cdfgData~>Ps~>value = Ps

 



   
  ); case turn = 7
  ((5)
     if(100 * ratio <= (width + space) * 13 + 5.0 then
          cdfgData~>Ra~>value = int((width + space) * 13.0 + 5.0) / 100.0
          warn("Aspect Ratio must be no less than (PathWidth+PathSpace)*13+5.0")
        )
    
    _minPw = 2.5
    _maxPw = 7
    _minPs = 1.75
    _maxPs = 6.25
 
Pw_in = cdfgData~>Pw~>value
Ps_in = cdfgData~>Ps~>value
Pw = max(_minPw, min(_maxPw, Pw_in))
Ps = max(_minPs, min(_maxPs, Ps_in))

if( 14.0*Pw + 13.0*Ps > 75.0 then
    scale = 75.0 / (14.0*Pw + 13.0*Ps)
    Pw = Pw * scale
    Ps = Ps * scale
    
    Pw = round( max(_minPw, min(_maxPw, Pw)) * 100.0 ) / 100.0
    Ps = round( max(_minPs, min(_maxPs, Ps)) * 100.0 ) / 100.0
    
    warn("Pw and Ps adjusted to satisfy 14*Pw+13*Ps <= 80 (now Pw=%f, Ps=%f)" Pw Ps)
)

cdfgData~>Pw~>value = Pw
cdfgData~>Ps~>value = Ps
 
    );case turns=5
   ((3)

if(100*ratio<=(width+space)*5+5.0
   then cdfgData~>Ra~>value=int(((cdfgData~>Pw~>value)+(cdfgData~>Ps~>value))*5.0+5.0)*0.01
   warn("Aespect Ratio out of range"))


    _minPw = 2.6
    _maxPw = 14
    _minPs = 1.5
    _maxPs = 15
 
Pw_in = cdfgData~>Pw~>value
Ps_in = cdfgData~>Ps~>value
Pw = max(_minPw, min(_maxPw, Pw_in))
Ps = max(_minPs, min(_maxPs, Ps_in))

Pw = round( max(_minPw, min(_maxPw, Pw_in)) * 100.0 ) / 100.0
Ps = round( max(_minPs, min(_maxPs, Ps_in)) * 100.0 ) / 100.0


when( 14.0*Pw + 13.0*Ps >= 75.0
    scale = 75.0 / (14.0*Pw + 13.0*Ps)
    Pw = Pw * scale
    Ps = Ps * scale
    Pw = round( max(_minPw, min(_maxPw, Pw)) * 100.0 ) / 100.0
    Ps = round( max(_minPs, min(_maxPs, Ps)) * 100.0 ) / 100.0
)

when( Pw + Ps >= 5.4
    scale = 5.4 / (Pw + Ps)
    Pw = Pw * scale
    Ps = Ps * scale
    Pw = round( max(_minPw, min(_maxPw, Pw)) * 100.0 ) / 100.0
    Ps = round( max(_minPs, min(_maxPs, Ps)) * 100.0 ) / 100.0
)

if( 14.0*Pw + 13.0*Ps >= 75.0 + 1e-6 then
    scale = 75.0 / (14.0*Pw + 13.0*Ps)
    Pw = Pw * scale
    Ps = Ps * scale
    Pw = round( max(_minPw, min(_maxPw, Pw)) * 100.0 ) / 100.0
    Ps = round( max(_minPs, min(_maxPs, Ps)) * 100.0 ) / 100.0
)
if( Pw + Ps >= 5.4 + 1e-6 then
    scale = 5.4 / (Pw + Ps)
    Pw = Pw * scale
    Ps = Ps * scale
    Pw = round( max(_minPw, min(_maxPw, Pw)) * 100.0 ) / 100.0
    Ps = round( max(_minPs, min(_maxPs, Ps)) * 100.0 ) / 100.0
)

	


cdfgData~>Pw~>value = Pw
cdfgData~>Ps~>value = Ps



       )
;case turns=3

  );case

if(turns<3
    then cdfgData~>Tr~>value=3 warn("Number Of Turns is out of range:[3,7]. Set to 3."))
if(turns>7
    then cdfgData~>Tr~>value=7 warn("Number Of Turns is out of range:[3,7]. Set to 7."))

    width=cdfgData~>Pw~>value
    width=int(width*100.0)/100.0
    space=cdfgData~>Ps~>value
    space=int(space*100.0)/100.0
    turns=cdfgData~>Tr~>value
    ratio=cdfgData~>Ra~>value
    ratio=int(ratio*100.0)/100.0
    );let
);proc
