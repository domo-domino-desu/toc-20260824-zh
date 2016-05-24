// gates.asy
//  logic gates
import settings;
settings.outformat="pdf";
settings.render=0;

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../../asy/");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy/");
import jh;
cd("");

pen circuitcolor = boldcolor;
pen circuitpen = DARKPEN+squarecap+circuitcolor;


// Return an AND gate picture
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
