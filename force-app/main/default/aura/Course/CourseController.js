({
    doRequest : function (component, event, helper) {
        let action = component.get("c.getCourses");
        let day = component.get("v.day");
        action.setParams({"curDate": day});
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                helper.showTable(component, helper);
                component.set("v.courses", response.getReturnValue());
            } else {
                console.log('Failed with state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },

    convertToBYN : function (component, event, helper) {
        component.set("v.convertedValue",
            component.get("v.rate") * component.get("v.curAmount") + ' BYN');
    },

    convertAny : function (component, event, helper) {
        let fromCur = component.get("v.curOne");
        let toCur = component.get("v.curTwo");
        let amount = component.get("v.uAmount");
        if ( fromCur && toCur && amount) {
            component.set("v.uConvertedValue", (fromCur * amount) / toCur);
        } else {
            component.set("v.uConvertedValue", null);
        }
    }

})