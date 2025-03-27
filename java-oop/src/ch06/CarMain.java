package ch06;

public class CarMain {

	public static void main(String[] args) {

		Car c = new Car();
		System.out.println(c.num);
		System.out.println(c.is);

		Car c2 = new Car(7, true);
		System.out.println(c2.num);
		System.out.println(c2.is);
		
		Car c3 = new Car(true);
		System.out.println(c3.num);
		System.out.println(c3.is);
		
		Car c4 = new Car(99, true);
		System.out.println(c4.num);
		System.out.println(c4.is);
		
		Car c1 = new Car();
		c1.print();
		c2.print();
	}
}
