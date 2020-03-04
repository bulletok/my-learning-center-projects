/*
 * Created by VRP Consulting on 10.07.2018.
 */
public class MyStringProcessor implements StringProcessor{

	public String addPrefix(String str) {
		String newStr = '!_' + str;
		return newStr;
	}

	public String addPostfix(String str) {
		String newStr = str + '_!';
		return newStr;
	}

	public String removeWhitespaces(String str) {
		String newStr = str.deleteWhitespace();
		return newStr;
	}

	public void updateList (List<String> firstList, List<String> secondList) {
		for (String s : firstList.clone()) {
			secondList.add(removeWhitespaces(s));
		}
		System.debug(firstList);
		System.debug(secondList);
	}

}