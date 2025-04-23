import service.ITv;
import service.SmartTv;

public class Main {

	public static void main(String[] args) {
		ITv tv = null;
		// 부모 타입(클래스, 추상 클래스, 인터페이스)
		// 에 자식 객체를 대입 -> 다형성
		tv.onOff();
		// ITv를 통해서 SmarTv의 onOff를 호출
		
		// 중간에 통신하는 접점 역할(interface)이 없다면
		SmartTv stv = new SmartTv();
		stv.onOff();
	}

}
