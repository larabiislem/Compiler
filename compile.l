%{
#include <stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts-2.h"
#include "rayan.tab.h"
#include "pile.h"
#include "quadruplet.h"
extern nb_ligne ;
extern Col;
extern char *yytext;
extern YYSTYPE yylval;

%}





num [0-9]
lettre [a-zA-Z]
unsigned_int {num}+ 
unsigned_float   {num}*[.]{num}+ 
signed_int "\("[+-]{num}+"\)"
signed_float (\([+-]{num}+"."{num}+\))
IDF {lettre}({lettre}|{num}|_)*



comment "//".* 
comment_p "/*"([^*]|\*+[^*/])*\*+"/"                       	
    


%%

"PROGRAMME" {insert (yytext,"programme ","",0,1);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return programme; }
{comment} {nb_ligne++; printf ("commentaire simple reconnu \n");}
{comment_p} {nb_ligne++; printf ("commentaire long reconnu \n");}
"VAR" {insert (yytext,"var ","",0,1); printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return var; }
"BEGIN" {insert (yytext,"begin ","",0,1);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return begin; }
"END" { insert (yytext,"end ","",0,1);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return end; }
"INTEGER" { insert (yytext,"mc_int ","",0,1); yylval.str=strdup(yytext);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return mc_int; }
"FLOAT" { insert (yytext,"mc_float ","",0,1); yylval.str=strdup(yytext);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return mc_float; }
"CONST"  { insert (yytext,"mc_const ","",0,1); yylval.str=strdup(yytext);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return mc_const; }

{unsigned_int} { 
  
						     
							 yylval.integer= atoi(yytext);
                             
					


return cst_uns_integer; }
{unsigned_float} {yylval.integer= atoi(yytext);
printf("ligne %d : unsigned_float reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return  cst_uns_float; }
{signed_float}  {  yylval.integer= atoi(yytext);
printf("ligne %d : signed_float reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return cst_s_float; }
{signed_int}  {yylval.integer= atoi(yytext);
printf("ligne %d : signed_int reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return cst_s_integer; }

"IF"  { insert (yytext,"mc_if ","",0,1);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return mc_if; }
"ELSE"  { insert (yytext,"mc_else ","",0,1);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return mc_else; }
"FOR" { insert (yytext,"mc_for","",0,1); printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return mc_for; }
"WHILE" { insert (yytext,"mc_while ","",0,1); printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return mc_while; }
"READLN" {insert (yytext,"readln ","",0,1);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return readln; }
"WRITELN" {insert (yytext,"writeln ","",0,1);printf ("ligne %d : mot cle  reconnue est %s \n", nb_ligne,yytext); Col=Col+strlen(yytext); return writeln; }

"=" { insert (yytext,"aff","",0,2); printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return aff; }
"+" { insert (yytext,"add ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return add; }
"-" { insert (yytext,"moins","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return moins; }
"*" {  insert (yytext,"mul ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext);  return mul; }
"/" { insert (yytext,"sep_div ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return sep_div; }
"&&" { insert (yytext,"et ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return et; }
"||" { insert (yytext,"ou ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return ou; }
"!"  {  insert (yytext,"not ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return not; }
"==" { insert (yytext,"equal ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return egale; }
"!=" { insert (yytext,"not_equal ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return not_equal; }
"<"  { insert (yytext,"inf ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return inf; }
"<=" { insert (yytext,"inf_equal ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return inf_equal; }
">"  { insert (yytext,"sup ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return sup; }
">=" { insert (yytext,"sup_equal","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return sup_equal; }
";"  { insert (yytext,"pvg ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return pvg; }
","  { insert (yytext,"vg","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return vg; }
"("  { insert (yytext,"paren_ferm","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return paren_ouv; }
")"  { insert (yytext,"paren_ouv ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return paren_ferm; }
"{"  { insert (yytext,"acc_ouv ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext);  return acc_ouv ; }
"}"  { insert (yytext,"acc_ferm ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return acc_ferm; }
"["  { insert (yytext,"crocht_ouvr ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return crocht_ouvr; }
"]"  { insert (yytext,"crocht_ferm ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return crocht_ferm; }
":"  { insert (yytext,"deux_p ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return deux_p; }
"'"  { insert (yytext,"cot ","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return cot; }
"." { insert (yytext,"point","",0,2);printf("ligne %d : separateur reconnu   %s \n" , nb_ligne,yytext ); Col=Col+strlen(yytext); return p; }



{IDF} {   
				Col= Col+ strlen (yytext); 
			   
                   if (yyleng<=7) {   
				                    insert (yytext,"IDF ","",-1,0);
			                        printf("Ligne %d IDF reconnu %s \n" ,nb_ligne, yytext );
									yylval.str=strdup(yytext);	
                                    return idf;								   
                                    								
									
							      }
                    else printf ("Erreur lexicale Ligne %d , IDF %s trop long   \n", nb_ligne, yytext);
                    
 }
 
 

\n {Col = 1; nb_ligne++;}
[ \t ] { Col = Col + strlen(yytext);}


. printf("Erreur lexicale ligne %d colonne %d sur l'entite %s\n",nb_ligne,Col,yytext);

%%
