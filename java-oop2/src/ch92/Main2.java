package ch92;

public class Main2 {

	public static void main(String[] args) {
		Main2 main2 = new Main2();
		// 람다식
		main2.exe((name)->System.out.println("일하다.")); // 기능만 넘길 때 사용하는 문법 - 람다(Lambda)
		
		// 익명 객체
		main2.exe(new IParent() {
			@Override
			public void work(String name) {
				System.out.println(name + "이 공부하다.");
			}
		});
	}
	
	public void exe(IParent parent) {
		parent.work("구디");
	}

}

@FunctionalInterface
interface IParent {
	void work(String name);
}