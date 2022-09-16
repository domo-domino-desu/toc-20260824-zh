// pdfs/inverse.asy
// Draw a succession of tapes for a Turing machine computation
// This one is written by hand

import settings;
settings.outformat="pdf";
settings.render=0;

// cd needed for relative import 
cd("../../../../asy");
// import jh;
import tape;
cd("");

unitsize(1pt);

tape_output("inverse000"," 111 ",2,"$\state{5}$");
tape_output("inverse001"," 111 ",1,"$\state{4}$");
tape_output("inverse002"," 111 ",3,"$\state{4}$");
tape_output("inverse003"," 111 ",2,"$\state{4}$");

