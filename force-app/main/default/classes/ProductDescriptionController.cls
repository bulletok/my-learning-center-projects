public with sharing class ProductDescriptionController {
    public static Product_Table__c getProduct() {
    	String prodId = ApexPages.currentPage().getParameters().get('id');
        return [SELECT Id, Name, Image_Url__c,Title__c , Product_Description__c, Unit_Price__c, Units_Avaliable__c
               FROM Product_Table__c WHERE Id=:prodId];
    }
}