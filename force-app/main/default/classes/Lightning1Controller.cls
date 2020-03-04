/*
 * Created by VRP Consulting on 30.07.2018.
 */
public class Lightning1Controller {

	@AuraEnabled
	public static String getRecords() {
		List<Account> accs = [
				SELECT Id, Name, NumberOfEmployees, BillingCity, Fax, Description
				FROM Account
		];
		String accsJson = (String) JSON.serialize(accs);

		return accsJson;
	}

	@AuraEnabled
	public static String getAccount(String accId) {
		List<Account> acc = [
				SELECT Id, Name, NumberOfEmployees, BillingCity, Fax, Description
				FROM Account
				WHERE Id=: accId
		        LIMIT 1
		];

		String accJson = (String) JSON.serialize(acc[0]);
		return accJson;
	}

}