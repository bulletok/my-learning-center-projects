/*
 * Created by VRP Consulting on 17.08.2018.
 */
public class AllContactsController {

	@AuraEnabled
	public static List<Contact> getRelatedContacts(Id accId) {
		List<Contact> cons = [SELECT Id, Name, AccountId FROM Contact WHERE AccountId = :accId];
		return cons;
	}

}