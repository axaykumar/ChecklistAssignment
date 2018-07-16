public class ChecklistController {
	
    @AuraEnabled
    public static CheckList__c getChecklist(){
        List<CheckList__c> listChecklist = [SELECT Id, Name, 
                                            (SELECT Id, Name, Done__c, Description__c, CreatedDate 
                                             FROM CheckList_Items__r ORDER BY Name DESC) 
                                            FROM CheckList__c 
                                            WHERE User__c = :UserInfo.getUserId()
                                        	LIMIT 1];
        if(!listChecklist.isEmpty()){
            return listChecklist[0];
        }
        
        return new CheckList__c(User__c = UserInfo.getUserId());
    }
    
    @AuraEnabled
    public static CheckList_Item__c saveItem(CheckList_Item__c item, CheckList__c checklist){
        if(item.CheckList__c == null){
        	item.CheckList__c = checklist.Id;    
        }
        
        upsert item;
        item = [SELECT ID, Name, Description__c, Done__c, CheckList__c, CreatedDate 
                FROM CheckList_Item__c WHERE Id = :item.Id];
        return item;
    }
    
    @AuraEnabled
    public static CheckList__c saveChecklist(CheckList__c checklist){
        checklist.User__c = UserInfo.getUserId();
        upsert checklist;
        return checklist;
    }
    
    @AuraEnabled
    public static List<String> getChecklistType(){
        List<String> options = new List<String>();
        for (Schema.PicklistEntry p : CheckList__c.Type__c.getDescribe().getPicklistValues()) {
            options.add(p.getLabel());
        }
        return options;
    }
    
    @AuraEnabled
    public static String getComponentHeader(){
        String header = Checklist_Community_Header__c.getInstance().Component_Header__c;
        if(header == null){
            header = 'Checklist';
        }
        return header;
    }
}