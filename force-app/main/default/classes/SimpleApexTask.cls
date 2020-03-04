/*
 * Created by VRP Consulting on 06.07.2018.
 */
public class SimpleApexTask {
	Integer a = 7;
	Integer b = 4;

	public void newSidesValue(Integer inc) {
		a += inc;
		b += inc;
	}

	public String calculateSquare(Integer inc) {
		String square = 'Стороны прямоугольника не были оределены!';
		if ( a != null && b != null) {
			square = String.valueOf(( a * b ) * inc);
		}
		return square;
	}

	public String calculatePerimeter(Integer inc) {
		String perimeter = 'Стороны прямоугольника не были оределены!';
		if ( a != null && b != null) {
			perimeter = String.valueOf(( a + b ) * 2 * inc);
		}
		return perimeter;
	}
}