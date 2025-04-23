package dto;

public class Member {
	// 정보 은닉
	private String id;
	private int age;
	private String pw;
	
	// 캡슐화
	// setter
	public void setId(String id) {
		this.id = id;
	}
	
	// getter
	public String getId() {
		return this.id;
	}

	public int getAge() {
		return this.age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getPw() {
		return this.pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}
	
	
}
