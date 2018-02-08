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

void() bubble_bob;

/*
==============================================================================

PLAYER

==============================================================================
*/

$cd /raid/quake/id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

//
// running
//
$frame attack1 attack2 attack3 attack4 attack5 attack6 attack7 attack8 attack9 attack10
$frame attack11 attack12 attack13 attack14 attack15 attack16 attack17 attack18 attack19 attack20

$frame cattack1 cattack2 cattack3 cattack4 cattack5 cattack6 cattack7 cattack8 cattack9 cattack10
$frame cattack11 cattack12 cattack13 cattack14 cattack15 cattack16 cattack17 cattack18 cattack19 cattack20
$frame cattack21 cattack22 cattack23 cattack24 

$frame dwalk1 dwalk2 dwalk3 dwalk4 dwalk5 dwalk6 dwalk7 dwalk8 dwalk9 dwalk10
$frame dwalk11 dwalk12 dwalk13 dwalk14 dwalk15

$frame idle1 idle2 idle3 idle4 idle5 idle6 idle7 idle8 idle9 idle10
$frame idle11 idle12 idle13 idle14 idle15 idle16 idle17 idle18 idle19 idle20
$frame idle21 idle22 idle23 idle24 idle25 idle26 idle27 idle28 idle29 idle30
$frame idle31 //idle32 

$frame jump1 jump2 jump3 jump4 jump5 jump6 jump7 jump8 jump9 jump10
$frame jump11 jump12 jump13 jump14 jump15 jump16 jump17 jump18

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 run10
$frame run11 run12 

$frame srun1 srun2 srun3 srun4 srun5 srun6 srun7 srun8 srun9 srun10
$frame srun11 srun12 srun13 srun14 srun15 srun16 srun17 srun18 srun19 srun20
$frame srun21 srun22 srun23 srun24 srun25 srun26 srun27 srun28 srun29 srun30
$frame srun31 srun32 srun33 srun34 srun35 srun36 srun37 

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame walk11 walk12 walk13 walk14 walk15 walk16 walk17 walk18 walk19 walk20
$frame walk21 walk22 walk23 walk24 walk25 walk26 walk27 walk28 walk29 walk30

/*
==============================================================================
PLAYER
==============================================================================
*/

void() player_run;
.float pranim;
void()	player_stand1 =[	$idle1,	player_stand1	]
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
	self.frame = $jump14;
	
	else
	{
	if (self.walkframe == 10)
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
	
	if (self.walkframe >= 31)
	{
	self.pranim = 1;
	self.walkframe = 0;
	}
	self.frame = $idle1 + self.walkframe;
	self.walkframe = self.walkframe + 1;	
	}
};
.float oldruning; 
void()	player_run =[	$run1,	player_run	]
{


//  float xyspeed = vlen(self.velocity - '0 0 1' * self.velocity_z);



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
	self.frame = $run1 + self.walkframe;
	}
	else
	{
	if (self.walkframe == 30)
	self.walkframe = 0;
	self.frame = 240 + self.walkframe;
	}


	self.walkframe = self.walkframe + 1;
	self.nextthink = time + 0.05;

};

void() player_jump1 = [$jump1, player_jump2] {self.nextthink = time + 0.05;};
void() player_jump2 = [$jump2, player_jump3] {self.nextthink = time + 0.05;};
void() player_jump3 = [$jump3, player_jump4] {self.nextthink = time + 0.05;};
void() player_jump4 = [$jump4, player_jump5] {self.nextthink = time + 0.05;};
void() player_jump5 = [$jump5, player_jump6] {self.nextthink = time + 0.05;};
void() player_jump6 = [$jump6, player_jump7] {self.nextthink = time + 0.05;};
void() player_jump7 = [$jump7, player_jump8] {self.nextthink = time + 0.05;};
void() player_jump8 = [$jump8, player_jump9] {self.nextthink = time + 0.05;};
void() player_jump9 = [$jump9, player_jump10] {self.nextthink = time + 0.05;};
void() player_jump10 = [$jump10, player_jump11] {self.nextthink = time + 0.05;};
void() player_jump11 = [$jump11, player_jump12] {self.nextthink = time + 0.05;};
void() player_jump12 = [$jump12, player_jump13] {self.nextthink = time + 0.05;};
void() player_jump13 = [$jump13, player_jump14] {self.nextthink = time + 0.05;

	if (!self.flags & FL_ONGROUND)
self.think = player_run;

};
void() player_jump14 = [$jump14, player_jump15] {self.nextthink = time + 0.05;};
void() player_jump15 = [$jump15, player_jump16] {self.nextthink = time + 0.05;};
void() player_jump16 = [$jump16, player_jump17] {self.nextthink = time + 0.05;};
void() player_jump17 = [$jump17, player_jump18] {self.nextthink = time + 0.05;};
void() player_jump18 = [$jump18, player_run] {self.nextthink = time + 0.05;};

void()	player_attack1 =	[$cattack1, player_axe2	] {self.weaponframe=1;self.nextthink = time + 0.05;};
void()	player_axe2 =	[$cattack2, player_axe3	] {self.weaponframe=2;self.nextthink = time + 0.05;};
void()	player_axe3 =	[$cattack3, player_axe4	] {self.weaponframe=3;self.nextthink = time + 0.05;};
void()	player_axe4 =	[$cattack4, player_axe5	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe5 =	[$cattack5, player_axe6	] {self.weaponframe=4;W_FireAxe();self.nextthink = time + 0.05;};
void()	player_axe6 =	[$cattack6, player_axe7	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe7 =	[$cattack7, player_axe8	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe8 =	[$cattack8, player_axe9	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe9 =	[$cattack9, player_axe10	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe10 =	[$cattack10, player_axe11 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe11 =	[$cattack11, player_axe12 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe12 =	[$cattack12, player_axe13 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe13 =	[$cattack13, player_axe14 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe14 =	[$cattack14, player_axe15 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe15 =	[$cattack15, player_axe16 ] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe16 =	[$cattack16, player_axe17	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe17 =	[$cattack17, player_axe18	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe18 =	[$cattack18, player_axe19	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe19 =	[$cattack19, player_axe20	] {self.weaponframe=4;W_FireAxe();self.nextthink = time + 0.05;};
void()	player_axe20 =	[$cattack20, player_axe21	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe21 =	[$cattack21, player_axe22	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe22 =	[$cattack22, player_axe23	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe23 =	[$cattack23, player_axe24	] {self.weaponframe=4;self.nextthink = time + 0.05;};
void()	player_axe24 =	[$cattack24, player_run	] {self.weaponframe=4;self.nextthink = time + 0.05;};




//============================================================================
void(float num_bubbles) DeathBubbles;

void() PainSound =
{
local float		rs;

	if (self.health < 0)
		return;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

// water pain sounds
	if (self.watertype == CONTENT_WATER && self.waterlevel == 3)
	{
		DeathBubbles(1);
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/drown1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/drown2.wav", 1, ATTN_NORM);
		return;
	}

// slime pain sounds
	if (self.watertype == CONTENT_SLIME)
	{
// FIX ME	put in some steam here
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.watertype == CONTENT_LAVA)
	{
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
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
		sound (self, CHAN_VOICE, "player/axhit1.wav", 1, ATTN_NORM);
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


void() DeathBubblesSpawn =
{
local entity	bubble;
	if (self.owner.waterlevel != 3)
		return;
	bubble = spawn();
	setmodel (bubble, "progs/s_bubble.spr");
	setorigin (bubble, self.owner.origin + '0 0 24');
	bubble.movetype = MOVETYPE_NOCLIP;
	bubble.solid = SOLID_NOT;
	bubble.velocity = '0 0 15';
	bubble.nextthink = time + 0.5;
	bubble.think = bubble_bob;
	bubble.classname = "bubble";
	bubble.frame = 0;
	bubble.cnt = 0;
	setsize (bubble, '-8 -8 -8', '8 8 8');
	self.nextthink = time + 0.1;
	self.think = DeathBubblesSpawn;
	self.air_finished = self.air_finished + 1;
	if (self.air_finished >= self.bubble_count)
		remove(self);
};

void(float num_bubbles) DeathBubbles =
{
local entity	bubble_spawner;
	
	bubble_spawner = spawn();
	setorigin (bubble_spawner, self.origin);
	bubble_spawner.movetype = MOVETYPE_NONE;
	bubble_spawner.solid = SOLID_NOT;
	bubble_spawner.nextthink = time + 0.1;
	bubble_spawner.think = DeathBubblesSpawn;
	bubble_spawner.air_finished = 0;
	bubble_spawner.owner = self;
	bubble_spawner.bubble_count = num_bubbles;
	return;
};


void() DeathSound =
{
local float		rs;

	// water death sounds
	if (self.waterlevel == 3)
	{
		DeathBubbles(20);
		sound (self, CHAN_VOICE, "player/h2odeath.wav", 1, ATTN_NONE);
		return;
	}
	
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
	new.nextthink = time + 10 + random()*10;
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
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

	if (damage_attacker.classname == "teledeath2")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}
		
	if (random() < 0.5)
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
	else
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NONE);
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

	if (deathmatch || coop)
		DropBackpack();
	
	self.weaponmodel="";
	self.view_ofs = '0 0 -8';
	self.deadflag = DEAD_DYING;
	self.solid = SOLID_NOT;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.movetype = MOVETYPE_TOSS;
	if (self.velocity_z < 10)
		self.velocity_z = self.velocity_z + random()*300;

	if (self.health < -40)
	{
		GibPlayer ();
		return;
	}

	DeathSound();
	
	self.angles_x = 0;
	self.angles_z = 0;
	PlayerDead();
	if (self.weapon == IT_AXE)
	{
//		player_die_ax1 ();
		return;
	}
	
	i = cvar("temp1");
	if (!i)
		i = 1 + floor(random()*6);
	

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
};/////////////