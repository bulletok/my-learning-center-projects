/*
 * Created by VRP Consulting on 27.08.2018.
 */
public class WelcomeEmailForContacts {

	public static void sentWelcomeEmail(List<Contact> cons) {

		if (cons[0].Email != null && cons[0].Email != '') {
			Messaging.reserveMassEmailCapacity(1);
			EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE Name = 'Welcome New Contacts'];
			System.debug(template);
			List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			email.setTemplateId(template.Id);
			email.setToAddresses(new String[] {cons[0].Email});
			email.setTargetObjectId(cons[0].Id);
			if (cons[0].AccountId != null) {
				email.setWhatId(cons[0].AccountId);
			}
			email.setSaveAsActivity(false);
			email.setUseSignature(false);
			messages.add(email);
			Messaging.sendEmail(messages);
		}
	}
}