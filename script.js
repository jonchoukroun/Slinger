// JavaScript for DrugWars (script.js)


// Generates random integer between min and max (inclusive)
var getRandom = function(min, max) {
    return (Math.floor(Math.random() * (max - min) +min));
}

// Create Player class
class Player {
    constructor(playerName, money, inventory) {
        this.playerName = playerName;
        this.money = money;
        this.inventory = inventory;
    }

    // Add income to money total
    addIncome(amount) {
        return this.money += amount;
    }

    // Subtract expenditure/loss from money total
    subtractLoss(amount) {
        if (this.money > amount) {
            return this.money -= amount;
        } else {
            return this.money = 0;
        }
    }

}

// Create Station class
class Station {
    constructor(stationName) {
        this.stationName = stationName;
    }

    // Announce subway Station
    announceStation() {
        return $("#mainScreen").prepend("<h3>"+this.stationName+"</h3>");
    }

    /* Random event function:
        - Officer Hardass
        - Drug price outlier
        - Mugging
        - Purchase offer (guns, coats)
    */
}


function getStation() {
    // Create instances of the subway Station class
    var stationList = [
        bronx = new Station("The Bronx"),
        ghetto = new Station("The Ghetto"),
        centralPark = new Station("Central Park"),
        manhattan = new Station("Manhattan"),
        coneyIsland = new Station("Coney Island"),
        brooklyn = new Station("Brooklyn")
    ];
    
    // Randomly call station
    var i = getRandom(0, stationList.length);
    stationList[i].announceStation();
}

window.onload = getStation()


// Create Drug class (see bottom comment about Scarcity)
class Drug {
    constructor(name, min, max) {
        this.name = name;
        this.min = min;
        this.max = max;
    }

    // Call these 2 functions at each Subway stop
    calculatePrice() {
        return getRandom(this.min, this.max);
    };

    calculateQuantity() {
        return getRandom(0, 51);
    };
}

// Create instances of the Drug class
var drugList = [
    cocaine = new Drug("Cocaine", 15000, 28000),
    weed = new Drug("Weed", 200, 850),
    heroin = new Drug("Heroin", 5000, 15000),
    acid = new Drug("Acid", 1000, 3000),
    speed = new Drug("Speed", 80, 250),
    opium = new Drug("Opium", 500, 10000)
];


var drugMenu = drugList.map(function(drug) {
    return menu = {
        name: drug.name,
        price: drug.calculatePrice(),
        quantity: drug.calculateQuantity()
    }}).filter(function(drug) {
        return drug.quantity >= 5;
        }).map(function(drug) {
                $("#menuTable").append(
                "<tr><td>"+drug.name+
                "</td><td>$</td><td>"+drug.price+
                "</td><td>"+drug.quantity+"</td></tr>");
            });

/*
var drugMenu = drugList.filter(function(drug) {
    var quantity = drug.calculateQuantity();
    console.log(drug.name, quantity);
    return quantity >= 5;
}).map(function(drug) {
    $("#menuTable").append(
    "<tr><td>"+drug.name+"</td><td>$</td><td>"+drug.calculatePrice()+
    "</td><td>"+drug.quantity+"</td></tr>");
});
*/


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
