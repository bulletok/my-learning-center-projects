@isTest
private class TestGoodStorage {
    @isTest static void TestTriggerWithZeroQuantity() {
        Goods_Storage__c good = new Goods_Storage__c(Name__c = 'test', Quantity__c = 0, Release_Date__c = Date.today()-7);
        insert good;
        Goods_Storage__c bool = [SELECT Available__c FROM Goods_Storage__c WHERE Id = :good.Id];
        System.assertEquals(false, bool.Available__c);
    }
    
    @isTest static void TestTriggerWithPositiveQuantity() {
        Goods_Storage__c good = new Goods_Storage__c(Name__c = 'test', Quantity__c = 2, Release_Date__c = Date.today()-7);
        insert good;
        Goods_Storage__c bool = [SELECT Available__c FROM Goods_Storage__c WHERE Id = :good.Id];
        System.assertEquals(true, bool.Available__c);
    }
    
    @isTest static void TestGetGoods() {
        GoodsStorageController testClass =  new GoodsStorageController();
        List<sObject> testGet = testClass.getGoods();
        Schema.SObjectType type = Schema.Goods_Storage__c.getSObjectType();
        System.assertEquals(type, testGet.getSobjectType());
    }
    @isTest static void TestChangeSorting(){
        GoodsStorageController testClass =  new GoodsStorageController();
        System.assertEquals('Name__c', testClass.sorting);
        testClass.sortByPrice();
        System.assertEquals('Price__c', testClass.sorting);
        testClass.sortByType();
        System.assertEquals('Type__c', testClass.sorting);
        testClass.sortByRelDate();
        System.assertEquals('Release_Date__c', testClass.sorting);
        testClass.sortByAddDate();
        System.assertEquals('Added_Date__c', testClass.sorting);
        testClass.sortByName();
        System.assertEquals('Name__c', testClass.sorting);
    }
    @isTest static void TestChangeOrdering(){
        GoodsStorageController testClass =  new GoodsStorageController();
        System.assertEquals('ASC', testClass.order);
        testClass.changeOrder();
        System.assertEquals('DESC', testClass.order);
        testClass.changeOrder();
        System.assertEquals('ASC', testClass.order);
    } 
    @isTest static void TestEditStorage(){
        GoodEditController testClass =  new GoodEditController();
        testClass.good = new Goods_Storage__c(Name__c = 'test', Quantity__c = 2, Release_Date__c = Date.today()-7);
        insert testClass.good;
        testClass.good.Quantity__c = 1;
        testClass.save();
        PageReference result = testClass.save();
        System.assertEquals(1, testClass.good.Quantity__c);
        System.assertEquals(true, result.getRedirect());
    }
    @isTest static void TestAddNew(){
        GoodNewController testClass = new GoodNewController();
        sObject testGet = testClass.getNew();
        Schema.SObjectType type = Schema.Goods_Storage__c.getSObjectType();
        System.assertEquals(type, testGet.getSobjectType());
        testClass.newGood.Name__c = 'test';
        PageReference result = testClass.add();
        System.assertEquals(true, result.getRedirect());
    }
}