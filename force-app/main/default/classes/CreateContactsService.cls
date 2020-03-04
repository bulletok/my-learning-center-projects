/*
 * Created by VRP Consulting on 30.08.2018.
 */
@RestResource(urlMapping = '/CreateContacts/*')
global with sharing class CreateContactsService {

	@HttpGet
	global static List<Contact> getContactsCreatedByEvent() {
		GetRecordsWithoutSharing getRecordsWithoutSharing = new GetRecordsWithoutSharing();
		List<Contact> cons = getRecordsWithoutSharing.getContactsByAutomatedProcess();
		return cons;
	}

	@HttpPost
	global static String createContactsByPlatformEvent(List<Map<String, String>> data) {
		List<Database.SaveResult> results = new List<Database.SaveResult>();
		List<Create_Contact__e> events = new List<Create_Contact__e>();
		final String LAST = 'LastName';
		final String FIRST = 'FirstName';
		final String DNCALL = 'DoNotCall';

		for (Map<String, String> conMap : data) {
			Boolean lastBool = conMap.containsKey(LAST);
			Boolean firstBool = conMap.containsKey(FIRST);
			Boolean notCBool = conMap.containsKey(DNCALL) && conMap.get(DNCALL).equalsIgnoreCase('true');
			if (lastBool) {
				Create_Contact__e evt = new Create_Contact__e();
				evt.LastName__c = conMap.get(LAST);
				evt.FirstName__c = (firstBool) ? conMap.get(FIRST) : null;
				evt.DoNotCall__c = (notCBool) ? true : false;
				events.add(evt);
			}
		}

		if (!events.isEmpty()) {
			results = EventBus.publish(events);
		}

		return JSON.serialize(results);
	}

	private without sharing class GetRecordsWithoutSharing {

		private List<Contact> getContactsByAutomatedProcess() {
			List<Contact> cons = [SELECT Id, Name FROM Contact WHERE Owner.Name = 'Automated Process'];
			return cons;
		}

	}
}