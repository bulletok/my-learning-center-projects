({
    myAction: function (component, event) {
        let amount = +component.get("v.amount");
        if (amount > 1 && amount <= 50) {
            let arr = [];
            for (let i = 1; i <= amount; i++) {
                arr.push('ITEM_'+ i);
            }
            let myEvent = component.getEvent("myEvent");
            myEvent.setParams({
                "amount" : arr
            }).fire();
        }
    },

    changeValue : function (component, event) {
        console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1')
        component.set("v.amount", event.getParam("value"));
    }
})