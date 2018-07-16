({
	createChecklist : function(component, newChecklist) {
		var createEvent = component.getEvent("createChecklist");
        createEvent.setParams({ "checklist" : newChecklist });
        createEvent.fire();
	}
})