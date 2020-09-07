*set var dummy=tcl(Fire::ActivateThermalcheck Steel01 *MatProp(Activate_Thermal,int) *ElemsMatProp(Element_type:) *ElemsNum)
*if(dummy==1)
*MessageBox
*endif
*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
*if(Matprop(Activate_Thermal,int)==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real) *\
*else
uniaxialMaterial Steel01Thermal *MaterialID *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real) *\
*endif
*format "%g%g%g%g"
*MatProp(Isotropic_hardening_parameter_a1,real) *MatProp(Isotropic_hardening_parameter_a2,real) *MatProp(Isotropic_hardening_parameter_a3,real) *MatProp(Isotropic_hardening_parameter_a4,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
*if(Matprop(Activate_Thermal,int)==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Force_Fy,real) *MatProp(Initial_stiffness_K,real) *MatProp(Strain-hardening_ratio_b,real) *\
*else
uniaxialMaterial Steel01Thermal *MaterialID *MatProp(Force_Fy,real) *MatProp(Initial_stiffness_K,real) *MatProp(Strain-hardening_ratio_b,real) *\
*endif
*format "%g%g%g%g"
*MatProp(Isotropic_hardening_parameter_a1,real) *MatProp(Isotropic_hardening_parameter_a2,real) *MatProp(Isotropic_hardening_parameter_a3,real) *MatProp(Isotropic_hardening_parameter_a4,real)
*else
*if(Matprop(Activate_Thermal,int)==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Moment_My,real) *MatProp(Moment_per_rotation_unit,real) *MatProp(Strain-hardening_ratio_b,real) *\
*else
uniaxialMaterial Steel01Thermal *MaterialID *MatProp(Moment_My,real) *MatProp(Moment_per_rotation_unit,real) *MatProp(Strain-hardening_ratio_b,real) *\
*endif
*format "%g%g%g%g"
*MatProp(Isotropic_hardening_parameter_a1,real) *MatProp(Isotropic_hardening_parameter_a2,real) *MatProp(Isotropic_hardening_parameter_a3,real) *MatProp(Isotropic_hardening_parameter_a4,real)
*endif 