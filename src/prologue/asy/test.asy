// test.asy
//  test importing from another directory

import settings;
settings.dir="..";  // have any effect? 
settings.outformat="pdf";

write(file=stdout,"This is test.asy ");
cd("..");
import test1;
cd("");
