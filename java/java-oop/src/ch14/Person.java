package ch14;

public class Person {
	// 산책하는 메서드
	/*
	public void withWalkDog(Dog d) {
		d.move();
	}
	public void withWalkSnake(Snake s) {
		s.move();
	}
	public void withWalkKangaroo(Kangaroo k) {
		k.move();
	}
	*/
	public void withWalk(Pet p) { // 다형성 이용
		p.move();
	}
}
