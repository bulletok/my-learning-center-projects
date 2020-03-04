public with sharing class GoodEditController {
    
    public Goods_Storage__c good {get; set;}
    
    public GoodEditController() {
        good = [SELECT Id, Name__c, Release_Date__c, Price__c,Quantity__c, 
                Added_Date__c, Type__c FROM Goods_Storage__c
                WHERE Id=:ApexPages.currentPage().getParameters().get('id')];
    }
    
    public Goods_Storage__c getGood() {
        return good;
    }
        
    public PageReference del() {
        delete good;
        PageReference main = new PageReference('https://dmitriy-vrp-dev-ed.lightning.force.com/apex/GoodsStorage');
        main.setRedirect(true);
        return main;
    }
    
    public PageReference save() {
        update good;
        PageReference main = new PageReference('https://dmitriy-vrp-dev-ed.lightning.force.com/apex/GoodsStorage');
        main.setRedirect(true);
        return main;
    }
}