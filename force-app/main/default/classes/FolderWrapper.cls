/*
 * Created by VRP Consulting on 16.07.2018.
 */
public class FolderWrapper implements Comparable{

    @AuraEnabled
    public Decimal Position {get;set;}
    @AuraEnabled
    public String Name {get;set;}

    public FolderWrapper(String n, Decimal pos) {
        this.Name = n;
        this.Position = pos;
    }

    public Integer compareTo(Object objectToCompareTo) {

        FolderWrapper folderWrap = (FolderWrapper)objectToCompareTo;

        Integer returnValue = 0;

        if ( this.Position > folderWrap.Position) {
            returnValue = 1;
        }
        else if ( this.Position < folderWrap.Position) {
            returnValue = -1;
        }
        System.debug('ZHOPA');

        return returnValue;
    }
}