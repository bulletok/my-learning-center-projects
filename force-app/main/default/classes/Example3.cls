public class Example3 {
    public Set<String> getUniqueContactNames() {
        Set<String> uniqueContactNames = new Set<String>();
        
        try {
            uniqueContactNames = getUniqueNames('Contact');
        } catch(Exception ex) {
            system.debug('Unkown Error: ' + ex.getMessage());
        }
        
        return uniqueContactNames;
    }
    
    public Set<String> getUniqueAccountNames() {
        Set<String> uniqueAccountNames = new Set<String>();
        
        try {
            uniqueAccountNames = getUniqueNames('Account');
        } catch(Exception ex) {
            system.debug('Unkown Error: ' + ex.getMessage());
        }
        
        return uniqueAccountNames;
    }
    
    private Set<String> getUniqueNames(String sObjectApiName) {
        Set<String> uniqueNames = new Set<String>();
        List<SObject> sobjects 	= new List<SObject>();
        
        sobjects = Database.query('SELECT Id, Name FROM ' + sObjectApiName);
        
        for(SObject sobj: sobjects) {
            uniqueNames.add(String.valueOf(sobj.get('Name')));
        }
        
        return uniqueNames;
    }
}