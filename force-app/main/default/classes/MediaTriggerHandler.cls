/*
 * Created by VRP Consulting on 31.07.2018.
 */
public class MediaTriggerHandler {

	public static void fillOrCreateContact(List<Media__c> medias) {
		for (Media__c m : medias) {
			if (m.Contact__c == null) {
				List<Contact> cons = [SELECT Id FROM Contact WHERE LastName = 'Default' LIMIT 1];
				if ( !cons.isEmpty() ) {
					System.debug('FROM SOQL: ' +cons);
					m.Contact__c = cons[0].Id;
				} else {
					Contact newCon = new Contact(LastName = 'Default');
					System.debug(newCon);
					insert newCon;
					System.debug(newCon.Id);
					m.Contact__c = newCon.Id;
				}
			}
		}
	}

}