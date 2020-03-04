public with sharing class GoodNewController {

    public Goods_Storage__c newGood {get; set;}
    
    public GoodNewController() {
        newGood = new Goods_Storage__c(Quantity__c = 1, Price__c = 0, Added_Date__c = Date.today(), 
                                       Release_Date__c = Date.today()-7);
    }
    
    public Goods_Storage__c getNew() {       
        return newGood;
    }
    
    public PageReference add() {
        PageReference main = new PageReference('https://dmitriy-vrp-dev-ed.lightning.force.com/apex/GoodsStorage');
        main.setRedirect(true);
        if(newGood.Release_Date__c < Date.today()) {
             newGood.Name = newGood.Name__c;
        	insert newGood;
        }
        return main;
    }    
    
}