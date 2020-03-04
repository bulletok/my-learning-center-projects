/*
 * Created by dmitriy-p on 8/7/18.
 */
public class CreateByApiNameController {

	@AuraEnabled
	public static void createRecord(String apiName, String[] fields, String[] values) {
		if (apiName != null && fields != null && values != null && ( fields.size() == values.size())) {

			Schema.SObjectField boolField;
			Schema.SObjectType objType = Schema.getGlobalDescribe().get(apiName);
			if (objType != null) {
				SObject sObj = Schema.getGlobalDescribe().get(apiName).newSObject();
				for (String field : fields) {
					boolField = objType.getDescribe().fields.getMap().get(field);
					if (boolField == null) {
						System.debug('Incorrect fields values!');
						break;
					}
				}
				if (boolField != null) {
					for (Integer i = 0; i < fields.size(); i++) {
						sObj.put(fields[i], values[i]);
					}
					insert sObj;
					System.debug(sObj);
				}
			} else {
				System.debug('Enter correct data!');
			}
		}
	}

}