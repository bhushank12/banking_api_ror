# README

# Banking API (Rails)

## Overview
A simple Banking API built with Ruby on Rails that supports:

1. Login
2. Account balance check
3. Deposit money to account

## Setup Instructions

1. Clone the repo -
  git clone <repo_url>
  - cd banking_api
2. Install dependencies -
  - bundle install
3. Setup database -
  - rails db:create db:migrate db:seed
4. Start server -
  - rails s
5. App will run on -
  - http://localhost:3000

## Tech Stack
1. Ruby on Rails
2. PostgreSQL
3. RSpec (Testing)
4. JWT (Authentication and authorization)

## Assumptions

1. Each user has only one account can switch to has many in future easily.
2. Balance cannot go negative.
4. JWT token expires after 24 hours.
5. No withdrawal feature implemented.

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


Headers -
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

Headers -
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

## How to Test APIs

Using Postman or curl:

1. Login
POST /login
→ Copy token from response

2. Get Balance
GET /balance
Header -
Authorization: Bearer <token>

3. Deposit
POST /deposit
Header - 
Authorization: Bearer <token>
Body:
{
  "amount": 100
}


## Authentication Flow
1. User logs in using email + PIN and server returns JWT token.
2. Pass token in all protected APIs in headers as Authorization: Bearer <token> to access /deposit, /balance apis.