// tape.asy
//  draw tape, as for a turing machine, and include text and tape head

import settings;
settings.outformat="pdf";
settings.render=0;

import jh;
import settexpreamble;
settexpreamble();
defaultpen(fontsize(8pt));

unitsize(1pt);

pen TAPE_PEN=linewidth(.4pt)+squarecap+miterjoin+fontsize(8pt)+black;
real TAPE_WIDTH=10pt;
real DEFAULT_TAPE_LENGTH = 200pt;

real TAPE_CELL_WIDTH = 6;  // too wide makes it hard to spot spaces

// write the string to the tape, with character i at position x=i (positions
// start counting at x=0)
void tape_write(picture p, string s) {
  for(int i=0; i < length(s); ++i) {
    draw(p,Label("\makebox[0em]{\texttt{"+substr(s,i,1)+"}}", TAPE_PEN), (TAPE_CELL_WIDTH*i,10*0.25), align=Align, invisible);
  }
}

// tape_contents
// write tape contents to a picture and return the length of the picture
// (this enables us to measure the bounding box)
real tape_contents_length(string s) {
  picture p;
  unitsize(p,1pt);
  tape_write(p,s);
  real length = max(p,user=true).x-min(p,user=true).x;
  return(length);
}


// return the path that is the wiggle at the end of the tape, where the
// bottom of the wiggle is at the point bottom
path tape_end_path(pair bottom) {
  pair tape_end_top=(0,TAPE_WIDTH);
  pair tape_end_bot=(0,0);
  path tape_end=tape_end_top
    ..(-0.1*TAPE_WIDTH,(2/3)*TAPE_WIDTH)
    ..(0.1*TAPE_WIDTH,(1/3)*TAPE_WIDTH)
    ..tape_end_bot;
  return shift(bottom)*tape_end;
}

real TAPE_PADDING = 12pt;  // pad the ends with blank space (make at least half the head width)
// draw the outline of the tape, including the ends
path tape_path(real tape_length=DEFAULT_TAPE_LENGTH) {
  path tape=(-TAPE_PADDING,0)--(tape_length+TAPE_PADDING,0)
    ..reverse(tape_end_path((tape_length+TAPE_PADDING,0)))
    --(-TAPE_PADDING,TAPE_WIDTH)..tape_end_path((-TAPE_PADDING,0))..cycle;
  return tape;
}

// draw the tape read/write head pointing to position x-location and
// containing the state (e.g., "q_3")
real TAPE_HEAD_X = 14pt; // how far tape head extends left-right
real TAPE_HEAD_Y = 12pt; // how far up-down
void draw_tape_head(picture p, real location, string state="") {
  path tape_head=(0,0)--(0.5*TAPE_HEAD_X,-0.25*TAPE_HEAD_Y)
    --(0.5*TAPE_HEAD_X,-1*TAPE_HEAD_Y)--(-0.5*TAPE_HEAD_X,-1*TAPE_HEAD_Y)
    --(-0.5*TAPE_HEAD_X,-0.25*TAPE_HEAD_Y)--cycle;
  path shifted_tape_head=shift(location*TAPE_CELL_WIDTH,-0.5pt)*tape_head;
  fill(p,shifted_tape_head,verylight_color);
  draw(p, Label("\makebox[0em]{"+state+"}", TAPE_PEN+black),shifted_tape_head,align=N,TAPE_PEN+linewidth(0.4pt)+light_color);
}

// draw the tape and the head
// p  picture to which to draw
// s  string written to the tape
// head_pos  real number (prob nat num) position for the tape head
// head_label string written to tape head (you may want to enclose in $'s)
void tape_draw(picture p, string s, real head_pos, string head_label="", real tape_length=DEFAULT_TAPE_LENGTH) {
  filldraw(p, tape_path(tape_length),drawpen=TAPE_PEN+light_color,fillpen=verylight_color);
  tape_write(p,s);
  draw_tape_head(p,head_pos,head_label);
}

// Output the tape
//  fn_prefix string  prefix of the file name (suffix is by file type)
//  s  string  String written to the tape
//  head_pos  integer  Left-right position of the ehad, starting at 0
//  head_label  string  string to put on the head
void tape_output(string fn_prefix, string s, real head_pos, string head_label="") {
  picture p;
  unitsize(p,1pt);
  real tape_length = tape_contents_length(s);
  tape_draw(p,s,head_pos,head_label,tape_length);
  shipout(fn_prefix,p);
}

// tape_output("tape1","101",0,"$q_0$");
// tape_output("tape2","101",1,"$q_2$");
// tape_output("tape3","101",2,"$q_1$");

// ======= STACK ROUTINES ==============

real STACK_LENGTH=100pt;
real STACK_WIDTH=TAPE_WIDTH;
path stack_path(real stack_length=STACK_LENGTH) {
  path stack=(0pt,0pt)--(stack_length,0pt)
    --(stack_length,STACK_WIDTH)--(0pt,STACK_WIDTH)--cycle;
  return stack;
}


// write the string to the stack, with character i at position x=i (positions
// start counting at x=0)
void stack_write(picture p, string[] S) {
  for(int i=0; i < S.length; ++i) {
    draw(p,Label("\smash{\makebox[0em]{"+S[i]+"}}", black), ((12*i)*1pt,10*0.25), align=Align, invisible);
  }
  dot(p,(-5pt,0),invisible);  // Keep it from cutting off leading symbols
}

// draw the stack
// p  picture to which to draw
// S  array of strings written to the stack
// stack_length=STACK_LENGTH How long to draw?
void stack_draw(picture p, string[] S, real stack_length=STACK_LENGTH) {
  // filldraw(p, stack_path(stack_length),drawpen=TAPE_PEN+light_color,fillpen=white);
  path sp = stack_path(stack_length);
  draw(p,point(sp,0)--point(sp,1)--point(sp,2)--point(sp,3),TAPE_PEN+light_color);
  draw(p,point(sp,3)--point(sp,3.1),TAPE_PEN+light_color);
  draw(p,point(sp,3.9)--point(sp,4),TAPE_PEN+light_color);
  stack_write(p,S);
}


void stack_output(string prefix, string[] S,  real stack_length=STACK_LENGTH) {
  picture p;
  unitsize(p,1pt);
  stack_draw(p,S,stack_length);
  shipout(prefix,p);
}


picture pda(string tape_contents, real head_pos, string head_label="", string[] stack_contents, real tape_length=DEFAULT_TAPE_LENGTH, real stack_length=STACK_LENGTH, real separation=20pt) {
  picture p_tape;
  unitsize(p_tape,1pt);
  tape_draw(p_tape, tape_contents, head_pos, head_label, tape_length);
  picture p_stack;
  unitsize(p_stack,1pt);
  stack_draw(p_stack,stack_contents,stack_length);
  add(p_tape,p_stack,(tape_length+separation,0)); // put spacer between the two
  return p_tape;
}
