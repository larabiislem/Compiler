
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     programme = 258,
     var = 259,
     begin = 260,
     end = 261,
     mc_int = 262,
     mc_float = 263,
     mc_const = 264,
     cst_uns_integer = 265,
     cst_uns_float = 266,
     cst_s_float = 267,
     cst_s_integer = 268,
     mc_if = 269,
     mc_else = 270,
     mc_for = 271,
     mc_while = 272,
     readln = 273,
     writeln = 274,
     aff = 275,
     add = 276,
     moins = 277,
     mul = 278,
     sep_div = 279,
     et = 280,
     ou = 281,
     not = 282,
     egale = 283,
     not_equal = 284,
     inf = 285,
     inf_equal = 286,
     sup = 287,
     sup_equal = 288,
     pvg = 289,
     vg = 290,
     paren_ouv = 291,
     paren_ferm = 292,
     acc_ouv = 293,
     acc_ferm = 294,
     idf = 295,
     crocht_ouvr = 296,
     crocht_ferm = 297,
     deux_p = 298,
     cot = 299,
     p = 300
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 15 "rayan.y"

   int integer ;
   char* str;
   
  



/* Line 1676 of yacc.c  */
#line 106 "rayan.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


