package service;

public class OttTv implements ITv {
	@Override
	public void onOff() {
		System.out.println("Ott서비스에 로그인 확인");
		System.out.println("서비스 시작 TV ON1");
	}
}
