({
    hideTable : function (component) {
        component.set("v.accounts", {});
        component.set("v.columns", []);
    },

    getRecords: function (component) {
        let action = component.get("c.getRecords");

        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", JSON.parse(response.getReturnValue()));
            } else {
                console.log('Failed with state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    getAccount : function (component, helper) {
        let action = component.get("c.getAccount");
        action.setParams({ accId : component.get("v.accId")});
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                    component.set("v.account", JSON.parse(response.getReturnValue()));
                    helper.hideTable(component);
            } else {
                console.log('Failed with state: ' + state);
                alert('You enter invalid ID. Please enter the valid ID.');
            }
        });
        $A.enqueueAction(action);
    }


})