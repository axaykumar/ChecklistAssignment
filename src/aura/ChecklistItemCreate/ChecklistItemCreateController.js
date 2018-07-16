({
	clickCreate : function(component, event, helper) {
		var validItem = component.find('itemform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validItem){
            var newItem = component.get("v.newItem");
            console.log("Create Item: " + JSON.stringify(newItem));
            helper.createItem(component, newItem);
        }
	}
})