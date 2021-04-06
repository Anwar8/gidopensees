
# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

*# Check if transient analysis is taking place, for recording nodal velocities and accelerations
*set var Transient_analysis=0
*loop intervals
*if(strcmp(IntvData(Analysis_type),"Transient")==0)
*set var Transient_analysis=1
*break
*endif
*end intervals
*#
*# Nodes
*#
*if(ndime==2)
*if(GenData(Nodal_displacements,int)==1)
recorder Node -file Node_displacements.out -time -nodeRange 1 *cntNodes -dof 1 2 disp
*endif
*if(GenData(Nodal_rotations,int)==1)
recorder Node -file Node_rotations.out -time -nodeRange 1 *cntNodes -dof 3 disp
*endif
*if(GenData(Nodal_reactions,int)==1)
recorder Node -file Node_forceReactions.out -time -nodeRange 1 *cntNodes -dof 1 2 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 *cntNodes -dof 3 reaction
*endif
*if(Transient_analysis==1)
*if(GenData(Nodal_accelerations,int)==1)
recorder Node -file Node_accelerations.out -time -nodeRange 1 *cntNodes -dof 1 2 accel
*endif
*if(GenData(Nodal_rotational_accelerations,int)==1)
recorder Node -file Node_rotAccelerations.out -time -nodeRange 1 *cntNodes -dof 3 accel
*endif
*if(GenData(Nodal_velocities,int)==1)
recorder Node -file Node_velocities.out -time -nodeRange 1 *cntNodes -dof 1 2 vel
*endif
*if(GenData(Nodal_rotational_velocities,int)==1)
recorder Node -file Node_rotVelocities.out -time -nodeRange 1 *cntNodes -dof 3 vel
*endif
*endif
*# 3D
*else
*if(GenData(Nodal_displacements,int)==1)
recorder Node -file Node_displacements.out -time -nodeRange 1 *cntNodes -dof 1 2 3 disp
*endif
*if(GenData(Nodal_rotations,int)==1)
recorder Node -file Node_rotations.out -time -nodeRange 1 *cntNodes -dof 4 5 6 disp
*endif
*if(GenData(Nodal_reactions,int)==1)
recorder Node -file Node_forceReactions.out -time -nodeRange 1 *cntNodes -dof 1 2 3 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 *cntNodes -dof 4 5 6 reaction
*endif
*if(Transient_analysis==1)
*if(GenData(Nodal_accelerations,int)==1)
recorder Node -file Node_accelerations.out -time -nodeRange 1 *cntNodes -dof 1 2 3 accel
*endif
*if(GenData(Nodal_rotational_accelerations,int)==1)
recorder Node -file Node_rotAccelerations.out -time -nodeRange 1 *cntNodes -dof 4 5 6 accel
*endif
*if(GenData(Nodal_velocities,int)==1)
recorder Node -file Node_velocities.out -time -nodeRange 1 *cntNodes -dof 1 2 3 vel
*if(GenData(Nodal_rotational_velocities,int)==1)
recorder Node -file Node_rotVelocities.out -time -nodeRange 1 *cntNodes -dof 4 5 6 vel
*endif
*endif
*endif
*endif
*#
*# Brick
*#
*if(cntStdBrick!=0)
*set var FirstBrickElemNumber=0
*set var LastBrickElemNumber=0
*loop elems
*if(ElemsType==5)
*set var FirstBrickElemNumber=ElemsNum
*break
*endif
*end elems
*loop elems
*if(ElemsType==5)
*set var LastBrickElemNumber=ElemsNum
*endif
*end elems
*if(GenData(_Forces,int)==1)
recorder Element -file stdBrick_force.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber forces
*endif
*if(GenData(_Stresses,int)==1)
recorder Element -file stdBrick_stress.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber stresses
*endif
*if(GenData(_Strains,int)==1)
recorder Element -file stdBrick_strain.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber strains
*endif
*endif
*#
*# ShellMITC4
*#
*if(cntShell!=0)
*if(GenData(Forces,int)==1)
recorder Element -file ShellMITC4_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file ShellMITC4_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*if(GenData(Strains,int)==1)
recorder Element -file ShellMITC4_strain.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*ElemsNum *\
*endif
*end elems
strains
*endif
*endif
*#
*# ShellDKGQ
*#
*if(cntShellDKGQ!=0)
*if(GenData(Forces,int)==1)
recorder Element -file ShellDKGQ_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file ShellDKGQ_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*if(GenData(Strains,int)==1)
recorder Element -file ShellDKGQ_strain.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*ElemsNum *\
*endif
*end elems
strains
*endif
*endif
*#
*# Quad
*#
*if(cntQuad!=0)
*if(GenData(Forces,int)==1)
recorder Element -file Quad_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
*# s11 s22 s12
recorder Element -file Quad_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*if(GenData(Strains,int)==1)
*# e11 e22 e12
recorder Element -file Quad_strain.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
strains
*endif
*endif
*#
*# QuadUP
*#
*if(cntQuadUP!=0)
*if(GenData(Stresses,int)==1)
*# s11 s22 s33 s12
recorder Element -file QuadUP_stress1.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 1 stress
recorder Element -file QuadUP_stress2.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 2 stress
recorder Element -file QuadUP_stress3.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 3 stress
recorder Element -file QuadUP_stress4.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 4 stress
*endif
*if(GenData(Strains,int)==1)
*# e11 e22 g12
recorder Element -file QuadUP_strain1.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 1 strain
recorder Element -file QuadUP_strain2.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 2 strain
recorder Element -file QuadUP_strain3.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 3 strain
recorder Element -file QuadUP_strain4.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
material 4 strain
*endif
*endif
*#
*# Tri
*#
*if(cntTri31!=0)
*if(GenData(Forces,int)==1)
recorder Element -file Tri31_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file Tri31_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*endif
*#
*# Elastic beam-column
*#
*if(cntEBC!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file ElasticBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*endif
*#
*# Elastic Timoshenko beam-column
*#
*if(cntETB!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file ElasticTimoshenkoBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*endif
*#
*# Force beam-column
*#
*if(cntFBC!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file ForceBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*if(GenData(Basic_deformation,int)==1)
recorder Element -file ForceBeamColumn_basicDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
basicDeformation
*endif
*if(GenData(Plastic_deformation,int)==1)
recorder Element -file ForceBeamColumn_plasticDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
plasticDeformation
*endif
*endif
*#
*# Displacement beam-column
*#
*if(cntDBC!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file DispBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*if(GenData(Basic_deformation,int)==1)
recorder Element -file DispBeamColumn_basicDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
basicDeformation
*endif
*if(GenData(Plastic_deformation,int)==1)
recorder Element -file DispBeamColumn_plasticDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
plasticDeformation
*endif
*endif
*#
*# Flexure-Shear Interaction Displacement beam-column
*#
*if(cntDBCI!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file DispBeamColumnInt_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*endif
*#
*# Truss
*#
*if(cntTruss!=0)
*if(GenData(Axial_force,int)==1)
recorder Element -file Truss_axialForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
*if(GenData(Axial_deformation,int)==1)
recorder Element -file Truss_deformations.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems
deformations
*endif
*endif
*#
*# Corotational truss
*#
*if(cntCorotTruss!=0)
*if(GenData(Axial_force,int)==1)
recorder Element -file CorotTruss_axialForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
*if(GenData(Axial_deformation,int)==1)
recorder Element -file CorotTruss_deformations.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems
deformations
*endif
*endif
*#
*# User recorders
*#
*set var FileExists=tcl(UserRecorder::RecorderFileExists)
*if(FileExists==1)

source "../Scripts/Recorders.tcl"; # user recorders
*endif
*#
*# Layer output
*#
*#
*# ShellMITC4
*#

*if(cntShell!=0)
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_A,int)==1||GenData(Stresses_in_layer_B,int)==1||GenData(Stresses_in_layer_C,int)==1||GenData(Strains_in_layer_A,int)==1||GenData(Strains_in_layer_B,int)==1||GenData(Strains_in_layer_C,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_A,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_B,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_C,int)==1)
for {set gaussID 1} {$gaussID<=4} {incr gaussID} {
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*if(MatProp(Decking_thickness,Real) > 0)
*set var Decklayers = 1
*else
*set var Decklayers = 0
*endif
*if(MatProp(Bot_cover_layers,int) > 0)
*set var Botcoverlayers = MatProp(Bot_cover_layers,int)
*else
*set var Botcoverlayers = 0
*endif
*if(MatProp(Bot_transverse_bar_diameter,Real) > 0)
*set var Bottranssteellayers = 1
*else
*set var Bottranssteellayers = 0
*endif
*if(MatProp(Bot_longitudinal_bar_diameter,Real) > 0)
*set var Botlongsteellayers = 1
*else
*set var Botlongsteellayers = 0
*endif
*if(MatProp(Core_layers,int) > 0)
*set var corelayers = MatProp(Core_layers,int)
*else
*set var corelayers = 0
*endif
*if(MatProp(Top_longitudinal_bar_diameter,Real) > 0)
*set var Toplongsteellayers = 1
*else
*set var Toplongsteellayers = 0
*endif
*if(MatProp(Top_transverse_bar_diameter,Real) > 0)
*set var Toptranssteellayers = 1
*else
*set var Toptranssteellayers = 0
*endif
*if(MatProp(Top_cover_layers,int) > 0)
*set var Topcoverlayers = MatProp(Top_cover_layers,int)
*else
*set var Topcoverlayers = 0
*endif
*break
*endif
*end materials
*break
*endif
*end elems
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_A,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Stress_layer_A),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"CustomLayer")==0)
*set var layer = GenData(Layer_Number_A,int)
*if(strcmp(GenData(Layer_Material_A),"Concrete")==0)
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Material_A),"Steel")==0)
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer stress
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_B,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Stress_layer_B),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"CustomLayer")==0)
*set var layer = GenData(Layer_Number_B,int)
*if(strcmp(GenData(Layer_Material_B),"Concrete")==0)
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Material_B),"Steel")==0)
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer stress
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_C,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Stress_layer_C),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"CustomLayer")==0)
*set var layer = GenData(Layer_Number_C,int)
*if(strcmp(GenData(Layer_Material_C),"Concrete")==0)
ShellMITC4_concrete_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Material_C),"Steel")==0)
ShellMITC4_steel_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer stress
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Strains_in_layer_A,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Strain_layer_A),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"CustomLayer")==0)
*set var layer = GenData(Layer_No_A,int)
*if(strcmp(GenData(Layer_Mat_A),"Concrete")==0)
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat_A),"Steel")==0)
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer strain
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Strains_in_layer_B,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Strain_layer_B),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"CustomLayer")==0)
*set var layer = GenData(Layer_No_B,int)
*if(strcmp(GenData(Layer_Mat_B),"Concrete")==0)
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat_B),"Steel")==0)
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer strain
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Strains_in_layer_C,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Strain_layer_C),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"CustomLayer")==0)
*set var layer = GenData(Layer_No_C,int)
*if(strcmp(GenData(Layer_Mat_C),"Concrete")==0)
ShellMITC4_concrete_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat_C),"Steel")==0)
ShellMITC4_steel_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer strain
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Temp_Elong_and_KtKc_in_layer_A,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Temp_Elong_layer_A),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"CustomLayer")==0)
*set var layer = GenData(Layer_Num_A,int)
*if(strcmp(GenData(Layer_Mat__A),"Concrete")==0)
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat__A),"Steel")==0)
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer TempAndElong
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Temp_Elong_and_KtKc_in_layer_B,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Temp_Elong_layer_B),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"CustomLayer")==0)
*set var layer = GenData(Layer_Num_B,int)
*if(strcmp(GenData(Layer_Mat__B),"Concrete")==0)
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat__B),"Steel")==0)
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer TempAndElong
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Temp_Elong_and_KtKc_in_layer_C,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Temp_Elong_layer_C),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"CustomLayer")==0)
*set var layer = GenData(Layer_Num_C,int)
*if(strcmp(GenData(Layer_Mat__C),"Concrete")==0)
ShellMITC4_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat__C),"Steel")==0)
ShellMITC4_steel_TempElong_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer TempAndElong
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_A,int)==1||GenData(Stresses_in_layer_B,int)==1||GenData(Stresses_in_layer_C,int)==1||GenData(Strains_in_layer_A,int)==1||GenData(Strains_in_layer_B,int)==1||GenData(Strains_in_layer_C,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_A,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_B,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_C,int)==1)
}
*endif
*endif
*#
*# ShellDKGQ
*#
*if(cntShellDKGQ!=0)
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_A,int)==1||GenData(Stresses_in_layer_B,int)==1||GenData(Stresses_in_layer_C,int)==1||GenData(Strains_in_layer_A,int)==1||GenData(Strains_in_layer_B,int)==1||GenData(Strains_in_layer_C,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_A,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_B,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_C,int)==1)
for {set gaussID 1} {$gaussID<=4} {incr gaussID} {
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*if(MatProp(Decking_thickness,Real) > 0)
*set var Decklayers = 1
*else
*set var Decklayers = 0
*endif
*if(MatProp(Bot_cover_layers,int) > 0)
*set var Botcoverlayers = MatProp(Bot_cover_layers,int)
*else
*set var Botcoverlayers = 0
*endif
*if(MatProp(Bot_transverse_bar_diameter,Real) > 0)
*set var Bottranssteellayers = 1
*else
*set var Bottranssteellayers = 0
*endif
*if(MatProp(Bot_longitudinal_bar_diameter,Real) > 0)
*set var Botlongsteellayers = 1
*else
*set var Botlongsteellayers = 0
*endif
*if(MatProp(Core_layers,int) > 0)
*set var corelayers = MatProp(Core_layers,int)
*else
*set var corelayers = 0
*endif
*if(MatProp(Top_longitudinal_bar_diameter,Real) > 0)
*set var Toplongsteellayers = 1
*else
*set var Toplongsteellayers = 0
*endif
*if(MatProp(Top_transverse_bar_diameter,Real) > 0)
*set var Toptranssteellayers = 1
*else
*set var Toptranssteellayers = 0
*endif
*if(MatProp(Top_cover_layers,int) > 0)
*set var Topcoverlayers = MatProp(Top_cover_layers,int)
*else
*set var Topcoverlayers = 0
*endif
*break
*endif
*end materials
*break
*endif
*end elems
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_A,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Stress_layer_A),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_A),"CustomLayer")==0)
*set var layer = GenData(Layer_Number_A,int)
*if(strcmp(GenData(Layer_Material_A),"Concrete")==0)
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Material_A),"Steel")==0)
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer stress
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_B,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Stress_layer_B),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_B),"CustomLayer")==0)
*set var layer = GenData(Layer_Number_B,int)
*if(strcmp(GenData(Layer_Material_B),"Concrete")==0)
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Material_B),"Steel")==0)
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer stress
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_C,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Stress_layer_C),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Stress_layer_C),"CustomLayer")==0)
*set var layer = GenData(Layer_Number_C,int)
*if(strcmp(GenData(Layer_Material_C),"Concrete")==0)
ShellDKGQ_concrete_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Material_C),"Steel")==0)
ShellDKGQ_steel_stress_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer stress
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Strains_in_layer_A,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Strain_layer_A),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_A),"CustomLayer")==0)
*set var layer = GenData(Layer_No_A,int)
*if(strcmp(GenData(Layer_Mat_A),"Concrete")==0)
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat_A),"Steel")==0)
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer strain
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Strains_in_layer_B,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Strain_layer_B),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_B),"CustomLayer")==0)
*set var layer = GenData(Layer_No_B,int)
*if(strcmp(GenData(Layer_Mat_B),"Concrete")==0)
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat_B),"Steel")==0)
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer strain
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Strains_in_layer_C,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Strain_layer_C),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Strain_layer_C),"CustomLayer")==0)
*set var layer = GenData(Layer_No_C,int)
*if(strcmp(GenData(Layer_Mat_C),"Concrete")==0)
ShellDKGQ_concrete_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat_C),"Steel")==0)
ShellDKGQ_steel_strain_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer strain
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Temp_Elong_and_KtKc_in_layer_A,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Temp_Elong_layer_A),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_A),"CustomLayer")==0)
*set var layer = GenData(Layer_Num_A,int)
*if(strcmp(GenData(Layer_Mat__A),"Concrete")==0)
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat__A),"Steel")==0)
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer TempAndElong
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Temp_Elong_and_KtKc_in_layer_B,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Temp_Elong_layer_B),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_B),"CustomLayer")==0)
*set var layer = GenData(Layer_Num_B,int)
*if(strcmp(GenData(Layer_Mat__B),"Concrete")==0)
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat__B),"Steel")==0)
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer TempAndElong
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Temp_Elong_and_KtKc_in_layer_C,int)==1)
*set var loopnum = 0
recorder Element -file *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*set var loopnum = loopnum + 1
*if(loopnum == 1)
*if(strcmp(GenData(Temp_Elong_layer_C),"SteelTopLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"SteelTopTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"SteelBotLongitudinal")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"SteelBotTransverse")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"ConcreteTop")==0)
*set var layer = Decklayers+Botcoverlayers+Bottranssteellayers+Botlongsteellayers+corelayers+Toplongsteellayers+Toptranssteellayers+Topcoverlayers
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"ConcreteBottom")==0)
*set var layer = Decklayers+Botcoverlayers
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out -time -ele *\
*elseif(strcmp(GenData(Temp_Elong_layer_C),"CustomLayer")==0)
*set var layer = GenData(Layer_Num_C,int)
*if(strcmp(GenData(Layer_Mat__C),"Concrete")==0)
ShellDKGQ_concrete_TempElong_KtKc_Layer*layer_GP$gaussID.out  -time -ele *\
*elseif(strcmp(GenData(Layer_Mat__C),"Steel")==0)
ShellDKGQ_steel_TempElong_Layer*layer_GP$gaussID.out  -time -ele *\
*endif
*endif
*endif
*ElemsNum *\
*endif
*end elems
material $gaussID fiber *layer TempAndElong
*endif
*#-------------------------------------------------------------------------------------------------------------------------
*if(GenData(Stresses_in_layer_A,int)==1||GenData(Stresses_in_layer_B,int)==1||GenData(Stresses_in_layer_C,int)==1||GenData(Strains_in_layer_A,int)==1||GenData(Strains_in_layer_B,int)==1||GenData(Strains_in_layer_C,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_A,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_B,int)==1||GenData(Temp_Elong_and_KtKc_in_layer_C,int)==1)
}
*endif
*endif
