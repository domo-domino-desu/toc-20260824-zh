// life.asy
// Conway's game of Life
// 2015-Jul-14 JH

cd("../../asy/");  // set to path to common asy dir
import jh;
cd("");


pen DEADCOLOR = background_color;
pen ALIVECOLOR = highlight_color;
path cell = box((0,0), (1,1));

// Open/close gameboard file
string makerelfn(string subdir, string fn, int dex) {
  return subdir+'/'+fn+format("%02d",dex)+".life";
}

file gameboard(string subdir, string fn, int dex) {
  string relfn = makerelfn(subdir,fn,dex);
  return input(relfn);
}

void closegameboard(file f) {
  close(f);
}

// Read from one file, return the resulting picture
picture one_gameboard(string subdir, string fn, int dex, real usize) {
  picture p;
  unitsize(p, usize);
  file f = gameboard("life",fn,dex);

  int cols = 0;   // maximum column number
  int rows = 0;   // max row number
  int cur_col = -1;
  int cur_row = 0;  
  pen color;
  bool flag = true;
  while(flag) {
    string c = getc(f);
    if (eof(f)) {
      break;
    }
    if (c == '\n') {
      cur_row = cur_row-1;
      rows = cur_row; 
      cur_col = -1;
      continue;
    }
    cur_col = cur_col+1;
    cols = max(cols, cur_col);
    if (c == '*') {
      color = ALIVECOLOR;
    } else {
      color = DEADCOLOR;
    }
    write(stdout, format("cur_row=%d",cur_row)+format(' cur_col=%d\n',cur_col));
    fill(p, shift(cur_col,cur_row)*cell, color);
  }
  closegameboard(f);
  // draw the lines bordering cells
  for (int i=1; i>rows; --i) { // side-to-side
    draw(p, (0,i)--(cols+1,i), MAINPEN+extendcap+light_color);
  }
  for (int j=0; j<=cols+1; ++j) { // up and down
    draw(p, (j,1)--(j,rows+1), MAINPEN+extendcap+light_color);
  }
  return p;
}


