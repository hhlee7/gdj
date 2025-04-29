package ch04;
// this 키워드(Python에서는 self로 사용)
// this는 만들어질 예정인 객체 자신을 가르킴
// 클래스에서는 아직 만들어지지 못한 객체를 가르키기 위해서 this를 사용

public class Car {
	public Car() {
	}
	public boolean onOff;
	public void move() {
		if(this.onOff) {
			System.out.println("자동차 Move!");
		} else {
			System.out.println("시동부터...");
		}
	}
		
}
