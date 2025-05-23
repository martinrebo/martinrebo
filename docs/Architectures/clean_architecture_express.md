# 🧼 Clean Architecture with Express.js & TypeScript

Clean Architecture is a powerful way to organize your codebase for **scalability**, **testability**, and **separation of concerns**. In this post, we’ll explore how to implement Clean Architecture in a **Node.js** project using **Express** and **TypeScript**.

---

## 📚 What is Clean Architecture?

> Clean Architecture is a software design philosophy introduced by **Robert C. Martin (Uncle Bob)**. It emphasizes separating software into **layers**, each with distinct responsibilities.

### 🧱 Layers of Clean Architecture

``` bash
+----------------------+
|     Entities         | <- Business rules
+----------------------+
| Use Cases / Services | <- Application logic
+----------------------+
| Interface Adapters   | <- Controllers, Presenters
+----------------------+
| Framework & Drivers  | <- Express, DB, etc.
+----------------------+
```

---

## 🎯 Why Use Clean Architecture?

* ✅ **Decouples** business logic from frameworks
* 🧪 Makes **unit testing** easy
* 🔄 Encourages **modularity** and **reusability**
* 🚀 Easier to scale & maintain

---

## 🛠️ Tech Stack

* **Node.js**
* **Express.js**
* **TypeScript**
* Optional: `tsyringe` (for DI), `zod` (for validation), `jest` (for testing)

---

## 📁 Folder Structure

```bash
src/
├── domain/           # Entities, Interfaces
│   └── user.ts
├── use-cases/        # Business logic
│   └── create-user.ts
├── infrastructure/   # DB, APIs, services
│   └── user-repo.ts
├── adapters/         # Controllers, routes
│   └── user-controller.ts
├── app/              # Express App
│   └── server.ts
└── index.ts          # Entry point
```

---

## 🧪 Example: Creating a User

### 1. `domain/user.ts` - Entity & Interface

```ts
export interface User {
  id: string;
  name: string;
  email: string;
}
```

---

### 2. `use-cases/create-user.ts` - Use Case

```ts
import { User } from "../domain/user";

interface CreateUserDTO {
  name: string;
  email: string;
}

interface UserRepository {
  save(user: User): Promise<void>;
}

export class CreateUser {
  constructor(private userRepo: UserRepository) {}

  async execute(data: CreateUserDTO): Promise<User> {
    const newUser: User = {
      id: Date.now().toString(),
      ...data,
    };
    await this.userRepo.save(newUser);
    return newUser;
  }
}
```

---

### 3. `infrastructure/user-repo.ts` - Implementation

```ts
import { User } from "../domain/user";
import { UserRepository } from "../use-cases/create-user";

export class InMemoryUserRepo implements UserRepository {
  private users: User[] = [];

  async save(user: User) {
    this.users.push(user);
    console.log("User saved:", user);
  }
}
```

---

### 4. `adapters/user-controller.ts` - Adapter

```ts
import { Request, Response } from "express";
import { CreateUser } from "../use-cases/create-user";

export const userController = (createUser: CreateUser) => async (
  req: Request,
  res: Response
) => {
  const user = await createUser.execute(req.body);
  res.status(201).json(user);
};
```

---

### 5. `app/server.ts` - Express App

```ts
import express from "express";
import bodyParser from "body-parser";
import { CreateUser } from "../use-cases/create-user";
import { InMemoryUserRepo } from "../infrastructure/user-repo";
import { userController } from "../adapters/user-controller";

const app = express();
app.use(bodyParser.json());

const userRepo = new InMemoryUserRepo();
const createUser = new CreateUser(userRepo);

app.post("/users", userController(createUser));

export default app;
```

---

### 6. `index.ts` - Entry Point

```ts
import app from "./app/server";

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server listening on port ${PORT}`);
});
```

---

## 🧼 Key Clean Code Principles Applied

| Principle                   | How It's Applied                                    |
| --------------------------- | --------------------------------------------------- |
| SRP (Single Responsibility) | Each class/file does one thing well                 |
| DIP (Dependency Inversion)  | Use cases depend on abstractions (interfaces)       |
| Open/Closed                 | Easily extend use-cases without changing core logic |
| Separation of Concerns      | Framework, logic, and domain are isolated           |

---

## 📦 Suggested Libraries

| Purpose              | Library                                             |
| -------------------- | --------------------------------------------------- |
| Dependency Injection | [`tsyringe`](https://github.com/microsoft/tsyringe) |
| Validation           | [`zod`](https://github.com/colinhacks/zod)          |
| Testing              | [`jest`](https://jestjs.io/)                        |
| Environment vars     | [`dotenv`](https://github.com/motdotla/dotenv)      |

---

## 🧠 Tips

* Think of your **domain** as **framework-agnostic**.
* Add a **`__tests__/`** folder per use case to keep unit tests close.
* Introduce a `ServiceLocator` or DI container as your app grows.

---

## 📚 Further Reading

* [Clean Architecture Book – Robert C. Martin](https://www.oreilly.com/library/view/clean-architecture/9780134494272/)
* [A Simple Clean Architecture Example in Node.js](https://dev.to/eduardomoroni/simple-clean-architecture-example-in-nodejs-4ke5)
* [Express TypeScript Starter (GitHub)](https://github.com/Microsoft/TypeScript-Node-Starter)

---

## 🙌 Wrapping Up

Clean Architecture isn’t just for enterprise systems. Even small projects benefit from a **well-structured, maintainable, and testable** codebase.

> 💬 “Code is clean if it can be understood easily – by everyone on the team.” – *Robert C. Martin*

---

## 🧼 Clean Architecture in Express.js & TypeScript (Functional Style)

---
💡 Clean Architecture **does not require classes** — especially in JavaScript/TypeScript where functional programming is idiomatic. You can use **pure functions**, **factory functions**, and **closures** to achieve the same separation of concerns.

Here's the **same Clean Architecture setup** rewritten with **no classes**, just **functions** and **objects**:

## 📁 Updated Folder Structure

```bash
src/
├── domain/
│   └── user.ts
├── use-cases/
│   └── create-user.ts
├── infrastructure/
│   └── user-repo.ts
├── adapters/
│   └── user-controller.ts
├── app/
│   └── server.ts
└── index.ts
```

---

## 1. `domain/user.ts` – Entity Type

```ts
export interface User {
  id: string;
  name: string;
  email: string;
}
```

---

## 2. `use-cases/create-user.ts` – Use Case as Factory Function

```ts
import { User } from "../domain/user";

export type CreateUserFn = (data: { name: string; email: string }) => Promise<User>;

export function createUserUseCase(userRepo: { save: (user: User) => Promise<void> }): CreateUserFn {
  return async ({ name, email }) => {
    const newUser: User = {
      id: Date.now().toString(),
      name,
      email,
    };
    await userRepo.save(newUser);
    return newUser;
  };
}
```

---

## 3. `infrastructure/user-repo.ts` – Repository as Function Object

```ts
import { User } from "../domain/user";

export function createInMemoryUserRepo() {
  const users: User[] = [];

  return {
    save: async (user: User) => {
      users.push(user);
      console.log("User saved:", user);
    },
    getAll: async () => users,
  };
}
```

---

## 4. `adapters/user-controller.ts` – Controller as a Function

```ts
import { Request, Response } from "express";
import { CreateUserFn } from "../use-cases/create-user";

export function createUserController(createUser: CreateUserFn) {
  return async (req: Request, res: Response) => {
    try {
      const user = await createUser(req.body);
      res.status(201).json(user);
    } catch (err) {
      res.status(500).json({ error: "Could not create user" });
    }
  };
}
```

---

## 5. `app/server.ts` – Composing the App

```ts
import express from "express";
import bodyParser from "body-parser";
import { createInMemoryUserRepo } from "../infrastructure/user-repo";
import { createUserUseCase } from "../use-cases/create-user";
import { createUserController } from "../adapters/user-controller";

const app = express();
app.use(bodyParser.json());

const userRepo = createInMemoryUserRepo();
const createUser = createUserUseCase(userRepo);
const userHandler = createUserController(createUser);

app.post("/users", userHandler);

export default app;
```

---

## 6. `index.ts` – Starting the Server

```ts
import app from "./app/server";

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`🚀 Server is running on http://localhost:${PORT}`);
});
```

---

## ✅ Functional Clean Architecture Benefits

| Advantage                | Why it matters 🔍                  |
| ------------------------ | ---------------------------------- |
| Fewer dependencies       | No `this` binding issues, no `new` |
| Easier to test           | Just pure functions and mocks      |
| Clear separation         | Every layer gets wired explicitly  |
| Works well with DI tools | e.g., tsyringe, awilix, etc.       |

---

## 🧠 Final Thoughts

Clean Architecture works beautifully in **functional TypeScript**. In fact, it aligns well with **Unix-style composition** and **test-first development**.

If you’re looking for even **lighter alternatives**, you can:

* Replace Express with `fastify`, `hono`, or `itty-router`
* Use Zod for input validation
* Swap the in-memory repo with a real database adapter

---
