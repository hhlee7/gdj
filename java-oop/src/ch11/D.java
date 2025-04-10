package ch11;

public class D extends C { // 1) extends A 2) extends C
	public int k;
	// A + C 상속
	public D() {
		super(); // 부모 생성자 호출 C() -> A()
		this.k = 0;
		
		// this..
		
		// Object : super.super.super.~
		// A() : x, name, m1() / super.super.x, super.super.name, super.super.m1()
		// C() : z, m3() / super.z, super.m3()
		// D() : k / this.k
	}
	
	public static void main(String[] args) {
		D d = new D();
		d.x = 1; // this.x가 없다 -> super.x가 없다 -> super.super.x
		d.z = 2; // this.z가 없다 -> super.z
		d.k = 3; // this.k
	}
}
