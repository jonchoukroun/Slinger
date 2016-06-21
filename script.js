function Drug(name, min, max, scarcity) {
    this.name = name;
    this.min = min;
    this.max = max;
}

Drug.prototype.calculatePrice = function() {
    var price = Math.random() * (this.max - this.min + 1) + this.min;
    return Math.round(price);
};

Drug.prototype.calculateQuantity = function() {
    var quantity = Math.random() * (50 - 1);
    return Math.round(quantity);
};

var drugList = [
    cocaine = new Drug("Cocaine", 15000, 28000, 40),
    weed = new Drug("Weed", 200, 850, 100),
    heroin = new Drug("Heroin", 5000, 15000, 70),
    acid = new Drug("Acid", 1000, 3000, 25),
    speed = new Drug("Speed", 80, 250, 65),
    opium = new Drug("Opium", 500, 10000, 20)
];

var drugMenu = drugList.map(function(drug) {
    return menu = {
        name: drug.name,
        price: drug.calculatePrice(),
        quantity: drug.calculateQuantity()
    }}).filter(function(drug) {
        return drug.quantity >= 5;
        }).map(function(drug) {
                console.log(drug);
                $("#menuTable").append(
                "<tr><td>"+drug.name+
                "</td><td>$</td><td>"+drug.price+
                "</td><td>"+drug.quantity+"</td></tr>");
            });



/* TODO
    - Rebuild menu to allow drug selection
    - Add Available & Inventory to menu table
    - Build buy/sell mechanism
    - Create form that appears right of menu

    TO INCLUDE SCARCITY:
    - add scarcity value as last parameter of each drug in drugList
    - Add the following to object Drug():
        this.scarcity = scarcity;
    - Replace statement in Drug.prototype.calculateQuantity():
        var quantity = Math.random() * (this.scarcity - 1);
*/
