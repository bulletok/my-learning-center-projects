public class Example4 {
    public Set<String> getUniqueContactNames() {
        List<SObject> sobjects 			= new List<SObject>();
        Set<String> uniqueContactNames 	= new Set<String>();
        
        try {
            sobjects 			= getRecords('Contact');
            uniqueContactNames 	= getUniqueRecordNames(sobjects);
        } catch(Exception ex) {
            system.debug('Unkown Error: ' + ex.getMessage());
        }
        
        return uniqueContactNames;
    }
    
    public Set<String> getUniqueAccountNames() {
        List<SObject> sobjects 			= new List<SObject>();
        Set<String> uniqueAccountNames 	= new Set<String>();
        
        try {
            sobjects 			= getRecords('Account');
            uniqueAccountNames 	= getUniqueRecordNames(sobjects);
        } catch(Exception ex) {
            system.debug('Unkown Error: ' + ex.getMessage());
        }
        
        return uniqueAccountNames;
    }
    
    private List<SObject> getRecords(String sObjectApiName) {
        List<SObject> sobjects 	= new List<SObject>();
        
        sobjects = Database.query('SELECT Id, Name FROM ' + sObjectApiName);
        
        return sobjects;
    }
    
    private Set<String> getUniqueRecordNames(List<SObject> sobjects) {
        Set<String> uniqueNames = new Set<String>();
        
        for(SObject sobj: sobjects) {
            uniqueNames.add(String.valueOf(sobj.get('Name')));
        }
        
        return uniqueNames;
    }
}