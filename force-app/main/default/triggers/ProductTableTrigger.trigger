trigger ProductTableTrigger on Product_Table__c (before insert, before update) {
    
    Date addDate;
    
    for (Product_Table__c prod : Trigger.New) {
        if(prod.Added_Date__c == null) {
            prod.Added_Date__c = Date.today();
        }
        addDate = prod.Added_Date__c;
    }
    
    Warehouse__c[] wrhsList = [SELECT Id,Name FROM Warehouse__c WHERE
                              Period_Start__c <= :addDate AND Period_End__c >= :addDate];
    
    System.debug(wrhsList);
    
    if (wrhsList.size() > 0) {
        TriggerHandler.addProdTable(wrhsList, Trigger.New);
    } else {
        TriggerHandler.createWRHSandAddProdTable(Trigger.New, addDate);
    }
}