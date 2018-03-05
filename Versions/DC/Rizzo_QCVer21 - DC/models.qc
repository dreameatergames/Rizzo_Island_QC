
/*
===============================================================================

WORLD WEAPONS

===============================================================================
*/

$modelname g_shot
$cd id1/models/g_shot
$origin 0 0 -24
$flags 8		// client side rotate
$base base
$skin skin
$frame shot1


$modelname g_nail
$cd id1/models/g_nail
$flags 8		// client side rotate
$origin 0 0 -24
$base base
$skin skin
$frame shot1


$modelname g_nail2
$cd id1/models/g_nail2
$flags 8		// client side rotate
$origin 0 0 -24
$base base
$skin skin
$frame shot2


$modelname g_rock
$cd id1/models/g_rock
$flags 8		// client side rotate
$origin 0 0 -24
$base base
$skin skin
$frame shot1


$modelname g_rock2
$cd id1/models/g_rock2
$flags 8		// client side rotate
$origin 0 0 -24
$base base
$skin skin
$frame shot1

$modelname g_light
$cd id1/models/g_light
$flags 8		// client side rotate
$origin 0 0 -24
$base base
$skin skin
$frame shot1

/*
===============================================================================

VIEW WEAPONS

===============================================================================
*/

$modelname v_axe
$cd id1/models/v_axe
$origin 0 5 54
$base base
$skin skin
$frame frame1 frame2 frame3 frame4 frame5 frame6 frame7 frame8 frame9


$modelname v_shot
$cd id1/models/v_shot
$origin 0 0 54
$base base
$skin skin
$frame shot1 shot2 shot3 shot4 shot5 shot6 shot7


$modelname v_shot2
$cd id1/models/v_shot2
$origin 0 0 56
$base base
$skin skin
$frame shot1 shot2 shot3 shot4 shot5 shot6 shot7


$modelname v_rock2
$cd id1/models/v_rock2
$origin 0 0 54
$base base
$skin skin
$frame shot1 shot2 shot3 shot4 shot5 shot6 shot6


$modelname v_rock
$cd id1/models/v_rock
$origin 0 0 54
$base base
$skin skin
$frame shot1 shot2 shot3 shot4 shot5 shot6 shot7


$modelname v_nail2
$cd id1/models/v_nail2
$origin 0 0 54
$base base
$skin skin
$frame shot1 shot2 shot3 shot4 shot5 shot6 shot7 shot8 shot9


$modelname v_nail
$cd id1/models/v_nail
$origin 0 0 54
$base base
$skin skin
$frame shot1 shot2 shot3 shot4 shot5 shot6 shot7 shot8 shot9

$modelname v_light
$cd id1/models/v_light
$origin 0 0 54
$base base
$skin skin
$frame shot1 shot2 shot3 shot4 shot5


/*
===============================================================================

ITEMS

===============================================================================
*/

$modelname w_g_key
$cd id1/models/w_g_key
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname w_s_key
$cd id1/models/w_s_key
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname m_g_key
$cd id1/models/m_g_key
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname m_s_key
$cd id1/models/m_s_key
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname b_g_key
$cd id1/models/b_g_key
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname b_s_key
$cd id1/models/b_s_key
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1


$modelname cube
$cd id1/models/cube
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname suit
$cd id1/models/suit
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname boots
$cd id1/models/boots
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname end1
$cd id1/models/end1
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname end2
$cd id1/models/end2
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname end3
$cd id1/models/end3
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1

$modelname end4
$cd id1/models/end4
$flags 8		// client side rotate
$base base
$skin skin
$frame frame1


/*
===============================================================================

GIBS

===============================================================================
*/

$modelname gib1
$cd id1/models/gib1
$flags 4		// EF_GIB
$origin 0 0 0
$base base
$skin skin
$frame frame1


// torso
$modelname gib2
$cd id1/models/gib2
$flags 4		// EF_GIB
$origin 0 0 0
$base base
$skin skin
$frame frame1

$modelname gib3
$cd id1/models/gib3
$flags 4		// EF_GIB
$origin 0 0 0
$base base
$skin skin
$frame frame1

// heads

$modelname h_player
$cd id1/models/h_player
$flags 4		// EF_GIB
$origin 0 0 0
$base base
$skin skin
$frame frame1

/*
===============================================================================

MISC

===============================================================================
*/

$modelname armor
$cd id1/models/armor
$flags 8		// client side rotate
$origin 0 0 -8
$base base
$skin skin
$skin skin2
$skin skin3
$frame armor

$modelname s_light			// shambler lightning ready
$cd id1/models/s_light
$origin 0 0 24
$base base
$skin skin
$frame	frame1 frame2 frame3

$modelname bolt3			// lightning towar bolts
$cd id1/models/bolt2
$origin 0 0 0
$base base
$scale 4
$skin skin
$frame	light

$modelname bolt2
$cd id1/models/bolt2
$origin 0 0 0
$base base
$skin skin
$frame	light

$modelname bolt
$cd id1/models/bolt
$origin 0 0 0
$base light
$skin light
$frame	light

$modelname laser
$cd id1/models/laser
$base base
$skin skin
$scale 2
$frame frame1

$modelname flame		// with torch
$cd id1/models/flame
$origin 0 0 12
$base base
$skin skin
$framegroupstart
$frame flame1	0.1
$frame flame2	0.1
$frame flame3	0.1
$frame flame4	0.1
$frame flame5	0.1
$frame flame6	0.1
$framegroupend

$modelname flame2		// standing flame, no torch
$cd id1/models/flame2
$origin 0 0 12
$base base
$skin skin
$framegroupstart
$frame flame1	0.1
$frame flame2	0.1
$frame flame3	0.1
$frame flame4	0.1
$frame flame5	0.1
$frame flame6	0.1
$framegroupend
$framegroupstart
$frame flameb1
$frame flameb2
$frame flameb3
$frame flameb4
$frame flameb5
$frame flameb6
$frame flameb7
$frame flameb8
$frame flameb9
$frame flameb10
$frame flameb11
$framegroupend

$modelname eyes
$cd id1/models/eyes
$origin 0 0 -24
$base base
$skin skin
$frame frame1

$modelname spike
$cd id1/models/spike
$origin 0 0 0
$base spike
$skin skin
$frame spike

$modelname s_spike
$cd id1/models/s_spike
$origin 0 0 0
$base spike
$skin skin
$frame spike

$modelname teleport
$cd id1/models/teleport
$origin 0 0 24
$base base
$skin skin
$frame frame1

