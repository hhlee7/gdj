package ablock;

// 메서드 생성 1원칙) 하나의 메서드는 하나의 역할만

public class Person {
	// 메서드 정보은닉
	private void first() {
		System.out.println("backup");
	}
	
	// 메서드 정보은닉
	private void second() {
		System.out.println("delete");
	}
	
	// 캡슐화
	public void deleteMember() {
		this.first();
		this.second();
	}
}
