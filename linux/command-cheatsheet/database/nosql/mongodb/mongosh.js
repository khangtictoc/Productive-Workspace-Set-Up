// USERS & ROLES
db.createUser({
    user: "<username>", 
    pwd: "<password>",
    roles: [ { role: "readWrite", db: "<database_name>" },
    ] },
);

// HANDLING DATA
db.init.insertOne({"name":"nontempy"});

// Get all data in all collections
db.getCollectionNames().forEach(function(c){print('Collection: ' + c); db.getCollection(c).find().forEach(printjson);})


