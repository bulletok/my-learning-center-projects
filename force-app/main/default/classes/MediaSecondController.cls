/*
 * Created by VRP Consulting on 31.07.2018.
 */
public class MediaSecondController {

	public List<SelectOption> opts { get; set; }
	public Id selectedContact { get; set; }
	public List<SelectOption> conMedias {get; set;}

	public MediaSecondController() {
		selectedContact = null;
	}

	public List<SelectOption> getCons() {
		opts = new List<SelectOption>();
		for (Contact c : [SELECT Id, Name FROM Contact]) {
			opts.add(new SelectOption(c.Id, c.Name));
		}
		return opts;
	}

	public void getMedias() {
		conMedias = new List<SelectOption>();
		for (Media__c m : [SELECT Id, Contact__r.Name FROM Media__c WHERE Contact__c = :selectedContact]) {
			conMedias.add(new SelectOption(m.Id, m.Contact__r.Name));
		}
	}

}