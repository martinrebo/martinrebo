# 🐶 How Husky Makes Your Code Better

Modern teams rely on **automation and consistency** to ensure clean, reliable codebases. That’s where **Husky** comes in — a tiny yet powerful tool that runs scripts at **Git hook** events. Let’s explore how Husky can *level up* your development workflow. 🚀

---

## 🧠 What is Husky?

**Husky** is a tool that lets you **run scripts at Git hooks**, such as `pre-commit`, `pre-push`, or `commit-msg`. These scripts can be used to lint code, run tests, check commit messages, and more — before bad code even reaches your remote repository. 🔒

> Think of it as an automated bouncer that checks your code before it gets inside the club. 🕺

---

## ⚙️ How it Works (Under the Hood)

Husky uses the **Git hooks** system, which are shell scripts located in your `.git/hooks` directory. Husky manages them for you in a **portable and reproducible way**, ideal for teams and CI pipelines.

---

## ✅ Benefits of Using Husky

| Benefit 💡           | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| **Code Quality**     | Automatically run linters/formatters before every commit                    |
| **Fail Fast**        | Prevent bad commits or pushes if tests fail                                 |
| **Enforce Standards**| Use commit message linting (`commitlint`) to enforce semantic messages       |
| **Automation**       | Automate repetitive checks that devs may forget                             |
| **CI/CD Ready**      | Mirrors many CI checks locally, saving time and reducing pipeline failures   |

---

## 🛠️ Setting Up Husky in a TypeScript/Node Project

### 1. Install Husky

```bash
npm install husky --save-dev
```

### 2. Enable Git Hooks

```bash
npx husky install
```

Add the install command to your `package.json` to enable hooks after cloning:

```json
"scripts": {
  "prepare": "husky install"
}
```

### 3. Add a Pre-Commit Hook

Let’s add a pre-commit hook to run ESLint:

```bash
npx husky add .husky/pre-commit "npm run lint"
```

Now, create a lint script:

```json
"scripts": {
  "lint": "eslint . --ext .ts"
}
```

### 4. Add Commit Message Linting (Optional but Great)

Install commitlint:

```bash
npm install --save-dev @commitlint/{config-conventional,cli}
```

Create `commitlint.config.js`:

```js
module.exports = { extends: ['@commitlint/config-conventional'] };
```

Hook it up:

```bash
npx husky add .husky/commit-msg 'npx --no-install commitlint --edit "$1"'
```

---

## 🧪 Integrate with CI/CD

Even with Husky locally, you should mirror those checks in CI:

```yaml
# example: .github/workflows/ci.yml
steps:
  - run: npm run lint
  - run: npm test
  - run: npx commitlint --from=HEAD~1
```

This way, you catch anything missed due to skipped local hooks (e.g., via `--no-verify`).

---

## 💡 Best Practices

- Always include Husky in `prepare` to ensure hook setup across teams.
- Don’t rely *only* on Husky — replicate checks in your CI pipeline.
- Combine with tools like **lint-staged** for blazing-fast pre-commit hooks.
- Use **commitlint** + **conventional commits** to automate changelogs.

---

## 🧵 Related Tools

| Tool             | Purpose                          |
|------------------|----------------------------------|
| `lint-staged`    | Run linters only on staged files |
| `commitlint`     | Enforce commit message formats   |
| `prettier`       | Format code consistently         |

---

## 📚 References

- Husky Docs → [https://typicode.github.io/husky](https://typicode.github.io/husky)
- Git Hooks → [https://git-scm.com/docs/githooks](https://git-scm.com/docs/githooks)
- Commitlint → [https://commitlint.js.org](https://commitlint.js.org)
- Lint-staged → [https://github.com/okonet/lint-staged](https://github.com/okonet/lint-staged)

---

## 🎯 Conclusion

Husky helps you **catch problems early**, **standardize development**, and **boost confidence** in your code — all before you even push to GitHub. It's a no-brainer for any serious TypeScript/Node.js project. 🧼✅

> ✨ _Start small — even a single pre-commit linter will make a big difference!_  
> 🧑‍💻 Happy coding!
