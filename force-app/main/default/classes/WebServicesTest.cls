/*
 * Created by VRP Consulting on 17.08.2018.
 */
@IsTest
private class WebServicesTest {

	@TestSetup
	static void setup() {

		for (Integer i = 0; i < 6; i++) {
			Contact con = new Contact(LastName = 'ZHOPA');
			insert con;
			Guest__c gs = new Guest__c(Contact__c = con.Id);
			gs.Is_Invited__c = ( i < 3) ? true : false;
			insert gs;
		}
	}

	@isTest
	static void testGet() {

	}



}