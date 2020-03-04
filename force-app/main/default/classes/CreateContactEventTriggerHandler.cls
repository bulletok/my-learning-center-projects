/*
 * Created by VRP Consulting on 30.08.2018.
 */
public class CreateContactEventTriggerHandler {

	public static void createContacts(List<Create_Contact__e> data) {
		List<Contact> cons = new List<Contact>();

		for (Create_Contact__e evt : data) {
			Contact con = new Contact();
			con.LastName = evt.LastName__c;
			con.FirstName = evt.FirstName__c;
			con.DoNotCall = evt.DoNotCall__c;
			cons.add(con);
		}

		if (!cons.isEmpty()) {
			insert cons;
		}

	}

}