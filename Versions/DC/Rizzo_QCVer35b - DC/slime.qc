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
setsize (self, '-16 -16 -16', '16 16 16');	
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


void() slime_stand1	=[	1,	slime_stand1	] {ai_stand();};

void() slime_walk1	=[	2 ,	slime_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "slime/movement.wav", 1, ATTN_IDLE);
ai_walk(8);};
void() slime_walk2	=[	3 ,	slime_walk3	] {ai_walk(4);};
void() slime_walk3	=[	4 ,	slime_walk4	] {ai_walk(4);};
void() slime_walk4	=[	5 ,	slime_walk5	] {ai_walk(4);};
void() slime_walk5	=[	6 ,	slime_walk6	] {ai_walk(4);};
void() slime_walk6	=[	7 ,	slime_walk7	] {ai_walk(4);};
void() slime_walk7	=[	8 ,	slime_walk1	] {ai_walk(4);};

void() slime_run1		=[	2  ,	slime_run2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "slime/movement.wav", 1, ATTN_IDLE);
ai_run(16);};
void() slime_run2		=[	3  ,	slime_run3	] {ai_run(6);};
void() slime_run3		=[	4  ,	slime_run4	] {ai_run(6);};
void() slime_run4		=[	5  ,	slime_run5	] {ai_run(5);};
void() slime_run5		=[	6  ,	slime_run6	] {ai_run(7);};
void() slime_run6		=[	7  ,	slime_run7	] {ai_run(6);};
void() slime_run7		=[	8  ,	slime_run1	] {ai_run(8);};

void() slime_atta1	=[	9,	slime_atta2	] {ai_charge(3);};
void() slime_atta2	=[	10,	slime_atta3	] {ai_charge(2);};
void() slime_atta3	=[	11,	slime_atta4	] {ai_charge(3);};
void() slime_atta4	=[	12,	slime_atta5	] {
sound (self, CHAN_VOICE, "slime/gib.wav", 1, ATTN_NORM);
slimeFireGrenade();};
void() slime_atta5	=[	13,	slime_atta6	] {ai_charge(2);};
void() slime_atta6	=[	14,	slime_atta7	] {ai_charge(4);};
void() slime_atta7	=[	15,	slime_atta8	] {ai_charge(2);};
void() slime_atta8	=[	16,	slime_atta9	] {ai_charge(2);};
void() slime_atta9	=[	17,	slime_run1	] {ai_charge(3);};

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
	precache_sound ("slime/hitback.wav");
	precache_sound ("slime/movement.wav");
	precache_sound ("slime/die.wav");

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
	self.th_melee = slime_atta;
	self.th_missile = slime_atta;

	walkmonster_start();
};   