// settexpreamble.asy  Set up a common texpreamble
// Use in your final mygraphic.asy as:
//   cd("../../../asy/");
//   import settexpreamble;
//   cd("");
//   settexpreamble();

string get_repo_path() {
  // Asymptote path functions are primitive.  You can't getcwd().
  // I need to import the node module from its dir.  I could make an
  // environment variable pointing to that dir.  But that would
  // require making it part of the book's compilation instructions.
  // Instead, I want to figure out what is the repo dir, and then
  // do the path manipultations.
  // This function returns the path to the repo.  The repo must be named
  // either "computing" or "toc".  If this function does not find either
  // then it returns the empty string.
  // It has the side effect of returning to the dir of the .asy file from
  // which it was invoked.

  string repo_path = "";
  // Get the current directory
  string current_dir = cd("");
  // Locate the two possible strings in that path.
  int project_part_of_path_dex_computing = rfind(current_dir, "/computing/");
  int project_part_of_path_dex_toc = rfind(current_dir, "/toc/");
  // write(stdout, "src/asy/settexpreamble.asy: project part of path index for computing is "+format("%d\n",project_part_of_path_dex_computing));
  // write(stdout, "src/asy/settexpreamble.asy: project part of path index for toc is "+format("%d\n",project_part_of_path_dex_toc));
  // Find which is used as the repo dir
  int project_part_of_path_dex;
  if (project_part_of_path_dex_computing >= project_part_of_path_dex_toc) {
    project_part_of_path_dex = project_part_of_path_dex_computing+length("/computing/src/");
  } else {
    project_part_of_path_dex = project_part_of_path_dex_toc+length("/toc/src/");
  }
  if (project_part_of_path_dex < 0) {
    write(stdout, '!!! src/asy/settexpreamble.asy get_repo_path(): YOU MUST NAME LOCAL REPO EITHER computing/ or toc/!!\n');
    repo_path="";
  } else {
    repo_path = substr(current_dir, 0, project_part_of_path_dex);
  }
  // write(stdout, 'src/asy/settexpreamble.asy get_repo_path(): repo_path is '+repo_path+'\n');
  return(repo_path);
}


string settexpreamble() {
  // Run the texpreamble() command with a suitable list of \import{..}'s
  string repo_path = get_repo_path();
  if (length(repo_path) == 0) {
    write(stdout, '!!! src/asy/settexpreamble.asy settexpreamble(): repo_path is the empty string, so the texpreamble() will not work\n');
  }
  string usefiles = "\usepackage{"+repo_path+"contentmacros}\usepackage{"+repo_path+"computingfonts}\usepackage{"+repo_path+"grammar}\usepackage{xcolor}\input{"+repo_path+"colorscheme}";
  // write(stdout,'info: src/asy/settexpreamble.asy settexpreamble(): usefiles is '+usefiles+'\n');  
  texpreamble(usefiles); 
  return(repo_path);
}

// string settexpreamble() {
//   // Asymptote requires full paths to find the LaTeX styles.  This function
//   // searches for the name of the project directory as either computing/ or toc/
//   // and then constructs the file paths from that.
  
//   // Get the current directory
//   string current_dir = cd("");
//   int project_part_of_path_dex_computing = rfind(current_dir, "/computing/");
//   int project_part_of_path_dex_toc = rfind(current_dir, "/toc/");
//   // write(stdout, "src/asy/settexpreamble.asy: project part of path index for computing is "+format("%d\n",project_part_of_path_dex_computing));
//   // write(stdout, "src/asy/settexpreamble.asy: project part of path index for toc is "+format("%d\n",project_part_of_path_dex_toc));
//   int project_part_of_path_dex;
//   if (project_part_of_path_dex_computing >= project_part_of_path_dex_toc) {
//     project_part_of_path_dex = project_part_of_path_dex_computing+length("/computing/src/");
//   } else {
//     project_part_of_path_dex = project_part_of_path_dex_toc+length("/toc/src/");
//   }
//   if (project_part_of_path_dex < 0) {
//     write(stdout, "src/asy/settexpreamble.asy: project part of path index is negative: !!YOU MUST NAME LOCAL REPO EITHER computing/ or toc/!!\n");
//   }
//   string path_prefix = substr(current_dir, 0, project_part_of_path_dex);
//   write(stdout, "src/asy/settexpreamble.asy: Path prefix is "+path_prefix+"<--\n");
//   // this causes an error (openout_any = p) because TeX wants to be in same dir as included file; must call tex with openany=a: texpreamble("\include{"+path_prefix+"/computing/src/colorscheme}\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}");
//   string usefiles = "\usepackage{"+path_prefix+"contentmacros}\usepackage{"+path_prefix+"computingfonts}\usepackage{"+path_prefix+"grammar}\usepackage{xcolor}\input{"+path_prefix+"colorscheme}";
//   // write(stdout, "settexpreamble.tex: \usefiles is:"+usefiles+"<-- ");  
//   // texpreamble("\usepackage{"+path_prefix+"/computing/src/computingfonts}\usepackage{"+path_prefix+"/computing/src/contentmacros}\usepackage{"+path_prefix+"/computing/src/grammar}\usepackage{xcolor}\input{"+path_prefix+"/computing/src/colorscheme}"); 
//   texpreamble(usefiles); 
//   return(path_prefix);
// }
