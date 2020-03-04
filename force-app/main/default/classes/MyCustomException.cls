/*
 * Created by VRP Consulting on 05.07.2018.
 */
public class MyCustomException extends Exception{

	public override String getMessage() {
		return 'Error: field "NumberOfEmployees" not must bu null !!!';
	}
}