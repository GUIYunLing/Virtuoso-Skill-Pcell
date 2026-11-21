# Pcell
努力学习Python和 Cadence Skill语言的小白

会定时开源MOS管、电阻、电容、电感，差分功率放大器等Pcell的源码，旨在帮助更多有需要的用户快速入门，上手

Cadence Virtuoso SKILL PCell source code: differential inductor (dfInd) layout generator, parameterized cell + CDF + modular .il. 差分电感 PCell 源码 / SKILL 布局自动化 / 参数化单元开发入门
SKILL Pcell generator for differential inductors (dfInd) in Cadence Virtuoso. Modular .il files for winding, routing, pins & CDF.


DiffAmpPcell (Tr=7) — staged SKILL PCell scaffold


Keywords
Cadence Virtuoso, SKILL, SKILL PCell, pcDefinePCell, CDF, cdfCreateParam, cdfSaveCDF, layout automation, parameterized cell, analog layout, differential inductor, figure-eight inductor, 8-shaped inductor, symmetric inductor, multi-tap inductor, center-tapped inductor, tapped inductor, on-chip inductor, RF passive, passive network, differential PA passive, differential amplifier load, balun-like layout, transformer-like winding, TSMC 28nm, tsmcN28, M3, M4, M5, VIA3, VIA4, VIA5, metal stack, dbCreatePath, dbCreatePathSeg, dbCreatePolygon, dbLayerOr, dbCopyFig, dbPointArrayAnd, dbCreateViaShapeArray, dbCreatePin, dbCreateLabel, dbCreateNet, bbox anchor, snap grid, 45-degree routing, winding geometry, turns Tr=7, path width Pw, path space Ps, aspect ratio Ra.

What is implemented
Five entry procedures: DiffAmpPcell, PcellCdf, CallBack, PcDefine (plus the grid-snap helper in the fuller variant).
CDF parameters: Pw (path width), Ps (path space), Ra (aspect ratio).
Absolute-coordinate winding geometry fixed to the x = 150 symmetry axis: MY = (300-x, y) and R180 = (300-x, -y).
Tr=7 winding only: k = 0..6, even k on M4, odd k on M3, with separate outer (k=0) and inner (k=6) end-ring special cases.
VIA4 winding taps and VIA5 / DI-region via calls, kept in their original call order including the reverse-order duplicate pairs.
What is intentionally missing
Two regions are replaced by markers:

Variables
Long original names were shortened for review readability, for example OutsideMainPath1 → out0, InsideMainPath1 → in6, MainPath1 → mid4, MainPath2 → mid3, PointList1/2 → m4pts/m3pts, PointListMirror1/2 → m4mpts/m3mpts. Restore the original names mechanically before comparing against any reference implementation.

Scope and status
Tr = 7 only. Other turn counts are not implemented.
Static text only. No evidence of loading in a target SKILL interpreter, no OA database objects, no PDK, no DRC/LVS/EM, no electrical connectivity claim.
Request counts are not success counts: a VIA call request is not proof that a via shape was created or that metal is connected.
Terminal names are not independent electrical nodes.
Typical search entry points
If you arrived here searching for a public reference implementation of a differential inductor PCell in SKILL, the upstream community sources usually cited are a modular dfInd implementation and an octagonal single-ended inductor PCell. Those are reference material for structure, layer assignment and 45-degree geometry only; they are not this file.
