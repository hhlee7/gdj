package dto;
public class MemberMain {
	public static void main(String[] args) {
		Member m1 = new Member();
		// 필드값 수정 불가
		// 정보 은닉으로 사용 불가
		// m1.id = "zoro";
		m1.setId("zoro");
		// m1.age = 22;
		m1.setAge(22);
		// m1.pw = "1234";
		m1.setPw("1234");
		// 캡슐화 메서드를 사용해야 함
		
		// 필드값 읽기 불가
		// 정보 은닉으로 사용 불가
		// System.out.println(m1.get);
		System.out.println(m1.getId());
		// System.out.println(m1.age);
		System.out.println(m1.getAge());
		// System.out.println(m1.pw);
		System.out.println(m1.getPw());
		// 캡슐화 메서드를 사용해야 함
	}
}
