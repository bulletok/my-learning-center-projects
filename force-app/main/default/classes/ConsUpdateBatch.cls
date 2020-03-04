/*
 * Created by VRP Consulting on 18.07.2018.
 */
public class ConsUpdateBatch implements Database.Batchable<sObject>{

	public Integer updatedConsCount = 0;

	public Database.QueryLocator start(Database.BatchableContext jobId) {
		return Database.getQueryLocator('SELECT FirstName, LastName FROM Contact ' +
				' WHERE FirstName = FirstJob AND LastName = SecondJob');
	}

	public Void execute(Database.BatchableContext jobId, List<Contact> recordList) {
		for (Contact c : recordList) {
			c.Title = 'Async Apex';
		}
		updatedConsCount = recordList.size();
		update recordList;
	}

	public Void finish(Database.BatchableContext jobId) {
		System.debug('Congratulation!!! ' + updatedConsCount + ' has benn updated!!!');
	}

	// TODO: Database.executeBatch(new ConsUpdateBatch(), 50);

}