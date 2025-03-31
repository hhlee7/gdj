package ch09;

import java.util.ArrayList;
import java.util.HashMap;

public class MethodEx2 {
	// 반환 타입 : 숫자
	// 매개 타입 : 배열
	// 배열.length API 사용 금지
	// 배열을 입력하면 반환값으로 배열의 길이 반환
	public int m24a(int[] arr) { // ex) int x = new int[7]
		int result = 0;
		for(int i : arr) {
			result++;
		}
		return result;
	}
	
	public int m24b(int[] arr) { // ex) int x = new int[7]
		int i = 0;
		boolean flag = true;
		while(flag) { // 무한 루프
			try {
				int temp = arr[i];
			} catch(Exception e) {
				return i;
			}
			i++;
		}
		return i;
	}
	
	// Student 타입을 디버깅한 문자열을 반환하는 메서드
	// 반환타입 : String
	// 매개타입 : 클래스 하나
	public String m25a(Student s) {
		String result = "";
		result += "번호는 " + s.num + "이고, ";
		result += "이름은 " + s.name + "입니다.";
		return result; // 번호는 ? 이고, 이름은 ? 입니다.
	}
	
	// 반환타입 : boolean
	// 매개타입 : 클래스 두 개
	public boolean m24c(Student s1, Student s2) {
		boolean result = false;
		// s1, s2를 비교하는 코드
		if(s1.num == s2.num && s1.name.equals(s2.name)) {
			result = true;
		}
		return result;
	}
	
	// 반환타입 : 배열
	// 매개타입 : List
	// List를 입력 받아서 배열로 변경하여 반환
	public int[] m4a(ArrayList<String> list) {
		int[] result = new int[list.size()];
		int i = 0;
		for(String s : list) {
			result[i] = Integer.parseInt(s);
			i++;
		}
		return result;
	}
	
	// {과제}
	// 반환타입 : 배열
	// 매개타입 : int
	// 252 -> {2, 5, 2}
	public int[] m5a(int num) { // 나누기 연산 사용해서
		int[] result = null;
		int number = num;
		int digitCount = 0;
		
		// number의 자릿수 계산
		while(number > 0) {
			digitCount++;
			number /= 10;
		}
		
		// number 의 값을 다시 복원
		number = num;
		
		// 자릿수 크기 만큼 배열 생성
		result = new int[digitCount];
		
		// 배열 인덱스에 순차적으로 값 저장
		for(int i = digitCount - 1; i >= 0; i--) {
			result[i] = number % 10;
			number /= 10;
		}
		return result;
	}
	
	// 252 -> {"2", "5", "2"}
	public String[] m5b(int num) { // substring() 메서드 사용해서
		String[] result = null;
		String str = num + ""; // "252"
		result = new String[str.length()]; // new String[3]
		for(int i = 0; i < result.length; i++) {
			if(i != result.length - 1) {
				result[i] = str.substring(i, i + 1); // (0, 1) / (1, 2)
			} else { // (2)
				result[i] = str.substring(i);
			}
		}
		return result;
	}
	
	// 반환타입 : 클래스
	// 매개타입 : int, String
	public Student m6a(int num, String name) {
		Student s = new Student();
		s.num = num;
		s.name = name;
		return s;
	}
	
	// 반환타입 : Student[]
	// 매개타입 : List<Map>
	public Student[] m7a(ArrayList<HashMap<String, Object>> list) {
		Student[] arr = new Student[list.size()];
		int i = 0;
		for(HashMap<String, Object> m : list) {
			arr[i] = new Student();
			arr[i].num = (Integer)(m.get("num"));
			arr[i].name = (String)(m.get("name"));
			i++;
		}
		return arr;
	}
	
	// 반환타입 : List<String>
	// 매개타입 : 임의의 개수의 문자열
	public ArrayList<String> m8a(String ... name) {
		ArrayList<String> result = new ArrayList<String>();
		for(String n : name) {
			result.add(n);
		}
		return result;
	}
	
	// 반환타입 : Map
	// 매개타입 : Student
	public HashMap<String, Object> m9a(Student s) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("num", s.num);
		result.put("name", s.name);
		return result;
	}
}
