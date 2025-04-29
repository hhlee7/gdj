package ch03;

public class Car {
	public Car() {} // 없으면 컴파일러에 의해 자동 생성
	
	public boolean onOff;
	public String name;
	public String color;
	
	public void move() {
		System.out.println("move");
	}
}
