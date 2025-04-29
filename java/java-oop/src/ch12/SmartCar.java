package ch12;

public class SmartCar extends Car {
	// Object:super.super > Car:super
	
	public String display;
	
	@Override
	public void onOff() {
		System.out.println("버튼 사용");
	}
	
	public static void main(String[] args) {
		SmartCar sc = new SmartCar();
		sc.onOff();
	}
}
