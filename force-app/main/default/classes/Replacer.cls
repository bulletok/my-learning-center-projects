public class Replacer {

    public static void doReplace() {
        List<Contact> cons = [SELECT Firstname, LastName FROM Contact 
                              WHERE LastName LIKE 'a%' OR LastName LIKE '%a'];
        List<Contact> toUpdate = new List<Contact>();
        String pattern = 'boss';
        for (Contact c : cons) {
            if (c.FirstName.containsIgnoreCase(pattern)) {
                System.debug('BEFORE: ' + c.FirstName + ' ' + c.LastName);
                c.FirstName = c.FirstName.replace(pattern, ' big ' + pattern);
                toUpdate.add(c);
               
            }
        }
        update toUpdate;
        for (Contact c : toUpdate) {
             System.debug('AFTER: ' +c.FirstName + ' ' + c.LastName);
        }
    }
}