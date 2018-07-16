({
	doInit : function(component, event, helper) {
		helper.getChecklist(component);
        helper.getComponentHeader(component);
	},
    
    handleCreateItem: function(component, event, helper){
        var createdItem = event.getParam("item");
        helper.createItem(component, createdItem);
    },
    
    handleUpdateItem: function(component, event, helper){
        var updatedItem = event.getParam("item");
        helper.updateItem(component, updatedItem);
    },
    
    handleChecklistUpsert: function(component, event, helper){
        var Checklist = event.getParam("checklist");
        helper.createChecklist(component, Checklist);
    }
})