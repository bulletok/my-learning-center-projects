/*
 * Created by VRP Consulting on 28.08.2018.
 */
public class ChildController {

	@AuraEnabled
	public static String getLogin() {
		return 'Hello from server!!!';
	}

}