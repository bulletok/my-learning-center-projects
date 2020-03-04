/*
 * Created by VRP Consulting on 19.07.2018.
 */
public class TaskPageController {

	public TaskPageController(ApexPages.StandardController con) {}

	public PageReference redirect() {
		PageReference allCons = new PageReference('/apex/TaskPage2');
		allCons.setRedirect(true);
		return allCons;
	}

}