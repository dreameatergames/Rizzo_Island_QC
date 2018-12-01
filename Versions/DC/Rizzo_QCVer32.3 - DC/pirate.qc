/*
==============================================================================

pirate / PLAYER

==============================================================================
*/

$cd id1/models/pirate3
$origin 0 -6 24
$base base		
$skin skin

$frame base0

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9 stand11 
$frame stand12 stand13 stand14 stand15 stand16 stand17 stand18 stand19 stand20 

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12 run13 run14
$frame run15 run16 run17 run18 run19

$frame jump1 jump2 jump3 jump4 jump5 jump6 jump7 jump8 jump9 jump10 jump11 jump12 
$frame jump13 jump14 jump15 jump16 jump17 jump18 jump19 jump20 jump21 jump22 jump23
$frame jump24 jump25 jump26 jump27 jump28 jump29 jump30 jump31

$frame attack1 attack2 attack3 attack4 attack5 attack6 attack7 attack8 attack9 attack10 attack11 attack12 attack13 attack14
$frame attack15 attack16 attack17 attack18 attack19 attack20

$frame attackb1 attackb2 attackb3 attackb4 attackb5 attackb6 attackb7 attackb8 attackb9 attackb10 attackb11 attackb12 attackb13 attackb14
$frame attackb15 attackb16 attackb17 attackb18 attackb19 attackb20

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10 death11 death12 
$frame death13 death14 death15 death16 death17 death18 death19 death20 death21 death22 death23
$frame death24 death25 death26 death27 death28 death29 death30 death31

/*
==============================================================================
pirate CODE
==============================================================================
*/

void()	pirate_stand1	=[	$stand1,	pirate_stand2	] {ai_stand();};
void()	pirate_stand2	=[	$stand2,	pirate_stand3	] {ai_stand();};
void()	pirate_stand3	=[	$stand3,	pirate_stand4	] {ai_stand();};
void()	pirate_stand4	=[	$stand4,	pirate_stand5	] {ai_stand();};
void()	pirate_stand5	=[	$stand5,	pirate_stand6	] {ai_stand();};
void()	pirate_stand6	=[	$stand6,	pirate_stand7	] {ai_stand();};
void()	pirate_stand7	=[	$stand7,	pirate_stand8	] {ai_stand();};
void()	pirate_stand8	=[	$stand8,	pirate_stand9	] {ai_stand();};
void()	pirate_stand9	=[	$stand9,	pirate_stand10	] {ai_stand();};
void()	pirate_stand10	=[	$stand10,	pirate_stand11	] {ai_stand();};
void()	pirate_stand11	=[	$stand11,	pirate_stand12	] {ai_stand();};
void()	pirate_stand12	=[	$stand12,	pirate_stand13	] {ai_stand();};
void()	pirate_stand13	=[	$stand13,	pirate_stand14	] {ai_stand();};
void()	pirate_stand14	=[	$stand14,	pirate_stand15	] {ai_stand();};
void()	pirate_stand15	=[	$stand15,	pirate_stand16	] {ai_stand();};
void()	pirate_stand16	=[	$stand16,	pirate_stand17	] {ai_stand();};
void()	pirate_stand17	=[	$stand17,	pirate_stand18	] {ai_stand();};
void()	pirate_stand18	=[	$stand18,	pirate_stand19	] {ai_stand();};
void()	pirate_stand19	=[	$stand19,	pirate_stand20	] {ai_stand();};
void()	pirate_stand20	=[	$stand20,	pirate_stand1	] {ai_stand();};

void()	pirate_walk1	=[	$run1,	pirate_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "pirate/idle.wav", 1, ATTN_IDLE);
ai_walk(1);};
void()	pirate_walk2	=[	$run2,	pirate_walk3	] {ai_walk(1);};
void()	pirate_walk3	=[	$run3,	pirate_walk4	] {ai_walk(1);};
void()	pirate_walk4	=[	$run4,	pirate_walk5	] {ai_walk(1);};
void()	pirate_walk5	=[	$run5,	pirate_walk6	] {ai_walk(2);};
void()	pirate_walk6	=[	$run6,	pirate_walk7	] {ai_walk(3);};
void()	pirate_walk7	=[	$run7,	pirate_walk8	] {ai_walk(4);};
void()	pirate_walk8	=[	$run8,	pirate_walk9	] {ai_walk(4);};
void()	pirate_walk9	=[	$run9,	pirate_walk10	] {ai_walk(2);};
void()	pirate_walk10	=[	$run10,	pirate_walk11	] {ai_walk(2);};
void()	pirate_walk11	=[	$run11,	pirate_walk12	] {ai_walk(2);};
void()	pirate_walk12	=[	$run12,	pirate_walk13	] {ai_walk(1);};
void()	pirate_walk13	=[	$run13,	pirate_walk14	] {ai_walk(0);};
void()	pirate_walk14	=[	$run14,	pirate_walk15	] {ai_walk(1);};
void()	pirate_walk15	=[	$run15,	pirate_walk16	] {ai_walk(1);};
void()	pirate_walk16	=[	$run16,	pirate_walk17	] {ai_walk(1);};
void()	pirate_walk17	=[	$run17,	pirate_walk18	] {ai_walk(3);};
void()	pirate_walk18	=[	$run18,	pirate_walk19	] {ai_walk(3);};
void()	pirate_walk19	=[	$run19,	pirate_walk1	] {ai_walk(3);};

void()	pirate_run1	=[	$run1,	pirate_run2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "pirate/idle.wav", 1, ATTN_IDLE);
ai_run(8);};
void()	pirate_run2	=[	$run2,	pirate_run3	] {ai_run(8);};
void()	pirate_run3	=[	$run3,	pirate_run4	] {ai_run(8);};
void()	pirate_run4	=[	$run4,	pirate_run5	] {ai_run(8);};
void()	pirate_run5	=[	$run5,	pirate_run6	] {ai_run(10);};
void()	pirate_run6	=[	$run6,	pirate_run7	] {ai_run(11);};
void()	pirate_run7	=[	$run7,	pirate_run8	] {ai_run(12);};
void()	pirate_run8	=[	$run8,	pirate_run9	] {ai_run(12);};
void()	pirate_run9	=[	$run9,	pirate_run10	] {ai_run(10);};
void()	pirate_run10	=[	$run10,	pirate_run11	] {ai_run(10);};
void()	pirate_run11	=[	$run11,	pirate_run12	] {ai_run(10);};
void()	pirate_run12	=[	$run12,	pirate_run13	] {ai_run(8);};
void()	pirate_run13	=[	$run13,	pirate_run14	] {ai_run(0);};
void()	pirate_run14	=[	$run14,	pirate_run15	] {ai_run(8);};
void()	pirate_run15	=[	$run15,	pirate_run16	] {ai_run(8);};
void()	pirate_run16	=[	$run16,	pirate_run17	] {ai_run(8);};
void()	pirate_run17	=[	$run17,	pirate_run18	] {ai_run(11);};
void()	pirate_run18	=[	$run18,	pirate_run19	] {ai_run(11);};
void()	pirate_run19	=[	$run19,	pirate_run1	] {ai_run(11);};





void(entity attacker, float damage)	pirate_pain =
{
	local float r;
	
	if (self.pain_finished > time)
		return;
		self.pain_finished = time + 3;
};

void() pirate_blade =
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
	}
};


void()	pirate_atk1	=[	$attack1,	pirate_atk2	] {ai_face();};
void()	pirate_atk2	=[	$attack2,	pirate_atk3	] {ai_face();};
void()	pirate_atk3	=[	$attack3,	pirate_atk4	] {ai_face();};
void()	pirate_atk4	=[	$attack4,	pirate_atk5	] {ai_face();};
void()	pirate_atk5	=[	$attack5,	pirate_atk6	] {ai_charge(5);pirate_blade();};
void()	pirate_atk6	=[	$attack6,	pirate_atk7	] {ai_charge(5);pirate_blade();};
void()	pirate_atk7	=[	$attack7,	pirate_atk8	] {ai_charge(5);};
void()	pirate_atk8	=[	$attack8,	pirate_atk9	] {ai_charge(5);};
void()	pirate_atk9	=[	$attack9,	pirate_atk10	] {ai_charge(5);};
void()	pirate_atk10	=[	$attack10,	pirate_atk11	] {ai_charge(5);};
void()	pirate_atk11	=[	$attack11,	pirate_atk12	] {ai_charge(5);};
void()	pirate_atk12	=[	$attack12,	pirate_atk13	] {ai_charge(5);};
void()	pirate_atk13	=[	$attack13,	pirate_atk14	] {ai_charge(5);};
void()	pirate_atk14	=[	$attack14,	pirate_atk15	] {ai_charge(5);};
void()	pirate_atk15	=[	$attack15,	pirate_atk16	] {ai_charge(5);};
void()	pirate_atk16	=[	$attack16,	pirate_atk17	] {ai_charge(5);};
void()	pirate_atk17	=[	$attack17,	pirate_atk18	] {ai_charge(5);};
void()	pirate_atk18	=[	$attack18,	pirate_atk19	] {ai_charge(5);};
void()	pirate_atk19	=[	$attack19,	pirate_atk20	] {ai_charge(5);};
void()	pirate_atk20	=[	$attack20,	pirate_run1	] {ai_charge(5);};

void()	pirate_atkb1	=[	$attackb1,	pirate_atkb2	] {ai_face();};
void()	pirate_atkb2	=[	$attackb2,	pirate_atkb3	] {ai_face();};
void()	pirate_atkb3	=[	$attackb3,	pirate_atkb4	] {ai_face();};
void()	pirate_atkb4	=[	$attackb4,	pirate_atkb5	] {ai_face();};
void()	pirate_atkb5	=[	$attackb5,	pirate_atkb6	] {ai_charge(5);};
void()	pirate_atkb6	=[	$attackb6,	pirate_atkb7	] {ai_charge(5);};
void()	pirate_atkb7	=[	$attackb7,	pirate_atkb8	] {ai_charge(5);};
void()	pirate_atkb8	=[	$attackb8,	pirate_atkb9	] {ai_charge(5);pirate_blade();};
void()	pirate_atkb9	=[	$attackb9,	pirate_atkb10	] {ai_charge(5);pirate_blade();};
void()	pirate_atkb10	=[	$attackb10,	pirate_atkb11	] {ai_charge(5);};
void()	pirate_atkb11	=[	$attackb11,	pirate_atkb12	] {ai_charge(5);};
void()	pirate_atkb12	=[	$attackb12,	pirate_atkb13	] {ai_charge(5);};
void()	pirate_atkb13	=[	$attackb13,	pirate_atkb14	] {ai_charge(5);};
void()	pirate_atkb14	=[	$attackb14,	pirate_atkb15	] {ai_charge(5);};
void()	pirate_atkb15	=[	$attackb15,	pirate_atkb16	] {ai_charge(5);};
void()	pirate_atkb16	=[	$attackb16,	pirate_atkb17	] {ai_charge(5);};
void()	pirate_atkb17	=[	$attackb17,	pirate_atkb18	] {ai_charge(5);};
void()	pirate_atkb18	=[	$attackb18,	pirate_atkb19	] {ai_charge(5);};
void()	pirate_atkb19	=[	$attackb19,	pirate_atkb20	] {ai_charge(5);};
void()	pirate_atkb20	=[	$attackb20,	pirate_run1	] {ai_charge(5);};

void()pirate_melee = 
{
if (random() < 0.5)
pirate_atkb1();
else
pirate_atk1();
};


void()	pirate_die1	=[	$death1,	pirate_die2	] {};
void()	pirate_die2	=[	$death2,	pirate_die3	] {};
void()	pirate_die3	=[	$death3,	pirate_die4	]
{self.solid = SOLID_NOT;};
void()	pirate_die4	=[	$death4,	pirate_die5	] {};
void()	pirate_die5	=[	$death5,	pirate_die6	] {};
void()	pirate_die6	=[	$death6,	pirate_die7	] {};
void()	pirate_die7	=[	$death7,	pirate_die8	] {};
void()	pirate_die8	=[	$death8,	pirate_die9	] {};
void()	pirate_die9	=[	$death9,	pirate_die10	] {};
void()	pirate_die10	=[	$death10,	pirate_die11	] {};
void()	pirate_die11	=[	$death11,	pirate_die12	] {};
void()	pirate_die12	=[	$death12,	pirate_die13	] {};
void()	pirate_die13	=[	$death13,	pirate_die14	]{};
void()	pirate_die14	=[	$death14,	pirate_die15	] {};
void()	pirate_die15	=[	$death15,	pirate_die16	] {};
void()	pirate_die16	=[	$death16,	pirate_die17	] {};
void()	pirate_die17	=[	$death17,	pirate_die18	] {};
void()	pirate_die18	=[	$death18,	pirate_die19	] {};
void()	pirate_die19	=[	$death19,	pirate_die20	] {};
void()	pirate_die20	=[	$death20,	pirate_die21	] {};
void()	pirate_die21	=[	$death21,	pirate_die22	] {};
void()	pirate_die22	=[	$death22,	pirate_die23	] {};
void()	pirate_die23	=[	$death23,	pirate_die24	]{};
void()	pirate_die24	=[	$death24,	pirate_die25	] {};
void()	pirate_die25	=[	$death25,	pirate_die26	] {};
void()	pirate_die26	=[	$death26,	pirate_die27	] {};
void()	pirate_die27	=[	$death27,	pirate_die28	] {};
void()	pirate_die28	=[	$death28,	pirate_die29	] {};
void()	pirate_die29	=[	$death29,	pirate_die30	] {};
void()	pirate_die30	=[	$death30,	pirate_die31	] {};
void()	pirate_die31	=[	$death31,	pirate_die31	] {};


void() pirate_die =
{

// regular death
	sound (self, CHAN_VOICE, "pirate/death1.wav", 1, ATTN_NORM);
		pirate_die1 ();
};


/*QUAKED monster_pirate (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/
void() monster_pirate =
{	
	if (deathmatch)
	{
		if (deathmatch !=7)remove(self);
		if (deathmatch !=7)return;
	}
//	if (random() < 0.5)
	self.skin  = rint (random() * 30);
	precache_model ("progs/pirate.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_sound ("pirate/death1.wav");
	precache_sound ("pirate/idle.wav");
	precache_sound ("pirate/pain1.wav");
	precache_sound ("pirate/pain2.wav");
	precache_sound ("pirate/sattck1.wav");
	precache_sound ("pirate/sight1.wav");

	precache_sound ("player/udeath.wav");		// gib death


	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/pirate.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 2;

	self.th_stand = pirate_stand1;
	self.th_walk = pirate_walk1;
	self.th_run = pirate_run1;
	self.th_melee = pirate_melee;
	self.th_pain = pirate_pain;
	self.th_die = pirate_die;

	walkmonster_start ();
};

