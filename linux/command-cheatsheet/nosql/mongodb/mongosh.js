// USERS & ROLES
db.createUser({
    user: "admin1",
    pwd: "admin123", // passwordPrompt(),
    // customData: { somethingnonsense: 12345 },
    roles: [ { role: "readWrite", db: "db_admin" },
    ] },
);

// HANDLING DATA
db.init.insertOne({"name":"nontempy"});

// DATABASE

// Switch or create if not exist
// If db is empty, it will exists as temporary
use myNewDatabase; 
show dbs;
db;


// COLLECTIONS
show collections;


