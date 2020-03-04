/*
 * Created by VRP Consulting on 28.06.2018.
 */
public class userInfoPageController {

	public String firstName {
		get;set;
	}
	public String lastName {
		get;set;
	}
	public String userId {
		get;set;
	}
	public String defaultCurrency {
		get;set;
	}
	public String userEmail {
		get;set;
	}
	public String organizationName {
		get;set;
	}
	public Integer limitQueries {
		get;set;
	}
	public Date dateToday {
		get;set;
	}

	public userInfoPageController() {
		firstName = UserInfo.getFirstName();
		lastName = UserInfo.getLastName();
		userId = UserInfo.getUserId();
		defaultCurrency = UserInfo.getDefaultCurrency();
		userEmail = UserInfo.getUserEmail();
		organizationName = UserInfo.getOrganizationName();
		limitQueries = Limits.getLimitQueries();
		dateToday = System.today();
	}
}