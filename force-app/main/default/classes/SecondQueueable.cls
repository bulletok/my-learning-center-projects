/*
 * Created by VRP Consulting on 18.07.2018.
 */
public class SecondQueueable implements Queueable{

	private List<Contact> cons;

	public SecondQueueable(List<Contact> cons) {
		this.cons = cons;
	}

	public Void execute(System.QueueableContext context) {
		for (Contact c : cons) {
			c.LastName = 'SecondJob';
		}
		insert cons;
	}
}