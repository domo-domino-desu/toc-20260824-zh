// stub.asy
// Stub of asy file
// 2015-Jul-14 JH

// These imports go in all .asy files to keep constants such as colors.
import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1cm);

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../asy/");
import settexpreamble;
cd("");
settexpreamble();

cd("../../asy/");
import jh;
cd("");
// import node;

