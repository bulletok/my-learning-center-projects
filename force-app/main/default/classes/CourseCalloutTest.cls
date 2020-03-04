/*
 * Created by VRP Consulting on 14.06.2018.
 */
@IsTest
private class CourseCalloutTest {
	@isTest static void calloutMock() {
		Test.setMock(HttpCalloutMock.class, new CourseCalloutMock());
		List<Object> testList = new List<Object>();
		System.assertEquals(2, CourseController.getCourses('2018-08-03').size());
		System.assertEquals( testList, CourseController.getCourses('2022-2-22'));
	}

}