({
    reRender : function (component) {
        component.set("v.amount", null);
        return this.superAfterRender();
    }
})