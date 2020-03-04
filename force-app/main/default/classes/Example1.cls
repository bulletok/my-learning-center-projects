public class Example1 {
	public List<String> method() {
        List<SObject> objs;
        objs = [select id, name, email, phone from contact];
        	List<String> strings;
        	integer size = objs.size();
        for(integer i = 0; i < size; i ++) {
            	boolean f = false;
            integer sizeNew = strings.size();
                for(integer j = 0; j < sizeNew; j ++) {
                if(objs[i].get('name') == strings[j]) {
                f = true;
                }
                }
                if(f != true) {
             strings.add(string.valueof(objs[i].get('name')));
          }
        }
        return strings;
    		}
}