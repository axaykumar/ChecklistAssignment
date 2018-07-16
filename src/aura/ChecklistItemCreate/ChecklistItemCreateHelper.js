({
	createItem : function(component, newItem) {
		var createEvent = component.getEvent("createItem");
        createEvent.setParams({ "item": newItem });
        createEvent.fire();
	}
})