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
void()	ks_explode1	=	[0,		ks_explode2] {};
void()	ks_explode2	=	[1,		ks_explode3] {};
void()	ks_explode3	=	[3,		SUB_Remove] {};


void() kBecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	ks_explode1 ();
};
void() T_MissileTouch;

void() kslime_run1;
.float waitattack;

void() kslimeGrenadeExplode =
{
	T_Damage (self, self.owner, self.owner, 1);
	sound (self, CHAN_VOICE, "bosses/skgib.wav", 1, ATTN_NORM);
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

void() kslimeGrenadeTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner
		kslimeGrenadeExplode();
	sound (self, CHAN_VOICE, "bosses/skhitb.wav", 1, ATTN_NORM);	// bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

/*
================
slimeFireGrenade
================
*/
void() kslimeGrenadeVel =
{
	self.owner.waitattack = 0;
	self.owner = self.enemy;
	self.skin = 1;
	self.velocity = self.velocity * -1;
}

void() kslimeGrenadeThink =
{
local entity pl;
pl = find(world, classname, "player");
local float dbt;

dbt = vlen (self.origin - pl.origin);

if (dbt < 200)
{
setsize (self, '-51 -54 -51', '98 102 94');	
}
else
{
setsize (self, '-4 -4 -4', '4 4 4');	
}


self.cnt -= 1;

if( self.cnt <0)
self.think = kslimeGrenadeExplode;
else
self.think = kslimeGrenadeThink;


self.nextthink = time + 0.1;

}

void() kslimeFireGrenade =
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
	missile.velocity = missile.velocity * 350;

	missile.avelocity = '300 300 300';
	missile.classname = "slimeball";
	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = kslimeGrenadeTouch;
	missile.health = 150;
	missile.takedamage = DAMAGE_AIM;
	missile.th_die = kslimeGrenadeExplode;
	missile.th_pain = kslimeGrenadeVel;
	missile.cnt = 150;
// set missile duration
	missile.nextthink = time;
	missile.think = kslimeGrenadeThink;

	setmodel (missile, "progs/skball.mdl");
	setsize (missile, '-32 -32 -24', '32 32 64');	
	setorigin (missile, self.origin);
};

.float idle_frame;
void() kslime_stand2;

void() kslime_stand1	=
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
self.think = kslime_stand1;
else
self.think = kslime_stand2;
}
else
self.think = kslime_stand1;
ai_stand();
self.nextthink = time + 0.1;

};

void() kslime_stand2	=
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
self.think = kslime_stand1;
else
self.think = kslime_stand2;
}
else
self.think = kslime_stand2;
ai_stand();
self.nextthink = time + 0.1;

};


void() kslime_walk1	=[	3 ,	kslime_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "bosses/skmove.wav", 1, ATTN_IDLE);
ai_walk(8);};
void() kslime_walk2	=[	4 ,	kslime_walk3	] {ai_walk(4);};
void() kslime_walk3	=[	5 ,	kslime_walk4	] {ai_walk(4);};
void() kslime_walk4	=[	6 ,	kslime_walk5	] {ai_walk(4);};
void() kslime_walk5	=[	7 ,	kslime_walk6	] {ai_walk(4);};
void() kslime_walk6	=[	8 ,	kslime_walk7	] {ai_walk(4);};
void() kslime_walk7	=[	9 ,	kslime_walk8	] {ai_walk(4);};
void() kslime_walk8	=[	10 ,	kslime_walk9	] {ai_walk(4);};
void() kslime_walk9	=[	11 ,	kslime_walk10	] {ai_walk(4);};
void() kslime_walk10	=[	12 ,	kslime_walk11	] {ai_walk(4);};
void() kslime_walk11	=[	13 ,	kslime_walk12	] {ai_walk(4);};
void() kslime_walk12	=[	14 ,	kslime_walk13	] {ai_walk(4);};
void() kslime_walk13	=[	15 ,	kslime_walk14	] {ai_walk(4);};
void() kslime_walk14	=[	16 ,	kslime_walk15	] {ai_walk(4);};
void() kslime_walk15	=[	17 ,	kslime_walk16	] {ai_walk(4);};
void() kslime_walk16	=[	18 ,	kslime_walk17	] {ai_walk(4);};
void() kslime_walk17	=[	19 ,	kslime_walk18	] {ai_walk(4);};
void() kslime_walk18	=[	20 ,	kslime_walk19	] {ai_walk(4);};
void() kslime_walk19	=[	21 ,	kslime_walk20	] {ai_walk(4);};
void() kslime_walk20	=[	22 ,	kslime_walk21	] {ai_walk(4);};
void() kslime_walk21	=[	23 ,	kslime_walk22	] {ai_walk(4);};
void() kslime_walk22	=[	24 ,	kslime_walk23	] {ai_walk(4);};
void() kslime_walk23	=[	25 ,	kslime_walk24	] {ai_walk(4);};
void() kslime_walk24	=[	26 ,	kslime_walk1	] {ai_walk(4);};

void() kslime_run1	=[	3 ,	kslime_run2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "bosses/skmove.wav", 1, ATTN_IDLE);
ai_run(8);};
void() kslime_run2	=[	4 ,	kslime_run3	] {ai_run(6);};
void() kslime_run3	=[	5 ,	kslime_run4	] {ai_run(8);};
void() kslime_run4	=[	6 ,	kslime_run5	] {ai_run(6);};
void() kslime_run5	=[	7 ,	kslime_run6	] {ai_run(8);};
void() kslime_run6	=[	8 ,	kslime_run7	] {ai_run(6);};
void() kslime_run7	=[	9 ,	kslime_run8	] {ai_run(7);};
void() kslime_run8	=[	10 ,	kslime_run9	] {ai_run(9);};
void() kslime_run9	=[	11 ,	kslime_run10	] {ai_run(8);};
void() kslime_run10	=[	12 ,	kslime_run11	] {ai_run(10);};
void() kslime_run11	=[	13 ,	kslime_run12	] {ai_run(8);};
void() kslime_run12	=[	14 ,	kslime_run13	] {ai_run(6);};
void() kslime_run13	=[	15 ,	kslime_run14	] {ai_run(5);};
void() kslime_run14	=[	16 ,	kslime_run15	] {ai_run(7);};
void() kslime_run15	=[	17 ,	kslime_run16	] {ai_run(8);};
void() kslime_run16	=[	18 ,	kslime_run17	] {ai_run(9);};
void() kslime_run17	=[	19 ,	kslime_run18	] {ai_run(8);};
void() kslime_run18	=[	20 ,	kslime_run19	] {ai_run(8);};
void() kslime_run19	=[	21 ,	kslime_run20	] {ai_run(7);};
void() kslime_run20	=[	22 ,	kslime_run21	] {ai_run(6);};
void() kslime_run21	=[	23 ,	kslime_run22	] {ai_run(5);};
void() kslime_run22	=[	24 ,	kslime_run23	] {ai_run(7);};
void() kslime_run23	=[	25 ,	kslime_run24	] {ai_run(8);};
void() kslime_run24	=[	26 ,	kslime_run1	] {ai_run(9);};


void() kslime_atta1	=[	27,	kslime_atta2	] {ai_face();};
void() kslime_atta2	=[	28,	kslime_atta3	] {ai_face();};
void() kslime_atta3	=[	29,	kslime_atta4	] {ai_face();};
void() kslime_atta4	=[	30,	kslime_atta5	] {

kslimeFireGrenade();
sound (self, CHAN_VOICE, "bosses/skgib.wav", 1, ATTN_NORM);

};
void() kslime_atta5	=[	31,	kslime_atta6	] {};
void() kslime_atta6	=[	32,	kslime_atta7	] {};
void() kslime_atta7	=[	33,	kslime_atta8	] {};
void() kslime_atta8	=[	34,	kslime_atta9	] {};
void() kslime_atta9	=[	35,	kslime_atta10	] {};
void() kslime_atta10	=[	36,	kslime_atta11	] {};
void() kslime_atta11	=[	37,	kslime_atta12	] {};
void() kslime_atta12	=[	38,	kslime_atta13	] {};
void() kslime_atta13	=[	39,	kslime_atta14	] {};
void() kslime_atta14	=[	40,	kslime_atta15	] {};
void() kslime_atta15	=[	41,	kslime_atta16	] {};
void() kslime_atta16	=[	42,	kslime_atta17	] {};
void() kslime_atta17	=[	43,	kslime_atta18	] {};
void() kslime_atta18	=[	44,	kslime_atta19	] {};
void() kslime_atta19	=[	45,	kslime_atta20	] {};
void() kslime_atta20	=[	46,	kslime_atta21	] {};
void() kslime_atta21	=[	47,	kslime_atta22	] {};
void() kslime_atta22	=[	48,	kslime_atta23	] {};
void() kslime_atta23	=[	49,	kslime_atta24	] {};
void() kslime_atta24	=[	50,	kslime_atta25	] {};
void() kslime_atta25	=[	51,	kslime_atta26	] {};
void() kslime_atta26	=[	52,	kslime_atta27	] {};
void() kslime_atta27	=[	53,	kslime_atta28	] {};
void() kslime_atta28	=[	54,	kslime_atta29	] {};
void() kslime_atta29	=[	55,	kslime_atta30	] {};
void() kslime_atta30	=[	56,	kslime_atta31	] {};
void() kslime_atta31	=[	57,	kslime_atta32	] {};
void() kslime_atta32	=[	58,	kslime_atta33	] {};
void() kslime_atta33	=[	59,	kslime_run1	] {};

void() kslime_atta =
{
if (!self.waitattack)
self.think = kslime_atta1;
else
self.think = kslime_run1;
self.nextthink = time;
}


void() kslime_pain =
{
};


void() kslime_die =
{
// check for gib

		sound (self, CHAN_VOICE, "bosses/skgib.wav", 1, ATTN_NORM);
		ThrowGib ("progs/skgib.mdl", self.health);
		ThrowGib ("progs/skgib.mdl", self.health);
		ThrowGib ("progs/skgib.mdl", self.health);
		ThrowHead ("progs/skgib.mdl", self.health);
		self.think = SUB_Remove;
		self.nextthink = time + 3;
};


//===========================================================================

/*QUAKED monster_kslime (1 0 0) (-263 -142 -236) (406 283 256) Ambush

*/
void() monster_kslime_spawn =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/kslime.mdl");

	setsize (self, '-263 -142 -236', '406 283 256');
	self.health = 1;
	self.th_stand = kslime_stand1;
	self.th_walk = kslime_walk1;
	self.th_run = kslime_run1;
	self.th_pain = kslime_pain;
	self.th_die = kslime_die;
	self.th_melee = kslime_atta1;
	self.th_missile = kslime_atta1;

	walkmonster_start();
}
void() monster_kslime =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/kslime.mdl");
	precache_sound ("bosses/skgib.wav");
	precache_sound ("bosses/skhit.wav");
	precache_sound ("bosses/skhitb.wav");
	precache_sound ("bosses/skmove.wav");
	precache_sound ("bosses/sdie.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/kslime.mdl");

	setsize (self, '-263 -142 -236', '406 283 256');
	self.health = 10;
	self.idle_frame = 1;
	self.th_stand = kslime_stand1;
	self.th_walk = kslime_walk1;
	self.th_run = kslime_run1;
	self.th_pain = kslime_pain;
	self.th_die = kslime_die;
	self.th_missile = kslime_atta;

	walkmonster_start();
};