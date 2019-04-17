
.entity camera;             // Chasecam Entity
void() Chasecam_Update;      // From Chasecam.QC
void(entity ent) SetViewPoint

void() Chasecam_On =
{
 self.camera = spawn();                       // Create a new Camera entity
 self.camera.classname = "camera";            // This is a Camera
 self.camera.movetype  = MOVETYPE_NONE;       // No movetype
 self.camera.solid     = SOLID_BBOX;           // Not solid.
 setmodel(self.camera, "progs/null.spr");
 setsize(self.camera, '-5 -5 -5', '5 5 5');      // Has no size.
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
};

void() ChaseCam_Toggle =    // Toggle Chasecam on/off
{
 if (!self.camera) {Chasecam_On();} else {Chasecam_Off();}
};
