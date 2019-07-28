/*  Copyright (C) 1996-1997  Id Software, Inc.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

    See file, 'COPYING', for details.
*/


/*
==============================================================================

PLAYER

==============================================================================
*/

$cd raid/quake/id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

//
// 
//

/*
==============================================================================
PLAYER
==============================================================================
*/

void() player_run;
.float pranim;
void()	player_stand1 =[	46,	player_stand1	]
{
	local float r;
	self.weaponframe=0;
	if ((self.velocity_x || self.velocity_y) && (self.flags & FL_ONGROUND))
	{
		self.walkframe=0;
		player_run();
		return;
	}

	if (!self.flags & FL_ONGROUND)
	self.frame = 90;
	
	else
	{
	if (self.walkframe == 11)
	{
	r = random();
	if (r > 0.1)
	{self.walkframe = 0;self.pranim = 0;}
	if	(self.pranim == 1)
	{self.pranim = 2; self.walkframe = 0;}
	if	(self.pranim == 2)
	{self.walkframe = 0;self.pranim = 3;}
	if	(self.pranim == 3)
	{self.walkframe = 0;self.pranim = 0;}

	}
	
	if (self.walkframe >= 32)
	{
	self.pranim = 1;
	self.walkframe = 0;
	}
	self.frame = 46 + self.walkframe;
	self.walkframe = self.walkframe + 1;	
	}
};
.float oldruning; 
void()	player_run =[	96,	player_run	]
{
	self.weaponframe=0;
	if ((!self.velocity_x && !self.velocity_y) | (!self.flags & FL_ONGROUND))
	{
		self.walkframe=0;
		player_stand1();
		return;
	}

	if (self.runing == 1)
	{
	if (self.walkframe == 12)
	self.walkframe = 0;
	self.frame = 96 + self.walkframe;
	}
	else
	{
	if (self.walkframe == 30)
	self.walkframe = 0;
	self.frame = 108 + self.walkframe;
	}


	self.walkframe = self.walkframe + 1;
	self.nextthink = time + 0.05;

};

void() player_jump1 = [78, player_jump2] {self.nextthink = time + 0.05;};
void() player_jump2 = [79, player_jump3] {self.nextthink = time + 0.05;};
void() player_jump3 = [80, player_jump4] {self.nextthink = time + 0.05;};
void() player_jump4 = [81, player_jump5] {self.nextthink = time + 0.05;};
void() player_jump5 = [82, player_jump6] {self.nextthink = time + 0.05;};
void() player_jump6 = [83, player_jump7] {self.nextthink = time + 0.05;};
void() player_jump7 = [84, player_jump8] {self.nextthink = time + 0.05;};
void() player_jump8 = [85, player_jump9] {self.nextthink = time + 0.05;};
void() player_jump9 = [86, player_jump10] {self.nextthink = time + 0.05;};
void() player_jump10 = [87, player_jump11] {self.nextthink = time + 0.05;};
void() player_jump11 = [88, player_jump12] {self.nextthink = time + 0.05;};
void() player_jump12 = [89, player_jump13] {self.nextthink = time + 0.05;};
void() player_jump13 = [90, player_jump14] {self.nextthink = time + 0.05;

    if (!self.flags & FL_ONGROUND)
self.think = player_run;

};
void() player_jump14 = [91, player_jump15] {self.nextthink = time + 0.05;};
void() player_jump15 = [92, player_jump16] {self.nextthink = time + 0.05;};
void() player_jump16 = [93, player_jump17] {self.nextthink = time + 0.05;};
void() player_jump17 = [94, player_jump18] {self.nextthink = time + 0.05;};
void() player_jump18 = [95, player_run] {self.nextthink = time + 0.05;};

void()	player_attack1c =	[20, player_attack2	] {self.weaponframe=1;self.nextthink = time + 0.05;};
void()	player_attack2 =	[21, player_attack3	] {self.weaponframe=2;self.nextthink = time + 0.05;};
void()	player_attack3 =	[22, player_attack4	] {self.weaponframe=3;self.nextthink = time + 0.05;};
void()	player_attack4 =	[23, player_attack5	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_attack5 =	[24, player_attack6	] {self.weaponframe=4;W_FireAxe();self.nextthink = time + 0.05;};
void()	player_attack6 =	[25, player_attack7	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_attack7 =	[26, player_attack8	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_attack8 =	[27, player_attack9	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_attack9 =	[28, player_attack10 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_attack10 =	[29, player_attack11 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_attack11 =	[30, player_run ] {self.weaponframe=4;self.nextthink = time + 0.05;};

void()	player_battack1 =	[31, player_battack2	] {self.weaponframe=1;self.nextthink = time + 0.05;};
void()	player_battack2 =	[32, player_battack3	] {self.weaponframe=2;self.nextthink = time + 0.05;};
void()	player_battack3 =	[33, player_battack4	] {self.weaponframe=3;self.nextthink = time + 0.05;};
void()	player_battack4 =	[34, player_battack5	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack5 =	[35, player_battack6	] {self.weaponframe=4;W_FireAxe();self.nextthink = time + 0.05;};
void()	player_battack6 =	[36, player_battack7	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack7 =	[37, player_battack8	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack8 =	[38, player_battack9	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack9 =	[39, player_battack10	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack10 =	[40, player_battack11 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack11 =	[41, player_battack12 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack12 =	[42, player_battack13 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_battack13 =	[43, player_run ] {self.weaponframe=4;self.nextthink = time + 0.05;};

void()	player_attack1 = 
{
local float r;
r = random();

if (r < 0.5)
player_attack1c();
else
player_battack1();

}
//============================================================================

void() PainSound =
{
local float		rs;

	if (self.health < 0)
		return;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/death1.wav", 1, ATTN_NONE);
		return;
	}

// slime pain sounds
	if (self.watertype == CONTENT_SLIME)
	{
// FIX ME	put in some steam here
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "p1ayer/hurt1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/hurt2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.watertype == CONTENT_LAVA)
	{
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/hurt1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/hurt2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
	self.pain_finished = time + 0.5;

// don't make multiple pain sounds right after each other

// ax pain sound
	if (self.axhitme == 1)
	{
		self.axhitme = 0;
		sound (self, CHAN_VOICE, "player/axhit.wav", 1, ATTN_NORM);
		return;
	}
	

	rs = rint((random() * 5) + 1);

	self.noise = "";
	if (rs == 1)
		self.noise = "player/hurt1.wav";
	else if (rs == 2)
		self.noise = "player/hurt2.wav";
	else if (rs == 3)
		self.noise = "player/hurt1.wav";
	else if (rs == 4)
		self.noise = "player/hurt2.wav";
	else if (rs == 5)
		self.noise = "player/hurt1.wav";
	else
		self.noise = "player/hurt2.wav";

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	return;
};

void() player_pain =
{
	if (self.weaponframe)
		return;

	if (self.invisible_finished > time)
		return;		// eyes don't have pain frames
PainSound();
		player_run ();
};




void() DeathSound =
{
local float		rs;

	// water death sounds
	
	rs = rint ((random() * 4) + 1);
	if (rs == 1)
		self.noise = "player/death1.wav";
	if (rs == 2)
		self.noise = "player/death2.wav";
	if (rs == 3)
		self.noise = "player/death3.wav";
	if (rs == 4)
		self.noise = "player/death4.wav";
	if (rs == 5)
		self.noise = "player/death5.wav";

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NONE);
	return;
};


void() PlayerDead =
{
	self.nextthink = -1;
// allow respawn after a certain time
	self.deadflag = DEAD_DEAD;
};

vector(float dm) VelocityForDamage =
{
	local vector v;

	v_x = 100 * crandom();
	v_y = 100 * crandom();
	v_z = 200 + 100 * random();

	if (dm > -50)
	{
//		dprint ("level 1\n");
		v = v * 0.7;
	}
	else if (dm > -200)
	{
//		dprint ("level 3\n");
		v = v * 2;
	}
	else
		v = v * 10;

	return v;
};

void(string gibname, float dm) ThrowGib =
{
	local	entity new;

	new = spawn();
	new.origin = self.origin;
	setmodel (new, gibname);
	setsize (new, '0 0 0', '0 0 0');
	new.velocity = VelocityForDamage (dm);
	new.movetype = MOVETYPE_BOUNCE;
	new.solid = SOLID_NOT;
	new.avelocity_x = random()*600;
	new.avelocity_y = random()*600;
	new.avelocity_z = random()*600;
	new.think = SUB_Remove;
	new.ltime = time;
	new.nextthink = new.ltime + 2 + random();
	new.frame = 0;
	new.flags = 0;
};

void(string gibname, float dm) ThrowHead =
{
	setmodel (self, gibname);
	self.frame = 0;
	self.nextthink = -1;
	self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 0', '16 16 56');
	self.velocity = VelocityForDamage (dm);
	self.origin_z = self.origin_z - 24;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.think = SUB_Remove;
	self.nextthink = time + 3;
	self.avelocity = crandom() * '0 600 0';
};


void() GibPlayer =
{
	ThrowHead ("progs/h_player.mdl", self.health);
	ThrowGib ("progs/gib1.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);
	ThrowGib ("progs/gib3.mdl", self.health);

	self.deadflag = DEAD_DEAD;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/death1.wav", 1, ATTN_NONE);
		return;
	}

	if (damage_attacker.classname == "teledeath2")
	{
		sound (self, CHAN_VOICE, "player/death1.wav", 1, ATTN_NONE);
		return;
	}
		
	if (random() < 0.5)
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
	else
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
};

void() player_die1think =
{
if (self.frame >= 161)
{
self.think = SUB_Null;
PlayerDead();
}

else
self.think = player_die1think;
self.frame += 1;
self.nextthink = time + 0.1;
};

void() player_die1 =
{
self.frame = 138;
self.think = player_die1think;
self.nextthink = time + 0.1;
};
void() player_die2think =
{
if (self.frame >= 178)
{
self.think = SUB_Null;
PlayerDead();
}
else
self.think = player_die2think;
self.frame += 1;
self.nextthink = time + 0.1;
};

void() player_die2 =
{
self.frame = 163;
self.think = player_die2think;
self.nextthink = time + 0.1;
};

void() PlayerDie =
{
	local	float	i;
	
	self.items = self.items - (self.items & IT_INVISIBILITY);
	self.invisible_finished = 0;	// don't die as eyes
	self.invincible_finished = 0;
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.modelindex = modelindex_player;	// don't use eyes
	
	self.weaponmodel="";
	self.view_ofs = '0 0 -8';
	self.deadflag = DEAD_DYING;
	self.solid = SOLID_NOT;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.movetype = MOVETYPE_TOSS;
	if (self.velocity_z < 10)
		self.velocity_z = self.velocity_z + random()*300;


	DeathSound();
	
	self.angles_x = 0;
	self.angles_z = 0;
	PlayerDead();
//	if (self.weapon == IT_AXE)
//	{
//		player_die_ax1 ();
//		return;
//	}

local float r;
r = random();

if (r >= 0.5)
player_die1 ();
else
player_die2 ();
//	i = cvar("temp1");
//	if (!i)/
//		i = 1 + floor(random()*6);
	

};

void() set_suicide_frame =
{	// used by klill command and diconnect command
	if (self.model != "progs/player.mdl")
		return;	// allready gibbed
	self.frame = 0;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_TOSS;
	self.deadflag = DEAD_DEAD;
	self.nextthink = -1;
}; 