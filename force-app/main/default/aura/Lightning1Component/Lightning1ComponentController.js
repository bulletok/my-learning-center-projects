({
    showRecords : function (component, event, helper) {
        component.set("v.columns", [
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Number Of Employees', fieldName: 'NumberOfEmployees', type: 'number'},
            {label: 'Billing City', fieldName: 'BillingCity', type: 'text'},
            {label: 'Fax', fieldName: 'Fax', type: 'phone'},
            {label: 'Description', fieldName: 'Description', type: 'text'},
            {label: 'Account Id', fieldName: 'Id', type: 'text'}
        ]);
        component.set("v.account", {});
        helper.getRecords(component);
    },

    hideResords : function (component, event, helper) {
        helper.hideTable(component);
    },

    searchAccount : function (component, event, helper) {
        const KEY_ENTER = +13;
        if ( event.keyCode === KEY_ENTER ) {
            helper.getAccount(component, helper);
        }
    }





})