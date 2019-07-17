
/*
 * Va"sa re"sitev prve naloge --- datoteko dopolnite in jo oddajte na spletno u"cilnico!
 *
 * Your solution to task 1 --- complete the file and submit it to U"cilnica!
 *
 * V naslednjo vrstico vpi"site va"so vpisno "stevilko / Enter your student ID number in the next line:
 *63170196
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main() {
	int n;
	scanf("%d", &n);
	char *niz = malloc (sizeof(char) *n+1);
	scanf("%s", niz);
	
	for(int i = 0; i < n; i++){
		if(i == 0){
			if(niz[0] >= 'a' && niz[0] <= 'z')
				niz[0] = niz[0] - 'a' + 'A';
		}
		else{
			if(niz[i-1] == '_')
				if(niz[i] >= 'a' && niz[i] <= 'z')
					niz[i] = niz[i] - 'a' + 'A';
		}
	}

	printf("%s", niz);	
	
    return 0;
}
