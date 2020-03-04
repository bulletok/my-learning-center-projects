trigger MediaTrigger on Media__c(before insert) {
	MediaTriggerHandler.fillOrCreateContact(Trigger.New);
}