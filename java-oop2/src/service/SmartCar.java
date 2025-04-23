package service;

public class SmartCar extends Car {
	@Override
	public void on() {
		System.out.println("인터넷 접속 확인");
		System.out.println("시동");
	}
}
