# 🧠 Express.js Backend Architecture Cheatsheet

> Your quick-reference guide to organizing scalable, maintainable Node.js + Express backends 🚀

---

## 🏗️ Common Backend Architectures

| Architecture | Description | Use Case |
|--------------|-------------|----------|
| **MVC** | Separates concerns into Model, View, Controller | Classic structure for APIs & web apps |
| **Modular (Feature-based)** | Each feature/module is self-contained | Scalable apps with multiple domains |
| **Hexagonal / Ports & Adapters** | Isolates core logic from infrastructure | Domain-driven design & testability |
| **Clean Architecture** | Layers: Entities → Use Cases → Interfaces | High testability and decoupling |

---

## 📁 Folder Structures Examples

### 1. 🧱 MVC (Model-View-Controller)

```

my-app/
├── controllers/
│   └── userController.js
├── models/
│   └── userModel.js
├── routes/
│   └── userRoutes.js
├── views/
│   └── user.ejs (optional)
├── app.js
└── server.js

```

✅ **Best for**: Beginners or REST APIs with basic structure.

---

### 2. 📦 Modular / Feature-Based

```

my-app/
├── modules/
│   ├── user/
│   │   ├── user.controller.js
│   │   ├── user.model.js
│   │   ├── user.routes.js
│   │   └── user.service.js
│   └── auth/
│       ├── auth.controller.js
│       ├── auth.routes.js
├── config/
├── middlewares/
├── utils/
├── app.js
└── server.js

```

✅ **Best for**: Medium to large apps with many features/domains.

---

### 3. 🧼 Clean Architecture

```

my-app/
├── src/
│   ├── domain/
│   │   ├── entities/
│   │   └── use-cases/
│   ├── infrastructure/
│   │   ├── db/
│   │   └── api/
│   ├── interfaces/
│   │   ├── controllers/
│   │   └── routes/
│   └── main/
│       ├── config/
│       └── server.js

```

✅ **Best for**: Complex apps needing strong separation of concerns.

---

## 🚀 Common File Responsibilities

| File / Folder | Purpose |
|---------------|---------|
| `controllers/` | Handle request/response logic |
| `models/` | Define data schemas & DB access |
| `routes/` | Define Express routes and link to controllers |
| `services/` | Business logic (optional but recommended) |
| `middlewares/` | Auth, logging, error handlers |
| `config/` | Environment config, DB setup, constants |
| `utils/` | Reusable helpers (e.g., validators, hashers) |

---

## 🔧 Example: Basic Route Setup

```js
// routes/user.routes.js
const express = require("express");
const router = express.Router();
const userController = require("../controllers/user.controller");

router.get("/", userController.getAllUsers);
router.post("/", userController.createUser);

module.exports = router;
```

```js
// controllers/user.controller.js
exports.getAllUsers = (req, res) => {
  res.json([{ id: 1, name: "Martin" }]);
};

exports.createUser = (req, res) => {
  const user = req.body;
  // Save user logic here
  res.status(201).json(user);
};
```

```js
// app.js
const express = require("express");
const app = express();

app.use(express.json());
app.use("/api/users", require("./routes/user.routes"));

module.exports = app;
```

```js
// server.js
const app = require("./app");
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
```

---

## 🛠️ Tips for Scalable Architecture

* 🔄 **Use `.env` for config** → use [dotenv](https://www.npmjs.com/package/dotenv)
* 🧪 **Add tests** (Jest, Supertest)
* 🗂️ **Split by domain** not just by function
* ⚙️ **Use service layer** to isolate business logic
* 🧵 **Use middleware** for DRY error handling, auth, logging
* 📦 **Consider TypeScript** for better type safety

---

## 📚 Resources

* 📘 [Express.js Docs](https://expressjs.com/)
* 🔧 [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
* 🏛️ [Clean Architecture in Node.js](https://dev.to/boiboi/clean-architecture-in-nodejs-35cn)
* 🚀 [Awesome Node.js](https://github.com/sindresorhus/awesome-nodejs)
* 🧰 [dotenv for config](https://www.npmjs.com/package/dotenv)

---

💡 *Choose the architecture that suits your app complexity. Start simple, refactor smart.*

---
