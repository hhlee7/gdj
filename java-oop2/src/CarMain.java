import service.Car;
import service.NetflixCar;

public class CarMain {

	public static void main(String[] args) {
		// 서로 통신하는 접점 역할은 interface가 아니어도 되는데?
		Car c = new NetflixCar();
		c.on();
	}

}
