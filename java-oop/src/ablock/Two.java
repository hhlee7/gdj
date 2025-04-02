package ablock;

public class Two {
	public void oneTest() {
		One one = new One();
		one.a = 1;
		one.b = 2;
		one.c = 3;
		// one.d = 4; // private은 같은 패키지라도 다른 클래스에서 직접 사용 불가 / 정보은닉
	}
}
