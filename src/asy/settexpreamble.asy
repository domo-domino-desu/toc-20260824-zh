// settexpreamble.asy  Set up a common texpreamble
// Use in your final mygraphic.asy as:
//   cd("../../../asy/");
//   import settexpreamble;
//   cd("");
//   settexpreamble();

string settexpreamble() {
  // Asymptote requires full paths to find the LaTeX styles.  This function
  // searches for the name of the project directory as either computing/ or toc/
  // and then constructs the file paths from that.
  
  // Get the current directory
  string current_dir = cd("");
  int project_part_of_path_dex_computing = rfind(current_dir, "/computing/");
  int project_part_of_path_dex_toc = rfind(current_dir, "/toc/");
  // write(stdout, "src/asy/settexpreamble.asy: project part of path index for computing is "+format("%d",project_part_of_path_dex_computing));
  // write(stdout, "src/asy/settexpreamble.asy: project part of path index for toc is "+format("%d",project_part_of_path_dex_toc));
  int project_part_of_path_dex;
  if (project_part_of_path_dex_computing >= project_part_of_path_dex_toc) {
    project_part_of_path_dex = project_part_of_path_dex_computing;
  } else {
    project_part_of_path_dex = project_part_of_path_dex_toc;
  }
  if (project_part_of_path_dex < 0) {
    write(stdout, "src/asy/settexpreamble.asy: project part of path index is negative: !!YOU MUST NAME LOCAL REPO EITHER computing/ or toc/!!");
  }
  string path_prefix = substr(current_dir, 0, project_part_of_path_dex);
  write(stdout, "src/asy/settexpreamble.asy: Path prefix is "+path_prefix+"<-- ");
  // this causes an error (openout_any = p) because TeX wants to be in same dir as included file; must call tex with openany=a: texpreamble("\include{"+path_prefix+"/computing/src/colorscheme}\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}");
  string usefiles = "\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}\usepackage{"+path_prefix+"/computing/src/grammar}\usepackage{xcolor}\input{"+path_prefix+"/computing/src/colorscheme}";
  // write(stdout, "settexpreamble.tex: \usefiles is:"+usefiles+"<-- ");  
  // texpreamble("\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}\usepackage{"+path_prefix+"/computing/src/grammar}\usepackage{xcolor}\input{"+path_prefix+"/computing/src/colorscheme}"); 
  texpreamble(usefiles); 
  return(path_prefix);
}
