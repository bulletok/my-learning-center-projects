public with sharing class GoodsStorageController {
    
    public String sorting = 'Name__c';
    public String order = 'ASC';
    
    public void changeOrder() {
        if( order == 'ASC' ) { 
            order = 'DESC'; 
        }  else { 
           order = 'ASC'; 
        }
    }
    
    public void sortByName() {
        sorting = 'Name__c';
        changeOrder();
    }
    public void sortByType() {
        sorting = 'Type__c';
        changeOrder();
    }
    public void sortByPrice() {
        sorting = 'Price__c';
        changeOrder();
    }
    public void sortByAddDate() {
        sorting = 'Added_Date__c';
        changeOrder();
    }
    public void sortByRelDate() {
        sorting = 'Release_Date__c';
        changeOrder();
    }
    
    public List<Goods_Storage__c> getGoods() {
        List<Goods_Storage__c> goods = Database.query('SELECT Id, Name__c, Available__c, Release_Date__c, Price__c,' +
                				'Quantity__c, Added_Date__c, Type__c ' + ' FROM Goods_Storage__c ' +
                				' ORDER BY '+ sorting + ' ' + order );
        return goods;
    }
}