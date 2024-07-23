// gates.asy
//  logic gates
import settings;
settings.outformat="pdf";
settings.render=0;

// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jhnode;

pen circuitcolor = boldcolor;
pen circuitpen = DARKPEN+squarecap+circuitcolor;

// Return an AND gate path
path andgate(real wd, real ln=-1) {
  if (ln<=0) {  // default is len = same as width; believe this is ANSI
    ln = wd;
  }
  real head_factor = 0.5;  // what percent of widht is head? believe this ANSI
  pair lower_lt = (-0.5*wd,-0.5*ln);
  pair upper_lt = (-0.5*wd,0.5*ln);
  pair lower_rt = (-0.5*wd+(1-head_factor)*wd,-0.5*ln);
  pair upper_rt = (-0.5*wd+(1-head_factor)*wd,0.5*ln);
  pair far_rt = (0.5*wd,0);

  return lower_lt -- lower_rt{right}::far_rt::{left}upper_rt -- upper_lt -- cycle;
};

// Return an OR gate path
path orgate(real wd, real ln=-1) {
  if (ln<=0) {  // default is len = same as width; believe this is ANSI
    ln = wd;
  }
  real head_factor = 0.75;  // what percent of width is head? believe this ANSI
  real rear_factor = 0.25;  // what percent to indent? believe this ANSI
  pair lower_lt = (-0.5*wd,-0.5*ln);
  pair upper_lt = (-0.5*wd,0.5*ln);
  pair lower_rt = (-0.5*wd+(1-head_factor)*wd,-0.5*ln);
  pair upper_rt = (-0.5*wd+(1-head_factor)*wd,0.5*ln);
  pair far_rt = (0.5*wd,0);
  pair far_lt = (-0.5*wd+(rear_factor*wd),0);

  return lower_lt -- lower_rt{right}::far_rt--far_rt::{left}upper_rt -- upper_lt .. far_lt .. cycle;
};


// Return a NOT gate path
path[] notgate(real wd, real ln=-1) {
  if (ln<=0) {  // default is len = same as width; believe this is ANSI
    ln = wd;
  }
  real circle_factor = 0.2;  // percent of width is circle? believe this ANSI
  pair lower_lt = (-0.5*wd,-0.5*ln);
  pair upper_lt = (-0.5*wd,0.5*ln);
  pair far_rt = (0.5*wd-circle_factor*wd,0);
  pair circle_center = (0.5*wd-0.5*circle_factor*wd,0);
  path c = shift(circle_center)*scale(0.5*circle_factor*wd)*rotate(180)*unitcircle; // circle(circle_center,circle_factor*wd);

  return lower_lt -- far_rt ^^ subpath(c,0,4) ^^ far_rt -- upper_lt -- lower_lt -- upper_lt;
};



// Return a NOT gate picture
picture notgate_pic(real wd, real ln=-1) {
  if (ln<=0) {  // default is len = same as width; believe this is ANSI
    ln = wd;
  }
  picture r;  // Return this
  unitsize(r,wd,ln);
  real circle_factor = 0.2;  // percent of width is circle? believe this ANSI
  pair lower_lt = (-0.5*wd,-0.5*ln);
  pair upper_lt = (-0.5*wd,0.5*ln);
  pair far_rt = (0.5*wd-circle_factor*wd,0);
  pair circle_center = (0.5*wd-0.5*circle_factor*wd,0);
  path c = shift(circle_center)*scale(0.5*circle_factor*wd)*rotate(180)*unitcircle; // circle(circle_center,circle_factor*wd);
  filldraw(r, c, fillpen=white, drawpen=circuitpen);
  // return lower_lt -- far_rt ^^ subpath(c,0,4) ^^ far_rt -- upper_lt -- lower_lt -- upper_lt;
  path tri = lower_lt -- far_rt -- upper_lt -- cycle;
  filldraw(r, tri, fillpen=white, drawpen=circuitpen);
  return r;
};


unitsize(1cm);
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

// ............................ AND gate symbol
picture pic;
int picnum = 0;
unitsize(pic,1cm);
draw(pic,(-1,.125)--(0,.125),circuitpen);
draw(pic,(-1,-.125)--(0,-.125),circuitpen);
draw(pic,(0,0)--(1,0),circuitpen);
filldraw(pic,andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 

shipout(format("gates%02d",picnum),pic,format="pdf");


// ............................ OR gate symbol
picture pic;
int picnum = 1;
unitsize(pic,1cm);
draw(pic,(-1,.125)--(0,.125),circuitpen);
draw(pic,(-1,-.125)--(0,-.125),circuitpen);
draw(pic,(0,0)--(1,0),circuitpen);
filldraw(pic,orgate(or_gate_size),fillpen=white,drawpen=circuitpen); 

shipout(format("gates%02d",picnum),pic,format="pdf");


// ............................ NOT gate symbol
picture pic;
int picnum = 2;
unitsize(pic,1cm);
draw(pic,(-1,0)--(-0.5*or_gate_size,0),circuitpen);
draw(pic,(0.5*or_gate_size,0)--(1,0),circuitpen);
draw(pic,notgate((0.5/0.2)*not_gate_size),circuitpen); 

shipout(format("gates%02d",picnum),pic,format="pdf");


// ............................ FPGA 
picture pic;
int picnum = 3;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33, r_x=0.67;  // horiz location of p wire, q wire, r wire
real bus_ht = 3.5;  // hgt, that is, length of the bus
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,0.8*bus_ht);
path q_bus = (q_x,0) -- (q_x,0.8*bus_ht);
path r_bus = (r_x,0) -- (r_x,0.8*bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,0.8*bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,0.8*bus_ht),N);
draw(pic,r_bus, circuitpen); label(pic,"$\smash[b]{R}$",(r_x,0.8*bus_ht),N);

// top wires
draw(pic,(p_x,0.7*bus_ht)--(layer1_nots_x-0.5*not_gate_size-not_offset_x,0.7*bus_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size-not_offset_x,0.7*bus_ht)--(layer1_x,0.7*bus_ht));
  draw(pic,shift(layer1_nots_x-not_offset_x,0.7*bus_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(q_x,0.65*bus_ht)--(layer1_nots_x-0.5*not_gate_size,0.65*bus_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,0.65*bus_ht)--(layer1_x,0.65*bus_ht));
  draw(pic,shift(layer1_nots_x,0.65*bus_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(r_x,0.6*bus_ht)--(layer1_x,0.6*bus_ht));

// middle wires
draw(pic,(p_x,0.45*bus_ht)--(layer1_nots_x-0.5*not_gate_size,0.45*bus_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,0.45*bus_ht)--(layer1_x,0.45*bus_ht));
  draw(pic,shift(layer1_nots_x,0.45*bus_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(q_x,0.4*bus_ht)--(layer1_x,0.4*bus_ht));
draw(pic,(r_x,0.35*bus_ht)--(layer1_nots_x-0.5*not_gate_size,0.35*bus_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,0.35*bus_ht)--(layer1_x,0.35*bus_ht));
  draw(pic,shift(layer1_nots_x,0.35*bus_ht)*notgate(not_gate_size),circuitpen); 

// bottom wires
draw(pic,(p_x,0.2*bus_ht)--(layer1_x,0.2*bus_ht));
draw(pic,(q_x,0.15*bus_ht)--(layer1_nots_x-0.5*not_gate_size-not_offset_x,0.15*bus_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size-not_offset_x,0.15*bus_ht)--(layer1_x,0.15*bus_ht));
  draw(pic,shift(layer1_nots_x-not_offset_x,0.15*bus_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(r_x,0.1*bus_ht)--(layer1_nots_x-0.5*not_gate_size,0.1*bus_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,0.1*bus_ht)--(layer1_x,0.1*bus_ht));
  draw(pic,shift(layer1_nots_x,0.1*bus_ht)*notgate(not_gate_size),circuitpen);

// right wires
draw(pic,(layer1_x,0.65*bus_ht)--(layer2_turn_x,0.65*bus_ht)
     --(layer2_turn_x,0.45*bus_ht)--(layer2_x,0.45*bus_ht),circuitpen);
draw(pic,(layer1_x,0.4*bus_ht)--(layer2_x,0.4*bus_ht));
draw(pic,(layer1_x,0.15*bus_ht)--(layer2_turn_x,0.15*bus_ht)
     --(layer2_turn_x,0.35*bus_ht)--(layer2_x,0.35*bus_ht),circuitpen);

// final wire
draw(pic,(layer2_x,0.4*bus_ht)--(layer2_x+1.0,0.4*bus_ht));

// dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,0.7*bus_ht),solderpen);
dot(pic,(q_x,0.65*bus_ht),solderpen);
dot(pic,(r_x,0.6*bus_ht),solderpen);
dot(pic,(p_x,0.45*bus_ht),solderpen);
dot(pic,(q_x,0.4*bus_ht),solderpen);
dot(pic,(r_x,0.35*bus_ht),solderpen);
dot(pic,(p_x,0.2*bus_ht),solderpen);
dot(pic,(q_x,0.15*bus_ht),solderpen);
dot(pic,(r_x,0.1*bus_ht),solderpen);

// and gates, level 1
filldraw(pic,shift(layer1_x,0.65*bus_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,0.4*bus_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,0.15*bus_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);

// or gate, level 2
filldraw(pic,shift(layer2_x,0.4*bus_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");


// ............................ NOT gate circuit
picture pic;
unitsize(pic,1.1cm);
int picnum = 4;

// parameters
real circuit_wd = 4;  // width of circult
real circuit_ht = 2.45; // height of circuit
real tran_ht = 0.8;  // hgt of center of transistor
real tran_rad = 0.4;  // radius of circle around transistor
real tran_gap = 0.5*tran_rad;
real gbar_offset = -0.25;  // dist from center of tran circle to gbar
real g_end = -1.3;  // left side of g line
real vout_ht = tran_ht+tran_rad+0.35;  // hgt of vout line
real vout_ln = 0.3*circuit_wd;  // length of vout line
real res_ln = 0.4;       // vertical length of the resistor
real res_offset = 0.04;  // 1/2 left-to-right wiggle 
real res_bot = vout_ht+0.35;  // hgt of bottom of resistor
real bat_ln = 0.08;  // vert len of battery
real bat_ht = 0.5*(circuit_ht-bat_ln); // height of bottom of battery
real bat_top = bat_ht + bat_ln; // height of top of battery

// the various paths
pair gap_bot = (0,tran_ht-0.5*tran_gap);
pair gap_top = (0,tran_ht+0.5*tran_gap);
path spath = gap_bot -- (0,0);
path dpath = (0,res_bot) -- gap_top;
path flap = gap_bot -- (0.1,ypart(gap_top));
path gbar = (gbar_offset,tran_ht-0.1) --
               (gbar_offset,tran_ht+0.1);
path botpath = (g_end,0) -- (circuit_wd,0);
path g = (gbar_offset,tran_ht) -- (g_end,tran_ht);
path vout = (0,vout_ht) -- (vout_ln,vout_ht);
path res = (0,0) -- (-1*res_offset, 0.1*res_ln) --
              (1*res_offset, 0.3*res_ln) --
              (-1*res_offset, 0.5*res_ln) --
              (1*res_offset, 0.7*res_ln) --
              (-1*res_offset, 0.9*res_ln) --
              (0,res_ln);
path above_res = (0,res_bot+res_ln) -- (0,circuit_ht) --
                    (circuit_wd,circuit_ht);
path bat_long = (-0.2,0) -- (0.2,0);
path bat_short = (-0.15,0) -- (0.15,0);
path top_to_bat = (circuit_wd,circuit_ht) -- (circuit_wd,bat_top);
path bot_to_bat = (circuit_wd,0) -- (circuit_wd,bat_ht);
path vi_full = (g_end,0) -- (g_end,tran_ht);
path vo_full = (vout_ln,vout_ht) -- (vout_ln,0);
path vi = subpath(vi_full,0.07,0.93);
path vo = subpath(vo_full,0.04,0.96);

// draw the paths
draw(pic, circle((0,tran_ht), tran_rad), LIGHTPEN+backgroundcolor);
draw(pic, spath, circuitpen);
draw(pic, dpath, circuitpen);
draw(pic, flap, circuitpen);
filldraw(pic, circle(gap_bot,0.035),lightcolor,circuitcolor);
filldraw(pic, circle(gap_top,0.035),lightcolor,circuitcolor);
draw(pic, botpath, circuitpen);
draw(pic, gbar, circuitpen);
draw(pic, g, circuitpen);
// filldraw(pic, circle((g_end,tran_ht),0.035),white,circuitcolor);
// filldraw(pic, circle((g_end,0),0.035),white,circuitcolor);
draw(pic,vout,circuitpen);
draw(pic,shift(0,res_bot)*res,circuitpen);
draw(pic,above_res,circuitpen);
draw(pic,top_to_bat,circuitpen);
draw(pic,bot_to_bat,circuitpen);
draw(pic,shift(circuit_wd,bat_top)*bat_long,circuitpen);
draw(pic,shift(circuit_wd,bat_ht)*bat_short,circuitpen);
draw(pic,Label("$V_\text{in}$",highlightcolor),vi,W,lightcolor,
      arrow=Arrows(HookHead(barb=0.8),2));
draw(pic,Label("$V_\text{out}$",highlightcolor),vo,E,lightcolor,
      arrow=Arrows(HookHead(barb=0.8),2));

// labels
label(pic,"\tiny\textsf{D}",(0,tran_ht+tran_rad),NW);
label(pic,"\tiny\textsf{S}",(0,tran_ht-tran_rad),SW);
label(pic,"\tiny\textsf{G}",(0-tran_rad,tran_ht),NW);
label(pic,"\scriptsize\textsf{$5$ volts}",(circuit_wd,bat_ht),SE);

shipout(format("gates%02d",picnum),pic,format="pdf");





// ======== Homework answers ==============

// ............................ FPGA .............
// This picture draws the not gates by drawing a line segment to the gate,
// then the gate, then a segment from the gate.  After this, will draw
// the not gate picture as easier. 

// .............. P=R ...............
picture pic;
int picnum = 5;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33, r_x=0.67;  // horiz location of p wire, q wire, r wire
real bus_ht = 4;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,0.8*bus_ht);
path q_bus = (q_x,0) -- (q_x,0.8*bus_ht);
path r_bus = (r_x,0) -- (r_x,0.8*bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,0.8*bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,0.8*bus_ht),N);
draw(pic,r_bus, circuitpen); label(pic,"$\smash[b]{R}$",(r_x,0.8*bus_ht),N);

// top wire group
real top_gate_center_ht = 2.775;
real top_top_wire_ht = top_gate_center_ht+wire_spacing;
real top_mid_wire_ht = top_gate_center_ht;
real top_bot_wire_ht = top_gate_center_ht-wire_spacing;
draw(pic,(p_x,top_top_wire_ht)--(layer1_nots_x-0.5*not_gate_size-not_offset_x,top_top_wire_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size-not_offset_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
  draw(pic,shift(layer1_nots_x-not_offset_x,top_top_wire_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(q_x,top_mid_wire_ht)--(layer1_nots_x-0.5*not_gate_size,top_mid_wire_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,top_mid_wire_ht)--(layer1_x,top_mid_wire_ht));
  draw(pic,shift(layer1_nots_x,top_mid_wire_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(r_x,top_bot_wire_ht)--(layer1_nots_x+not_offset_x-0.5*not_gate_size,top_bot_wire_ht));
  draw(pic,(layer1_nots_x+not_gate_size,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
  draw(pic,shift(layer1_nots_x+not_offset_x,top_bot_wire_ht)*notgate(not_gate_size),circuitpen); 

// middle top wires
real mtop_gate_center_ht = 2.0;
real mtop_top_wire_ht = mtop_gate_center_ht+wire_spacing;
real mtop_mid_wire_ht = mtop_gate_center_ht;
real mtop_bot_wire_ht = mtop_gate_center_ht-wire_spacing;
draw(pic,(p_x,mtop_top_wire_ht)--(layer1_nots_x-0.5*not_gate_size,mtop_top_wire_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,mtop_top_wire_ht)--(layer1_x,mtop_top_wire_ht));
  draw(pic,shift(layer1_nots_x,mtop_top_wire_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(q_x,mtop_mid_wire_ht)--(layer1_x,mtop_mid_wire_ht));
draw(pic,(r_x,mtop_bot_wire_ht)--(layer1_nots_x-0.5*not_gate_size,mtop_bot_wire_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,mtop_bot_wire_ht)--(layer1_x,mtop_bot_wire_ht));
  draw(pic,shift(layer1_nots_x,mtop_bot_wire_ht)*notgate(not_gate_size),circuitpen); 

// middle bottom wires
real mbot_gate_center_ht = 1.225;
real mbot_top_wire_ht = mbot_gate_center_ht+wire_spacing;
real mbot_mid_wire_ht = mbot_gate_center_ht;
real mbot_bot_wire_ht = mbot_gate_center_ht-wire_spacing;
draw(pic,(p_x,mbot_top_wire_ht)--(layer1_x,mbot_top_wire_ht));
draw(pic,(q_x,mbot_mid_wire_ht)--(layer1_nots_x-0.5*not_gate_size,mbot_mid_wire_ht));
  draw(pic,(layer1_nots_x+0.5*not_gate_size,mbot_mid_wire_ht)--(layer1_x,mbot_mid_wire_ht));
  draw(pic,shift(layer1_nots_x,mbot_mid_wire_ht)*notgate(not_gate_size),circuitpen); 
draw(pic,(r_x,mbot_bot_wire_ht)--(layer1_x,mbot_bot_wire_ht));

// bottom wires
real bot_gate_center_ht = 0.45;
real bot_top_wire_ht = bot_gate_center_ht+wire_spacing;
real bot_mid_wire_ht = bot_gate_center_ht;
real bot_bot_wire_ht = bot_gate_center_ht-wire_spacing;
draw(pic,(p_x,bot_top_wire_ht)--(layer1_x,bot_top_wire_ht));
draw(pic,(q_x,bot_mid_wire_ht)--(layer1_x,bot_mid_wire_ht));
draw(pic,(r_x,bot_bot_wire_ht)--(layer1_x,bot_bot_wire_ht));

real or_center_ht = (mtop_gate_center_ht+mbot_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_mid_wire_ht)--(layer2_turn_x,top_mid_wire_ht)
     --(layer2_turn_x,or_center_ht+0.3*or_gate_size)--(layer2_x,or_center_ht+0.3*or_gate_size),circuitpen);
draw(pic,(layer1_x,mtop_mid_wire_ht)--(layer2_turn_x-0.1,mtop_mid_wire_ht)
     --(layer2_turn_x-0.1,or_center_ht+0.1*or_gate_size)--(layer2_x,or_center_ht+0.1*or_gate_size),circuitpen);
draw(pic,(layer1_x,mbot_mid_wire_ht)--(layer2_turn_x-0.1,mbot_mid_wire_ht)
     --(layer2_turn_x-0.1,or_center_ht-0.1*or_gate_size)--(layer2_x,or_center_ht-0.1*or_gate_size),circuitpen);
draw(pic,(layer1_x,bot_mid_wire_ht)--(layer2_turn_x,bot_mid_wire_ht)
     --(layer2_turn_x,or_center_ht-0.3*or_gate_size)--(layer2_x,or_center_ht-0.3*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,0.4*bus_ht)--(layer2_x+1.0,0.4*bus_ht));

// dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_mid_wire_ht),solderpen);
dot(pic,(r_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,mtop_top_wire_ht),solderpen);
dot(pic,(q_x,mtop_mid_wire_ht),solderpen);
dot(pic,(r_x,mtop_bot_wire_ht),solderpen);
dot(pic,(p_x,mbot_top_wire_ht),solderpen);
dot(pic,(q_x,mbot_mid_wire_ht),solderpen);
dot(pic,(r_x,mbot_bot_wire_ht),solderpen);
dot(pic,(p_x,bot_top_wire_ht),solderpen);
dot(pic,(q_x,bot_mid_wire_ht),solderpen);
dot(pic,(r_x,bot_bot_wire_ht),solderpen);

// and gates, level 1
filldraw(pic,shift(layer1_x,top_mid_wire_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,mtop_mid_wire_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,mbot_mid_wire_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,bot_mid_wire_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);

// or gate, level 2
filldraw(pic,shift(layer2_x,0.4*bus_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");



// .............. P XOR Q ...............
picture pic;
int picnum = 6;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33;  // horiz location of p wire, q wire, r wire
real bus_ht = 2;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 1.5;
real top_top_wire_ht = top_gate_center_ht+0.5*wire_spacing;
real top_bot_wire_ht = top_gate_center_ht-0.5*wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x-0.25,top_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,top_bot_wire_ht)*notgate_pic(not_gate_size));

// bottom wires
real bot_gate_center_ht = 0.5;
real bot_top_wire_ht = bot_gate_center_ht+0.5*wire_spacing;
real bot_bot_wire_ht = bot_gate_center_ht-0.5*wire_spacing;
draw(pic,(p_x,bot_top_wire_ht)--(layer1_x,bot_top_wire_ht));
draw(pic,(q_x,bot_bot_wire_ht)--(layer1_x,bot_bot_wire_ht));

// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,bot_top_wire_ht),solderpen);
dot(pic,(q_x,bot_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+bot_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.25*or_gate_size)--(layer2_x,or_center_ht+0.25*or_gate_size),circuitpen);
draw(pic,(layer1_x,bot_gate_center_ht)--(layer2_turn_x,bot_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.25*or_gate_size)--(layer2_x,or_center_ht-0.25*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,bot_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);


// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");





// .............. majority of inputs are T ...............
picture pic;
int picnum = 7;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33;  // horiz location of p wire, q wire, r wire
real bus_ht = 4;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);
path r_bus = (r_x,0) -- (r_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,bus_ht),N);
draw(pic,r_bus, circuitpen); label(pic,"$\smash[b]{R}$",(r_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 3.5;
real top_top_wire_ht = top_gate_center_ht+wire_spacing;
real top_mid_wire_ht = top_gate_center_ht;
real top_bot_wire_ht = top_gate_center_ht-wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_mid_wire_ht)--(layer1_x,top_mid_wire_ht));
draw(pic, (r_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,top_top_wire_ht)*notgate_pic(not_gate_size));

// second wire group
real sec_gate_center_ht = 2.5;
real sec_top_wire_ht = sec_gate_center_ht+wire_spacing;
real sec_mid_wire_ht = sec_gate_center_ht;
real sec_bot_wire_ht = sec_gate_center_ht-wire_spacing;
draw(pic, (p_x,sec_top_wire_ht)--(layer1_x,sec_top_wire_ht));
draw(pic, (q_x,sec_mid_wire_ht)--(layer1_x,sec_mid_wire_ht));
draw(pic, (r_x,sec_bot_wire_ht)--(layer1_x,sec_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,sec_mid_wire_ht)*notgate_pic(not_gate_size));

// third wire group
real trd_gate_center_ht = 1.5;
real trd_top_wire_ht = trd_gate_center_ht+wire_spacing;
real trd_mid_wire_ht = trd_gate_center_ht;
real trd_bot_wire_ht = trd_gate_center_ht-wire_spacing;
draw(pic, (p_x,trd_top_wire_ht)--(layer1_x,trd_top_wire_ht));
draw(pic, (q_x,trd_mid_wire_ht)--(layer1_x,trd_mid_wire_ht));
draw(pic, (r_x,trd_bot_wire_ht)--(layer1_x,trd_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,trd_bot_wire_ht)*notgate_pic(not_gate_size));

// fourth (bottom) wire group
real frt_gate_center_ht = 0.5;
real frt_top_wire_ht = frt_gate_center_ht+wire_spacing;
real frt_mid_wire_ht = frt_gate_center_ht;
real frt_bot_wire_ht = frt_gate_center_ht-wire_spacing;
draw(pic, (p_x,frt_top_wire_ht)--(layer1_x,frt_top_wire_ht));
draw(pic, (q_x,frt_mid_wire_ht)--(layer1_x,frt_mid_wire_ht));
draw(pic, (r_x,frt_bot_wire_ht)--(layer1_x,frt_bot_wire_ht));
// no not gates

// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_mid_wire_ht),solderpen);
dot(pic,(r_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,sec_top_wire_ht),solderpen);
dot(pic,(q_x,sec_mid_wire_ht),solderpen);
dot(pic,(r_x,sec_bot_wire_ht),solderpen);
dot(pic,(p_x,trd_top_wire_ht),solderpen);
dot(pic,(q_x,trd_mid_wire_ht),solderpen);
dot(pic,(r_x,trd_bot_wire_ht),solderpen);
dot(pic,(p_x,frt_top_wire_ht),solderpen);
dot(pic,(q_x,frt_mid_wire_ht),solderpen);
dot(pic,(r_x,frt_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+frt_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.30*or_gate_size)--(layer2_x,or_center_ht+0.30*or_gate_size),circuitpen);
draw(pic,(layer1_x,sec_gate_center_ht)--(layer2_turn_x-0.1,sec_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht+0.10*or_gate_size)--(layer2_x,or_center_ht+0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,trd_gate_center_ht)--(layer2_turn_x-0.1,trd_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht-0.10*or_gate_size)--(layer2_x,or_center_ht-0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,frt_gate_center_ht)--(layer2_turn_x,frt_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.30*or_gate_size)--(layer2_x,or_center_ht-0.30*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,sec_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,trd_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,frt_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);


// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");



// .............. Q circuit ...............
picture pic;
int picnum = 8;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33;  // horiz location of p wire, q wire, r wire
real bus_ht = 2;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 1.5;
real top_top_wire_ht = top_gate_center_ht+0.5*wire_spacing;
real top_bot_wire_ht = top_gate_center_ht-0.5*wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,top_top_wire_ht)*notgate_pic(not_gate_size));

// bottom wires
real bot_gate_center_ht = 0.5;
real bot_top_wire_ht = bot_gate_center_ht+0.5*wire_spacing;
real bot_bot_wire_ht = bot_gate_center_ht-0.5*wire_spacing;
draw(pic,(p_x,bot_top_wire_ht)--(layer1_x,bot_top_wire_ht));
draw(pic,(q_x,bot_bot_wire_ht)--(layer1_x,bot_bot_wire_ht));

// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,bot_top_wire_ht),solderpen);
dot(pic,(q_x,bot_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+bot_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.25*or_gate_size)--(layer2_x,or_center_ht+0.25*or_gate_size),circuitpen);
draw(pic,(layer1_x,bot_gate_center_ht)--(layer2_turn_x,bot_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.25*or_gate_size)--(layer2_x,or_center_ht-0.25*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,bot_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);


// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");





// .............. pair of tables; first table ...............
picture pic;
int picnum = 9;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33, r_x=0.67;  // horiz location of p wire, q wire, r wire
real bus_ht = 3;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);
path r_bus = (r_x,0) -- (r_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,bus_ht),N);
draw(pic,r_bus, circuitpen); label(pic,"$\smash[b]{R}$",(r_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 2.5;
real top_top_wire_ht = top_gate_center_ht+wire_spacing;
real top_mid_wire_ht = top_gate_center_ht;
real top_bot_wire_ht = top_gate_center_ht-wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_mid_wire_ht)--(layer1_x,top_mid_wire_ht));
draw(pic, (r_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x-0.5*not_gate_size,top_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,top_mid_wire_ht)*notgate_pic(not_gate_size));

// second wire group
real sec_gate_center_ht = 1.5;
real sec_top_wire_ht = sec_gate_center_ht+wire_spacing;
real sec_mid_wire_ht = sec_gate_center_ht;
real sec_bot_wire_ht = sec_gate_center_ht-wire_spacing;
draw(pic, (p_x,sec_top_wire_ht)--(layer1_x,sec_top_wire_ht));
draw(pic, (q_x,sec_mid_wire_ht)--(layer1_x,sec_mid_wire_ht));
draw(pic, (r_x,sec_bot_wire_ht)--(layer1_x,sec_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,sec_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,sec_bot_wire_ht)*notgate_pic(not_gate_size));

// third wire group
real trd_gate_center_ht = 0.5;
real trd_top_wire_ht = trd_gate_center_ht+wire_spacing;
real trd_mid_wire_ht = trd_gate_center_ht;
real trd_bot_wire_ht = trd_gate_center_ht-wire_spacing;
draw(pic, (p_x,trd_top_wire_ht)--(layer1_x,trd_top_wire_ht));
draw(pic, (q_x,trd_mid_wire_ht)--(layer1_x,trd_mid_wire_ht));
draw(pic, (r_x,trd_bot_wire_ht)--(layer1_x,trd_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,trd_mid_wire_ht)*notgate_pic(not_gate_size));

// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_mid_wire_ht),solderpen);
dot(pic,(r_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,sec_top_wire_ht),solderpen);
dot(pic,(q_x,sec_mid_wire_ht),solderpen);
dot(pic,(r_x,sec_bot_wire_ht),solderpen);
dot(pic,(p_x,trd_top_wire_ht),solderpen);
dot(pic,(q_x,trd_mid_wire_ht),solderpen);
dot(pic,(r_x,trd_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+frt_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.30*or_gate_size)--(layer2_x,or_center_ht+0.30*or_gate_size),circuitpen);
draw(pic,(layer1_x,sec_gate_center_ht)--(layer2_x,or_center_ht),circuitpen);
draw(pic,(layer1_x,trd_gate_center_ht)--(layer2_turn_x,trd_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.30*or_gate_size)--(layer2_x,or_center_ht-0.30*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,sec_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,trd_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,frt_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);

// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");




// .............. pair of tables; second table ...............
picture pic;
int picnum = 10;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33, r_x=0.67;  // horiz location of p wire, q wire, r wire
real bus_ht = 4;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);
path r_bus = (r_x,0) -- (r_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,bus_ht),N);
draw(pic,r_bus, circuitpen); label(pic,"$\smash[b]{R}$",(r_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 3.5;
real top_top_wire_ht = top_gate_center_ht+wire_spacing;
real top_mid_wire_ht = top_gate_center_ht;
real top_bot_wire_ht = top_gate_center_ht-wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_mid_wire_ht)--(layer1_x,top_mid_wire_ht));
draw(pic, (r_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x-0.5*not_gate_size,top_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,top_mid_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x+0.5*not_gate_size,top_bot_wire_ht)*notgate_pic(not_gate_size));

// second wire group
real sec_gate_center_ht = 2.5;
real sec_top_wire_ht = sec_gate_center_ht+wire_spacing;
real sec_mid_wire_ht = sec_gate_center_ht;
real sec_bot_wire_ht = sec_gate_center_ht-wire_spacing;
draw(pic, (p_x,sec_top_wire_ht)--(layer1_x,sec_top_wire_ht));
draw(pic, (q_x,sec_mid_wire_ht)--(layer1_x,sec_mid_wire_ht));
draw(pic, (r_x,sec_bot_wire_ht)--(layer1_x,sec_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,sec_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,sec_bot_wire_ht)*notgate_pic(not_gate_size));

// third wire group
real trd_gate_center_ht = 1.5;
real trd_top_wire_ht = trd_gate_center_ht+wire_spacing;
real trd_mid_wire_ht = trd_gate_center_ht;
real trd_bot_wire_ht = trd_gate_center_ht-wire_spacing;
draw(pic, (p_x,trd_top_wire_ht)--(layer1_x,trd_top_wire_ht));
draw(pic, (q_x,trd_mid_wire_ht)--(layer1_x,trd_mid_wire_ht));
draw(pic, (r_x,trd_bot_wire_ht)--(layer1_x,trd_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,trd_bot_wire_ht)*notgate_pic(not_gate_size));

// fourth wire group
real frt_gate_center_ht = 0.5;
real frt_top_wire_ht = frt_gate_center_ht+wire_spacing;
real frt_mid_wire_ht = frt_gate_center_ht;
real frt_bot_wire_ht = frt_gate_center_ht-wire_spacing;
draw(pic, (p_x,frt_top_wire_ht)--(layer1_x,frt_top_wire_ht));
draw(pic, (q_x,frt_mid_wire_ht)--(layer1_x,frt_mid_wire_ht));
draw(pic, (r_x,frt_bot_wire_ht)--(layer1_x,frt_bot_wire_ht));
// not gates
// add(pic,shift(layer1_nots_x,trd_mid_wire_ht)*notgate_pic(not_gate_size));

// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_mid_wire_ht),solderpen);
dot(pic,(r_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,sec_top_wire_ht),solderpen);
dot(pic,(q_x,sec_mid_wire_ht),solderpen);
dot(pic,(r_x,sec_bot_wire_ht),solderpen);
dot(pic,(p_x,trd_top_wire_ht),solderpen);
dot(pic,(q_x,trd_mid_wire_ht),solderpen);
dot(pic,(r_x,trd_bot_wire_ht),solderpen);
dot(pic,(p_x,frt_top_wire_ht),solderpen);
dot(pic,(q_x,frt_mid_wire_ht),solderpen);
dot(pic,(r_x,frt_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+frt_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.30*or_gate_size)--(layer2_x,or_center_ht+0.30*or_gate_size),circuitpen);
draw(pic,(layer1_x,sec_gate_center_ht)--(layer2_turn_x-0.1,sec_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht+0.10*or_gate_size)--(layer2_x,or_center_ht+0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,trd_gate_center_ht)--(layer2_turn_x-0.1,trd_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht-0.10*or_gate_size)--(layer2_x,or_center_ht-0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,frt_gate_center_ht)--(layer2_turn_x,frt_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.30*or_gate_size)--(layer2_x,or_center_ht-0.30*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,sec_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,trd_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,frt_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);

// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");



// .............. `implies' circuit ...............
picture pic;
int picnum = 11;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33;  // horiz location of p wire, q wire, r wire
real bus_ht = 3;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{P}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(q_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 2.5;
real top_top_wire_ht = top_gate_center_ht+0.5*wire_spacing;
real top_bot_wire_ht = top_gate_center_ht-0.5*wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x-0.5*not_gate_size,top_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,top_bot_wire_ht)*notgate_pic(not_gate_size));

// second wires
real sec_gate_center_ht = 1.5;
real sec_top_wire_ht = sec_gate_center_ht+0.5*wire_spacing;
real sec_bot_wire_ht = sec_gate_center_ht-0.5*wire_spacing;
draw(pic,(p_x,sec_top_wire_ht)--(layer1_x,sec_top_wire_ht));
draw(pic,(q_x,sec_bot_wire_ht)--(layer1_x,sec_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,sec_top_wire_ht)*notgate_pic(not_gate_size));

// third wires
real trd_gate_center_ht = 0.5;
real trd_top_wire_ht = trd_gate_center_ht+0.5*wire_spacing;
real trd_bot_wire_ht = trd_gate_center_ht-0.5*wire_spacing;
draw(pic,(p_x,bot_top_wire_ht)--(layer1_x,bot_top_wire_ht));
draw(pic,(q_x,bot_bot_wire_ht)--(layer1_x,bot_bot_wire_ht));

// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,sec_top_wire_ht),solderpen);
dot(pic,(q_x,sec_bot_wire_ht),solderpen);
dot(pic,(p_x,trd_top_wire_ht),solderpen);
dot(pic,(q_x,trd_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+trd_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.25*or_gate_size)--(layer2_x,or_center_ht+0.25*or_gate_size),circuitpen);
draw(pic,(layer1_x,sec_gate_center_ht)--(layer2_x,or_center_ht),circuitpen);
draw(pic,(layer1_x,trd_gate_center_ht)--(layer2_turn_x,trd_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.25*or_gate_size)--(layer2_x,or_center_ht-0.25*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,sec_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,trd_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);

// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");



// .............. `full adder' circuit ...............
picture pic;
int picnum = 12;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33, r_x=0.67;  // horiz location of p wire, q wire, r wire
real bus_ht = 4;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);
path r_bus = (r_x,0) -- (r_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{I}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{P}$",(q_x,bus_ht),N);
draw(pic,r_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(r_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 3.5;
real top_top_wire_ht = top_gate_center_ht+wire_spacing;
real top_mid_wire_ht = top_gate_center_ht;
real top_bot_wire_ht = top_gate_center_ht-wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_mid_wire_ht)--(layer1_x,top_mid_wire_ht));
draw(pic, (r_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x-0.5*not_gate_size,top_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,top_mid_wire_ht)*notgate_pic(not_gate_size));

// second wire group
real sec_gate_center_ht = 2.5;
real sec_top_wire_ht = sec_gate_center_ht+wire_spacing;
real sec_mid_wire_ht = sec_gate_center_ht;
real sec_bot_wire_ht = sec_gate_center_ht-wire_spacing;
draw(pic, (p_x,sec_top_wire_ht)--(layer1_x,sec_top_wire_ht));
draw(pic, (q_x,sec_mid_wire_ht)--(layer1_x,sec_mid_wire_ht));
draw(pic, (r_x,sec_bot_wire_ht)--(layer1_x,sec_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,sec_top_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,sec_bot_wire_ht)*notgate_pic(not_gate_size));

// third wire group
real trd_gate_center_ht = 1.5;
real trd_top_wire_ht = trd_gate_center_ht+wire_spacing;
real trd_mid_wire_ht = trd_gate_center_ht;
real trd_bot_wire_ht = trd_gate_center_ht-wire_spacing;
draw(pic, (p_x,trd_top_wire_ht)--(layer1_x,trd_top_wire_ht));
draw(pic, (q_x,trd_mid_wire_ht)--(layer1_x,trd_mid_wire_ht));
draw(pic, (r_x,trd_bot_wire_ht)--(layer1_x,trd_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x-0.5*not_gate_size,trd_mid_wire_ht)*notgate_pic(not_gate_size));
add(pic,shift(layer1_nots_x,trd_bot_wire_ht)*notgate_pic(not_gate_size));

// fourth wire group
real frt_gate_center_ht = 0.5;
real frt_top_wire_ht = frt_gate_center_ht+wire_spacing;
real frt_mid_wire_ht = frt_gate_center_ht;
real frt_bot_wire_ht = frt_gate_center_ht-wire_spacing;
draw(pic, (p_x,frt_top_wire_ht)--(layer1_x,frt_top_wire_ht));
draw(pic, (q_x,frt_mid_wire_ht)--(layer1_x,frt_mid_wire_ht));
draw(pic, (r_x,frt_bot_wire_ht)--(layer1_x,frt_bot_wire_ht));
// no not gates


// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_mid_wire_ht),solderpen);
dot(pic,(r_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,sec_top_wire_ht),solderpen);
dot(pic,(q_x,sec_mid_wire_ht),solderpen);
dot(pic,(r_x,sec_bot_wire_ht),solderpen);
dot(pic,(p_x,trd_top_wire_ht),solderpen);
dot(pic,(q_x,trd_mid_wire_ht),solderpen);
dot(pic,(r_x,trd_bot_wire_ht),solderpen);
dot(pic,(p_x,frt_top_wire_ht),solderpen);
dot(pic,(q_x,frt_mid_wire_ht),solderpen);
dot(pic,(r_x,frt_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+frt_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.30*or_gate_size)--(layer2_x,or_center_ht+0.30*or_gate_size),circuitpen);
draw(pic,(layer1_x,sec_gate_center_ht)--(layer2_turn_x-0.1,sec_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht+0.10*or_gate_size)--(layer2_x,or_center_ht+0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,trd_gate_center_ht)--(layer2_turn_x-0.1,trd_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht-0.10*or_gate_size)--(layer2_x,or_center_ht-0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,frt_gate_center_ht)--(layer2_turn_x,frt_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.30*or_gate_size)--(layer2_x,or_center_ht-0.30*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));
label(pic,"$\smash[b]{L}$",(layer2_x+1.0,or_center_ht),N);

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,sec_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,trd_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,frt_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);

// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");



// .............. `carry' circuit ...............
picture pic;
int picnum = 13;
unitsize(pic,1cm);

// bus
real p_x=0, q_x=0.33, r_x=0.67;  // horiz location of p wire, q wire, r wire
real bus_ht = 4;  // hgt, that is, length of the bus
real wire_spacing = 0.175;  // how far apart are the three wires
real layer1_x = 2.5;  // where are the layer1 gates, horizontally?
real layer1_nots_x = 0.65*layer1_x;  // the not's before them?
real layer2_x = 4.5;  // where are the layer2 gates, horizontally?
real layer2_nots_x = 0.75*layer2_x;  // the not's before them?
real layer2_turn_x = 0.80*layer2_x;  // the not's before them?
real not_offset_x = 0.15; // horiz difference between adjacent not's 
real and_gate_size = 0.5;
real or_gate_size = and_gate_size;
real not_gate_size = 0.2;

path p_bus = (p_x,0) -- (p_x,bus_ht);
path q_bus = (q_x,0) -- (q_x,bus_ht);
path r_bus = (r_x,0) -- (r_x,bus_ht);

draw(pic,p_bus, circuitpen); label(pic,"$\smash[b]{I}$",(p_x,bus_ht),N);
draw(pic,q_bus, circuitpen); label(pic,"$\smash[b]{P}$",(q_x,bus_ht),N);
draw(pic,r_bus, circuitpen); label(pic,"$\smash[b]{Q}$",(r_x,bus_ht),N);

// top wire group
real top_gate_center_ht = 3.5;
real top_top_wire_ht = top_gate_center_ht+wire_spacing;
real top_mid_wire_ht = top_gate_center_ht;
real top_bot_wire_ht = top_gate_center_ht-wire_spacing;
draw(pic, (p_x,top_top_wire_ht)--(layer1_x,top_top_wire_ht));
draw(pic, (q_x,top_mid_wire_ht)--(layer1_x,top_mid_wire_ht));
draw(pic, (r_x,top_bot_wire_ht)--(layer1_x,top_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,top_top_wire_ht)*notgate_pic(not_gate_size));

// second wire group
real sec_gate_center_ht = 2.5;
real sec_top_wire_ht = sec_gate_center_ht+wire_spacing;
real sec_mid_wire_ht = sec_gate_center_ht;
real sec_bot_wire_ht = sec_gate_center_ht-wire_spacing;
draw(pic, (p_x,sec_top_wire_ht)--(layer1_x,sec_top_wire_ht));
draw(pic, (q_x,sec_mid_wire_ht)--(layer1_x,sec_mid_wire_ht));
draw(pic, (r_x,sec_bot_wire_ht)--(layer1_x,sec_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,sec_mid_wire_ht)*notgate_pic(not_gate_size));

// third wire group
real trd_gate_center_ht = 1.5;
real trd_top_wire_ht = trd_gate_center_ht+wire_spacing;
real trd_mid_wire_ht = trd_gate_center_ht;
real trd_bot_wire_ht = trd_gate_center_ht-wire_spacing;
draw(pic, (p_x,trd_top_wire_ht)--(layer1_x,trd_top_wire_ht));
draw(pic, (q_x,trd_mid_wire_ht)--(layer1_x,trd_mid_wire_ht));
draw(pic, (r_x,trd_bot_wire_ht)--(layer1_x,trd_bot_wire_ht));
// not gates
add(pic,shift(layer1_nots_x,trd_bot_wire_ht)*notgate_pic(not_gate_size));

// fourth wire group
real frt_gate_center_ht = 0.5;
real frt_top_wire_ht = frt_gate_center_ht+wire_spacing;
real frt_mid_wire_ht = frt_gate_center_ht;
real frt_bot_wire_ht = frt_gate_center_ht-wire_spacing;
draw(pic, (p_x,frt_top_wire_ht)--(layer1_x,frt_top_wire_ht));
draw(pic, (q_x,frt_mid_wire_ht)--(layer1_x,frt_mid_wire_ht));
draw(pic, (r_x,frt_bot_wire_ht)--(layer1_x,frt_bot_wire_ht));
// no not gates

// solder dots
pen solderpen = linewidth(2pt); 
dot(pic,(p_x,top_top_wire_ht),solderpen);
dot(pic,(q_x,top_mid_wire_ht),solderpen);
dot(pic,(r_x,top_bot_wire_ht),solderpen);
dot(pic,(p_x,sec_top_wire_ht),solderpen);
dot(pic,(q_x,sec_mid_wire_ht),solderpen);
dot(pic,(r_x,sec_bot_wire_ht),solderpen);
dot(pic,(p_x,trd_top_wire_ht),solderpen);
dot(pic,(q_x,trd_mid_wire_ht),solderpen);
dot(pic,(r_x,trd_bot_wire_ht),solderpen);
dot(pic,(p_x,frt_top_wire_ht),solderpen);
dot(pic,(q_x,frt_mid_wire_ht),solderpen);
dot(pic,(r_x,frt_bot_wire_ht),solderpen);

// .... level 2 ...
real or_center_ht = (top_gate_center_ht+frt_gate_center_ht)/2;

// right wires
draw(pic,(layer1_x,top_gate_center_ht)--(layer2_turn_x,top_gate_center_ht)
     --(layer2_turn_x,or_center_ht+0.30*or_gate_size)--(layer2_x,or_center_ht+0.30*or_gate_size),circuitpen);
draw(pic,(layer1_x,sec_gate_center_ht)--(layer2_turn_x-0.1,sec_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht+0.10*or_gate_size)--(layer2_x,or_center_ht+0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,trd_gate_center_ht)--(layer2_turn_x-0.1,trd_gate_center_ht)
     --(layer2_turn_x-0.1,or_center_ht-0.10*or_gate_size)--(layer2_x,or_center_ht-0.10*or_gate_size),circuitpen);
draw(pic,(layer1_x,frt_gate_center_ht)--(layer2_turn_x,frt_gate_center_ht)
     --(layer2_turn_x,or_center_ht-0.30*or_gate_size)--(layer2_x,or_center_ht-0.30*or_gate_size),circuitpen);

// final wire
draw(pic,(layer2_x,or_center_ht)--(layer2_x+1.0,or_center_ht));
label(pic,"$\smash[b]{C}$",(layer2_x+1.0,or_center_ht),N);

// Draw gates after wires so filldraw covers wire stubs

// and gates, level 1
filldraw(pic,shift(layer1_x,top_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen); 
filldraw(pic,shift(layer1_x,sec_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,trd_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);
filldraw(pic,shift(layer1_x,frt_gate_center_ht)*andgate(and_gate_size),fillpen=white,drawpen=circuitpen);

// or gate, level 2
filldraw(pic,shift(layer2_x,or_center_ht)*orgate(or_gate_size),fillpen=white,drawpen=circuitpen);

shipout(format("gates%02d",picnum),pic,format="pdf");

