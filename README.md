# README

# Banking API (Rails)

## Overview
A simple Banking API built with Ruby on Rails that supports:

1. Login
2. Account balance check
3. Deposit money to account

## Tech Stack
1. Ruby on Rails
2. PostgreSQL
3. RSpec (Testing)
4. JWT (Authentication and authorization)

## API Endpoints

### Login

 - POST /login

Request -
```
{
  "email": "alice@example.com",
  "pin": "1234"
}
```
Success -
```
{
  "message": "Login successful",
  "token": "jwt_token_here"
}
```
Error -
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

Success -
```
{
  "balance": 1000.0
}
```

Error -
```
{
    "error": "Invalid token"
}
```

### Deposit Money
- POST /deposit

Headers
```
Authorization: Bearer <token>
```
Request -
```
{
  "amount": 50
}
```

Success -
```
{
  "balance": 1050.0,
  "message": "Deposit successfully"
}
```
Error -
```
{
  "error": "Amount must be greater than 0 or invalid amount"
}
```
## Authentication Flow
1. User logs in using email + PIN and server returns JWT token.
2. Pass token in all protected APIs in headers as Authorization: Bearer <token> to access /deposit, /balance apis.