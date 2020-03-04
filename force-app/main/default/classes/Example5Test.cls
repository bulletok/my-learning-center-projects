@IsTest
public with sharing class Example5Test {
    @IsTest
    public static void funcTest(){
        List<Contact> contacts = new List<Contact>{
                new Contact(LastName = 'test'),
                new Contact(LastName = 'test')
        };
        insert contacts;
        List<Lead> leads = new List<Lead>{
                new Lead(LastName = 'test', Company = 'company'),
                new Lead(LastName = 'test', Company = 'company')
        };
        insert leads;

        Test.startTest();
        Example5.func();
        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM Contact].size());
        System.assertEquals(1, [SELECT Id FROM Lead].size());
    }
}