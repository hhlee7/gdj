import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class MainTest {
	public static void main(String[] args) {
		// 자바 함수형 프로그래밍 (java 8 이상 / Lambda & Stream API 사용)
		List<String> list1 = Arrays.asList("루피", "조로", "나미", "상디");
		for(String s : list1) {
			System.out.println(s);
		}
		
		list1.stream().forEach(System.out::println); // 메서드 참조
		// 여러 메모리 공간을 사용하던 요소들이 하나의 메모리 공간으로 이동됨
		
		System.out.println("---------------");
		
		// Math, Arrays, Collections
		List<Integer> list2 = Arrays.asList(1, 2, 3, 4, 5);
		// 형식 추론
		list2.stream().filter(n -> n % 2 == 0).forEach(System.out::println);
		
		System.out.println("---------------");
		
		list1.stream().map(s -> s.length()).forEach(System.out::println);
		
		// ex) 빅데이터 수집 -> 하나의 스트림으로 변환 -> 가공 -> 출력 or 새로운 컬렉션
		
		System.out.println("---------------");
		
		List<Integer> list3 = Arrays.asList(1, 2, 3, 4, 5, 5, 6, 2, 3, 4, 5, 7, 8, 9);
		list3.stream().distinct().sorted().forEach(System.out::println);
		
		List<Integer> list4 = Arrays.asList(20, 22, 30, 27, 31, 21);
		Optional<Integer> result = list4.stream().reduce((x, y) -> x + y);
		System.out.println(result.get());
	}
}
