/*
 * Created by VRP Consulting on 31.07.2018.
 */
public class MediaFirstController {

	public Media__c media { get; set; }
	public List<SelectOption> opts { get; set; }

	public MediaFirstController() {
		media = new Media__c(Contact__c = null, URL__c = null, Type__c = null);
	}

	public List<SelectOption> getCons() {
		opts = new List<SelectOption>();
		for (Contact c : [SELECT Id, Name FROM Contact]) {
			opts.add(new SelectOption(c.Id, c.Name));
		}
		return opts;
	}


	public void save() {
		insert media;
		media = new Media__c(Contact__c = null, URL__c = null, Type__c = null);
	}
}