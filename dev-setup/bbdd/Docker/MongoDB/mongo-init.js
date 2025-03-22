// Switch to the application database
db = db.getSiblingDB("mydb_mongodb");

// Create a collection
db.createCollection("first_collection");

// Insert sample data
db.first_collection.insertOne({
  name: "Initial test data",
  created_at: new Date(),
});

// Grant specific permissions to the root user for this database
// This allows using the root user to access this specific database
db = db.getSiblingDB("admin");
db.grantRolesToUser("myuser", [{ role: "readWrite", db: "mydb_mongodb" }]);
