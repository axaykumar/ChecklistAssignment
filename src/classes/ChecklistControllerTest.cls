@isTest
public class ChecklistControllerTest{
    
    @isTest
    static void getChecklistNegativeTest(){
        
        CheckList__c result = ChecklistController.getChecklist();
        System.assertEquals(result.User__c, UserInfo.getUserId());
    }
    
    @isTest
    static void getChecklistPositiveTest(){
        
        CheckList__c checklist = new CheckList__c(Name = 'Test Checklist', Type__c = 'Shopping List', User__c = UserInfo.getUserId());
        insert checklist;
        
        CheckList__c result = ChecklistController.getChecklist();
        System.assertEquals(result.CheckList_Items__r.size(), 0);
    }
    
    @isTest
    static void getChecklistBulkTest(){
        
        CheckList__c checklist = new CheckList__c(Name = 'Test Checklist', Type__c = 'Shopping List', User__c = UserInfo.getUserId());
        insert checklist;
        
        List<CheckList_Item__c> lstChecklistItems = new List<CheckList_Item__c>();
        for(Integer i = 0; i < 200; i++){
            lstChecklistItems.add(new CheckList_Item__c(CheckList__c = checklist.Id, Description__c = 'Test ' + i, Done__c = true));
        }
        insert lstChecklistItems;
        
        CheckList__c result = ChecklistController.getChecklist();
        System.assertEquals(result.CheckList_Items__r.size(), 200);
    }
    
    @isTest
    static void saveItemNegativeTest(){
        
        CheckList__c checklist = new CheckList__c(Name = 'Test Checklist', Type__c = 'Shopping List', User__c = UserInfo.getUserId());
        insert checklist;
         
        CheckList_Item__c item = new CheckList_Item__c(Description__c = 'To-do something', Done__c = false);
        
        CheckList_Item__c result = ChecklistController.saveItem(item, checklist);
        
        System.assertEquals(result.CheckList__c, checklist.Id);
    }
    
    @isTest
    static void saveItemPositiveTest(){
        
        CheckList__c checklist = new CheckList__c(Name = 'Test Checklist', Type__c = 'Shopping List', User__c = UserInfo.getUserId());
        insert checklist;
         
        CheckList_Item__c item = new CheckList_Item__c(CheckList__c = checklist.Id, Description__c = 'To-do something', Done__c = false);
        
        CheckList_Item__c result = ChecklistController.saveItem(item, checklist);
        
        System.assertEquals(result.CheckList__c, checklist.Id);
    }
    
    @isTest
    static void saveChecklistTest(){
        
        CheckList__c checklist = new CheckList__c(Name = 'My To-Do List', Type__c = 'Shopping List');
        CheckList__c result = ChecklistController.saveChecklist(checklist);
        System.assertEquals(result.User__c, UserInfo.getUserId());    
    }
    
    @isTest
    static void getChecklistTypeTest(){
        List<String> lstOptions = ChecklistController.getChecklistType();
        System.assert(lstOptions.size() > 0);
    }
    
    @isTest
    static void getComponentHeaderNegative(){
        String header = ChecklistController.getComponentHeader();
        System.assertEquals(header, 'Checklist');
    }
    
    @isTest
    static void getComponentHeaderPositive(){
        
        insert new Checklist_Community_Header__c(Component_Header__c = 'ToDos');

        String header = ChecklistController.getComponentHeader();
        System.assertEquals(header, 'ToDos');
    }
}