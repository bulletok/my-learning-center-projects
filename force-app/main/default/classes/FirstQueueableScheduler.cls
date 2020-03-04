/*
 * Created by VRP Consulting on 18.07.2018.
 */
public class FirstQueueableScheduler implements Schedulable{

	public Void execute(System.SchedulableContext context) {

		String cronExp = '0 0 12 15 * * ?';

		Id jobId = System.enqueueJob(new FirstQueueable());
		AsyncApexJob jobInfo = [SELECT Status FROM AsyncApexJob WHERE Id = :jobId];
		if (jobInfo.Status == 'Completed') {
			System.scheduleBatch(new ConsUpdateBatch(), 'Job after first schedule.', 20, 50);
		}
	}
}