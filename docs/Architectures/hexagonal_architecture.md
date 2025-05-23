# 🧱 Hexagonal Architecture in Express.js with TypeScript

*Functional & Maintainable APIs using the Ports & Adapters Pattern*

---

## 🚪 What is Hexagonal Architecture?

Hexagonal Architecture, also known as the **Ports and Adapters** pattern, was introduced by **Alistair Cockburn**. It promotes designing software systems in a way that **isolates the core business logic** from the outer world (like frameworks, databases, or APIs).

---

## 📦 Key Concepts

| Concept         | Description                                                |
| --------------- | ---------------------------------------------------------- |
| **Domain**      | Core logic – pure and independent of frameworks.           |
| **Ports**       | Interfaces the domain exposes (input) or expects (output). |
| **Adapters**    | Implementations of those ports. E.g., HTTP, DB, CLI.       |
| **Application** | Composes everything. Wires ports to adapters.              |

---

### 📐 Layered Structure

```bash
+---------------------------+
|       Express App         |
|  (HTTP Adapter - Input)   |
+---------------------------+
|        Input Port         |
+---------------------------+
|       Application         |
+---------------------------+
|        Output Port        |
+---------------------------+
|    DB Adapter / Services  |
+---------------------------+
```

---

## 🛠️ Tech Stack

* Express.js
* TypeScript
* Functional-style architecture
* No classes — only pure functions & closures

---

## 📁 Folder Structure

```bash
src/
├── domain/
│   └── user.ts              # Entity + Port Interfaces
├── application/
│   └── create-user.ts       # Use case
├── adapters/
│   ├── inbound/             # HTTP (input)
│   │   └── user-route.ts
│   └── outbound/            # DB (output)
│       └── user-repo.ts
├── app/
│   └── server.ts            # Express config
└── index.ts                 # Entry point
```

---

## 🧪 Example Use Case: Create a User

---

### 1. `domain/user.ts` – Entity + Ports

```ts
export interface User {
  id: string;
  name: string;
  email: string;
}

// Output Port (Repository)
export interface UserRepositoryPort {
  save(user: User): Promise<void>;
}
```

---

### 2. `application/create-user.ts` – Use Case (Input Port)

```ts
import { User, UserRepositoryPort } from "../domain/user";

export type CreateUserInput = {
  name: string;
  email: string;
};

export type CreateUserPort = (input: CreateUserInput) => Promise<User>;

export function createUserApp(userRepo: UserRepositoryPort): CreateUserPort {
  return async ({ name, email }) => {
    const user: User = {
      id: Date.now().toString(),
      name,
      email,
    };

    await userRepo.save(user);
    return user;
  };
}
```

---

### 3. `adapters/outbound/user-repo.ts` – DB Adapter (Output Port Implementation)

```ts
import { User, UserRepositoryPort } from "../../domain/user";

export function inMemoryUserRepo(): UserRepositoryPort {
  const users: User[] = [];

  return {
    async save(user: User) {
      users.push(user);
      console.log("User saved:", user);
    },
  };
}
```

---

### 4. `adapters/inbound/user-route.ts` – HTTP Adapter (Input Port)

```ts
import { Router } from "express";
import { CreateUserPort } from "../../application/create-user";

export function userRouter(createUser: CreateUserPort) {
  const router = Router();

  router.post("/", async (req, res) => {
    try {
      const user = await createUser(req.body);
      res.status(201).json(user);
    } catch (e) {
      res.status(400).json({ error: "Error creating user" });
    }
  });

  return router;
}
```

---

### 5. `app/server.ts` – Express Composition

```ts
import express from "express";
import bodyParser from "body-parser";
import { userRouter } from "../adapters/inbound/user-route";
import { createUserApp } from "../application/create-user";
import { inMemoryUserRepo } from "../adapters/outbound/user-repo";

const app = express();
app.use(bodyParser.json());

// Wire Adapters & Use Case
const userRepo = inMemoryUserRepo();
const createUser = createUserApp(userRepo);

app.use("/users", userRouter(createUser));

export default app;
```

---

### 6. `index.ts` – Start the App

```ts
import app from "./app/server";

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`🚀 Hexagonal app listening on http://localhost:${PORT}`);
});
```

---

## ✅ Benefits of Hexagonal Architecture

| Benefit                | Why it’s great 💡                           |
| ---------------------- | ------------------------------------------- |
| Framework-agnostic     | Core logic works without Express, DBs, etc. |
| Pluggable Adapters     | Easily swap Express, REST, CLI, etc.        |
| Testable               | Mock adapters or domain ports easily        |
| Separation of concerns | Clear boundaries between parts              |

---

## 🧠 Final Thoughts

Hexagonal Architecture helps you **treat the web framework as a detail**, not a foundation. It encourages **portability**, **testability**, and **long-term maintainability** — especially in growing codebases.

> “The application should not depend on the framework, the framework should depend on the application.” – *Alistair Cockburn*

---

## 🔗 Useful Resources

* [Hexagonal Architecture by Cockburn](https://alistair.cockburn.us/hexagonal-architecture/)
* [Hexagonal Node.js Example](https://dev.to/alexandrebodin/hexagonal-architecture-with-node-js-19np)
* [Ports & Adapters in TypeScript (GitHub)](https://github.com/Sairyss/domain-driven-hexagon)

---

Great! Here's a complete **blog post** version of **Hexagonal Architecture using Express.js + TypeScript** with a **class-based approach**. This structure fits teams who prefer **OOP** principles like **encapsulation**, **polymorphism**, and **dependency injection**.

---

## 🧱 Hexagonal Architecture (Class-Based Approach)

### 🧠 Architecture Diagram

```bash
┌────────────────────────────┐
│       Web Framework        │ ← HTTP (Express) = Input Adapter
└────────────┬───────────────┘
             ↓
     ┌──────────────┐
     │  Input Port  │ ← Controller calls UseCase via Interface
     └──────┬───────┘
            ↓
     ┌──────────────┐
     │   Use Case   │ ← Business Logic (core)
     └──────┬───────┘
            ↓
     ┌──────────────┐
     │ Output Port  │ ← Interface to DB, Services, etc.
     └──────┬───────┘
            ↓
     ┌──────────────┐
     │   Adapter    │ ← Implementation of Output Port (InMemoryRepo)
     └──────────────┘
```

### 📁 Folder Structure (Class-Based)

```bash
src/
├── domain/
│   ├── user.entity.ts
│   └── user.repository.ts         # Output Port (interface)
├── application/
│   └── create-user.usecase.ts     # Input Port + Use Case
├── infrastructure/
│   └── user.repository.inmemory.ts# Output Adapter
├── adapters/
│   └── user.controller.ts         # Input Adapter
├── app/
│   └── server.ts                  # App setup
└── index.ts                       # Entry point
```

---

### 1. `domain/user.entity.ts` – Entity

```ts
export class User {
  constructor(
    public readonly id: string,
    public readonly name: string,
    public readonly email: string
  ) {}
}
```

---

### 2. `domain/user.repository.ts` – Output Port

```ts
import { User } from "./user.entity";

export interface UserRepository {
  save(user: User): Promise<void>;
  findAll(): Promise<User[]>;
}
```

---

### 3. `application/create-user.usecase.ts` – Use Case

```ts
import { UserRepository } from "../domain/user.repository";
import { User } from "../domain/user.entity";

export interface CreateUserRequest {
  name: string;
  email: string;
}

export class CreateUserUseCase {
  constructor(private readonly userRepo: UserRepository) {}

  async execute(data: CreateUserRequest): Promise<User> {
    const user = new User(Date.now().toString(), data.name, data.email);
    await this.userRepo.save(user);
    return user;
  }
}
```

---

### 4. `infrastructure/user.repository.inmemory.ts` – DB Adapter

```ts
import { UserRepository } from "../domain/user.repository";
import { User } from "../domain/user.entity";

export class InMemoryUserRepository implements UserRepository {
  private users: User[] = [];

  async save(user: User): Promise<void> {
    this.users.push(user);
    console.log("Saved user:", user);
  }

  async findAll(): Promise<User[]> {
    return this.users;
  }
}
```

---

### 5. `adapters/user.controller.ts` – HTTP Adapter

```ts
import { Router, Request, Response } from "express";
import { CreateUserUseCase } from "../application/create-user.usecase";

export class UserController {
  constructor(private readonly createUserUseCase: CreateUserUseCase) {}

  getRouter(): Router {
    const router = Router();

    router.post("/", async (req: Request, res: Response) => {
      try {
        const user = await this.createUserUseCase.execute(req.body);
        res.status(201).json(user);
      } catch (e) {
        res.status(500).json({ error: "Failed to create user" });
      }
    });

    return router;
  }
}
```

---

### 6. `app/server.ts` – App Composition

```ts
import express from "express";
import bodyParser from "body-parser";
import { InMemoryUserRepository } from "../infrastructure/user.repository.inmemory";
import { CreateUserUseCase } from "../application/create-user.usecase";
import { UserController } from "../adapters/user.controller";

const app = express();
app.use(bodyParser.json());

const userRepo = new InMemoryUserRepository();
const createUserUseCase = new CreateUserUseCase(userRepo);
const userController = new UserController(createUserUseCase);

app.use("/users", userController.getRouter());

export default app;
```

---

### 7. `index.ts` – Entry Point

```ts
import app from "./app/server";

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server is running on http://localhost:${PORT}`);
});
```

---

### ✅ Summary: Why This Works

| Component           | Role                      |
| ------------------- | ------------------------- |
| `UserController`    | Input Adapter (HTTP)      |
| `CreateUserUseCase` | Application Logic         |
| `UserRepository`    | Output Port (Interface)   |
| `InMemoryUserRepo`  | Output Adapter (InMemory) |
