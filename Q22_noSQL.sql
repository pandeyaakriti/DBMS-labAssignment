// Customers Collection
{
  "_id": ObjectId("..."),
  "customer_id": 1,
  "name": "John Doe",
  "email": "john@email.com",
  "address": "123 Main St, City",
  "phone": "555-0101",
  "orders": [
    {
      "order_id": 1001,
      "order_date": "2024-01-15T10:30:00Z",
      "total_amount": 1109.97,
      "status": "completed",
      "items": [
        {
          "product_id": 101,
          "name": "Laptop",
          "category": "Electronics",
          "quantity": 1,
          "unit_price": 999.99
        },
        {
          "product_id": 102,
          "name": "Mouse",
          "category": "Electronics",
          "quantity": 1,
          "unit_price": 29.99
        },
        {
          "product_id": 103,
          "name": "Keyboard",
          "category": "Electronics",
          "quantity": 1,
          "unit_price": 79.99
        }
      ]
    },
    {
      "order_id": 1003,
      "order_date": "2024-01-17T09:15:00Z",
      "total_amount": 19.99,
      "status": "shipped",
      "items": [
        {
          "product_id": 104,
          "name": "Book",
          "category": "Education",
          "quantity": 1,
          "unit_price": 19.99
        }
      ]
    }
  ]
}
-- SAMPLE DATA --
db.customers.insertMany([
  {
    "customer_id": 1,
    "name": "John Doe",
    "email": "john@email.com",
    "address": "123 Main St, City",
    "phone": "555-0101",
    "orders": [
      {
        "order_id": 1001,
        "order_date": "2024-01-15T10:30:00Z",
        "total_amount": 1109.97,
        "status": "completed",
        "items": [
          {"product_id": 101, "name": "Laptop", "category": "Electronics", "quantity": 1, "unit_price": 999.99},
          {"product_id": 102, "name": "Mouse", "category": "Electronics", "quantity": 1, "unit_price": 29.99},
          {"product_id": 103, "name": "Keyboard", "category": "Electronics", "quantity": 1, "unit_price": 79.99}
        ]
      },
      {
        "order_id": 1003,
        "order_date": "2024-01-17T09:15:00Z",
        "total_amount": 19.99,
        "status": "shipped",
        "items": [
          {"product_id": 104, "name": "Book", "category": "Education", "quantity": 1, "unit_price": 19.99}
        ]
      }
    ]
  },
  {
    "customer_id": 2,
    "name": "Jane Smith",
    "email": "jane@email.com",
    "address": "456 Oak Ave, Town",
    "phone": "555-0102",
    "orders": [
      {
        "order_id": 1002,
        "order_date": "2024-01-16T14:20:00Z",
        "total_amount": 49.98,
        "status": "pending",
        "items": [
          {"product_id": 102, "name": "Mouse", "category": "Electronics", "quantity": 1, "unit_price": 29.99},
          {"product_id": 104, "name": "Book", "category": "Education", "quantity": 1, "unit_price": 19.99}
        ]
      }
    ]
  }
]);
-- get customer with details 
db.customers.aggregate([
  {$unwind: "$orders"},
  {$project: {
    "name": 1,
    "order_id": "$orders.order_id",
    "order_date": "$orders.order_date",
    "total_amount": "$orders.total_amount",
    "status": "$orders.status"
  }},
  {$sort: {"order_date": 1}}
]);