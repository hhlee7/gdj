package ch14;
public class Main {
	public static void main(String[] args) {
		Person p = new Person();
		
		Dog d = new Dog();
		p.withWalk(d); // Pet p = d;
		
		Snake s = new Snake();
		p.withWalk(s); // Pet p = s;
		
		Kangaroo k = new Kangaroo();
		p.withWalk(k); // Pet p = k;
	}
}
