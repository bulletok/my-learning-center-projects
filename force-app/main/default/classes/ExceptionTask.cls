/*
 * Created by VRP Consulting on 05.07.2018.
 */
public class ExceptionTask {

	public static void manyExceptions() {

		//sObjectException
		try {
			List<Account> accs = [SELECT Id FROM Account LIMIT 1];

			Contact c = new Contact();
			c.FirstName = 'EXCEPTION';
			c.LastName = 'CONTACT';
			insert c;

			c.AssistantName = accs[0].Name;
			update c;
		} catch (System.SObjectException e) {
			System.debug('Message ' + e.getMessage());
		}

		//DmlException
		try {
			Contact c = new Contact();
			insert c;
		} catch (System.DmlException e) {
			System.debug('Message ' + e.getMessage());
		}

		//ListException
		try {
			List<Contact> cons = [SELECT Id fROM Contact LIMIT 2];
			update cons[3];
		} catch (System.ListException e) {
			System.debug('Message ' + e.getMessage());
		}

		//NullPointerException
		try {
			Integer expInt;
			expInt *= 4;
		} catch (System.NullPointerException e) {
			System.debug('Message ' + e.getMessage());
		}
	}

	//allDmlExceptions
	public static void allDmlExceptions() {

		try {
			Contact c = new Contact();
			insert c;
		} catch (System.DmlException e) {
			System.debug('Cause: ' + e.getCause());
			System.debug('---------------------------------------');
			System.debug('Line Number: ' + e.getLineNumber());
			System.debug('---------------------------------------');
			System.debug('Stack Trace String: ' + e.getStackTraceString());
			System.debug('---------------------------------------');
			System.debug('Type name: ' + e.getTypeName());
			System.debug('---------------------------------------');
			System.debug('getMessage: ' + e.getMessage());
			System.debug('---------------------------------------');
			System.debug('---------------------------------------');
			System.debug('---------------------------------------');
			System.debug('DmlFieldNames: ' + e.getDmlFieldNames(0));
			System.debug('---------------------------------------');
			System.debug('DmlFields: ' + e.getDmlFields(0));
			System.debug('---------------------------------------');
			System.debug('DmlId: ' + e.getDmlId(0));
			System.debug('---------------------------------------');
			System.debug('DmlIndex: ' + e.getDmlIndex(0));
			System.debug('---------------------------------------');
			System.debug('DmlMessage: ' + e.getDmlMessage(0));
			System.debug('---------------------------------------');
			System.debug('DmlStatusCode: ' + e.getDmlStatusCode(0));
			System.debug('---------------------------------------');
			System.debug('DmlType: ' + e.getDmlType(0));
			System.debug('---------------------------------------');
			System.debug('NumDml: ' + e.getNumDml());
		}
	}

	public static void accountsUseCustomExceprion(List<Account> accs) {
		try {
			for (Account acc : accs) {
				if (acc.NumberOfEmployees == null) throw new MyCustomException();
			}
		} catch (MyCustomException e) {
			System.debug('Message: ' + e.getMessage());
		}
	}

}