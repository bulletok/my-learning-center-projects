public with sharing class CourseController {

	@AuraEnabled
	public static List<Object> getCourses(String curDate) {
		List<Object> result = new List<Object>();
		Date myDate = Date.valueOf(curDate);
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('http://www.nbrb.by/API/ExRates/Rates/?onDate='
				+myDate.year()+'-'+myDate.month()+'-'+myDate.day() + '&Periodicity=0');
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