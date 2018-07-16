({
    doInit: function(component, event, helper){
        var action = component.get("c.getChecklistType");
        action.setCallback(this, function(response) {
            if(response.getState() == "SUCCESS"){
                var optionsArray = response.getReturnValue();
                var opts = [];
                opts.push({ label: "--- None ---", value: "" });
                for (var i = 0; i < optionsArray.length; i++) {
                    opts.push({
                        label: optionsArray[i],
                        value: optionsArray[i]
                    });
                }
                
                component.set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },
	clickCreate : function(component, event, helper) {
		var validForm = component.find('checklistform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validForm){
            var newChecklist = component.get("v.newChecklist");
            console.log("Create Checklist: " + JSON.stringify(newChecklist));
            helper.createChecklist(component, newChecklist);
        }  
	}
})