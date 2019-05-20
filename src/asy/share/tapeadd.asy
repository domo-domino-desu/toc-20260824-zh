// tape.asy
//  draw tape, as for a turing machine, and include text and tape head

import settings;
settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

import jh;

unitsize(1pt);

import tape;
tape_output("tapedecrement0"," 111",1,"$q_0$",100);
tape_output("tapedecrement1"," 111",2,"$q_0$",100);
tape_output("tapedecrement2"," 111",3,"$q_0$",100);
tape_output("tapedecrement3"," 111",4,"$q_0$",100);
tape_output("tapedecrement4"," 111",3,"$q_1$",100);
tape_output("tapedecrement5"," 11 ",3,"$q_1$",100);
tape_output("tapedecrement6"," 11 ",2,"$q_2$",100);
tape_output("tapedecrement7"," 11 ",1,"$q_2$",100);
tape_output("tapedecrement8"," 11 ",0,"$q_2$",100);
tape_output("tapedecrement9"," 11 ",1,"$q_3$",100);
