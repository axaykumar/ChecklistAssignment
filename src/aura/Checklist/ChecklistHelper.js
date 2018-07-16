({
	getChecklist : function(component) {
		
        var action = component.get("c.getChecklist");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var checklist = response.getReturnValue();
                if(checklist.Id != null){
                    component.set("v.hasChecklist", true);
                    component.set("v.checklistItems", checklist.CheckList_Items__r);
                }
            	component.set("v.checklist", checklist);
            }
            
        });
        $A.enqueueAction(action);
	},
    
    getComponentHeader: function(component){
        var action = component.get("c.getComponentHeader");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var headerText = response.getReturnValue();
                component.set("v.headerText", headerText);
            }
            
        });
        $A.enqueueAction(action);
    },
    saveItem: function(component, item, callback){
        var action = component.get("c.saveItem");
        var checklist = component.get("v.checklist");
        action.setParams({ "item" : item, "checklist" : checklist });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
    
    createItem: function(component, item){
        this.saveItem(component, item, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var items = component.get("v.checklistItems");
                items.push(response.getReturnValue());
                component.set("v.checklistItems", items);
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({ "title": "Success!", "message": " Your Checklist Item has been saved successfully."});
                toastEvent.fire();
            }
        });
    },
    
    updateItem: function(component, item){
        this.saveItem(component, item);
    },
    
    createChecklist: function(component, checklist){
        var action = component.get("c.saveChecklist");
        action.setParams({ "checklist" : checklist });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.checklist", response.getReturnValue());
                component.set("v.hasChecklist", true);
            }
        });
        $A.enqueueAction(action);
    }
})