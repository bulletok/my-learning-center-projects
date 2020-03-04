public class TriggerHandler {
	public static Boolean myBool = true;

	public static void addProdTable(List<Warehouse__c> wrhsList, List<Product_Table__c> prodList) {

		for (Product_Table__c prod : prodList) {
			prod.Warehouse__c = wrhsList[0].Id;
		}
	}

	public static void createWRHSandAddProdTable(List<Product_Table__c> prodList, Date addDate) {

		List<Org_Configuration__c> customOrg = [SELECT Id, Period_Term__c FROM Org_Configuration__c];
		Integer period = (Integer)customOrg[0].Period_Term__c;

		Warehouse__c newWRHS = new Warehouse__c(Name = 'Warehouse' + addDate + ' ' + addDate.addDays(period),
				Period_Start__c = addDate,
				Period_End__c = addDate.addDays(period));
		insert newWRHS;
		for (Product_Table__c prod : prodList) {
			prod.Warehouse__c = newWRHS.Id;
		}
	}

	public static void createNewtask(List<Task> tasks) {
		if (myBool == true) {
			myBool = false;
			List<Task> newTasks = new List<Task>();
			for (Task t : tasks) {
				Task newTask = new Task();
				newTask.OwnerId = t.OwnerId;
				newTask.Status = t.Status;
				newTask.Subject = t.Subject;
				newTask.Priority = t.Priority;
				if (t.ActivityDate != null) {
					newTask.ActivityDate = t.ActivityDate.addDays(1);
				}
				newTasks.add(newTask);
			}
			insert newTasks ;
		}
	}
}