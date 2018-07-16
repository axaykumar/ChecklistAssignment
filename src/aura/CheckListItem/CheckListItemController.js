({
	doInit : function(component, event, helper) {
		var mydate = component.get("v.item.CreatedDate");
        if(mydate){
            component.set("v.formatdate", new Date(mydate));
        }
	},
    clickDone: function(component, event, helper){
        var item = component.get("v.item");
        var updateEvent = component.getEvent("updateItem");
        updateEvent.setParams({ "item": item });
        updateEvent.fire();
    }
})