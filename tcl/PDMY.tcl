namespace eval PDMY {}

proc PDMY::GenerateRecommendedValues { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set kPaunit "kPa"
			set MPaunit "MPa"
			set GPaunit "GPa"
			set mdunit "ton/m^3"
			set Soil_type [DWLocalGetValue $GDN $STRUCT $QUESTION]

				switch $Soil_type {

					"Loose_Sand" {
						set rho 1.7; # ton/m^3
						set Gr 55; # MPa
						set Bulk 150; # MPa
						set gammamax 0.1
						set Fangle 29
						set d 0.5
						set pr 80; #kPa
						set ptang 29
						set contraction 0.21
						set dilat1 0.0
						set dilat2 0.0
						set liquefac1 10; # kPa
						set liquefac2 0.02
						set liquefac3 1.0
						set voidratio 0.85
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Medium_Sand" {
						set rho 1.9; # ton/m^3
						set Gr 75; # MPa
						set Bulk 200; # MPa
						set gammamax 0.1
						set Fangle 33
						set d 0.5
						set pr 80; #kPa
						set ptang 27
						set contraction 0.07
						set dilat1 0.4
						set dilat2 2.0
						set liquefac1 10; # kPa
						set liquefac2 0.01
						set liquefac3 1.0
						set voidratio 0.70
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Medium-dense_Sand" {
						set rho 2.0; # ton/m^3
						set Gr 100; # MPa
						set Bulk 300; # MPa
						set gammamax 0.1
						set Fangle 37
						set d 0.5
						set pr 80; #kPa
						set ptang 27
						set contraction 0.05
						set dilat1 0.6
						set dilat2 3.0
						set liquefac1 5; # kPa
						set liquefac2 0.003
						set liquefac3 1
						set voidratio 0.55
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Dense_Sand" {
						set rho 2.1; # ton/m^3
						set Gr 135; # MPa
						set Bulk 390; # MPa
						set gammamax 0.1
						set Fangle 40
						set d 0.5
						set pr 80; # kPa
						set ptang 27
						set contraction 0.03
						set dilat1 0.8
						set dilat2 5.0
						set liquefac1 0.0; # kPa
						set liquefac2 0.0
						set liquefac3 0.0
						set voidratio 0.45
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Custom" {
						return ""
					}
					default {
						return ""
					}
				}
		}
	}

	return ""
}

proc PDMY::CheckIntvNum { event args } {

	switch $event {

		SYNC {
			lassign $args GDN STRUCT QUESTION
			set value [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set intvalue [expr int($value)]

			if {$value != $intvalue} {
				WarnWinText "Interval number must be integer"
				set ok [DWLocalSetValue $GDN $STRUCT $QUESTION $intvalue]
			}
		}
	}
	return ""
}