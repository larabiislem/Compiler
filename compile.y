%{
 
   int nb_ligne = 1; 
   int Col=1;
   extern yytext;
   char save_type[20];
   char TempValeur [20];
   float tmp;               
float op1, op2;           
char sauvidf[20];         


%}

%union{
   int integer ;
   char* str;
   
  
}

%token 
programme
var
begin
end
<str>mc_int
<str>mc_float
<str>mc_const
<integer>cst_uns_integer
<integer>cst_uns_float
<integer>cst_s_float
<integer>cst_s_integer
mc_if
mc_else
mc_for
mc_while
readln
writeln
aff
add
moins
mul
sep_div
et
ou
not
egale
not_equal
inf
inf_equal
sup
sup_equal
pvg
vg
paren_ouv
paren_ferm
acc_ouv 
acc_ferm
<str>idf
crocht_ouvr
crocht_ferm
deux_p
cot
p


%type <integer> EXP_ARRITH




%nonassoc not
%left ou
%left et
%left sup sup_equal egale not_equal inf_equal inf
%left add moins
%left mul sep_div





%start S

%%

S: programme idf var acc_ouv List_Dec acc_ferm begin BLOC_INST end p {printf("\n\n syntaxe correcte"); YYACCEPT;} ;  

List_Dec : DEC List_Dec | DEC | CONST_DEC List_Dec ;

DEC: TYPE idf LIST_VAR {                  if (check_declaration($2)==0){ insert_type($2,save_type); }
                        else{printf("    >>>>>>> Errreur semantique a la ligne %d colonne %d , DOUBLE DECLARATION de idf %s \n",nb_ligne,Col,$2);}}
| TAB_DEC;



TAB_DEC: TYPE idf crocht_ouvr EXP_ARRITH crocht_ferm pvg | mc_const TYPE idf crocht_ouvr EXP_ARRITH crocht_ferm pvg ;

CONST_DEC : mc_const LISTE_CONST pvg;
LISTE_CONST
: idf aff cst_uns_integer vg LISTE_CONST {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double déclaration de %s\n", $1);
    }
}
| idf aff cst_uns_float vg LISTE_CONST {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double déclaration de %s\n", $1);
    }
}
| idf aff cst_s_float vg LISTE_CONST {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double déclaration de %s\n", $1);
    }
}
| idf aff cst_s_integer vg LISTE_CONST {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); // Déclare l'identifiant
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double declaration de %s\n", $1);
    }
}
| idf vg LISTE_CONST {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, 0, 0);  
    } else {
        printf("Erreur : Double declaration de %s\n", $1);
    }
}
| idf {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, 0, 0); 
    } else {
        printf("Erreur : Double declaration de %s\n", $1);
    }
}
| idf aff cst_s_integer {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double declaration de %s\n", $1);
    }
}
| idf aff cst_s_float {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double declaration de %s\n", $1);
    }
}
| idf aff cst_uns_float {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double declaration de %s\n", $1);
    }
}
| idf aff cst_uns_integer {
    if (check_declaration($1) == 0) {
        insert($1, "IDF", "CONST", 0); 
        insert_const_value($1, $3, 1); 
    } else {
        printf("Erreur : Double declaration de %s\n", $1);
    }
};







LIST_VAR: vg idf LIST_VAR  {                  if (check_declaration($2)==0){ insert_type($2,save_type); }
                        else{printf("    >>>>>>> Errreur semantique a la ligne %d colonne %d , DOUBLE DECLARATION de idf %s \n",nb_ligne,Col,$2);}}| pvg ;

TYPE:   mc_int {strcpy(save_type,$1);} 
       |mc_float {strcpy(save_type,$1);};




BLOC_INST : INST BLOC_INST | INST ;
INST : AFFECT| IF_ELSE | WHILE | FOR | WRITE | READ  ;

WRITE : writeln paren_ouv cot idf cot paren_ferm pvg ;


READ : readln paren_ouv cot idf cot paren_ferm pvg;

AFFECT: idf aff EXP_ARRITH pvg {
    tmp = Depiler();

    if (check_declaration($1) == 0) {
        printf("    >>>>>>> Erreur semantique ligne %d colonne %d : Identifiant non declare : %s\n", nb_ligne, Col, $1);
    } else {
        get_type_of_idf($1, sauvidf);

        if (type_compatible(sauvidf, Is_int(&tmp) ? "INTEGER" : "FLOAT")) {
            ajout_quad_affect_val($1, &tmp);
            set_value_of_idf($1, tmp);  
        } else {
            printf("    >>>>>>> Erreur semantique ligne %d colonne %d : INCOMPATIBILITE DE TYPE : %s est %s, ne peut pas recevoir %s\n",
                   nb_ligne, Col, $1, sauvidf, Is_int(&tmp) ? "INTEGER" : "FLOAT");
        }
    }
}

EXP_ARRITH: EXP_ARRITH add EXP_ARRITH {
                op2 = Depiler();
                op1 = Depiler();
                tmp = op1 + op2;
                Empiler(tmp);
                ajout_quad_opbinaire('+', &op1, &op2);
            }
          | EXP_ARRITH moins EXP_ARRITH {
                op2 = Depiler();
                op1 = Depiler();
                tmp = op1 - op2;
                Empiler(tmp);
                ajout_quad_opbinaire('-', &op1, &op2);
            }
          | EXP_ARRITH mul EXP_ARRITH {
                op2 = Depiler();
                op1 = Depiler();
                tmp = op1 * op2;
                Empiler(tmp);
                ajout_quad_opbinaire('*', &op1, &op2);
            }
          | EXP_ARRITH sep_div EXP_ARRITH {
                op2 = Depiler();
                op1 = Depiler();
                if (op2 == 0) {
                    printf("    >>>>>>> Erreur semantique ligne %d colonne %d : Division par zero\n", nb_ligne, Col);
                } else {
                    tmp = op1 / op2;
                    Empiler(tmp);
                    ajout_quad_opbinaire('/', &op1, &op2);
                }
            }
         
          | paren_ouv EXP_ARRITH paren_ferm {
               
            }
          | idf {
                if (check_declaration($1) == 0) {
                    printf("    >>>>>>> Erreur semantique ligne %d colonne %d : Identifiant %s non declare\n", nb_ligne, Col, $1);
                } else {
                    get_value_of_idf($1, &tmp);
                    Empiler(tmp);
                }
            }
          | cst_uns_integer {
                Empiler($1);
            }
          | cst_uns_float {
                Empiler($1);
            }
		 | cst_s_integer {
		     Empiler($1);}
	     | cst_s_float {
		     Empiler($1);}
;
















IF_ELSE : mc_if paren_ouv COND paren_ferm acc_ouv BLOC_INST acc_ferm ELSE ;
ELSE: mc_else acc_ouv BLOC_INST acc_ferm | ;
COND : EXP_ARRITH OP_LOG EXP_ARRITH CNDL | EXP_ARRITH OPRC EXP_ARRITH CNDL | paren_ouv EXP_ARRITH OP_LOG EXP_ARRITH paren_ferm CNDL | paren_ouv EXP_ARRITH OPRC EXP_ARRITH paren_ferm CNDL;
CNDL : OP_LOG COND | ;


WHILE : mc_while paren_ouv COND paren_ferm acc_ouv BLOC_INST acc_ferm;
FOR :mc_for paren_ouv  idf  deux_p  cst_uns_integer deux_p  cst_uns_integer deux_p  EXP_ARRITH  paren_ferm acc_ouv BLOC_INST acc_ferm {if (check_declaration($3)==0) {printf( "  >>>>>>> Errreur semantique a la ligne %d colonne %d ,  idf non declare %s \n",nb_ligne,Col,$2);};};

OP_LOG : et | ou | not ;
OPRC : egale | not_equal | inf | inf_equal | sup | sup_equal ;
%%

int main(int argc, char **argv) {
    yyparse();
	print();
	afficher_qdr();
	return 0;
	
}

int yywrap() {
    return 1; 
}

int yyerror(const char *s) {
printf("\n   =====> Erreur Syntaxique  \n au niveau la ligne %d et a la colonne %d sur l'entite %s\n ", nb_ligne,Col,yytext);
}
