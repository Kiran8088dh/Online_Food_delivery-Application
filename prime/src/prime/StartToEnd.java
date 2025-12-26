package prime;

import java.util.Scanner;

public class StartToEnd {
	
	public boolean isCheckPrime(int n) {
		for(int i=2 ;i*i<=n;i++) {
			if(n<2)return false;
			if(n%i==0) {
				return false;
			}
		}
		return true;
		
	}
	public void printPrime(int low,int high) {
		for(int i=low;i<=high;i++) {
			if(isCheckPrime(i)) {
				System.out.print(i + " ");
			}
		}
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner sc = new Scanner(System.in);
		StartToEnd s=new StartToEnd();
		int low =sc.nextInt();
		int high = sc.nextInt();
		
		s.printPrime(low,high);
		
	}

}
