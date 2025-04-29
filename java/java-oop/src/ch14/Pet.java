package ch14;

public abstract class Pet { // 추상 클래스 : 오로지 부모 역할만 수행함 / 추상 메서드 생성자는 호출 불가
	public abstract void move(); // 추상 메서드 / 미완성된 메서드 / 구현부 없음 : 오버라이딩 하기 위해 사용
	public void move2() {};
	int x;
}
