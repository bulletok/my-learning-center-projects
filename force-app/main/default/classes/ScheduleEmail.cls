/*
 * Created by VRP Consulting on 27.08.2018.
 */
public class ScheduleEmail implements Schedulable{

	public Void execute(System.SchedulableContext context) {
		List<Account> accs = [SELECT Name FROM Account WHERE CreatedDate = :Date.today()];
		List<Contact> cons = [SELECT Name FROM Contact WHERE CreatedDate = :Date.today()];
		List<Case> cases = [SELECT Id, Owner.Name, Account.Name FROM Case WHERE CreatedDate = :Date.today()];
		User admin = [SELECT Name, Email FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];

		String message = 'Today  created: ';
		message += 'Accounts: ' + createStringOfNames(accs);
		message += '; Contacts: ' + createStringOfNames(cons);
		message += '; Cases: ';
		if (cases != null && !cases.isEmpty()) {
			for (Case c : cases) {
				message += c.Owner.Name + ' was created case with ID ' + c.Id + ' for account ' + c.Account.Name;
			}
		}
		message += '.';

		Messaging.reserveSingleEmailCapacity(1);
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {admin.Email};
		mail.setToAddresses(toAddresses);
		mail.setReplyTo('support@salesforce.com');
		mail.setSenderDisplayName('Salesforce Support');
		mail.setSubject('New records.');
		mail.setBccSender(false);
		mail.setUseSignature(false);
		mail.setPlainTextBody(message);
		mail.setHtmlBody(message);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

	}

	private String createStringOfNames(List<sObject> objList) {
		String message = '';

		if (objList != null && !objList.isEmpty()) {
			for (sObject obj : objList) {
				message += (String) obj.get('Name') + ', ';
			}
		}

		return message;
	}
}