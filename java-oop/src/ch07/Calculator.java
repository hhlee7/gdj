package ch07;

public class Calculator {
	public Calculator() {
		this.power = false;
	}
	public boolean power;
	public int num;
	
	public void setPower() {
		this.power = !this.power;
	}
	
	public void setNum(int num) {
		// 계산기 파워가 ON(true)일때만 실행
		if(this.power) {
			this.num = num;
		} else {
			System.out.println("계산기가 OFF 상태입니다.");
		}
	}
	
	// this.num * (0.5 ~ 1.5)
	public double setRateNum(double rate) {
		double result = 0;
		if(!this.power) { // this.power == false
			System.out.println("계산기가 OFF 상태입니다.");
		} else {
			if(!(rate >= 0.5 && rate <= 1.5)) {
				System.out.println("입력값 ERROR");
			} else {
				result = this.num * rate;
			}
		}
		return result;
	}
	
	// this.num이 짝수인지 홀수인지 알고 싶은 메서드
	public String checkNum() {
		// 계산기 파워가 ON(true)일때만 실행
		String result = "";
		if(!this.power) { // this.power == false
			System.out.println("계산기가 OFF 상태입니다.");
			result = "ERROR";
		} else {
			if(this.num % 2 == 0) {
				result = "짝수";
			} else {
				result = "홀수";
			}
		}
		return result;
		// result 안에 있는 값을 반환
	}
	

}
