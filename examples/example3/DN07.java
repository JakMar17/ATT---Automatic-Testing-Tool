import java.util.Scanner;

class DN07 {
    
    private static Scanner sc = new Scanner (System.in);
    private static int velikost;
    private static int [] [] tabela;
    private static int steviloKvadratov = 0;

    public static void main (String [] args) {
        velikost = sc.nextInt();
        tabela = new int [velikost] [velikost];

        polniTabelo();
        tabelomat();
        //izpisTabele();
        izpis();

    }

    private static void polniTabelo() {
        for (int i = 0; i < velikost; i++) {
            for (int j = 0; j < velikost; j++) {
                tabela [i] [j] = sc.nextInt();
            }
        }
    }

    private static void tabelomat() {
        for (int i = 0; i <= tabela.length; i++) {
            for (int j = 0; j <= tabela.length; j++) {
                if (i == 0 || j == 0)
                    continue;
                if (tabela [i-1] [j-1] == 1) {
                    steviloKvadratov++;
                    tabletomat (i,  j);
                }
            }
        }
    }

    private static void tabletomat (int vrsta, int stolp) {
        boolean enica = true;

        for (int korak = 1; (korak - vrsta) < 0 && (korak - stolp) < 0; korak++) {
            int i = 0;
            while (i <= korak) {
                boolean pogoj1 = tabela [vrsta - (i + 1)] [stolp - (korak + 1)] != 1;
                boolean pogoj2 = tabela [vrsta - (korak + 1)] [stolp - (i + 1)] != 1;
                if (pogoj1 || pogoj2)
                    enica = false;
                i++;
            }
            if (enica == false)
                break;
            steviloKvadratov ++;
        }
    }

    private static void izpisTabele () {
        for (int i = 0; i < tabela.length; i++) {
            for (int j = 0; j < tabela.length; j++)
                System.out.printf("%d ", tabela [i] [j]);
            System.out.println();
        }
    }

    private static void izpis () {
        System.out.println(steviloKvadratov);
    }
}