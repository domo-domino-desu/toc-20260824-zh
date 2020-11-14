// Return an AND gate picture
path andgate(real wd, real ln=-1) {
  if (ln<=0) {  // default is len = same as width; believe this is ANSI
    ln = wd;
  }
  real head_factor = 0.5;  // what percent of widht is head? believe this ANSI
  pair lower_lt = (-0.5*wd,-0.5*ln);
  pair upper_lt = (-0.5*wd,0.5*ln);
  pair lower_rt = (-0.5*wd+(1-head_factor)*wd,-0.5*ln);
  pair upper_rt = (-0.5*wd+(1-head_factor)*wd,0.5*ln);
  pair far_rt = (0.5*wd,0);

  return lower_lt -- lower_rt{right}::far_rt::{left}upper_rt -- upper_lt -- cycle;
};

// Return an OR gate path
path orgate(real wd, real ln=-1) {
  if (ln<=0) {  // default is len = same as width; believe this is ANSI
    ln = wd;
  }
  real head_factor = 0.75;  // what percent of width is head? believe this ANSI
  real rear_factor = 0.25;  // what percent to indent? believe this ANSI
  pair lower_lt = (-0.5*wd,-0.5*ln);
  pair upper_lt = (-0.5*wd,0.5*ln);
  pair lower_rt = (-0.5*wd+(1-head_factor)*wd,-0.5*ln);
  pair upper_rt = (-0.5*wd+(1-head_factor)*wd,0.5*ln);
  pair far_rt = (0.5*wd,0);
  pair far_lt = (-0.5*wd+(rear_factor*wd),0);

  return lower_lt -- lower_rt{right}::far_rt--far_rt::{left}upper_rt -- upper_lt .. far_lt .. cycle;
};


// Return a NOT gate path
path[] notgate(real wd, real ln=-1) {
  if (ln<=0) {  // default is len = same as width; believe this is ANSI
    ln = wd;
  }
  real circle_factor = 0.2;  // percent of width is circle? believe this ANSI
  pair lower_lt = (-0.5*wd,-0.5*ln);
  pair upper_lt = (-0.5*wd,0.5*ln);
  pair far_rt = (0.5*wd-circle_factor*wd,0);
  pair circle_center = (0.5*wd-0.5*circle_factor*wd,0);
  path c = shift(circle_center)*scale(0.5*circle_factor*wd)*rotate(180)*unitcircle; // circle(circle_center,circle_factor*wd);

  // return lower_lt -- far_rt ^^ subpath(c,0,4) ^^ far_rt -- upper_lt -- lower_lt -- cycle;
  return lower_lt -- far_rt :: arc(circle_center,0.5*circle_factor*wd,-3.14159,3.14159) :: far_rt -- upper_lt -- lower_lt -- cycle;
};


