({
    doInit: function (component, event, helper) {
        let action = component.get("c.getRelatedContacts");
        action.setParams({
            "accId" : component.get("v.recordId")
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.cons", response.getReturnValue());
            } else {
                console.log('Error with state: ', state);
            }
        });
        $A.enqueueAction(action);
    },
    
    redirect: function (component, event, helper) {
        let navEvt = $A.get("e.force:navigateToSObject");
        if (navEvt) {
            navEvt.setParams({
                "recordId": event.target.id,
                "slideDevName": "related"
            }).fire();
        }
    }
})