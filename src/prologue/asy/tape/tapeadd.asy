// tape.asy
//  draw tape, as for a turing machine, and include text and tape head

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

cd("../../../asy/");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy");  // make it able to see jh.asy
import jh;
cd("");  // back to dir we started at
cd("../../../asy/share");  // shared routines
import tape;
cd("");  // back to dir we started at

unitsize(1pt);

import tape;
tape_output("tapeadd00"," 11 111 ",1,"$q_0$",100);
tape_output("tapeadd01"," 11 111 ",2,"$q_0$",100);
tape_output("tapeadd02"," 11 111 ",3,"$q_0$",100);
tape_output("tapeadd03"," 111111 ",3,"$q_1$",100);
tape_output("tapeadd04"," 111111 ",4,"$q_1$",100);
tape_output("tapeadd05"," 111111 ",5,"$q_1$",100);
tape_output("tapeadd06"," 111111 ",6,"$q_1$",100);
tape_output("tapeadd07"," 111111 ",7,"$q_1$",100);
tape_output("tapeadd08"," 111111 ",6,"$q_2$",100);
tape_output("tapeadd09"," 111111 ",5,"$q_2$",100);
tape_output("tapeadd10"," 111111 ",4,"$q_2$",100);
tape_output("tapeadd11"," 111111 ",3,"$q_2$",100);
tape_output("tapeadd12"," 111111 ",2,"$q_2$",100);
tape_output("tapeadd13"," 111111 ",1,"$q_2$",100);
tape_output("tapeadd14"," 111111 ",0,"$q_2$",100);
tape_output("tapeadd15"," 111111 ",1,"$q_3$",100);
tape_output("tapeadd16","  11111 ",1,"$q_3$",100);
tape_output("tapeadd17","  11111 ",2,"$q_4$",100);

// tapefcn
tape_output("tapefcn0","  111 ",2,"$q_0$",100);
tape_output("tapefcn1","  11111 ",2,"$q_h$",100);
