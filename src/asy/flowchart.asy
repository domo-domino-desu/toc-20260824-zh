// Common definitions across all flowcharts
import node;
import jh;

// patch minipages as too wide
// I added this to wt_string.asy, as making the changes here caused
//  a failure I did not understand.
// JH getminipage boxes that are snugger
// pair getminipagesize1(string s)
// {
//   picture pic;
//   string[] lines=split(s, "\\");
//   pair M, m, D;
//   real w=0, h=0;
//   for (string line: lines)
//   {
//     label(pic, line);
//     M=max(pic); m=min(pic); D=M-m;
//     w=max(w, D.x);
//     h+=D.y;
//   }
//   real dw=13pt;  // was 3pt
//   return (w-dw,h);
// }
// string minipage3(string s, align flush=(0,0))
// {
//   real width=getminipagesize1(s).x;
//   string flushstring;
//   if (flush.dir==W)
//     flushstring="\flushleft ";
//   else if (flush.dir==E)
//     flushstring="\flushright ";
//   else
//     flushstring="\centering ";
//   return "\begin{minipage}{"+(string) (width/pt)+"pt}"+flushstring+s+"\end{minipage}"; 
// }

pen NODEPEN=fontsize(8pt)+fontcommand("\sffamily");
pen EDGEPEN=fontsize(6pt)+fontcommand("\sffamily"); 
// // define edge style
defaultdrawstyle=drawstyle(p=EDGEPEN, arrow=Arrow(DefaultHead,size=3));
// // Standard node is single-circle border
defaultnodestyle=nodestyle(textpen=NODEPEN, xmargin=1pt, drawfn=FillDrawer(FILLCOLOR,black));
// // Double circle nodes
nodestyle ns_accepting=nodestyle(textpen=NODEPEN, drawfn=Filler(FILLCOLOR)+DoubleDrawer(black));
// // nodes without any boxing
nodestyle ns_noborder=nodestyle(textpen=NODEPEN, xmargin=1pt, drawfn=None);
