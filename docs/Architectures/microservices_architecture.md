# 🧩 Microservices Architecture with Express.js & TypeScript

*Scalable APIs using independent, decoupled services*

---

## 🚀 What is Microservices Architecture?

**Microservices Architecture** is a design style that structures an application as a **collection of loosely coupled services**, each focused on a single business capability.

> 🧠 "Do one thing well. Expose it via a well-defined interface. Let services evolve independently."

---

## 🧱 Characteristics of Microservices

| Feature                   | Description                                            |
| ------------------------- | ------------------------------------------------------ |
| 🧩 Small, independent     | Each service owns its data, logic, and APIs            |
| 🌐 Own API                | Services communicate via HTTP, gRPC, or message queues |
| 🗃️ Separate databases    | No shared DBs – services own their persistence         |
| 🚀 Independent deployment | Each service can be deployed independently             |
| 🧪 Isolated failure       | If one service fails, others continue to function      |

---

## 🛠 Stack for This Demo

* **Express.js** – Web server per service
* **TypeScript** – Strong typing and maintainability
* **Docker** – Containerization
* **HTTP REST** – Simple service-to-service communication (via `axios`)
* Optional: Add a message broker (e.g., RabbitMQ, Kafka) later

---

## 📁 Example: Users + Orders

We’ll build 2 services:

```bash
users-service/
orders-service/
```

Each has its own:

* Express app
* Database (mocked)
* API
* Docker container

---

### 🔀 Services Flow

```bash
Client → Users Service
            ↓
         (calls)
            ↓
        Orders Service
```

---

## 🧱 1. Users Service

### 📁 `users-service/`

```bash
users-service/
├── src/
│   ├── routes/
│   │   └── user.routes.ts
│   ├── app.ts
│   └── index.ts
├── Dockerfile
├── package.json
└── tsconfig.json
```

### `user.routes.ts`

```ts
import { Router } from "express";

const router = Router();

router.get("/", (req, res) => {
  res.json([{ id: 1, name: "Alice" }]);
});

export default router;
```

### `app.ts`

```ts
import express from "express";
import userRoutes from "./routes/user.routes";

const app = express();
app.use(express.json());
app.use("/users", userRoutes);

export default app;
```

### `index.ts`

```ts
import app from "./app";

app.listen(4001, () => {
  console.log("👤 Users Service listening on port 4001");
});
```

---

## 🧱 2. Orders Service

### 📁 `orders-service/`

```bash
orders-service/
├── src/
│   ├── routes/
│   │   └── order.routes.ts
│   ├── services/
│   │   └── user.service.ts
│   ├── app.ts
│   └── index.ts
├── Dockerfile
├── package.json
└── tsconfig.json
```

### `order.routes.ts`

```ts
import { Router } from "express";
import { getUserById } from "../services/user.service";

const router = Router();

router.get("/", async (req, res) => {
  const user = await getUserById(1); // Example: calling Users Service
  res.json([{ id: 101, item: "Book", user }]);
});

export default router;
```

### `user.service.ts`

```ts
import axios from "axios";

export async function getUserById(id: number) {
  const res = await axios.get(`http://localhost:4001/users`);
  return res.data.find((u: any) => u.id === id);
}
```

### `app.ts` for Orders Service

```ts
import express from "express";
import orderRoutes from "./routes/order.routes";

const app = express();
app.use(express.json());
app.use("/orders", orderRoutes);

export default app;
```

### `index.ts` for Orders Service

```ts
import app from "./app";

app.listen(4002, () => {
  console.log("📦 Orders Service listening on port 4002");
});
```

---

## 🐳 Dockerize Each Service

### `users-service/Dockerfile`

```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "run", "start"]
```

### `orders-service/Dockerfile`

```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "run", "start"]
```

---

## 🧪 Testing Locally

### Run with Docker Compose (optional)

```yaml
# docker-compose.yml
version: "3"
services:
  users:
    build: ./users-service
    ports:
      - "4001:4001"

  orders:
    build: ./orders-service
    ports:
      - "4002:4002"
```

---

## 🧠 Best Practices for Microservices

| Practice                | Description                                         |
| ----------------------- | --------------------------------------------------- |
| 🚪 Define clear APIs    | REST, gRPC, or message-based                        |
| 🗃️ Own your data       | No shared DBs                                       |
| 📊 Monitoring           | Use observability tools (e.g., Prometheus, Grafana) |
| ⚠️ Handle failures      | Use retries, circuit breakers                       |
| 📦 Containerize         | Docker/Kubernetes for isolation                     |
| 🔐 Secure communication | JWT, API keys, etc.                                 |

---

## 🚀 When to Use Microservices

✅ Good for:

* Large, scaling teams
* Domain-driven design
* Independent deployments
* High availability

❌ Not great for:

* Small teams or MVPs
* Simple CRUD apps

---

## 📚 Further Reading

* [Microservices by Martin Fowler](https://martinfowler.com/articles/microservices.html)
* [12-Factor App Methodology](https://12factor.net/)
* [Node.js Microservice Frameworks](https://moleculer.services/)
* [Event-driven communication](https://docs.nestjs.com/microservices/basics)

---

Awesome! Here's an **enhanced version** of the blog post that includes **RabbitMQ** 🐇 for **asynchronous communication** between microservices. This setup keeps HTTP for queries, and introduces **RabbitMQ for events** (e.g., when a new user is created).

---

## 🧩 Microservices Architecture with Express.js, TypeScript & RabbitMQ

*Decoupled services with async messaging*

## 🧠 Why RabbitMQ?

RabbitMQ is a **message broker** that enables microservices to **communicate asynchronously** by publishing and subscribing to events instead of making direct HTTP calls.

### 🚦 Synchronous (HTTP) vs Asynchronous (RabbitMQ)

| Feature    | HTTP                     | RabbitMQ                       |
| ---------- | ------------------------ | ------------------------------ |
| Pattern    | Request/Response         | Pub/Sub or Work Queue          |
| Coupling   | Tight                    | Loose                          |
| Speed      | Fast, but blocking       | Buffered, async                |
| Resilience | Fails if service is down | Can queue messages until ready |

---

## 🧪 What We'll Build

* `users-service`: Sends event to RabbitMQ when user is created
* `orders-service`: Listens for new user events and logs or stores them
* RabbitMQ for messaging

---

## 🐳 Docker Compose Setup

### `docker-compose.yml`

```yaml
version: "3.8"
services:
  rabbitmq:
    image: rabbitmq:3-management
    ports:
      - "5672:5672"     # RabbitMQ connection port
      - "15672:15672"   # RabbitMQ dashboard

  users:
    build: ./users-service
    ports:
      - "4001:4001"
    depends_on:
      - rabbitmq

  orders:
    build: ./orders-service
    ports:
      - "4002:4002"
    depends_on:
      - rabbitmq
```

🔗 RabbitMQ Dashboard: [http://localhost:15672](http://localhost:15672)
🧪 Default login: `guest` / `guest`

---

## 🧱 USERS SERVICE

### `users-service/src/events/rabbitmq.ts`

```ts
import amqp from "amqplib";

let channel: amqp.Channel;

export async function connectRabbitMQ() {
  const connection = await amqp.connect("amqp://rabbitmq");
  channel = await connection.createChannel();
  await channel.assertQueue("user_created");
  console.log("🐇 Connected to RabbitMQ");
}

export async function publishUserCreated(user: any) {
  if (!channel) throw new Error("RabbitMQ not connected");
  channel.sendToQueue("user_created", Buffer.from(JSON.stringify(user)));
}
```

### `users-service/src/routes/user.routes.ts`

```ts
import { Router } from "express";
import { publishUserCreated } from "../events/rabbitmq";

const router = Router();

router.post("/", async (req, res) => {
  const user = { id: Date.now(), ...req.body };
  await publishUserCreated(user);
  res.status(201).json(user);
});

export default router;
```

### `users-service/src/index.ts`

```ts
import app from "./app";
import { connectRabbitMQ } from "./events/rabbitmq";

const PORT = 4001;

connectRabbitMQ().then(() => {
  app.listen(PORT, () => {
    console.log(`👤 Users service on http://localhost:${PORT}`);
  });
});
```

---

## 🧱 ORDERS SERVICE

### `orders-service/src/events/rabbitmq.ts`

```ts
import amqp from "amqplib";

export async function consumeUserCreated() {
  const connection = await amqp.connect("amqp://rabbitmq");
  const channel = await connection.createChannel();
  await channel.assertQueue("user_created");
  console.log("📥 Listening to user_created events...");

  channel.consume("user_created", (msg) => {
    if (msg !== null) {
      const user = JSON.parse(msg.content.toString());
      console.log("📨 Received user:", user);
      // Optionally: Save to DB, cache, or perform actions
      channel.ack(msg);
    }
  });
}
```

### `orders-service/src/index.ts`

```ts
import app from "./app";
import { consumeUserCreated } from "./events/rabbitmq";

const PORT = 4002;

consumeUserCreated().then(() => {
  app.listen(PORT, () => {
    console.log(`📦 Orders service on http://localhost:${PORT}`);
  });
});
```

---

## 🔐 Optional: Message Format Contract

You can define shared interfaces like:

```ts
// shared/user-created.event.ts
export interface UserCreatedEvent {
  id: number;
  name: string;
  email: string;
}
```

Ensure both services agree on the format — possibly with a **shared npm package** for contracts.

---

## 🧠 Advantages of Adding RabbitMQ

✅ No direct dependencies between services
✅ Asynchronous processing
✅ More fault-tolerant than HTTP
✅ Enables **event-driven** workflows

---

## 🔁 Possible Events to Handle

| Event            | Source Service  | Subscriber Services     |
| ---------------- | --------------- | ----------------------- |
| `user_created`   | Users Service   | Orders, Email, Billing  |
| `order_placed`   | Orders Service  | Inventory, Notification |
| `payment_failed` | Billing Service | Support, Notification   |

---

## 📚 Further Reading on Events

* [RabbitMQ Docs](https://www.rabbitmq.com/documentation.html)
* [Event-driven Architecture](https://martinfowler.com/articles/201701-event-driven.html)
* [RabbitMQ with Node.js Guide](https://www.cloudamqp.com/docs/nodejs.html)

---

## ✅ Summary

| Layer            | Tool        |
| ---------------- | ----------- |
| Web/API          | Express.js  |
| Language         | TypeScript  |
| Messaging        | RabbitMQ 🐇 |
| Containerization | Docker      |

> “When services emit events, your system becomes **reactive, extensible, and powerful**.”

Great! Here's a set of **unit test examples** for both the **publisher** (Users service) and the **consumer** (Orders service) in the RabbitMQ-based microservices setup.

We'll use:

* ✅ [`jest`](https://jestjs.io/) — testing framework
* ✅ [`ts-jest`](https://github.com/kulshekhar/ts-jest) — TypeScript transformer for Jest
* ✅ [`amqplib-mocks`](https://www.npmjs.com/package/amqplib-mocks) — lightweight mock for RabbitMQ

---

## 🧪 Unit Testing RabbitMQ Publisher & Consumer in Node.js Microservices

---

### 🛠 Setup: `jest.config.js`

```js
module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
};
```

Install the test tools:

```bash
npm install --save-dev jest ts-jest @types/jest amqplib-mocks
```

---

## 📤 USERS SERVICE – Test the Publisher

### `users-service/src/events/rabbitmq.ts` (testable version)

Refactor the publisher to accept `channel` as an argument:

```ts
import amqp from "amqplib";

let channel: amqp.Channel;

export async function connectRabbitMQ() {
  const connection = await amqp.connect("amqp://rabbitmq");
  channel = await connection.createChannel();
  await channel.assertQueue("user_created");
}

export function getChannel() {
  return channel;
}

export async function publishUserCreated(user: any, ch?: amqp.Channel) {
  const usedChannel = ch || channel;
  if (!usedChannel) throw new Error("Channel not initialized");
  usedChannel.sendToQueue("user_created", Buffer.from(JSON.stringify(user)));
}
```

### `users-service/__tests__/publisher.test.ts`

```ts
import { publishUserCreated } from "../src/events/rabbitmq";
import { MockChannel } from "amqplib-mocks";

describe("RabbitMQ Publisher", () => {
  it("should publish user_created message", async () => {
    const mockChannel = new MockChannel();

    const user = { id: 1, name: "Test", email: "test@example.com" };

    const sendSpy = jest.spyOn(mockChannel, "sendToQueue");

    await publishUserCreated(user, mockChannel as any);

    expect(sendSpy).toHaveBeenCalledWith(
      "user_created",
      Buffer.from(JSON.stringify(user))
    );
  });
});
```

---

## 📥 ORDERS SERVICE – Test the Consumer

### `orders-service/src/events/rabbitmq.ts` (testable version)

Separate the handler so it's independently testable:

```ts
export function handleUserCreatedMessage(msg: any, ack: () => void) {
  const user = JSON.parse(msg.content.toString());
  console.log("📨 Received user:", user);
  // Perform business logic
  ack();
}
```

Use it in your consumer:

```ts
channel.consume("user_created", (msg) => {
  if (msg !== null) {
    handleUserCreatedMessage(msg, () => channel.ack(msg));
  }
});
```

---

### `orders-service/__tests__/consumer.test.ts`

```ts
import { handleUserCreatedMessage } from "../src/events/rabbitmq";

describe("RabbitMQ Consumer", () => {
  it("should process user_created message and call ack", () => {
    const fakeUser = { id: 1, name: "Alice" };
    const msg = {
      content: Buffer.from(JSON.stringify(fakeUser)),
    };

    const ack = jest.fn();

    handleUserCreatedMessage(msg, ack);

    expect(ack).toHaveBeenCalled();
  });
});
```

---

### ✅ Summary for Testing

| Component | Test                        |
| --------- | --------------------------- |
| Publisher | Mock `channel.sendToQueue`  |
| Consumer  | Extract handler, mock `msg` |

---

## 🚀 Optional Improvements

* Use `supertest` for end-to-end testing Express routes
* Add a `logger` and mock it in tests
* Use a `shared-events` package to validate message formats

---
