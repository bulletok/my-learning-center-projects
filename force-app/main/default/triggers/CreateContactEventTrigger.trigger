trigger CreateContactEventTrigger on Create_Contact__e (after insert) {
	CreateContactEventTriggerHandler.createContacts(Trigger.New);
}