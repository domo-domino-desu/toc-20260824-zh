// tm.asy
//  draw succession of tapes for a Turing machine computation

import settings;
settings.outformat="pdf";
settings.render=0;

// cd needed for relative import 
cd("../../../asy");
import tape;
cd("");

unitsize(1pt);

tape_output("tm000"," 111 ",1,"$q_0$");
tape_output("tm001"," 111 ",2,"$q_0$");
tape_output("tm002"," 111 ",3,"$q_0$");
tape_output("tm003"," 111 ",4,"$q_0$");
tape_output("tm004"," 111 ",3,"$q_1$");
tape_output("tm005"," 11  ",3,"$q_1$");
tape_output("tm006"," 11  ",2,"$q_2$");
tape_output("tm007"," 11  ",1,"$q_2$");
tape_output("tm008"," 11  ",0,"$q_2$");
tape_output("tm009"," 11  ",1,"$q_3$");

