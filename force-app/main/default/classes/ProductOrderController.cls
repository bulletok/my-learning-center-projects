public with sharing class ProductOrderController {
    
    public Product_Table__c prod {get; set;}
    public Contact con {get; set;}
    public Order_Table__c order {get; set;}
    
    public ProductOrderController() {
        prod = [SELECT Id, Name, Image_Url__c,Title__c , Product_Description__c, Unit_Price__c, Units_Avaliable__c
               FROM Product_Table__c WHERE Id=:ApexPages.currentPage().getParameters().get('id')];
        con = new Contact();
        order = new Order_Table__c();
    }
        
	public Product_Table__c getProduct() {
        return prod;
    }
    public Contact getContact() {
        return con;
    }
    public Order_Table__c getOrder() {
        return order;
    }
    
    public PageReference save() {
        List<Contact> newCon = [SELECT Id, FirstName, LastName, Email__c FROM Contact 
                         WHERE Email__c=:con.Email__c];
        if (!newCon.isEmpty()) {
            newCon[0].FirstName = con.FirstName;
            newCon[0].LastName = con.LastName;
        } else {
            newCon.add(new Contact(Email__c = con.Email__c,
                                FirstName = con.FirstName, LastName = con.LastName));
        }
        upsert newCon[0];
        
        Order_Table__c newOrder = new Order_Table__c(Product__c = prod.Id,
                                                    Name =  newCon[0].LastName + ' ' + newCon[0].FirstName 
                                                     + ' ordered ' + prod.Name,
                                                 	Units__c = order.Units__c,
                                                    Order_Amount__c = order.Units__c * prod.Unit_Price__c,
                                                    Contact__c = newCon[0].Id);
        insert newOrder;
                
        if((prod.Units_Avaliable__c - newOrder.Units__c) >= 0) {
            prod.Units_Avaliable__c = prod.Units_Avaliable__c - newOrder.Units__c;
            update prod;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Ваш заказ успешно завершён!'));

        } else {
            delete newOrder;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Не хватает товаров на  складе!'));

        }
        
        return null;
    }
            

}