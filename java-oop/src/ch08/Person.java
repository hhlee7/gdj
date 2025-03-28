package ch08;
import java.util.*;

public class Person {
	public String id;
	public String pw;
	public Person() {}
	public Person(String id, String pw) {
		this.id = id;
		this.pw = pw;
	}
	
	// 1-1) 리턴 타입 : void, 매개변수 : 없음
	public void m11() {
		System.out.println("Hello");
	}
	
	// 1-1 과제) 리턴 타입 : void, 매개변수 : 없음
	// ~ 12:00 Good Morning
	// ~ 18:00 Good Afternoon
	// ~ 00:00 Good Evening
	public void m11a() {
		Calendar c = Calendar.getInstance();
		int hour = c.get(Calendar.HOUR);
		if(hour < 12) {
			System.out.println("Good morning");
		} else if(hour < 18) {
			System.out.println("Good Afternoon");
		} else {
			System.out.println("Good Evening");
		}
	}
	
	// 1-2) 리턴 타입 : void, 매개변수 : int(시간 0 ~ 23)
	public void m12(int time) {
		if(time < 0 || time > 23) {
			System.out.println("0 ~ 23 입력하세요.");
			return;
		}
		if(time < 12) {
			System.out.println("AM");
		} else {
			System.out.println("PM");
		}
	}
	
	public void m12a(boolean flag) {
		flag = true;
		System.out.println(flag);
	}
	
	// 1-3) 리턴 타입 : void, 매개변수 : String
	// 글자 수 짝수, 홀수
	public void m13a(String name) {
		if(name == null) {
			System.out.println("null 입력 안됩니다.");
			return;
		}
		int len = name.length();
		if(len % 2 == 0) {
			System.out.println("짝수");
		} else {
			System.out.println("홀수");
		}
	}
	// 로그인(Person id, pw가 동일하면 로그인)
	public void m13b(String id, String pw) {
		if(this.id.equals(id) && this.pw.equals(pw)) {
			System.out.println("로그인 성공");
		} else {
			System.out.println("로그인 실패");
		}
	}
	
	// 1-4) 리턴 타입 : void, 매개변수 : 기본타입 배열(참조 타입)
	public void m14a(int[] arr) {
		if(arr == null) {
			System.out.println("null 입력 안됩니다.");
			return;
		}
		for(int i = 0; i < arr.length; i++) {
			arr[i] = i + 1;
		}
		for(int i = 0; i < arr.length; i++) {
			System.out.print(arr[i] + ",");
		}
		System.out.println();
	}
	
	// 1-5) 리턴 타입 : void, 매개변수 : class
	public void m15a(Data d) {
		d.y = d.y * 100;
	}
	
	// 1-6) 리턴 타입 : void, 매개변수 : class[]
	public void m16a(Data[] datas) {
		for(int i = 0; i < datas.length; i++) {
			if(datas[i].x % 2 == 1) {
				System.out.println(datas[i].y + ",");
			}
		}
		System.out.println();
	}
	public void m16b(Data[] datas, int y) {
		for(Data d : datas) {
			if(d.y == y) {
				System.out.println("d.x:" + d.x + ", d.y:" + d.y);
			}
		}
	}
	
	// 1-7) 리턴 타입 : void, 매개변수 : String 배열
	public void m17a(String[] names) {
		for(String n : names) {
			System.out.println(n);
		}
	}
	
	// 1-8) 리턴 타입 : void, 매개변수 : ArrayList
	public void m18a(ArrayList<Integer> year) {
		System.out.println("입력된 리스트 중 윤년은 ");
		for(Integer y : year) {
			if((y % 4 == 0 && y % 100 != 00) || y % 400 == 0) { // 윤년이면
				System.out.print(y + " ");
			}
		}
		System.out.println("입니다.");
	}
	
	// 1-9) 리턴 타입 : void, 매개변수 : HashMap
	public void m19a(HashMap<String, Object> map) {
		System.out.println((String)(map.get("name")));
		System.out.println((Integer)(map.get("age")));
		String[] hobby = (String[])map.get("hobby");
		for(String h : hobby) {
			System.out.print(h + ",");
		}
		System.out.println();
		
		Data data = (Data)(map.get("data"));
		System.out.println(data.x);
		System.out.println(data.y);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
