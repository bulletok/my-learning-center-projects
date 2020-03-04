/*
 * Created by VRP Consulting on 16.07.2018.
 */
public class DragAndDropController{

	@AuraEnabled
	public static List<Chain__c> getChains() {
		List<Chain__c> chains = [SELECT Id, Name, PrevChain__c FROM Chain__c];
		return sortChains(chains);
	}

	@AuraEnabled
	public static void updateLookups(List<Chain__c> chains) {
		update chains;
	}


	private static List<Chain__c> sortChains(List<Chain__c> chains) {
		Id lookupId = null;
		Map<Id, Chain__c> chainsMap = new Map<Id, Chain__c>();

		for (Chain__c c : chains) {
			chainsMap.put(c.PrevChain__c, c);
		}
		chains.clear();

		for (Id key : chainsMap.keySet()) {
			chains.add(chainsMap.get(lookupId));
			lookupId = chainsMap.get(lookupId).Id;
		}
		return chains;
	}

}