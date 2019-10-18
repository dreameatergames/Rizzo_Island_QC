/*
These functions give dead bodies color and avoid the "Invalid skin" message under GLQuake (currently v0.97)

The first maxplayers entities (ie. the entities besides world that exist at
the start of worldspawn) are used by clients when they connect.
The client entities are the only ones that have colors for player models in
GLQuake. Spare client entities can be used for dead bodies.
The approach of this workaround is to use client entities for player models where
possible and use normal entities for head gibs and eyes.
Hence head gibs and eyes always have skin 0, thus avoiding the invalid player
skin # error.
If there is not 4 spare client entities then some bodies use normal entities
and hence don't have color in GLQuake.
*/
// 1998-06-21 Invalid skin and GLQuake body color workaround by Robert Field
//            file added

/*
============
PostThink

Displays alternative entities for players or bodies if necessary each frame.
(the actual player or body entity in these cases are not rendered)
P.S.: don't mix up with PlayerPostThink() in client.qc
============
*/
void() PostThink =
{
	self.nextthink = 0.001;	// call PostThink every frame

	// loop through players linked list and display their eye or head gib model if necessary
	self = find(world, classname_, "player");
	while (self)
	{
		if (self.display_ent.modelindex)
		{
			// self.display_ent is a non-client entity
			setorigin(self.display_ent, self.origin);
			self.display_ent.angles = self.angles;
			self.display_ent.effects = self.effects;
		}
		self = find(self, classname_, "player");
	}

	// loop through bodies linked list and display their player model if necessary
	self = first_bodyque;
	while (self)
	{
		// self.display_ent is a spare client entity or world
		// self.display_ent.modelindex == 0 if a non-player model is being used, and self.display_ent is a spare client
		// self.display_ent.modelindex == 1 if self.display_ent == world
		if (self.display_ent.modelindex > 1)
			setorigin(self.display_ent, self.origin);
		self = self.owner;
	}
};

/*
============
FindClientBodyQue

Assigns a spare client entity to bodyque_entry.
If none spare then assign world.
Start search for client entity at bodyque_client.
============
*/
void(entity bodyque_entry) FindClientBodyQue =
{
	// post_think is the first entity after the client entities
	while (bodyque_client != post_think)
	{
		// check if bodyque_client is currently used by a client or body
		if (bodyque_client.classname_ != "player" && bodyque_client.classname_ != "body")
		{
			// bodyque_client is spare
			bodyque_entry.display_ent = bodyque_client;
			bodyque_client.classname_ = "body";
			bodyque_client.score_pos = score_pos_;
			return;
		}
		// get next bodyque_client and increment its index
		score_pos_ = score_pos_ + 1;
		bodyque_client = nextent(bodyque_client);
	}

	bodyque_entry.display_ent = world;	// no spare client entities
};

/*
============
AssignBodies

Assigns spare client entities to the 4 body entities.
If none spare then assign world.
This function is called whenever there is a change in the connected client entities list.
============
*/
void() AssignBodies =
{
	local entity bodyque_entry;

	// get first bodyque_client (with index 0)
	score_pos_ = 0;
	bodyque_client = nextent(world);

	// loop through bodies linked list and assign client entities if possible
	bodyque_entry = first_bodyque;
	while (bodyque_entry)
	{
		if (bodyque_entry.classname_ != "body")
			FindClientBodyQue(bodyque_entry);
		bodyque_entry = bodyque_entry.owner;
	}
};

/*
============
InitBodyQue

The bodies form a linked list (in the original id code they form a ring).
Called at the start of worldspawn so that post_think is the first entity after the client entities.
============
*/
void() InitBodyQue =
{
	post_think = spawn();
	post_think.nextthink = 0.001;
	post_think.think = PostThink;

	bodyque_head = first_bodyque = spawn();
	bodyque_head.owner = spawn();
	bodyque_head.owner.owner = spawn();
	bodyque_head.owner.owner.owner = spawn();
};

/*
============
CopyToBodyQue

Called whenever the original id CopyToBodyQue was called.
============
*/
void(entity ent) CopyToBodyQue =
{
	local entity bodyque_entry;	// the entity that renders the body

	if (ent.modelindex)
	{
		// ent is using the player model
		if (bodyque_head.display_ent)
		{
			// bodyque_head is using a spare client entity (ie. bodyque_entry)
			bodyque_entry = bodyque_head.display_ent;
			bodyque_head.modelindex = 0;	// don't render bodyque_head

			// set body colors for GLQuake (ignored by normal Quake since it takes notice of .colormap below)
			WriteByte(MSG_ALL, MSG_UPDATECOLORS);
			WriteByte(MSG_ALL, bodyque_entry.score_pos);	// the index of the client entity bodyque_entry
			WriteByte(MSG_ALL, (ent.team - 1) * 17);	// GLQuake color (ent.team - 1)
			// if ent has a shirt color ent.shirt then replace this last line by
			// WriteByte(MSG_ALL, ent.shirt * 16 + (ent.team - 1));
			setorigin (bodyque_entry, ent.origin);	// just in case PostThink has already been called this frame
		}
		else
		{
			// bodyque_head doesn't have a client entity so use itself (its color won't work in GLQuake though)
			bodyque_entry = bodyque_head;
		}

		bodyque_entry.skin = ent.skin;
		bodyque_entry.modelindex = ent.modelindex;
	}
	else
	{
		// ent is not using the player model
		if (bodyque_head.display_ent)
			bodyque_head.display_ent.modelindex = 0;
		// don't render the client entity bodyque_head.display_ent
		bodyque_entry = bodyque_head;
		bodyque_entry.skin = 0;
		bodyque_entry.modelindex = ent.display_ent.modelindex;
	}

	// set bodyque_entry.model to != ""
	bodyque_entry.model = "/";
	// set body colors for normal Quake (ignored by GLQuake)
	bodyque_entry.colormap = ent.colormap;
	// copy info display info of ent
	bodyque_entry.angles = ent.angles;
	bodyque_entry.frame = ent.frame;

	// copy physics info of ent
	bodyque_head.velocity = ent.velocity;
	bodyque_head.flags = 0;
	setorigin (bodyque_head, ent.origin);
	setsize (bodyque_head, ent.mins, ent.maxs);
	bodyque_head.movetype = MOVETYPE_TOSS;

	// move along bodyque_head (note: using a linked list not a ring)
	bodyque_head = bodyque_head.owner;
	if (!bodyque_head)
		bodyque_head = first_bodyque;
};

/*
============
SkinFixConnect

Called when client connects.
Assigns client an entity which is used for its head gib or eye model.
============
*/
void(entity client) SkinFixConnect =
{
	client.classname_ = "player";
	client.display_ent = spawn();
	// set client.display_ent to != ""
	client.display_ent.model = "/";
};

/*
============
SkinFixDisConnect

Called when client disconnects.
Does garbage collection for client.display_ent.
============
*/
void(entity client) SkinFixDisConnect =
{
	// since removing client.display_ent need to copy it if it is being rendered
	if (client.display_ent.modelindex)
		CopyToBodyQue(client);

	// must garbage collect client.display_ent since a new client will have client.display_ent == world
	remove(client.display_ent);
};

/*
============
Set_modelindex_0

Called when client is not being rendered (eg. intermission or observer mode)
============
*/
void(entity client) Set_modelindex_0 =
{
	client.display_ent.modelindex = 0;
};

/*
============
Set_modelindex_player

Called after client has been given a player model.
(client.modelindex must have been set)
============
*/
void(entity client) Set_modelindex_player =
{
	if (client.display_ent.modelindex)
	{
		// client.display_ent was being rendered
		client.display_ent.modelindex = 0;	// don't render client.display_ent

		// switch to client viewport
		msg_entity = client;
		WriteByte(MSG_ONE, SVC_SETVIEWPORT);
		WriteEntity(MSG_ONE, client);
	}
};

/*
============
Set_modelindex_non_player

Called after client has been given a non-player model.
(client.modelindex must have been set)
============
*/
void(entity client) Set_modelindex_non_player =
{
	if (client.display_ent.modelindex != client.modelindex)
	{
		// client.modelindex is the desired non-player model which client.display_ent will be rendering
		client.display_ent.modelindex = client.modelindex;	// render client.display_ent

		// switch to client.display_ent viewport
		msg_entity = client;
		WriteByte(MSG_ONE, SVC_SETVIEWPORT);
		WriteEntity(MSG_ONE, client.display_ent);
	}
	client.modelindex = 0;	// don't render client
};
//Now you have to inform the compiler about the new file by putting the following line after "Defs.qc" in "Progs.src".
//"Progs.src"

//skinfix.qc		// 1998-06-21 Invalid skin and GLQuake body color workaround by Robert Field
//Some new variables will be needed to be defined in "Defs.qc".
//"Defs.src"

// 1998-06-21 Invalid skin and GLQuake body color workaround by Robert Field  start
//
// skinfix.qc
//

// protocol bytes
float SVC_SETVIEWPORT = 5;
float MSG_UPDATECOLORS = 17;

entity post_think;	// used to call PostThink every frame (after player physics),
			// and is the first entity after the client entities
entity bodyque_head;	// the next bodyque entity to be used
entity first_bodyque;	// the start of the bodyque linked list
entity bodyque_client;	// used to find a spare client entity to be used as a body
float score_pos_;	// the entity index of bodyque_client

.entity display_ent;	// the alternative display entity of a client or body
.float score_pos;	// the entity index
.string classname_; 	// used to avoid conflict with .classname, but not strictly necessary
// 1998-06-21 Invalid skin and GLQuake body color workaround by Robert Field  end