#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure pour les identifiants et constantes
typedef struct NoeudIDF {
    char name[20];       
    char code[20];       
    char type[20];       
    float val;           
    struct NoeudIDF* suivant;
} NoeudIDF;

// Structure pour les séparateurs et mots-clés
typedef struct NoeudElt {
    char name[20];
    char code[20];
    struct NoeudElt* suivant;
} NoeudElt;

// Pointeurs pour les listes chaînées
NoeudIDF* listeIDF = NULL;
NoeudElt* listeSeparateurs = NULL;
NoeudElt* listeMotsCles = NULL;

// Initialisation des listes chaînées
void initialisation() {
    listeIDF = NULL;
    listeSeparateurs = NULL;
    listeMotsCles = NULL;
}

NoeudIDF* search(char entity[], int t) {
    if (t == 0) { // Recherche parmi les identifiants
        NoeudIDF* courant = listeIDF;
        while (courant != NULL) {
            if (strcmp(courant->name, entity) == 0) {
                return courant; // Trouvé
            }
            courant = courant->suivant;
        }
    }
    return NULL; // Non trouvé
}


void insert(char entity[], char code[], char type[], float value, int t) {
    if (t == 0) { // Identifiants et constantes
        if (search(entity, 0) == NULL) { // Vérifie si non déclaré
            NoeudIDF* nouveau = (NoeudIDF*)malloc(sizeof(NoeudIDF));
            strcpy(nouveau->name, entity);
            strcpy(nouveau->code, code);
            strcpy(nouveau->type, type);
            nouveau->val = (value == -1) ? -1 : value; // -1 pour indiquer "Non initialisé"
            nouveau->suivant = listeIDF;
            listeIDF = nouveau;
        } 
    }
}

int check_declaration(char entity[]) {
    NoeudIDF* courant = search(entity, 0); // Recherche dans les identifiants
    if (courant != NULL && strcmp(courant->type, "") == 0) {
        return 0; 
    }
    return -1; 
}





// Récupère le type d'une entité identifiée
void get_type_of_idf(char entite[], char typ[]) {
    NoeudIDF* courant = search(entite,0);
    if (courant != NULL) {
        strcpy(typ, courant->type);
    } else {
        strcpy(typ, ""); // Si non trouvé
    }
}

// Détermine le type d'une expression
void get_type_of_expr(float expr, char* type) {
    if ((int)expr == expr) { // Vérifie si expr est entier
        strcpy(type, "INTEGER");
    } else {
        strcpy(type, "FLOAT");
    }
}

// Définit le type d'une entité
void insert_type(char entity[], char type[]) {
    NoeudIDF* sym = search(entity,0);
    if (sym != NULL) {
        strcpy(sym->type, type);
    } else {
        printf("Erreur : Identifiant %s non déclaré\n", entity);
    }
}

// Définit le type "CONST" pour une constante
void insert_const_type(char entity[]) {
    NoeudIDF* sym = search(entity,0);
    if (sym != NULL) {
        strcpy(sym->type, "CONST");
    } else {
        printf("Erreur : Identifiant %s non déclaré\n", entity);
    }
}

void insert_const_value(char entity[], float value) {
    NoeudIDF* sym = search(entity, 0);
    if (sym != NULL) {
        if (strcmp(sym->type, "CONST") == 0) {
            sym->val = value;
        } else {
            printf("Erreur : %s n'est pas une constante\n", entity);
        }
    } else {
        printf("Erreur : Identifiant %s non declare\n", entity);
    }
}

int type_compatible(const char* target_type, const char* expr_type) {
    if (strcmp(target_type, expr_type) == 0) {
        return 1; 
    }
    if (strcmp(target_type, "INTEGER") == 0 && strcmp(expr_type, "FLOAT") == 0) {
        return 0;
    }
    if (strcmp(target_type, "FLOAT") == 0 && strcmp(expr_type, "INTEGER") == 0) {
        return 1; 
    }
    return 0; 
}


// Affecte une nouvelle valeur à un identifiant
void set_value_of_idf(char entite[], float newval) {
    NoeudIDF* courant = search(entite,0);
    if (courant != NULL) {
        if (strcmp(courant->type, "INTEGER") == 0) {
            courant->val = (int)newval; // Convertir en entier si nécessaire
        } else if (strcmp(courant->type, "FLOAT") == 0) {
            courant->val = newval;
        }
    } else {
        printf("Erreur : Identifiant %s non déclaré\n", entite);
    }
}

// Récupère la valeur associée à un identifiant
void get_value_of_idf(char entite[], float* ttmp) {
    NoeudIDF* courant = search(entite,0);
    if (courant != NULL) {
        *ttmp = courant->val;
    } else {
        printf("Erreur : Identifiant %s non déclaré\n", entite);
        *ttmp = -1;
    }
}

// Vérifie si une valeur est un entier
int Is_int(float* value) {
    return (*value == (int)(*value));
}

// Affiche la table des symboles
void print() {
    printf("\n/****************** Table des Symboles ******************/\n");
    printf("|    Name    |    Code    |     Type     |    Value     |\n");
    printf("---------------------------------------------------------\n");
    NoeudIDF* courantIDF = listeIDF;
    while (courantIDF != NULL) {
        printf("| %10s | %10s | %12s | %12s |\n",
               courantIDF->name,
               courantIDF->code,
               courantIDF->type,
               (courantIDF->val == -1) ? "Non init" : (sprintf((char[20]){}, "%.2f", courantIDF->val), (char[20]){}));
        courantIDF = courantIDF->suivant;
    }
    printf("---------------------------------------------------------\n");
}
