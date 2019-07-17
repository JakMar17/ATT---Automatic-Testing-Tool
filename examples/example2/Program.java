import java.util.Scanner;

public class Program {
    private static Scanner sc = new Scanner (System.in);
    private static int stPodatkov;
    private static double dolzina;
    private static Complex[] polinom1;
    private static Complex[] polinom2;
    private static Complex[] rezultat;

    public static void main(String[] args) {
        branjePodatkov();

        polinom1 = razdeli(polinom1, false);
        polinom2 = razdeli(polinom2, false);


        for (int i = 0; i < dolzina; i++) {
            Complex x1 = polinom1[i];
            Complex x2 = polinom2[i];
            rezultat[i] = x2.times(x1).conj();
        }

        rezultat = razdeli(rezultat, true);

        konjugiraj(rezultat);
        for (int i = 0; i < rezultat.length; i++)
            rezultat[i] = rezultat[i].times(1 / dolzina);

        izpis(rezultat);

    }

    private static void branjePodatkov () {
        stPodatkov = sc.nextInt();
        int potenca = (int) Math.ceil(Math.log(stPodatkov*2)/Math.log(2));
        dolzina = Math.pow(2, potenca);

        polinom1 = narediPolinom(dolzina);
        polinom2 = narediPolinom(dolzina);
        rezultat = new Complex [(int)dolzina];
    }

    private static Complex[] narediPolinom (double dolzina) {
        Complex [] polinom = new Complex [(int)dolzina];

        for (int i = 0; i < stPodatkov; i++) {
            int podatek = sc.nextInt();
            polinom[i] = narediStopnjo(podatek, 0);
        }

        for (int i = stPodatkov; i < polinom.length; i++) {
            polinom[i] = narediStopnjo(0,0);
        }

        return polinom;
    }

    private static Complex narediStopnjo (int realni, int imaginarni) {
        Complex stopnja = new Complex (realni, imaginarni);
        return stopnja;
    }

    private static Complex[] razdeli (Complex[] polinom, boolean r) {
        int d;
        if ( (d = polinom.length) == 1 )
            return polinom;
        
        Complex[] p1 = new Complex[d/2];
        Complex[] p2 = new Complex[d/2];

        boolean sod = true;
        for (int i = 0, stevec1 = 0, stevec2 = 0; i < polinom.length; i++) {
            if (sod) {
                p1[stevec1] = polinom[i];
                sod = false;
                stevec1++;
            } else {
                p2[stevec2] = polinom[i];
                sod = true;
                stevec2++;
            }
        }

        p1 = razdeli(p1, r);
        p2 = razdeli(p2, r);
        polinom = zdruzi(polinom, p1, p2);

        if (r)
            konjugiraj(polinom);
        
        izpis(polinom);

        if (r)
            konjugiraj(polinom);


        return polinom;
    }

    private static Complex[] zdruzi (Complex[] rezultat, Complex[] polinom1, Complex[] polinom2) {
        int d = rezultat.length;
        double x = 2 * Math.PI / d;
        double sinus = Math.sin(x);
        double cosinus = Math.cos(x);

        Complex w = new Complex (cosinus, sinus);
        Complex wk = new Complex (1,0);
        Complex wkTemp = wk;

        int i = 0;
        while (i < d/2) {
            Complex p1 = polinom1[i];
            Complex p2 = polinom2[i];
            Complex r = p1.plus(p2.times(wkTemp));

            rezultat[i] = r;
            
            wkTemp = wkTemp.times(w);
            i++;
        }

        wkTemp = wk;
        int j = 0;
        while (i < d) {
            Complex p1 = polinom1[j];
            Complex p2 = polinom2[j];
            Complex r = p1.minus(p2.times(wkTemp));

            rezultat[i] = r;

            wkTemp = wkTemp.times(w);
            i++; j++;
        }

        return rezultat;
    }

    private static void konjugiraj (Complex[] polinom) {
        for (int i = 0; i < polinom.length; i++)
            polinom[i] = polinom[i].conj();
        //return polinom;
    }

    private static void izpis (Complex[] polinom) {

        for (int i = 0; i < polinom.length; i++) {
            String izpis = polinom[i].toString();
            System.out.format("%s ", izpis);
        }
        System.out.println();
    }
}

class Complex extends Program {
    double re;
    double im;

    public Complex(double real, double imag) {
        re = real;
        im = imag;
    }

    public String toString() {
        double tRe = (double) Math.round(re * 100000) / 100000;
        double tIm = (double) Math.round(im * 100000) / 100000;
        if (tIm == 0)
            return tRe + "";
        if (tRe == 0)
            return tIm + "i";
        if (tIm < 0)
            return tRe + "-" + (-tIm) + "i";
        return tRe + "+" + tIm + "i";
    }

    public Complex conj() {
        return new Complex(re, -im);
    }

    // sestevanje
    public Complex plus(Complex b) {
        Complex a = this;
        double real = a.re + b.re;
        double imag = a.im + b.im;
        return new Complex(real, imag);
    }

    // odstevanje
    public Complex minus(Complex b) {
        Complex a = this;
        double real = a.re - b.re;
        double imag = a.im - b.im;
        return new Complex(real, imag);
    }

    // mnozenje z drugim kompleksnim stevilo
    public Complex times(Complex b) {
        Complex a = this;
        double real = a.re * b.re - a.im * b.im;
        double imag = a.re * b.im + a.im * b.re;
        return new Complex(real, imag);
    }

    // mnozenje z realnim stevilom
    public Complex times(double alpha) {
        return new Complex(alpha * re, alpha * im);
    }

    // reciprocna vrednost kompleksnega stevila
    public Complex reciprocal() {
        double scale = re * re + im * im;
        return new Complex(re / scale, -im / scale);
    }

    // deljenje
    public Complex divides(Complex b) {
        Complex a = this;
        return a.times(b.reciprocal());
    }

    // e^this
    public Complex exp() {
        return new Complex(Math.exp(re) * Math.cos(im), Math.exp(re) * Math.sin(im));
    }

    // potenca komplesnega stevila
    public Complex pow(int k) {

        Complex c = new Complex(1, 0);
        for (int i = 0; i < k; i++) {
            c = c.times(this);
        }
        return c;
    }

}