package ch92;

public class Main {
	public void exe(Parent parent) {
		parent.work();
	}
	
	public static void main(String[] args) {
		Main main = new Main();
		Parent parent = new Parent();
		main.exe(parent);
		
		Child parent2 = new Child(); // 다형성
		main.exe(parent2);
		
		main.exe(new Child()); // 다형성
		
		Parent parent3 = new Parent() { // 일회성 객체, 익명 객체 -> 클래스를 따로 만들 필요가 없다.
			@Override
			void work() {
				System.out.println("밥을 먹다.");
			}
		};
		main.exe(parent3);
		
		main.exe(new Parent() { // 익명 객체의 변수를 만들 필요가 없다. class 익명 extends Parent
			@Override
			void work() {
				System.out.println("밥을 먹다.");
			}
		});
	}

}

class Parent {
	void work() {
		System.out.println("일을 한다.");
	}
}

class Child extends Parent { // 부모(extends, implements) 자식 관계
	@Override
	void work() {
		System.out.println("공부를 한다.");
	}
}
