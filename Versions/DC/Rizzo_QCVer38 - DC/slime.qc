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

slime

==============================================================================
*/
void()	s_explode1	=	[0,		s_explode2] {};
void()	s_explode2	=	[1,		s_explode3] {};
void()	s_explode3	=	[3,		SUB_Remove] {};


void() BecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

void() T_MissileTouch =
{
	local float	damg;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	damg = 1;
	
	if (other.health)
	{
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;	// mostly immune
		T_Damage (other, self, self.owner, damg );
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
	T_RadiusDamage (self, self.owner, 120, other);

//	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};
void() slime_run1;
.float waitattack;

void() slimeGrenadeExplode =
{
	T_Damage (self, self.owner, self.owner, 1);
	sound (self, CHAN_VOICE, "slime/gib.wav", 1, ATTN_NORM);
	self.owner.waitattack = 0;
	T_Damage (other, self, self.owner, 1);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/hit.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

void() slimeGrenadeTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner
		slimeGrenadeExplode();
	sound (self, CHAN_VOICE, "slime/hitback.wav", 1, ATTN_NORM);	// bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

/*
================
slimeFireGrenade
================
*/
void() slimeGrenadeVel =
{
	self.owner.waitattack = 0;
	self.owner = self.enemy;
	self.skin = 1;
	self.velocity = self.velocity * -1;
}

void() slimeGrenadeThink =
{
local entity pl;
pl = find(world, classname, "player");
local float dbt;

dbt = vlen (self.origin - pl.origin);

if (dbt < 120)
{
setsize (self, '-20 -20 -20', '20 20 20');	
}
else
{
setsize (self, '-4 -4 -4', '4 4 4');	
}


self.cnt -= 1;

if( self.cnt <0)
self.think = slimeGrenadeExplode;
else
self.think = slimeGrenadeThink;


self.nextthink = time + 0.1;

}

void() slimeMelee =
{
	local vector	delta;
	local float 	ldmg;

	if (!self.enemy)
		return;		// removed before stroke
		
	delta = self.enemy.origin - self.origin;

	if (vlen(delta) < 60)
	{
	ldmg = 0.5;
	T_Damage (self.enemy, self, self, ldmg);
	sound (self, CHAN_WEAPON, "slime/hit.wav", 1, ATTN_NORM);
	}
};

void() slimeFireGrenade =
{
	local	entity missile, mpuff;
	
	//self.effects = self.effects | EF_MUZZLEFLASH;

	self.waitattack = 1;
	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
		
// set missile speed	

	makevectors (self.angles);

	missile.velocity = normalize(self.enemy.origin - self.origin);
	missile.velocity = missile.velocity * 128;

	missile.avelocity = '300 300 300';
	missile.classname = "slimeball";
	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = slimeGrenadeTouch;
	missile.health = 150;
	missile.takedamage = DAMAGE_AIM;
	missile.th_die = slimeGrenadeExplode;
	missile.th_pain = slimeGrenadeVel;
	missile.cnt = 150;
// set missile duration
	missile.nextthink = time;
	missile.think = slimeGrenadeThink;

	setmodel (missile, "progs/s_ball.mdl");
	setsize (missile, '-4 -4 -4', '4 4 4');	
	setorigin (missile, self.origin);
};

.float idle_frame;
void() slime_stand2;

void() slime_stand1	=
{

if(self.idle_frame == 1)
self.frame = 1;
self.idle_frame += 1;
if(self.idle_frame == 23)
{
self.idle_frame = 1;
local float random_idle;
random_idle = random();
if(random_idle > 0.3)
self.think = slime_stand1;
else
self.think = slime_stand2;
}
else
self.think = slime_stand1;
ai_stand();
self.nextthink = time + 0.1;

};

void() slime_stand2	=
{
if(self.idle_frame == 1)
self.frame = 2;
self.idle_frame += 1;
if(self.idle_frame == 52)
{
self.idle_frame = 1;
local float random_idle;
random_idle = random();
if(random_idle > 0.3)
self.think = slime_stand1;
else
self.think = slime_stand2;
}
else
self.think = slime_stand2;
ai_stand();
self.nextthink = time + 0.1;

};


void() slime_walk1	=[	3 ,	slime_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "slime/movement.wav", 1, ATTN_IDLE);
ai_walk(8);};
void() slime_walk2	=[	4 ,	slime_walk3	] {ai_walk(4);};
void() slime_walk3	=[	5 ,	slime_walk4	] {ai_walk(4);};
void() slime_walk4	=[	6 ,	slime_walk5	] {ai_walk(4);};
void() slime_walk5	=[	7 ,	slime_walk6	] {ai_walk(4);};
void() slime_walk6	=[	8 ,	slime_walk7	] {ai_walk(4);};
void() slime_walk7	=[	9 ,	slime_walk8	] {ai_walk(4);};
void() slime_walk8	=[	10 ,	slime_walk9	] {ai_walk(4);};
void() slime_walk9	=[	11 ,	slime_walk10	] {ai_walk(4);};
void() slime_walk10	=[	12 ,	slime_walk11	] {ai_walk(4);};
void() slime_walk11	=[	13 ,	slime_walk12	] {ai_walk(4);};
void() slime_walk12	=[	14 ,	slime_walk13	] {ai_walk(4);};
void() slime_walk13	=[	15 ,	slime_walk14	] {ai_walk(4);};
void() slime_walk14	=[	16 ,	slime_walk15	] {ai_walk(4);};
void() slime_walk15	=[	17 ,	slime_walk16	] {ai_walk(4);};
void() slime_walk16	=[	18 ,	slime_walk17	] {ai_walk(4);};
void() slime_walk17	=[	19 ,	slime_walk18	] {ai_walk(4);};
void() slime_walk18	=[	20 ,	slime_walk19	] {ai_walk(4);};
void() slime_walk19	=[	21 ,	slime_walk20	] {ai_walk(4);};
void() slime_walk20	=[	22 ,	slime_walk21	] {ai_walk(4);};
void() slime_walk21	=[	23 ,	slime_walk22	] {ai_walk(4);};
void() slime_walk22	=[	24 ,	slime_walk23	] {ai_walk(4);};
void() slime_walk23	=[	25 ,	slime_walk24	] {ai_walk(4);};
void() slime_walk24	=[	26 ,	slime_walk1	] {ai_walk(4);};

void() slime_run1	=[	3 ,	slime_run2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "slime/movement.wav", 1, ATTN_IDLE);
ai_run(8);};
void() slime_run2	=[	4 ,	slime_run3	] {ai_run(6);};
void() slime_run3	=[	5 ,	slime_run4	] {ai_run(8);};
void() slime_run4	=[	6 ,	slime_run5	] {ai_run(6);};
void() slime_run5	=[	7 ,	slime_run6	] {ai_run(8);};
void() slime_run6	=[	8 ,	slime_run7	] {ai_run(6);};
void() slime_run7	=[	9 ,	slime_run8	] {ai_run(7);};
void() slime_run8	=[	10 ,	slime_run9	] {ai_run(9);};
void() slime_run9	=[	11 ,	slime_run10	] {ai_run(8);};
void() slime_run10	=[	12 ,	slime_run11	] {ai_run(10);};
void() slime_run11	=[	13 ,	slime_run12	] {ai_run(8);};
void() slime_run12	=[	14 ,	slime_run13	] {ai_run(6);};
void() slime_run13	=[	15 ,	slime_run14	] {ai_run(5);};
void() slime_run14	=[	16 ,	slime_run15	] {ai_run(7);};
void() slime_run15	=[	17 ,	slime_run16	] {ai_run(8);};
void() slime_run16	=[	18 ,	slime_run17	] {ai_run(9);};
void() slime_run17	=[	19 ,	slime_run18	] {ai_run(8);};
void() slime_run18	=[	20 ,	slime_run19	] {ai_run(8);};
void() slime_run19	=[	21 ,	slime_run20	] {ai_run(7);};
void() slime_run20	=[	22 ,	slime_run21	] {ai_run(6);};
void() slime_run21	=[	23 ,	slime_run22	] {ai_run(5);};
void() slime_run22	=[	24 ,	slime_run23	] {ai_run(7);};
void() slime_run23	=[	25 ,	slime_run24	] {ai_run(8);};
void() slime_run24	=[	26 ,	slime_run1	] {ai_run(9);};


void() slime_atta1	=[	27,	slime_atta2	] {ai_face();};
void() slime_atta2	=[	28,	slime_atta3	] {ai_face();};
void() slime_atta3	=[	29,	slime_atta4	] {ai_face();};
void() slime_atta4	=[	30,	slime_atta5	] {

if (self.skin == 1)
{
ai_charge(4);
slimeMelee();
}
else
slimeFireGrenade();
sound (self, CHAN_VOICE, "slime/gib.wav", 1, ATTN_NORM);

};
void() slime_atta5	=[	31,	slime_atta6	] {};
void() slime_atta6	=[	32,	slime_atta7	] {};
void() slime_atta7	=[	33,	slime_atta8	] {};
void() slime_atta8	=[	34,	slime_atta9	] {};
void() slime_atta9	=[	35,	slime_atta10	] {};
void() slime_atta10	=[	36,	slime_atta11	] {};
void() slime_atta11	=[	37,	slime_atta12	] {};
void() slime_atta12	=[	38,	slime_atta13	] {};
void() slime_atta13	=[	39,	slime_atta14	] {};
void() slime_atta14	=[	40,	slime_atta15	] {};
void() slime_atta15	=[	41,	slime_atta16	] {};
void() slime_atta16	=[	42,	slime_atta17	] {};
void() slime_atta17	=[	43,	slime_atta18	] {};
void() slime_atta18	=[	44,	slime_atta19	] {};
void() slime_atta19	=[	45,	slime_atta20	] {};
void() slime_atta20	=[	46,	slime_atta21	] {};
void() slime_atta21	=[	47,	slime_atta22	] {};
void() slime_atta22	=[	48,	slime_atta23	] {};
void() slime_atta23	=[	49,	slime_atta24	] {};
void() slime_atta24	=[	50,	slime_atta25	] {};
void() slime_atta25	=[	51,	slime_atta26	] {};
void() slime_atta26	=[	52,	slime_atta27	] {};
void() slime_atta27	=[	53,	slime_atta28	] {};
void() slime_atta28	=[	54,	slime_atta29	] {};
void() slime_atta29	=[	55,	slime_atta30	] {};
void() slime_atta30	=[	56,	slime_atta31	] {};
void() slime_atta31	=[	57,	slime_atta32	] {};
void() slime_atta32	=[	58,	slime_atta33	] {};
void() slime_atta33	=[	59,	slime_run1	] {};

void() slime_atta =
{
if (!self.waitattack)
self.think = slime_atta1;
else
self.think = slime_run1;
self.nextthink = time;
}


void() slime_pain =
{
};


void() slime_die =
{
// check for gib

		sound (self, CHAN_VOICE, "slime/gib.wav", 1, ATTN_NORM);
		ThrowGib ("progs/s_gib.mdl", self.health);
		ThrowGib ("progs/s_gib.mdl", self.health);
		ThrowGib ("progs/s_gib.mdl", self.health);
		ThrowHead ("progs/s_gib.mdl", self.health);
		self.think = SUB_Null;
		self.nextthink = time + 1;
};


//===========================================================================

/*QUAKED monster_slime (1 0 0) (-32 -32 -24) (32 32 40) Ambush

*/
void() monster_slime_spawn =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/slime.mdl");

	setsize (self, '-32 -32 -24', '32 32 40');
	self.health = 1;
	self.th_stand = slime_stand1;
	self.th_walk = slime_walk1;
	self.th_run = slime_run1;
	self.th_pain = slime_pain;
	self.th_die = slime_die;
	self.th_melee = slime_atta1;
	self.th_missile = slime_atta1;

	walkmonster_start();
}
void() monster_slime =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/slime.mdl");
	precache_sound ("slime/gib.wav");
	precache_sound ("slime/hit.wav");
	precache_sound ("slime/hitback.wav");
	precache_sound ("slime/movement.wav");
	precache_sound ("slime/die.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/slime.mdl");

	setsize (self, '-32 -32 -24', '32 32 40');
	self.health = 1;
	self.idle_frame = 1;
	self.th_stand = slime_stand1;
	self.th_walk = slime_walk1;
	self.th_run = slime_run1;
	self.th_pain = slime_pain;
	self.th_die = slime_die;
	if(self.skin == 1)
	self.th_melee = slime_atta;
	self.th_missile = slime_atta;

	walkmonster_start();
};