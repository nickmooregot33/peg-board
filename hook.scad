include <sae-units/sae-units.scad>
include <hook_functions.scad>


peg_r = 5 * sixteenth_inch / 2;
midsection_l = 3 * eighth_inch;
bottom_section_l =  one_inch;
//rotate([0,90,0]) single_peg(1 * eighth_inch, 1 * quarter_inch);
offset_section( 5 * sixteenth_inch / 2, 0, 60, midsection_l);
$fn = 100;

// end one
translate([
	distance_to_move_on_x_axis(peg_r, 60, midsection_l) + peg_r,
	-(offset_from_x_axis(peg_r, 60, midsection_l) + distance_to_move_on_y_axis(peg_r, 60, midsection_l)
),
	0]) rotate([90,0,0]) 
		cylinder(h = bottom_section_l, r = peg_r);

//end 2
rotate([0,0,180])
	translate([
		distance_to_move_on_x_axis(peg_r, 60, midsection_l) + peg_r,
		-(offset_from_x_axis(peg_r, 60, midsection_l) + distance_to_move_on_y_axis(peg_r, 60, midsection_l)),
		0]) rotate([90,0,0]) 
			cylinder(h = .5 * one_inch, r = peg_r);
//lower hole peg
translate([
	0,
	- ( bottom_section_l + offset_from_x_axis(peg_r, 60, midsection_l) + distance_to_move_on_y_axis(peg_r, 60, midsection_l) - peg_r),
	0
	])
	rotate([0,90,0])
		cylinder(
			h = 2 * (distance_to_move_on_x_axis(peg_r, 60, midsection_l) + 1 * peg_r), 
			r = peg_r,
			center = true
		);
//box(); 

//hook end
translate([
	distance_to_move_on_x_axis(peg_r, 60, midsection_l) + peg_r + 10,
	-(offset_from_x_axis(peg_r, 60, midsection_l) + distance_to_move_on_y_axis(peg_r, 60, midsection_l) +  2 * (distance_to_move_on_x_axis(peg_r, 60, midsection_l) + 1.5 * peg_r) + 9),
	0
	])
	rotate([0,0,180]) 
		rotate_extrude(angle=180, convexity = 10)
			translate([10,0])
				circle(peg_r);

translate([
	distance_to_move_on_x_axis(peg_r, 60, midsection_l) + peg_r + 2 * 10,
	- ( bottom_section_l + offset_from_x_axis(peg_r, 60, midsection_l) + distance_to_move_on_y_axis(peg_r, 60, midsection_l) - peg_r),
	0
]) rotate([90,0,0]) cylinder(h = 5, r = peg_r);
