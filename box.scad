include <sae-units/sae-units.scad>

module box(
	peg2peg = one_inch,
	peg_radius = 1, 
	peg_length = 1, 
	hook_radius = 1, 
	box_depth = 4 * one_inch, //in inches
	box_width = 2.5 * one_inch, //in inches
	box_length = 4 * one_inch, //in inches
	box_height = 2.5 * one_inch, // in inches
	box_thickness = 1 * eighth_inch,
	box_corner_radius = 1 * eighth_inch
) {
	linear_extrude(height = box_height) {
		difference() {
			offset(r = box_corner_radius){
				square([box_width - box_thickness, box_length - box_thickness], true);	
			}
			offset(r = -box_corner_radius){
				square([box_width, box_length], true);
			}
		}
	}
	linear_extrude(height = box_thickness) {
		offset(r = box_corner_radius){
			square([box_width - box_thickness, box_length - box_thickness], true);	
		}
	}
}
