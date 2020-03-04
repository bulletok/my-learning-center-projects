/*
 * Created by mrbul on 6/30/2018.
 */
public class RickAndMorty {

	public static void createRandomRecords() {
		List<Contact> cons = new List<Contact>();
		for (Integer i = 0; i < 10; i++) {
			Contact c = new Contact();
			Integer r = Integer.valueOf(Math.round(Math.random() * (2-1)) +1);
			if (r == 1) {
				c.FirstName = 'Rick';
				c.LastName = 'Sanchez';
			} else {
				c.FirstName = 'Morty';
				c.LastName = 'Smith';
			}
			cons.add(c);
		}
		System.debug(cons.size());
		insert cons;
	}

	public static void createMorties() {
		List<Contact> cons = new List<Contact>();
		for (Integer i = 0; i < 10; i++) {
			Contact c = new Contact();
			c.FirstName = 'MORTY';
			c.LastName = 'SMITH';
			cons.add(c);
		}
		insert cons;
	}

	public static void createRicks() {
		List<Contact> cons = new List<Contact>();
		for (Integer i = 0; i < 10; i++) {
			Contact c = new Contact();
			c.FirstName = 'RICK';
			c.LastName = 'SANCHEZ';
			cons.add(c);
		}
		insert cons;
	}
}