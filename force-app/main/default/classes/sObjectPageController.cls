/*
 * Created by VRP Consulting on 19.06.2018.
 */
public class sObjectPageController {

	public List<SelectOption> objectNames {get;set;}
	public List<SelectOption> objectFields {get;set;}
	public List<String> currentFields {get;set;}
	public List<SelectOption> fieldsDescription {get;set;}
	public List<sObject> exSOQL {get;set;}
	public Map<String, Schema.SObjectField> objectFieldsRAW {get;set;}
	Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();

	public String[] newLimits {get;set;}
	public String mySOQL {get;set;}
	public String updateSOQL {get;set;}
	public String sObj {get;set;}
	public String order {get;set;}
	public String sorting {get;set;}
	public String fields {get;set;}

	public Integer countObj {get;set;}
	public Integer currentObj {get;set;}
	public Integer limitObj {get;set;}
	public Boolean bool {get;set;}


	public List<SelectOption> limits {get;set;}

	public sObjectPageController() {
		objectNames = new List<SelectOption>();
		limits = new List<SelectOption>();
		newLimits =  new List<String>{'1','3','5','10'};
		limitObj = 3;
		bool = true;
		for(String i : newLimits) {
			limits.add(new SelectOption(i,i));
		}
		for(Schema.SObjectType item: ProcessInstance.TargetObjectId.getDescribe().getReferenceTo()) {
			objectNames.add(new SelectOption(item.getDescribe().getLocalName(),
					item.getDescribe().getLocalName()));
		}
	}

	public void getObjectFields() {
		objectFields = new List<SelectOption>();
		if(sObj != '--None--') {
			objectFieldsRAW = gd.get(sObj).getDescribe().fields.getMap();
			for(Schema.SObjectField field : objectFieldsRAW.values()) {
				objectFields.add(new SelectOption(field.getDescribe().getLocalName(),
												   field.getDescribe().getLocalName()));
			}
		}
		currentFields = new List<String>();
	}

	public void getFieldsDescription() {
		fieldsDescription = new List<SelectOption>();
		if (!currentFields.isEmpty()) {
			for (String field : currentFields) {
				fieldsDescription.add(new SelectOption(objectFieldsRAW.get(field).getDescribe().getLocalName(),
						objectFieldsRAW.get(field).getDescribe().getLocalName() +' - '+
						objectFieldsRAW.get(field).getDescribe().getType().name()));
			}
		}
	}

	public void createSOQL() {
		order = (order == null) ? 'Name' : order;
		sorting = (sorting == null) ? 'ASC' : sorting;
		currentObj = (currentObj == null) ? 0 : currentObj;
		fields = '';
		fields = String.join(currentFields, ', ');
		mySOQL = 'SELECT ' + fields + ' FROM ' + sObj + ' ' +'ORDER BY'+ ' ' +order
				 + ' ' +sorting+ ' ' + 'LIMIT ' + ' ' + limitObj;
		if(sObj.length() > 0) {
			countObj = Database.countQuery('SELECT COUNT() FROM ' + ' ' + sObj);
		}
	}
	public void executeSOQL() {
		updateSOQL = '';
		exSOQL = new List<sObject>();
		updateSOQL = mySOQL+ ' ' +'OFFSET'+ ' '+ currentObj;
		bool = (limitObj >= countObj) ? true : false;
		if(!currentFields.isEmpty()) {
			exSOQL = Database.query(updateSOQL);
		}
	}
	public void changeOrder() {
		sorting = (sorting == 'ASC') ? 'DESC' : 'ASC';
		createSOQL();
		executeSOQL();
	}
	public void fPage() {
		currentObj = 0;
		executeSOQL();
	}
	public void lPage() {
		currentObj = countObj - limitObj;
		executeSOQL();
	}
	public void prev() {
		currentObj = (currentObj -limitObj > 0) ? (currentObj -limitObj) : 0;
		executeSOQL();
	}
	public void next() {
		currentObj = (currentObj +limitObj > countObj -limitObj) ? (countObj -limitObj) : (currentObj +limitObj);
		executeSOQL();
	}

	public PageReference save() {
		update exSOQL;
		return null;
	}
}