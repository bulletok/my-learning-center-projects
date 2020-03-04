({
    handlerChange: function (myCase, param_1, param_2, arr, drag, drop) {
        switch (myCase) {
            case 1:
                arr[drag + 1].PrevChain__c = (param_1) ? arr[drag - 1].Id : null;
                arr[drag].PrevChain__c = (param_2) ? arr[drop].Id : null;
                break;
            case 2:
                arr[drag].PrevChain__c = (param_1) ? arr[drop].Id : null;
                arr[drop + 1].PrevChain__c = (param_2) ? arr[drag].Id : null;
                break;
            case 3:
                arr[drag + 1].PrevChain__c = (param_1) ? arr[drag - 1].Id : null;
                arr[drag].PrevChain__c = (param_2) ? arr[drop].Id : null;
                arr[drop + 1].PrevChain__c = arr[drag].Id;
                break;
        }
    },

    changeLookups: function (component, event, helper) {
        let arr = component.get("v.chains");
        let drag = +component.get("v.dragIndex");
        let drop = +component.get("v.dropIndex");
        const CASE_1 = +1;
        const CASE_2 = +2;
        const CASE_3 = +3;

        // first group of exceptions
        if (!arr[drop + 1]) {
            if (!arr[drag - 1]) {
                // 2 exceptions
                helper.handlerChange(CASE_1, false, true, arr, drag, drop);
            } else {
                // !drop+1 exception
                helper.handlerChange(CASE_1, true, true, arr, drag, drop);
            }
        } else if (!arr[drag - 1]) {
            // !drag-1 exception
            helper.handlerChange(CASE_3, false, true, arr, drag, drop);
        }
        // Second group of exceptions
        else if (!arr[drop - 1]) {
            if (!arr[drag + 1]) {
                // 2 exceptions
                helper.handlerChange(CASE_2, false, true, arr, drag, drop);
            } else {
                // !drop-1 exception
                helper.handlerChange(CASE_3, true, false, arr, drag, drop);
            }
        } else if (!arr[drag + 1]) {
            // !drag +1 exception
            helper.handlerChange(CASE_2, true, true, arr, drag, drop);
        }
        // Positive cases
        else {
            helper.handlerChange(CASE_3, true, true, arr, drag, drop);
        }


        let updateLookups = component.get("c.updateLookups");
        updateLookups.setParams({chains: arr});

        updateLookups.setCallback(this, function (response) {
            let state = response.getState();
            if (state === 'SUCCESS') {
                console.log('Update state: ', state);
            } else if (state === 'ERROR') {
                console.log(response.getError()[0].message);
            }
        });
        $A.enqueueAction(updateLookups);
    }
})