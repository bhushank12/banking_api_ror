# README

# Banking API (Rails)

## Overview
A simple Banking API built with Ruby on Rails that supports:

1. JWT Authentication
2. Account balance check
3. Deposit transactions
4. Secure and concurrent-safe updates

## Tech Stack
1. Ruby on Rails
2. PostgreSQL
3. RSpec (Testing)
4. JWT (Authentication and authorization)

## API Endpoints

### Login

 - POST /login

Request
```
{
  "email": "alice@example.com",
  "pin": "1234"
}
```
Success Response
```
{
  "message": "Login successful",
  "token": "jwt_token_here"
}
```
Error Response
```
{
    "error": "Invalid email or pin"
}
```
### Get Account Balance

- GET /balance


Headers
```
Authorization: Bearer <token>
```

Success Response
```
{
  "balance": 1000.0
}
```

### Deposit Money
- POST /deposit

Headers
```
Authorization: Bearer <token>
```
Request
```
{
  "amount": 50
}
```

Success Response
```
{
  "balance": 1050.0,
  "message": "Deposit successfully"
}
```
Error Response
```
{
  "error": "Amount must be greater than 0 or invalid amount"
}
```
## Authentication Flow
1. User logs in using email + PIN and server returns JWT token.
2. Pass token in all protected APIs in headers as Authorization: Bearer <token> to access /deposit, /balance apis.