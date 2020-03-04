/*
 * Created by VRP Consulting on 17.08.2018.
 */
public class ContactActionController {

	@AuraEnabled
	public static Integer countCons(Id accId) {
		Integer num = [SELECT COUNT() FROM Contact WHERE AccountId = :accId];
		return num;
	}

}