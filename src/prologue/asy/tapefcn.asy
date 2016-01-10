// tapefcn.asy
//  draw tape for before and after, to give defn of fcn

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import tape --> jh
cd("../../asy/share/");
import tape;
cd("");

tape_output("tapefcn0"," 111 ",1,"$q_0$",100);
tape_output("tapefcn1"," 11111 ",1,"$q_k$",100);

