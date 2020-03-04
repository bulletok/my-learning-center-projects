/*
 * Created by VRP Consulting on 19.07.2018.
 */
public class CustomTaskPageController {

	public List<Contact> getAllContacts() {
		List<Contact> cons = [SELECT Name, FirstName, LastName, Email, Phone FROM Contact];
		return cons;
	}

	public PageReference previous() {
		PageReference con = new PageReference('/apex/TaskPage?id=0037F00000Zsqs8QAB');
		con.setRedirect(true);
		return con;
	}
}