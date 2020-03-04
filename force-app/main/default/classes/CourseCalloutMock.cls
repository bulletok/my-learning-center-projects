/*
 * Created by VRP Consulting on 14.06.2018.
 */
@IsTest
global class CourseCalloutMock implements HttpCalloutMock{

	public HttpResponse respond(HttpRequest request) {
		HttpResponse myResponse = new HttpResponse();
		if(request.getEndpoint().contains('2018-8-3')) {
			myResponse.setBody('[{"Cur_ID": 145, "Date": "2018-08-03T00:00:00", "Cur_Abbreviation": "USD", "Cur_Scale": 1,"Cur_Name": "Доллар США", "Cur_OfficialRate" : "2.0002"}, {"Cur_ID": 292, "Date": "2018-08-03T00:00:00", "Cur_Abbreviation": "EUR", "Cur_Scale": 1, "Cur_Name": "Евро", "Cur_OfficialRate" : 2.3264}]');
			myResponse.setStatusCode(200);
			return myResponse;
		} else {
			myResponse.setStatusCode(404);
			return myResponse;
		}
	}
}