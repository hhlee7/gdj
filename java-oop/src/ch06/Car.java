package ch06;
import java.util.ArrayList;

public class Car {
	public int num;
	public boolean is;
	public String arr;
	public ArrayList<String> list;
	
	// 생성자가 없으면 컴파일러가 기계어로 변경할 때
	// 기본 생성자(매개값이 없는) 모양으로 자동 추가함.

	public Car() {
		// 필드 초기화 코드도 자동으로 추가
		// 필드는 초기화의 규칙이 필요
		this.num = 0;
		this.is = false;
		this.arr = null;
		this.list = null;
	}
	
	// 생성자 오버로딩
	// 일반 생성자
	public Car(int num) {
		// 컴파일러가 일반 생성자가 존재하므로 기본 생성자를 추가 X
		// 생성자안에 필드 초기화 코드가 없음 -> 컴파일러가 추가
		this.num = num;
	}
	
	public Car(boolean is) {
		this.is = is;
	}
	
	public Car(int num, boolean is) {
		this.num = num;
		this.is = is;
	}
	
	// 메서드 오버로딩 - 매개값이 다르고 이름이 같은 메서드
	public void test() {}
	public void test(int x) {}
	
	// this
	public void print() {
		System.out.println(this.num);
	}
}
