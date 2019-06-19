// pdfs/replicator.asy
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

tape_output("replicator000"," 111         ",1,"$\state{0}$");
tape_output("replicator001"," B11 1 1     ",2,"$\state{10}$");
tape_output("replicator002"," BB1 11 11   ",3,"$\state{20}$");
tape_output("replicator003"," BBB 111 111 ",5,"$\state{30}$");

