// settexpreamble.asy  Set up a common texpreamble
// Use in your final mygraphic.asy as:
//   cd("../../../asy/");
//   import settexpreamble;
//   cd("");
//   settexpreamble();

string settexpreamble() {
  // Get the current directory
  string current_dir = cd("");
  int project_part_of_path_dex = rfind(current_dir, "/computing/");
  string path_prefix = substr(current_dir, 0, project_part_of_path_dex);
  write(stdout, "src/asy/settexpreamble.asy: Path prefix is "+path_prefix+"<-- ");
  // this causes an error (openout_any = p) because TeX wants to be in same dir as included file; must call tex with openany=a: texpreamble("\include{"+path_prefix+"/computing/src/colorscheme}\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}");
  string usefiles = "\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}\usepackage{"+path_prefix+"/computing/src/grammar}\usepackage{xcolor}\input{"+path_prefix+"/computing/src/colorscheme}";
  // write(stdout, "settexpreamble.tex: \usefiles is:"+usefiles+"<-- ");  
  // texpreamble("\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}\usepackage{"+path_prefix+"/computing/src/grammar}\usepackage{xcolor}\input{"+path_prefix+"/computing/src/colorscheme}"); 
  texpreamble(usefiles); 
  return(path_prefix);
}
