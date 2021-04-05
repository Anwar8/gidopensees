*set var PrintPlainPattern=0
*set var PrintMultiSupportPattern=0
*set var PrintPlainPatternPathTimeseries=0
*#
*# Check if there are any loads applied
*#
*set cond Point_Forces *nodes *CanRepeat
*add cond Line_Forces *nodes *CanRepeat
*add cond Surface_Forces *nodes *CanRepeat
*add cond Point_Displacements *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var PrintPlainPatternPathTimeseries=1
*break
*end nodes
*set cond Point_Forces *nodes *CanRepeat
*add cond Line_Forces *nodes *CanRepeat
*add cond Surface_Forces *nodes *CanRepeat
*add cond Point_Displacements *nodes *CanRepeat
*add cond Line_Displacements *nodes *CanRepeat
*add cond Surface_Displacements *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var PrintPlainPattern=1
*break
*end nodes
*set cond Line_Uniform_Forces *elems *CanRepeat
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Line_Linear_Temperatures *elems *CanRepeat
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Line_Temperature_History *elems *CanRepeat
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Line_Gas_Temperatures *elems
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Line_Composite_Section_Beam *elems
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Surface_Composite_Section *elems
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Surface_Gas_Temperatures *elems
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Surface_Uniform_Load *elems *CanRepeat
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Surface_Linear_Temperatures *elems *CanRepeat
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*set cond Surface_Temperature_History *elems *CanRepeat
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*set var PrintPlainPatternPathTimeseries=1
*break
*end elems
*if(IntvData(Activate_dead_load,int)==1)
*set var PrintPlainPattern=1
*endif
*set cond Point_Ground_Motion_from_Record *nodes
*add cond Point_Sine_Ground_Motion *nodes
*loop nodes *OnlyInCond
*set var PrintMultiSupportPattern=1
*break
*end nodes
*if(strcmp(IntvData(Loading_type),"Constant")==0 || strcmp(IntvData(Loading_type),"Linear")==0)
*#
*# if there are loads applied, Create the pattern
*#
*if(PrintPlainPattern==1)
# Loads - Plain Pattern
*set var PatternTag=operation(IntvNum*100)
pattern Plain *PatternTag *IntvData(Loading_type) {
*#
*# Point / line / surface forces
*#
*set cond Point_Forces *nodes *CanRepeat
*add cond Line_Forces *nodes *CanRepeat
*add cond Surface_Forces *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==6)
*format "%6d"
    load *NodesNum *\
*format "%8g%8g%8g%8g%8g%8g"
*cond(1,real) *cond(2,real) *cond(3,real) *cond(4,real) *cond(5,real) *cond(6,real)
*elseif(nodeDOF==3)
*if(ndime==3)
*format "%6d"
    load *NodesNum *\
*format "%8g%8g%8g"
*cond(1,real) *cond(2,real) *cond(3,real)
*# 2D with 3DOF : Ux Uy Rz --> Fx Fy Mz
*else
*format "%6d"
    load *NodesNum *\
*format "%8g%8g%8g"
*cond(1,real) *cond(2,real) *cond(6,real)
*endif
*elseif(nodeDOF==2)
*format "%6d"
    load *NodesNum *\
*format "%8g%8g"
*cond(1,real) *cond(2,real)
*endif
*end nodes
*if(ndime==3)
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
*format "%6d%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(3,real) *cond(1,real)
*end elems
*# if it is 2D
*else
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
*format "%6d%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(1,real)
*end elems
*endif
*if(ndime==3)
*set cond Line_Temperature_History *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var fiberZ1=MatProp(Z1,real)
*set var fiberZ2=MatProp(Z2,real)
*set var fiberY1=MatProp(Y1,real)
*set var fiberY2=MatProp(Y2,real)
*set var area=MatProp(Cross_section_area,real)
*else
*MessageBox Error: Cannot grab section properties from anything other than a Fiber section
*endif
*break
*endif
*end materials
*format "%6d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -beamThermal -z -source *cond(1) *fiberY1 *fiberY2 *fiberZ1 *fiberZ2
*endif
*end elems
*endif
*if(ndime==3)
*set cond Line_Gas_Temperatures *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var fiberZ1=MatProp(Z1,real)
*set var fiberZ2=MatProp(Z2,real)
*set var fiberY1=MatProp(Y1,real)
*set var fiberY2=MatProp(Y2,real)
*set var angle=MatProp(Rotation_angle,real)
*else
*MessageBox Error: Cannot grab section properties from anything other than a Fiber section
*endif
*break
*endif
*end materials
*#set var tempFileDir=tcl(GetTempFileDir *cond(1))
*#cannot assign a string to a variable in .bas, thus invoke function directly in load command.
*if(angle == 90 || angle == 270)
*format "%d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -beamThermal -source *tcl(Fire::GetTempFileDir *cond(ID,int) beam-column) *fiberY1 *fiberY2 *fiberZ1 *fiberZ2
*else
*format "%d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -beamThermal -z -source *tcl(Fire::GetTempFileDir *cond(ID,int) beam-column) *fiberY1 *fiberY2 *fiberZ1 *fiberZ2
*endif
*endif
*end elems
*endif

*if(ndime==3)
*set cond Line_Composite_Section_Beam *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var fiberZ1=MatProp(Z1,real)
*set var fiberZ2=MatProp(Z2,real)
*set var fiberY1=MatProp(Y1,real)
*set var fiberY2=MatProp(Y2,real)
*else
*MessageBox Error: Cannot grab section properties from anything other than a Fiber section
*endif
*break
*endif
*end materials
*#set var tempFileDir=tcl(GetTempFileDir *cond(1))
*#cannot assign a string to a variable in .bas, thus invoke function directly in load command.
*format "%d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -beamThermal -z -source *tcl(Fire::GetTempFileDir *cond(ID,int) beam-column) *fiberY1 *fiberY2 *fiberZ1 *fiberZ2
*endif
*end elems
*endif

*if(ndime==3)
*set cond Surface_Gas_Temperatures *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0 || strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"LayeredShell")==0)
*set var thickness=MatProp(Slab_thickness,real)
*set var deckingThickness=MatProp(Decking_thickness,real)
*set var offset=MatProp(Offset,real)
*else
*MessageBox Error: Cannot grab section properties from anything other than a layered shell section
*endif
*break
*endif
*end materials
*#set var tempFileDir=tcl(GetTempFileDir *cond(ID,int) slab)
*#cannot assign a string to a variable in .bas, thus invoke function directly in load command.
*set var topFiber=operation(1.001*(thickness+deckingThick)/2.0-offset)
*set var botFiber=operation(-1.001*(thickness+deckingThick)/2.0-offset)
*format "%6d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -shellThermal -source *tcl(Fire::GetTempFileDir *cond(ID,int) slab) *botFiber *topFiber	
*endif
*end elems
*endif

*if(ndime==3)
*set cond Surface_Composite_Section *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0 || strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"LayeredShell")==0)
*set var thickness=MatProp(Slab_thickness,real)
*set var deckingThickness=MatProp(Decking_thickness,real)
*set var offset=MatProp(Offset,real)
*else
*MessageBox Error: Cannot grab section properties from anything other than a layered shell section
*endif
*break
*endif
*end materials
*#set var tempFileDir=tcl(GetTempFileDir *cond(ID,int) slab)
*#cannot assign a string to a variable in .bas, thus invoke function directly in load command.
*set var topFiber=operation(1.001*(thickness+deckingThick)/2.0-offset)
*set var botFiber=operation(-1.001*(thickness+deckingThick)/2.0-offset)
*format "%6d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -shellThermal -source *tcl(Fire::GetTempFileDir *cond(ID,int) slab) *botFiber *topFiber	
*endif
*end elems
*endif

*if(ndime==3)
*set cond Line_Linear_Temperatures *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var secHeight = MatProp(Height_h,real)
*set var botFiber=operation(-0.500001*secHeight)
*set var topFiber=operation(0.500001*secHeight)
*set var area=MatProp(Cross_section_area,real)
*set var angle=MatProp(Rotation_angle,real)
*else
*else
*MessageBox Error: Cannot grab section properties from anything other than a Fiber section
*endif
*break
*endif
*end materials
*if(angle!=0)
*endif
*format "%6d%8g%8g%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -beamThermal -z *cond(2,real) *botFiber *cond(1,real) *topFiber	
*endif
*end elems
*endif
*set cond Surface_Uniform_Load *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0 || strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*# end coordinates
*set var x1=NodesCoord(1,1)
*set var y1=NodesCoord(1,2)
*set var z1=NodesCoord(1,3)
*set var x2=NodesCoord(2,1)
*set var y2=NodesCoord(2,2)
*set var z2=NodesCoord(2,3)
*set var x3=NodesCoord(3,1)
*set var y3=NodesCoord(3,2)
*set var z3=NodesCoord(3,3)
*set var x4=NodesCoord(4,1)
*set var y4=NodesCoord(4,2)
*set var z4=NodesCoord(4,3)
*set var vecx1=operation(x2-x1)
*set var vecx2=operation(x3-x2)
*set var vecy1=operation(y2-y1)
*set var vecy2=operation(y3-y2)
*set var vecz1=operation(z2-z1)
*set var vecz2=operation(z3-z2)
*set var vecx3=operation(x4-x1)
*set var vecx4=operation(x4-x3)
*set var vecy3=operation(y4-y1)
*set var vecy4=operation(y4-y3)
*set var vecz3=operation(z4-z1)
*set var vecz4=operation(z4-z3)
*set var dotproduct1=operation(vecx1*vecx2+vecy1*vecy2+vecz1*vecz2)
*set var dotproduct2=operation(vecx3*vecx4+vecy3*vecy4+vecz3*vecz4)
*set var magn1=operation(sqrt(vecx1*vecx1+vecy1*vecy1+vecz1*vecz1))
*set var magn2=operation(sqrt(vecx2*vecx2+vecy2*vecy2+vecz2*vecz2))
*set var magn3=operation(sqrt(vecx3*vecx3+vecy3*vecy3+vecz3*vecz3))
*set var magn4=operation(sqrt(vecx4*vecx4+vecy4*vecy4+vecz4*vecz4))
*set var theta1=operation(acos(dotproduct1/(magn1*magn2)))
*set var theta2=operation(acos(dotproduct2/(magn3*magn4)))
*set var A=operation((magn1*magn2*sin(theta1))/2+(magn3*magn4*sin(theta2))/2)
*set var AppliedLoad=operation(cond(1,real)*A/4)
*if((AppliedLoad<1e-6) && (AppliedLoad>-1e-6))
*set var AppliedLoad=0
*endif
*if(ndime==3)
*if(strcmp(GenData(Vertical_axis),"Z")==0)
*format "%6d%8.6g"
    load *ElemsConec(1) 0.0 0.0 *AppliedLoad 0.0 0.0 0.0
*format "%6d%8.6g"
    load *ElemsConec(2) 0.0 0.0 *AppliedLoad 0.0 0.0 0.0
*format "%6d%8.6g"
    load *ElemsConec(3) 0.0 0.0 *AppliedLoad 0.0 0.0 0.0
*format "%6d%8.6g"
    load *ElemsConec(4) 0.0 0.0 *AppliedLoad 0.0 0.0 0.0
*elseif(strcmp(GenData(Vertical_axis),"Y")==0)
*format "%6d%8.6g"
    load *ElemsConec(1) 0.0 *AppliedLoad 0.0 0.0 0.0 0.0
*format "%6d%8.6g"
    load *ElemsConec(2) 0.0 *AppliedLoad 0.0 0.0 0.0 0.0
*format "%6d%8.6g"
    load *ElemsConec(3) 0.0 *AppliedLoad 0.0 0.0 0.0 0.0
*format "%6d%8.6g"
    load *ElemsConec(4) 0.0 *AppliedLoad 0.0 0.0 0.0 0.0
*endif
*endif
*endif
*end elems
*if(ndime==3)
*set cond Surface_Linear_Temperatures *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0 || strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"PlateFiber")==0)
*set var thickness=MatProp(Plate_thickness_h,real)
*set var offset=0.0
*set var deckingThick=0.0
*elseif(strcmp(MatProp(Section:),"ElasticMembranePlate")==0)
*set var thickness=MatProp(Section_depth_h,real)
*set var offset=0.0
*set var deckingThick=0.0
*elseif(strcmp(MatProp(Section:),"LayeredShell")==0)
*set var thickness=MatProp(Slab_thickness,real)
*set var deckingThickness=MatProp(Decking_thickness,real)
*set var offset=MatProp(Offset,real)
*elseif(strcmp(MatProp(Section:),"UserMaterial")==0)
*set var thickness=MatProp(Width,real)
*set var offset=0.0
*set var deckingThick=0.0
*else
*MessageBox Error: Invalid Section selected for Shell/ShellDKGQ element
*endif
*break
*endif
*end materials
*set var topFiber=operation(1.001*(thickness+deckingThick)/2.0-offset)
*set var botFiber=operation(-1.001*(thickness+deckingThick)/2.0-offset)
*format "%6d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -shellThermal *cond(2,real) *botFiber *cond(1,real) *topFiber	
*endif
*end elems
*endif
*if(ndime==3)
*set cond Surface_Temperature_History *elems
*loop elems *OnlyInCond
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0 || strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"PlateFiber")==0)
*set var thickness=MatProp(Plate_thickness_h,real)
*set var offset=0.0
*set var deckingThick=0.0
*elseif(strcmp(MatProp(Section:),"ElasticMembranePlate")==0)
*set var thickness=MatProp(Section_depth_h,real)
*set var offset=0.0
*set var deckingThick=0.0
*elseif(strcmp(MatProp(Section:),"LayeredShell")==0)
*set var thickness=MatProp(Slab_thickness,real)
*set var deckingThickness=MatProp(Decking_thickness,real)
*set var offset=MatProp(Offset,real)
*elseif(strcmp(MatProp(Section:),"UserMaterial")==0)
*set var thickness=MatProp(Width,real)
*set var offset=0.0
*set var deckingThick=0.0
*else
*MessageBox Error: Invalid Section selected for Shell/ShellDKGQ element
*endif
*break
*endif
*end materials
*set var topFiber=operation(1.001*(thickness+deckingThick)/2.0-offset)
*set var botFiber=operation(-1.001*(thickness+deckingThick)/2.0-offset)
*format "%6d%8g%8g%8g%8g"
    eleLoad -ele *ElemsNum -type -shellThermal -source *cond(1) *botFiber *topFiber	
*endif
*end elems
*endif
*set cond Point_Displacements *nodes
*add cond Line_Displacements *nodes
*add cond Surface_Displacements *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==6)
*# 3D - 6 Dofs -> Ux Uy Uz Rx Ry Rz
*# If value is zero, it is like a restraint! So a restraint condition can be used instead.
*if(cond(1,real)!=0)
*format "%6d%8g"
  sp *NodesNum 1 *cond(1,real)
*endif
*if(cond(2,real)!=0)
*format "%6d%8g"
  sp *NodesNum 2 *cond(2,real)
*endif
*if(cond(3,real)!=0)
*format "%6d%8g"
  sp *NodesNum 3 *cond(3,real)
*endif
*if(cond(4,real)!=0)
*format "%6d%8g"
  sp *NodesNum 4 *cond(4,real)
*endif
*if(cond(5,real)!=0)
*format "%6d%8g"
  sp *NodesNum 5 *cond(5,real)
*endif
*if(cond(6,real)!=0)
*format "%6d%8g"
  sp *NodesNum 6 *cond(6,real)
*endif
*elseif(nodeDOF==3)
*if(ndime==3)
*# 3D - 3 Dofs -> Ux Uy Uz
  sp *NodesNum 1 *cond(1,real)
  sp *NodesNum 2 *cond(2,real)
  sp *NodesNum 3 *cond(3,real)
*else
*# 2D - 3 Dofs -> 2 Translations (Ux,Uy) 1 Rotation Rz
*if(cond(1,real)!=0)
*format "%6d%8g"
  sp *NodesNum 1 *cond(1,real)
*endif
*if(cond(2,real)!=0)
*format "%6d%8g"
  sp *NodesNum 2 *cond(2,real)
*endif
*if(cond(6,real)!=0)
*format "%6d%8g"
  sp *NodesNum 3 *cond(6,real)
*endif
*endif
*# 2 dofs
*else
*if(cond(1,real)!=0)
*format "%6d%8g"
  sp *NodesNum 1 *cond(1,real)
*endif
*if(cond(2,real)!=0)
*format "%6d%8g"
  sp *NodesNum 2 *cond(2,real)
*endif
*endif
*end nodes
*if(IntvData(Activate_dead_load,int)==1 && strcmp(IntvData(Analysis_type),"Static")==0 && strcmp(IntvData(Integrator_type),"Load_control")==0)

# Dead Loads

*include DeadLoad.bas
*endif
}
*endif
*elseif(strcmp(IntvData(Loading_type),"Function")==0)
*if(PrintPlainPatternPathTimeseries==1)

# Loads - Timeseries Path

*include PlainPatternTimeseriesPath.bas
*endif
*elseif(strcmp(IntvData(Loading_type),"Multiple_support_excitation")==0)
*if(PrintMultiSupportPattern==1)

# Loads - Multiple Support Pattern

*set var PatternTag=operation(IntvNum*1000)
*include MultipleSupportExcitationPattern.bas
*endif
*endif
