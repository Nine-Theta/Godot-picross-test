shader_type spatial;
render_mode world_vertex_coords;
uniform float curveStrength = 0.1f;

void vertex() {
	vec3 camPos = CAMERA_POSITION_WORLD;

	//normalized vertex position relative to the camera position
	vec3 vertDelta = vec3(VERTEX.x - camPos.x,VERTEX.y - camPos.y, VERTEX.z - camPos.z);

	//Does the fancy curve thingy,
	float x = (-curveStrength * pow(vertDelta.x,2.0f));
	float y = (-curveStrength * pow(vertDelta.y,2.0f));

	VERTEX.z += (x+ y)*-vertDelta.z*curveStrength;

	//Still uncertain about the normals, but they seem good enough

	float angleX = atan(x / vertDelta.x);
	float angleY = atan(y / vertDelta.y);

	//calculate sin/cos so we only need to do them once
	float sinX = sin(angleX);
	float cosX = cos(angleX);
	float sinY = sin(angleY);
	float cosY = cos(angleY);

	//rotate around y-axis
	NORMAL.x = cosX*NORMAL.x - sinX*NORMAL.z;
	NORMAL.z = sinX*NORMAL.x + cosX*NORMAL.z;

	//rotate around x-axis
	NORMAL.y = cosY*NORMAL.y - sinY*NORMAL.z;
	NORMAL.z = sinY*NORMAL.y + cosY*NORMAL.z;

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
