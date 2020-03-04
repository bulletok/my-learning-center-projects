trigger GoodStorageTrigger on Goods_Storage__c (before insert, before update) {
    
    for(Goods_Storage__c good : Trigger.new) {
        good.Available__c = (good.Quantity__c > 0) ? true : false;
    }
}