include <sae-units/sae-units.scad>


module single_peg( peg_radius, peg_length ) {
	linear_extrude(peg_length){
		circle(peg_radius);
	}
}


module offset_section_end(peg_radius, peg_length, angle) {
	rotate_extrude(angle = angle) {
		translate([peg_radius,0,0]) circle(r = peg_radius);
	}
	 translate([peg_radius,0,0]) rotate([90, 0, 0]) single_peg(peg_radius, peg_length);
}

function offset_y2c(radius, length, angle, midsection_length) = 0; // distance of offset end from y axis
function offset_x2c() = 0; // distance of offset end from x axis

function toa2opposite(reference_angle, adjacent) = tan(reference_angle) * adjacent; // magnitude of normal vector from curve face to the y axis

function offset_from_x_axis(peg_radius, angle, midsection_length) = let (
	dfo = toa2opposite(90 - angle, peg_radius)
) sqrt(
	pow(dfo, 2) + pow(peg_radius,2)
);
function the_distance_to_move_on_forty_five_degree_plane(
	peg_radius, 
	angle, 
	midsection_length
) = let (
	displacement_from_origin = toa2opposite(90 - angle, peg_radius)
) ( .5 * midsection_length ) >= displacement_from_origin? ( midsection_length / 2 ) - displacement_from_origin:- (displacement_from_origin - ( midsection_length / 2 )) ;

function distance_to_move_on_x_axis(
	peg_radius, 
	angle, 
	midsection_length
) = sin(angle) * the_distance_to_move_on_forty_five_degree_plane(peg_radius, angle, midsection_length);

function distance_to_move_on_y_axis(
	peg_radius, 
	angle, 
	midsection_length
) = cos(angle) * the_distance_to_move_on_forty_five_degree_plane(peg_radius, angle, midsection_length);


module offset_section( peg_radius, peg_length, angle, midsection_length) {
	displacement_from_origin  = toa2opposite(90 - angle, peg_radius); // magnitude of normal vector from curve face to the y axis
	offset_from_x_axis = offset_from_x_axis(peg_radius, angle, midsection_length);
	distance_to_move_on_x_axis = distance_to_move_on_x_axis(peg_radius, angle, midsection_length);
	distance_to_move_on_y_axis = distance_to_move_on_y_axis(peg_radius, angle, midsection_length);
	
	translate([distance_to_move_on_x_axis, - distance_to_move_on_y_axis, 0])
		translate([0, -offset_from_x_axis, 0 ]) 
			offset_section_end( peg_radius, peg_length, angle);
	translate([- distance_to_move_on_x_axis, distance_to_move_on_y_axis, 0])
		rotate([0,0,180]) 
			translate([0, -offset_from_x_axis, 0 ]) 
				offset_section_end( peg_radius, peg_length, angle); 
	
	rotate([90,90,angle]) 
		translate([0,0, - .5 * midsection_length]) 
			single_peg(peg_radius, midsection_length);
	// figuring out placement of extentions from the offset ends
	
	
	//to line up the ends, the x offset of new pieces needs to be distance_to_move_on_x_axis + the peg_radius
	//to line up the ends, the y offset neets to be offset_from_x_axis + distance_to_move_on_y_axis
}
