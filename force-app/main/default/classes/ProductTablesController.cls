public with sharing class ProductTablesController {
    public static List<Product_Table__c> getProducts() {
        List<Product_Table__c> products =  [SELECT Id, Name, Image_Url__c,Title__c , Product_Description__c, Unit_Price__c
               FROM Product_Table__c ORDER BY Unit_Price__c LIMIT 100];
        for(Product_Table__c prod : products) {
            prod.Product_Description__c = prod.Product_Description__c.left(100) + '...';
        }
        return products;
    }
}