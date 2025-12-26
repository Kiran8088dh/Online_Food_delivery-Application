package prime;

import java.util.Scanner;

public class primeNumber {

    // Check if a number is prime
    public static boolean isPrime(int n) {
        if (n <= 1) return false;
        for (int i = 2; i <= Math.sqrt(n); i++) {
            if (n % i == 0)
                return false;
        }
        return true;
    }

    // Print all prime numbers between M and N
    public static void printPrimesBetween(int N, int M) {
        for (int i = M + 1; i < N; i++) {
            if (isPrime(i)) {
                System.out.print(i + " ");
            }
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

       
        int N = sc.nextInt();

        
        int M = sc.nextInt();

        printPrimesBetween(N, M);
    }
}
