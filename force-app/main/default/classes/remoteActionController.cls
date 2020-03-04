/*
 * Created by VRP Consulting on 25.06.2018.
 */
public class remoteActionController {

	Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
	public static Map<String, Schema.SObjectField> objectFieldsRAW { get;set;}
	public static List<String> myFields { get; set;}

	public remoteActionController() {}

	@RemoteAction
	public static List<String> getObjects() {
		List<String> myObjects = new List<String>();
		for(Schema.SObjectType item: ProcessInstance.TargetObjectId.getDescribe().getReferenceTo()) {
			myObjects.add(item.getDescribe().getLocalName());
		}
		return myObjects;
	}

	@RemoteAction
	public static List<String> getFields(String accName) {
		myFields = new List<String>();
		String num = String.valueOf(Database.countQuery('SELECT COUNT() FROM ' + ' ' + accName ));
		myFields.add(num);
		objectFieldsRAW = Schema.getGlobalDescribe().get(accName).getDescribe().fields.getMap();
		for(Schema.SObjectField field : objectFieldsRAW.values()) {
			myFields.add(field.getDescribe().getLocalName());
		}
		return myFields;
	}

	@RemoteAction
	public static Map<String, String> getDescription(List<String> fields) {
		Map<String, String> fd = new Map<String, String>();
		objectFieldsRAW = Schema.getGlobalDescribe().get(fields[0]).getDescribe().fields.getMap();
		if(!fields.isEmpty()) {
			for(String f : fields) {
				if(fields.indexof(f) != 0)
				fd.put(f, objectFieldsRAW.get(f).getDescribe().getType().name());
			}
		}
		System.debug(fd);
		return fd;
	}

	@RemoteAction
	public static String executeSOQL(String soql) {
		List<Map<String, Object>> result = new List<Map<String, Object>>();
		List<sObject> records = Database.query(soql);


		for (sObject obj : records) {
			Map<String, Object> myMap = new Map<String, Object>();
			myMap = obj.getPopulatedFieldsAsMap();
			result.add(myMap);
		}
		String myJson = JSON.serialize(records);
		return myJson;
	}
}