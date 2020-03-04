/*
 * Created by VRP Consulting on 24.08.2018.
 */
public class OnlinerController {

	@AuraEnabled
	public static List<Object> getCourses() {
		List<Object> result = new List<Object>();
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(	'http://www.nbrb.by/API/ExRates/Rates?Periodicity=0');
		request.setMethod('GET');
		request.setTimeout(30000);
		HttpResponse response = http.send(request);
		if(response.getStatusCode() == 200) {
			result = (List<Object>) JSON.deserializeUntyped(response.getBody());
			return result;
		}
		return result;
	}

}