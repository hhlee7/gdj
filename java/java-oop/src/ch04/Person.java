package ch04;
// 객체 간의 통신

public class Person {
	public void drive() {
		Car c1 = new Car();
		c1.move(); // this -> c1
		
		Car c2 = new Car();
		c2.onOff = true;
		c2.move(); // this -> c2
	}
}
