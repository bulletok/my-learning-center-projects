trigger ContactTrigger on Contact(before insert, before update, after insert, after update) {

	if (Trigger.isAfter && Trigger.isInsert) {
		//RickAndMortyTriggerHandler.handlerAfterInsertRick(Trigger.new);
		//RickAndMortyTriggerHandler.handlerAfterBulkRandomInsert();
		WelcomeEmailForContacts.sentWelcomeEmail(Trigger.New);
	}

	if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
		//RickAndMortyTriggerHandler.handlerBeforeInsertOrUpdateMorty(Trigger.new);
	}

}