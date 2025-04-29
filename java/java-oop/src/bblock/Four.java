package bblock;
import ablock.One;
public class Four extends One {
	public void oneTest () {
		this.a = 1;
		this.b = 2; // protected는 같은 패키지에서 사용이 가능하나, 상속 관계인 자식 클래스에서는 호출 가능
		// this.c = 3;
		// this.d = 4;
	}
}
