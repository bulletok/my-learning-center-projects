/*
 * Created by mrbul on 6/30/2018.
 */
public class RickAndMortyTriggerHandler {

	public static void handlerAfterInsertRick(List<Contact> cons) {
		List<Contact> Morties = new List<Contact>();
		for (Contact c : cons) {
			if (c.FirstName != null && c.LastName.equalsIgnoreCase('sanchez') &&
					c.FirstName.equalsIgnoreCase('rick')) {
				Contact Morty = new Contact(
						FirstName = 'Morty',
						LastName = 'Smith',
						MyRick__c = c.Id
				);
				Morties.add(Morty);
			}
		}
		insert Morties;
	}

	public static void handlerBeforeInsertOrUpdateMorty(List<Contact> cons) {
		for (Contact c : cons) {
			if (c.FirstName != null && c.LastName.equalsIgnoreCase('Smith') &&
					c.FirstName.equalsIgnoreCase('Morty')) {
				c.SadMorty__c = (c.MyRick__c == null) ? true : false;
			}
		}
	}

	public static void handlerAfterBulkRandomInsert() {

		List<Contact> allMorties = [SELECT Id, MyRick__c FROM Contact WHERE FirstName = 'Morty'
		AND LastName = 'Smith'];

		List<Contact> sadMorties = new List<Contact>();
		Set<Id> happyMortiesIdSet = new Set<Id>();

		for (Contact c : allMorties) {
			if(c.MyRick__c != null) {
				happyMortiesIdSet.add(c.MyRick__c);
			} else {
				sadMorties.add(c);
			}
		}

		List<Contact> freeRicks = [SELECT Id FROM Contact WHERE FirstName = 'Rick'
		AND LastName = 'Sanchez' AND Id NOT IN :happyMortiesIdSet];

		if (!freeRicks.isEmpty() && !sadMorties.isEmpty()) {
			for (Integer i = 0; i < freeRicks.size(); i++) {
				if (sadMorties.size() == i) {
					break;
				}
				sadMorties[i].MyRick__c = freeRicks[i].Id;
			}
		}

		if (!sadMorties.isEmpty()) {
			update sadMorties;
		}
	}
}