trigger TaskTrigger on Task(before insert, after insert) {
	if (Trigger.isAfter && Trigger.isInsert) {
		TriggerHandler.createNewtask(Trigger.New);
	}
	System.debug('HELLO!');
}