@isTest
public class CrowCalcTest {

	@testSetup
	static void setup() {

		List<Crow__c> crowsToAdd = new List<Crow__c>();

		for (Integer i = 0; i < 50; i++) {
			crowsToAdd.add(new Crow__c(CrowNumber__c = i));
		}

		insert crowsToAdd;


	}

	@isTest
	public static void testAddCrows() {

		Integer initialCrows = 50;

		Boolean addCrowsResult = CrowCalc.addCrows(10);

		Integer crowsAfter = [SELECT COUNT() FROM Crow__c] - initialCrows;

		System.assert(crowsAfter == 10, 'Wrong answer!');

		System.assert(addCrowsResult, 'Success addition not "true"');

		addCrowsResult = CrowCalc.addCrows(null);

		System.assert(!addCrowsResult );

	}

	@isTest
	public static void testSubtractCrows() {

		Integer numberOfCrows = 30;

		Boolean subCrowsResult = CrowCalc.subtractCrows(numberOfCrows);

		Integer crowsQuantity = [SELECT COUNT() FROM Crow__c];

		System.assert(subCrowsResult);

		System.assertEquals(20, crowsQuantity);

		subCrowsResult = CrowCalc.subtractCrows(null);

		System.assert(!subCrowsResult);


	}

	@isTest
	public static void testGetTotal() {
		Integer startVal = CrowCalc.getTotal();

		System.assertEquals(50, startVal);

		CrowCalc.addCrows(50);

		Integer crowsQuantity = [SELECT COUNT() FROM Crow__c];

		System.assertEquals(100, crowsQuantity);
	}

	@isTest
	public static void testResetCalc() {

		Integer crowsQuantity = [SELECT COUNT() FROM Crow__c];

		System.assertEquals(50, crowsQuantity);

		Boolean resertResult = CrowCalc.resetCalc();

		System.assert(resertResult);

		System.assertEquals(0, [SELECT COUNT() FROM Crow__c]);

	}

}