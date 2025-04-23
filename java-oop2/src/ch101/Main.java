package ch101;

public class Main {
	public static void main(String[] args) throws ClassNotFoundException {
		try {
			System.out.println("hello"); // 모든 코드는 예외를 발생 시킬 수 있다.
			System.out.println(1/0);
			System.out.println("bye");
		} catch (Exception e) {
			System.out.println("예외 발생");
			return;
			// e.printStackTrace();
			// 예외가 발생 했을 때 조치 해야 할 내용 
		} finally {
			System.out.println("finally");
		}

		
		
		// Class.forName("java.lang.String");
		
		/*
		try {
			System.out.println(5/0);
		} catch(Exception e) {
			System.out.println("0으로 나눌 수 없습니다.");
		}
		*/
	}

}
