/*
 * Created by VRP Consulting on 02.07.2018.
 */
public class MyComponentController {
	public Id cAccId {get; set;}

	public Account getCurrentAccount() {
		return [SELECT Name, AccountNumber, Phone, BillingCity, Type
		 FROM Account WHERE Id =: cAccId];
	}

}