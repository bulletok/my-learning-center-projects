public class Example5 {
    public static void func() {
		List<Contact> cons = [SELECT Name FROM Contact];
		List<Lead> leads = [SELECT Name FROM Lead];

		List<sObject> recsToDel = new List<sObject>();
		recsToDel.addAll(returnDuplicates(cons));
		recsToDel.addAll(returnDuplicates(leads));

		List<Database.DeleteResult> deleteResult = Database.delete(recsToDel, false);
		System.debug(deleteResult);
    }

	private static List<sObject> returnDuplicates(List<sObject> objs) {
		Set<Object> setForCheck = new Set<Object>();
		List<sObject> recsToDel = new List<sObject>();

		for (sObject obj : objs) {
			if (!setForCheck.contains(obj.get('Name'))) {
				setForCheck.add(obj.get('Name'));
			} else {
				recsToDel.add(obj);
			}
		}
		return recsToDel;

	}
}