package ch13;

public class B extends A {
	final int x = 10;
	
	@Override
	public void test() {
		// this.x = 9; // 필드 앞 final -> 상수
		// 메서드 앞 final -> 오버라이딩 불가
		// 클래스 앞 final -> 상속 불가
	}
}
