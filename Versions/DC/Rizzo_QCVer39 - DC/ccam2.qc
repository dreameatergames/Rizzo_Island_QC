
.entity camera;             // Chasecam Entity
.vector static_camera_origin;
.float static_camera;
.vector oldangles;
void() Chasecam_Update;      // From Chasecam.QC
void(entity ent) SetViewPoint
void()InitTrigger;
void() Chasecam_On =
{
 self.camera = spawn();                       // Create a new Camera entity
 self.camera.classname = "camera";            // This is a Camera
 self.camera.movetype  = MOVETYPE_NONE;       // No movetype
 self.camera.solid     = SOLID_NOT;           // Not solid.
 setmodel(self.camera, "progs/null.spr");
 setsize(self.camera, '-0 -0 -0', '0 0 0');      // Has no size.
 Chasecam_Update();                            // Update cam
 stuffcmd(self, "r_drawviewmodel 0\ncl_bob 0\ncl_rollangle 0\nv_kickpitch 0\nv_kickroll 0\n");
 SetViewPoint(self.camera);
};

void() Chasecam_Off =
{
 stuffcmd(self, "r_drawviewmodel 1\ncl_bob 0.02\ncl_rollangle 2.0\nv_kickpitch 0.6\nv_kickroll 0.6\n");
 SetViewPoint(self);
 remove(self.camera);
};

void() Chasecam_Update =
{

if(self.static_camera != 1)
{
local vector camera_origin;
 if (!self.camera) return;
 makevectors (self.v_angle);
 traceline (self.origin + self.view_ofs, self.origin + (self.view_ofs * 2) +
           (v_forward * -120) + (v_up * -6), 0, self);

 camera_origin_x = trace_endpos_x;
 camera_origin_y = trace_endpos_y;
 camera_origin_z = trace_endpos_z - self.view_ofs_z;
 camera_origin = camera_origin + trace_plane_normal;
 setorigin (self.camera, camera_origin);
}
else
{ 
self.angles = self.oldangles;
//v_angle =  self.oldangles;
 camera_origin = self.static_camera_origin;
 setorigin (self.camera, camera_origin);
}
};

void() ChaseCam_Toggle =    // Toggle Chasecam on/off
{
 if (!self.camera) {Chasecam_On();} else {Chasecam_Off();}
};

void()info_camera =
{};

void() camoff_touch =
{
if(other.classname != "player")
return;

if(other.static_camera)
	{
	other.static_camera = 0;
	stuffcmd(other, "m_forward 1\n");
	stuffcmd(other, "m_pitch 0.022\n");
	stuffcmd(other, "m_side 0.8\n");
	stuffcmd(other, "m_yaw 0.022\n");
	}
};

void() trigger_camera_off =
{
	InitTrigger ();
	self.touch = camoff_touch;
};

void() camon_touch =
{
	local vector camorg, camangles;
	if(other.classname != "player")
	return;
	if(!other.static_camera)
	{
	other.oldangles  = other.angles;
	local entity cam;
	cam = find (world, targetname, self.target);
	camorg = cam.origin;
	camangles =  cam.angles;
	other.static_camera_origin = camorg;

	WriteByte(1, SVC_SETANGLE);
	WriteAngle(1, camangles_x);
	WriteAngle(1, camangles_y);
	WriteAngle(1, camangles_z); 

	stuffcmd(other, "m_forward 0\n");
	stuffcmd(other, "m_pitch 0\n");
	stuffcmd(other, "m_side 0\n");
	stuffcmd(other, "m_yaw 0\n");
	other.static_camera = 1;
	}
}

void() trigger_camera =
{
	InitTrigger ();
	self.touch = camon_touch;
};
.entity rizzoplayer;
.string targetcam1;
.string targetcam2;
.string targetcam3;

.string targetnamecam1;
.string targetnamecam2;
.string targetnamecam3;

.float timecam1;
.float timecam2;
.float timecam3;

void() info_cutscene_off =
{
	self.rizzoplayer.static_camera = 0;
	stuffcmd(self.rizzoplayer, "m_forward 1\n");
	stuffcmd(self.rizzoplayer, "m_pitch 0.022\n");
	stuffcmd(self.rizzoplayer, "m_side 0.8\n");
	stuffcmd(self.rizzoplayer, "m_yaw 0.022\n");

};

void() info_cutscene_think2 =
{
	local vector camorg, camangles;	
	local entity cam;
	cam = find (world, targetnamecam3, self.targetcam3);
	camorg = cam.origin;
	camangles =  cam.angles;
	self.rizzoplayer.static_camera_origin = camorg;

	WriteByte(1, SVC_SETANGLE);
	WriteAngle(1, camangles_x);
	WriteAngle(1, camangles_y);
	WriteAngle(1, camangles_z); 
	self.nextthink = time + self.timecam3;
	self.think = info_cutscene_off;	

};

void() info_cutscene_think =
{
	local vector camorg, camangles;	
	local entity cam;
	cam = find (world, targetnamecam2, self.targetcam2);
	camorg = cam.origin;
	camangles =  cam.angles;
	self.rizzoplayer.static_camera_origin = camorg;

	WriteByte(1, SVC_SETANGLE);
	WriteAngle(1, camangles_x);
	WriteAngle(1, camangles_y);
	WriteAngle(1, camangles_z); 
	self.nextthink = time + self.timecam2;
	if(self.timecam3)
	self.think = info_cutscene_think2;
	else
	self.think = info_cutscene_off;	

};

void() info_cutscene_use =
{
	local vector camorg, camangles;
	local entity rizzo;
	rizzo = find (world,classname, "player");
	self.rizzoplayer = rizzo;	
	if(!rizzo.static_camera)
	{
	rizzo.oldangles  = rizzo.angles;
	local entity cam;
	cam = find (world, targetnamecam1, self.targetcam1);
	camorg = cam.origin;
	camangles =  cam.angles;
	rizzo.static_camera_origin = camorg;

	WriteByte(1, SVC_SETANGLE);
	WriteAngle(1, camangles_x);
	WriteAngle(1, camangles_y);
	WriteAngle(1, camangles_z); 

	stuffcmd(rizzo, "m_forward 0\n");
	stuffcmd(rizzo, "m_pitch 0\n");
	stuffcmd(rizzo, "m_side 0\n");
	stuffcmd(rizzo, "m_yaw 0\n");
	rizzo.static_camera = 1;
	}

	if(self.timecam2)
	self.think = info_cutscene_think;
	else
	self.think = info_cutscene_off;	
	self.nextthink = time + self.timecam1;	
};

void() info_cutscene =
{
self.use = info_cutscene_use;
};


