shader_type spatial;
render_mode world_vertex_coords;
uniform float curveStrength = 0.0625f;

void vertex() {
	vec3 camPos = CAMERA_POSITION_WORLD;
	
	//normalized vertex position relative to the camera position 
	vec2 vertNPos = normalize(vec2(VERTEX.x - camPos.x,VERTEX.y - camPos.y));
	
	float ax = VERTEX.x - camPos.x;
	
	//Does the fancy curve thingy, 
	float x = (curveStrength * pow(VERTEX.x-camPos.x,2.0f));
	float y = 0.0f;//(curveStrength * pow(VERTEX.y-camPos.y,2.0f));
	
	VERTEX.z -= x+ y;
	float depth = VERTEX.z * -1.0f;
	
	//Still uncertain about the normals, but they seem good enough
	NORMAL.x = x*vertNPos.x;
	//NORMAL.y = y*vertNPos.y;
	NORMAL.z = 1.0f;
	
	NORMAL = normalize(NORMAL);
}

void fragment() {	
	// World space normal
	/**/
    vec4 Wn = INV_VIEW_MATRIX * vec4( NORMAL, 0.0 );
	
	bool WorldSpace = true;
	bool RemapRange = false;
	
    if ( WorldSpace == false ) // Local space normal
    {
        Wn = inverse( MODEL_MATRIX ) * Wn;
    }
    if ( RemapRange == true )
    {
        ALBEDO = ( Wn.rgb + 1.0 )/2.0;
    }
    else
    {
        ALBEDO = Wn.rgb;
    }/**/
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
