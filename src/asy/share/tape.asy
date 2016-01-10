// tape.asy
//  draw tape, as for a turing machine, and include text and tape head

import settings;
settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

cd("..");
import jh;
cd("./share");  // come back to this dir

defaultpen(fontsize(8pt));

unitsize(1pt);

pen TAPE_PEN=linewidth(.4pt)+squarecap+miterjoin+fontsize(8pt)+black;
real TAPE_WIDTH=10pt;

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

real TAPE_LENGTH=200pt;
path tape_path(real tape_length=TAPE_LENGTH) {
  path tape=(-10pt,0)--(tape_length-10pt,0)
    ..reverse(tape_end_path((tape_length-10pt,0)))
    --(-10pt,TAPE_WIDTH)..tape_end_path((-10pt,0))..cycle;
  return tape;
}

// draw the tape read/write head pointing to position x-location and
// containing the state (e.g., "q_3")
real TAPE_HEAD_X = 12pt; // how far tape head extends left-right
real TAPE_HEAD_Y = 12pt; // how far up-down
void draw_tape_head(picture p, real location, string state="") {
  path tape_head=(0,0)--(0.5*TAPE_HEAD_X,-0.25*TAPE_HEAD_Y)
    --(0.5*TAPE_HEAD_X,-1*TAPE_HEAD_Y)--(-0.5*TAPE_HEAD_X,-1*TAPE_HEAD_Y)
    --(-0.5*TAPE_HEAD_X,-0.25*TAPE_HEAD_Y)--cycle;
  path shifted_tape_head=shift(location*10,-0.5pt)*tape_head;
  fill(p,shifted_tape_head,verylight_color);
  draw(p, Label("\makebox[0em]{"+state+"}", TAPE_PEN+black),shifted_tape_head,align=N,TAPE_PEN+linewidth(0.4pt)+light_color);
}

// write the string to the tape, with character i at position x=i (positions
// start counting at x=0)
void tape_write(picture p, string s) {
  for(int i=0; i < length(s); ++i) {
    draw(p,Label("\makebox[0em]{\texttt{"+substr(s,i,1)+"}}", black), (10*i,10*0.25), align=Align, invisible);
  }
}

// draw the tape and the head
// p  picture to which to draw
// s  string written to the tape
// head_pos  real number (prob nat num) position for the tape head
// head_label string written to tape head (you may want to enclose in $'s)
void tape_draw(picture p, string s, real head_pos, string head_label="", real tape_length=TAPE_LENGTH) {
  filldraw(p, tape_path(tape_length),drawpen=TAPE_PEN+light_color,fillpen=verylight_color);
  tape_write(p,s);
  draw_tape_head(p,head_pos,head_label);
}

void tape_output(string prefix, string s, real head_pos, string head_label="",  real tape_length=TAPE_LENGTH) {
  picture p;
  unitsize(p,1pt);
  tape_draw(p,s,head_pos,head_label,tape_length);
  shipout(prefix,p);
}

// tape_output("tape1","101",0,"$q_0$");
// tape_output("tape2","101",1,"$q_2$");
// tape_output("tape3","101",2,"$q_1$");
