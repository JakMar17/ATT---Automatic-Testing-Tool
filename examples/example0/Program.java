import java.util.*;

public class Program {

    private static Scanner sc = new Scanner(System.in);
    private static int velikostSeznam;

    public static void main(String[] args) {
        List<Integer> seznam = new ArrayList<>(0);
        while(sc.hasNext())
            seznam.add (sc.nextInt());
        najdi(seznam);
        
    }

    private static int najdi(List<Integer> seznam) {
        velikostSeznam = seznam.size();
        if(velikostSeznam == 1)
            return izpis0(seznam);

            List<Integer> l = new ArrayList<>(0);
            List<Integer> d = new ArrayList<>(0);

            if (velikostSeznam % 2 != 0) {
                l = seznam.subList(0, (velikostSeznam/2) +1);
                d = seznam.subList( (velikostSeznam/2)+1, velikostSeznam);
            } else { 
                l = seznam.subList(0, velikostSeznam/2);
                d = seznam.subList(velikostSeznam/2, velikostSeznam);
            }

            int maksimum = 0, maxL = najdi(l), maxD = najdi(d), maxS = najdiS(l, d);

            if (maxD <= maxL && maxS < maxL) {
                maksimum = maxL;
            } else if (maxD >= maxL && maxS < maxD) {
                maksimum = maxD;
            } else {
                maksimum = maxS;
            }

        return izpis(seznam, maksimum);

    }

    private static int izpis0(List<Integer> seznam) {
        int x = seznam.get(0);
        System.out.print(seznam);
        System.out.format(": %d%n", x);
        //System.out.println();
        return x;
    }

    private static int izpis(List<Integer> seznam, int x) {
        System.out.print(seznam);
        System.out.format(": %d%n", x);
        //System.out.println();
        return x;
    }

    private static int najdiS (List<Integer> l, List<Integer> d) {
        velikostSeznam = l.size();
        int tekoca = l.get(velikostSeznam -1);
        int vsotaL = tekoca;

        int i = velikostSeznam-2;
        while (i >= 0 ) {
            tekoca += l.get(i);
            if (tekoca < vsotaL){}
            else {vsotaL = tekoca;}

            i--;
        }

        velikostSeznam = d.size();
        tekoca = d.get(0);
        int vsotaD = tekoca;

        i = 1;
        while(i < velikostSeznam) {
            tekoca += d.get(i);
            if (tekoca <= vsotaD) {}
            else {vsotaD = tekoca;}

            i++;
        }

        return vsotaL+vsotaD;
    }
}