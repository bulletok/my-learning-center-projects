@RestResource(urlMapping = '/Guests/*')
global class WebServices {

	@TestVisible private static Boolean checkTempKey(String key) {
		Boolean myBoolean = false;
		Datetime currentTime = Datetime.now().addMinutes(-1);

		List<Temporary_Key__c> keys = [SELECT Key__c, CreatedDate FROM Temporary_Key__c
				WHERE Key__c = :key AND CreatedDate > :currentTime];

		if (!keys.isEmpty()) {
			myBoolean = true;
		}

		return myBoolean;
	}

	@HttpGet
	global static List<Guest__c> getGuests() {
		List<Guest__c> guests;
		if (checkTempKey(RestContext.request.headers.get('"Authorization"'))) {

			RestRequest request = RestContext.request;
			String param = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1)
					.replace('+', ' ');
			if (param.equalsIgnoreCase('guests') || param == '') {
				guests =
				[SELECT Id, Name, Owner.Id, Owner.Name, Contact__r.Name, Contact__c, Is_Invited__c FROM Guest__c];
			} else if (param.equalsIgnoreCase('true') || param.equalsIgnoreCase('false')) {
				if (param.equalsIgnoreCase('true')) {
					guests =
					[SELECT Id, Name, Owner.Id, Owner.Name, Contact__r.Name, Contact__c, Is_Invited__c
							FROM Guest__c WHERE Is_Invited__c = true];

				} else {
					guests =
					[SELECT Id, Name, Owner.Id, Owner.Name, Contact__r.Name, Contact__c, Is_Invited__c
							FROM Guest__c WHERE Is_Invited__c = false];

				}
			} else {
				guests =
				[SELECT Id, Name, Owner.Id, Owner.Name, Contact__r.Name, Contact__c, Is_Invited__c
						FROM Guest__c WHERE Id = :param];

			}
		}
		return guests;
	}

	@HttpPost
	global static String checkPassword(String pass) {

		String temporaryKey = 'Password is wrong!!!';
		final String password = 'WHO_AM_I';

		if (pass != null && pass.equals(password)) {
			final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
			String randStr = '';
			while (randStr.length() < 80) {
				Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
				randStr += chars.substring(idx, idx + 1);
			}
			temporaryKey = randStr;
			Temporary_Key__c tK = new Temporary_Key__c(Key__c = temporaryKey);
			insert tK;
		}
		return temporaryKey;
	}


	@HttpPut
	global static Map<String, List<Contact>> putGuests(List<Map<String, String>> guestNames,
													   List<String> conIds) {

		Map<String, List<Contact>> response;
		if (checkTempKey(RestContext.request.headers.get('"Authorization"'))) {
			final String L_NAME = 'LastName';
			final String F_NAME = 'FirstName';

			if (guestNames != null && !guestNames.isEmpty()) {

				//list with full names from "guestNames" Map
				Map<String, List<Contact>> consMap = new Map<String, List<Contact>>();
				//fill this List
				for (Map<String, String> nMap : guestNames) {
					if (nMap.containsKey(L_NAME) && nMap.containsKey(F_NAME)) {
						consMap.put(nMap.get(F_NAME) + ' ' + nMap.get(L_NAME), new List<Contact>());
					}
				}

				//execute Contacts with current names and without guest
				Contact[] cons = [SELECT Id, Name FROM Contact WHERE Id
				NOT IN (SELECT Contact__c FROM Guest__c) AND Name IN :consMap.keySet()];

				//fill "consMap" to identify unique names, duplicates and contacts to create
				if (!cons.isEmpty()) {
					for (Contact c : cons) {
						consMap.get(c.Name).add(c);
					}
				}

				List<Contact> consToInsert = new List<Contact>();
				List<Contact> consToGuests = new List<Contact>();

				//sort "consMap" and fill "consToInsert"
				for (String key : consMap.keySet()) {
					Integer arrSize = consMap.get(key).size();
					if (arrSize > 1) {
						if (!response.containsKey(key)) {
							response.put(key, new List<Contact>());
						}
						response.get(key).addAll(consMap.get(key));
						consMap.remove(key);
					} else if (arrSize == 0) {
						String[] names = key.split('[w* ]');
						Contact newC = new Contact(
								FirstName = names[0],
								LastName = names[1]);
						consToInsert.add(newC);
					} else if (arrSize == 1) {
						consToGuests.add(consMap.get(key)[0]);
					}
				}

				if (!consToInsert.isEmpty()) {
					insert consToInsert;
					consToGuests.addAll(consToInsert);
				}

				if (!consToGuests.isEmpty()) {
					List<Guest__c> guests = new List<Guest__c>();
					for (Contact con : consToGuests) {
						guests.add(new Guest__c(Contact__c = con.Id));
					}
					insert guests;
				}
			}


			if (conIds != null && !conIds.isEmpty()) {
				List<Contact> consToGuests = [SELECT Id FROM Contact WHERE Id
				NOT IN (SELECT Contact__c FROM Guest__c) AND Id IN :conIds];
				if (!consToGuests.isEmpty()) {
					List<Guest__c> newGuests = new List<Guest__c>();
					for (Contact c : consToGuests) {
						newGuests.add(new Guest__c(Contact__c = c.Id));
					}
					insert newGuests;
				}
			}
		}
		return response;
	}

	@HttpPatch
	global static Guest__c patchGuests(String Name) {
		Guest__c result;
		if (checkTempKey(RestContext.request.headers.get('"Authorization"'))) {
			List<Guest__c> guest = [SELECt Id, Contact__r.Name, Is_Invited__c FROM Guest__c
					WHERE Contact__r.Name = :Name LIMIT 1];
			if (!guest.isEmpty()) {
				guest[0].Is_Invited__c = true;
				update guest;
				result = guest[0];
			}
		}
		return result;
	}

	@HttpDelete
	global static void deleteGuests() {
		if (checkTempKey(RestContext.request.headers.get('"Authorization"'))) {
			RestRequest request = RestContext.request;
			String Name = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1)
					.replace('+', ' ');
			List<Guest__c> guest = [SELECt Id, Contact__r.Name FROM Guest__c
					WHERE Contact__r.Name = :Name];
			if (!guest.isEmpty()) {
				delete guest;
			}
		}
	}
}