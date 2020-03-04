({
    getCount: function (component, event) {
        setTimeout(function () {
            let action = component.get("c.countCons");
            action.setParams({
                "accId": component.get("v.contact").AccountId
            });
            action.setCallback(this, function (response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    $A.get("e.force:closeQuickAction").fire();
                    component.set("v.count", response.getReturnValue());
                } else {
                    console.log('Error with state: ', state);
                }
            });
            $A.enqueueAction(action);
        }, 0);
    },

    showToast: function (component, event) {
        let toastEvent = $A.get("e.force:showToast");
        if (toastEvent) {
            toastEvent.setParams({
                "title": "Success!",
                "message": "The related Account has " + component.get("v.count") + " contacts!"
            }).fire();
        } else {
            console.log("The related Account has " + component.get("v.count") + " contacts!");
        }
    }
})