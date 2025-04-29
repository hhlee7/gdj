package ch05;

public class ClassMember {
	// 1. static : ClassMember와 무관하고 공간과 이름만을 빌려다 쓰는 요소
	// 1-1) static method
	public static void sFunc() {
		System.out.println("sFunc()");
	}
	// 1-2) static field
	public static int x = 1;
	// 전역 변수는 처음부터 값을 가지고 있어야 함
	// 무조건 초기화 필요
	
	public static int[] arr = new int[3];
	// 자바는 대입 연산자 우측에 문장이 올 수 X
	
	public static int y = (int)Math.random(); // y가 랜덤값을 가짐
	
	// 1-3) static block
	static {
		for(int i = 0; i < ClassMember.arr.length; i++) {
			int rNum = (int)(Math.random() * 10) + 1;
			ClassMember.arr[i] = rNum;
		}
	}
	// 2. 메서드
	public void func() {
		System.out.println("func()");
	}
	// ClassMember cm = new ClassMember(); cm.fun();
	
	// 3. 필드
	public String name;
	
	// 4. 생성자
	public ClassMember() { // 없으면 기본 형태로 자동으로 생성됨(컴파일러)
		// 필드 초기화 코드가 없다면 자동으로 코드가 구현됨(컴파일러)
		this.name = null;
	}
	public class InClass{} // 내부 클래스
	public enum InEnum{ // 내부 Enum
		x, y
	}
	public interface InInterface{} // 내부 인터페이스
	public @interface InAnnotation{} // 내부 에노테이션
}
