/*
 * Created by VRP Consulting on 18.07.2018.
 */
public class FirstQueueable implements Queueable{

	public Void execute(System.QueueableContext context) {
		List<Contact> cons = new List<Contact>();

		for ( Integer i = 0; i < 200; i++ ) {
			Contact con = new Contact(FirstName = 'FirstJob');
			cons.add(con);
		}

		SecondQueueable insertJob = new SecondQueueable(cons);
		Id jobId = System.enqueueJob(insertJob);
	}
}