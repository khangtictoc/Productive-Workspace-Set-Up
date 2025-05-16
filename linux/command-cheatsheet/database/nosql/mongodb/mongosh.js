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




