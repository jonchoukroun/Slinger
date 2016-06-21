function Drug(name, min, max, scarcity) {
    this.name = name;
    this.min = min;
    this.max = max;
    this.scarcity = scarcity;
}

Drug.prototype.calculatePrice = function() {
    var price = Math.random() * (this.max - this.min + 1) + this.min;
    return Math.round(price);
};

Drug.prototype.calculateQuantity = function() {
    var quantity = Math.random() * (this.scarcity - 1);
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

var drugAvailability = drugList.filter(function(drug) {
    return quantity = drug.calculateQuantity() > 5;}).map(function(drug) {
        $("#menuTable").append("<tr><td>"+drug.name+"</td><td>$</td><td>"
        +drug.calculatePrice().toString()+"</td</tr>");
    });
    
$("#menuTable td:contains([\d])").css("text-align", "right");

/* TODO
    - Rebuild menu to allow drug selection
    - Add Available & Inventory to menu table
    - Build buy/sell mechanism
    - Create form that appears right of menu
*/
