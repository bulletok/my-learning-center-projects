/*
 * Created by VRP Consulting on 20.08.2018.
 */
public class SuperTask {

	public static void superMethod(String apiName, List<String> fieldsList) {
		String fields = String.join(fieldsList, ', ');
		List<sObject> objs = Database.query('SELECT' + ' ' + fields + ' ' +
													   'FROM' + ' ' + apiName);

		Set<Integer> hashs = new Set<Integer>();
		List<sObject> listToDelete = new List<sObject>();

		for (sObject obj : objs) {
			Integer myHash = 0;
			for (String s : fieldsList) {
				myHash += obj.get(s).hashCode();
			}
			if (hashs.contains(myHash)) {
				listToDelete.add(obj);
			} else {
				hashs.add(myHash);
			}
		}
		if (!listToDelete.isEmpty()) {
			Database.delete(listToDelete, false);

		}
	}
}