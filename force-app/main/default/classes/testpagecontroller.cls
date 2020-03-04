public class testpagecontroller {

	public String SelectedObject {get; set;}
	public List<SelectOption> fieldLableAPI {get; set;}
	public List<selectoption> supportedObject {get; set;}
	public List<String> SelectedFields {get; set;}
	public List<sObject> ObjectList {get; set;}

	public testpagecontroller ()
		{
			//Initialize
			supportedObject = new List<selectoption>() ;
			SelectedObject = '' ;
			fieldLableAPI = new List<SelectOption>() ;
			SelectedFields = new List<String>() ;
			ObjectList = new List<sObject>() ;

			//Get only reference to objects
			for(Schema.SObjectType item : ProcessInstance.TargetObjectId.getDescribe().getReferenceTo())
				{
					//Excluding custom setting objects
					if(!item.getDescribe().isCustomSetting())
					{
						//Adding to list
						supportedObject.add(new SelectOption(item.getDescribe().getLocalName().toLowerCase() , item.getDescribe().getLabel() ));
					}
				}

		}



	Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
	Set<String> objectKeys = gd.keySet();
	public void ObjectFields()
		{
			if(SelectedObject != '--None--')
			{
				//Creating sObject for dynamic selected object
				Schema.SObjectType systemObjectType = gd.get(SelectedObject);
				//Fetching field results
				Schema.DescribeSObjectResult r = systemObjectType.getDescribe();

				Map<String, Schema.SObjectField> M = r.fields.getMap();
				//Creating picklist of fields
				for(Schema.SObjectField fieldAPI : M.values())
					{
						fieldLableAPI.add(new SelectOption(fieldAPI.getDescribe().getName() , fieldAPI.getDescribe().getLabel())) ;
					}
			}
		}

}