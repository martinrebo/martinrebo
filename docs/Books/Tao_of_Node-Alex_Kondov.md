# Tao of Node by Alex Kondov

## Chapter 1: Structure & Coding Practices

1. Structure the App in Modules
  
  Separation of Concerns is a different thing than separation of technical responsibilities: Don't structure by technical responsibilities, Structure by domain modules
2. Start with a Modular Monolith
3. Split the implementation in Layers:
      *`Handler` deals with transport. `Service` manages the domain without knowing whether it's responding to and HTTP request or a message from an event-driven system. Use a `Repository` to extract the data access logic.
      * App logic split: transport, domain, data access layers.
4. Use Services to communicate between modules
      *Don't brake the boundaries of the domain modules: Communicate using imported services inside the handlers.
5. Create Domain Entities
      * Avoid return data directly from storage
      * Make your domain layer a simple as possible.

     ```js
     // product-repository.js
     // 👎 Avoid returning data directly from storage 👎
     // If the storage imposes constraints on naming and formatting.
     export async function getProduct(id) {
     return dbClient.getItem(id);
     }
     // product-repository.js
     // 👍 Map the retrieved item to a domain object 👍
     // Rename storage-specific fields and improve its structure.
     export async function getProduct(id) {
     const product = dbClient.getItem(id);
     return mapToProductEntity(product);
     }
     ```

6. Separate Utility Functions and Domain Logic

      * 👎 Don't put everything into a utility folder
      * 👍 Separate utilities and domain logic

7. Use Hypertext for REST APIs

      * Most REST APIs are limited only to resource-based URLs and HTTP verbs. According to the 'Richardson Maturity Model', these are only the first two levels of a three-level model to build truly RESTful APIs. The final level of maturity introduces HATEOS (Hypertext As The Engine Of Application State). This solves the problem of discovery and further decouples the clients form the services. Patch vs Put. 
      * For example, when you make a request to fetch a single resource, the REST API will also send all related operations.

8. Validate Request Structure

      * The validation logic can get verbose and repetitive. It's better to use a library to validate the request payload against a JSON schema.
      * `Joi ajv and express-validator` are the popular choice.
      * Don't validate the request explicitly
      * Enrich validation with `422 Unprocessable Entity` before being handled by the Central error Handler. 

      ```js
       // 👎 Don't validate requests explicitly 
       const createUserHandler = (req, res) => { 
       const { name, email, phone } = req.body; 
       if ( 
       name && 
       isValidName(name) && 
       email && 
       isValidEmail(email)
       ) { 
       userService.create({ 
       userName, 
       email, 
       phone, 
       status, 
       }); 
       } 
       // Handle error... 
       }; 
       // Use a library to validate and generate more descriptive messages 
       const schema = Joi.object().keys({ 
       name: Joi.string().required(), 
       email: Joi.string().email().required(), 
       phone: Joi.string() 
       .regex(/^\d{3}-\d{3}-\d{4}$/) 
       .required(), 
       }); 

       const createUserHandler = (req, res) => { 
       const { error, value } = schema.validate(req.body); 
       // Handle error... 
       }
       ```
9. Validate in Middleware

      * Validate the data before it reaches the handler.
      * It is best to have granular middleware that get chained rather than few large ones focused on specific path. 

      ```js
      // Create a reusable validation middleware 
      const validateBody = (schema) => (req, res, next) => { 
       const { value, error } = Joi.compile(schema).validate( 
       req.body 
       ); 
       
       if (error) { 
       const errorMessage = error.details 
       .map((details) => details.message) 
       .join(", "); 
       
       return next( 
       new AppError(httpStatus.BAD_REQUEST, errorMessage) 
       ); 
       } 
       
       Object.assign(req, value); 
       return next(); 
      }; 
       
      // Use it in the route definitions 
      app.put("/user", validate(userSchema), handlers.updateUser); 
      ```

10. Handling Business Logic in Middleware

    * Middleware is a part of the transport layer since they get access to the raw request, so they should follow the same rules as the handlers. It should decide whether to stop or continue execution, but keep business logic out of it. 
    * By delegating the business call to another module. Try to use generic names for such functions: `hasAdminAccess` vs `hasPermissions`

        ```js
        // Don't implement business logic in the middleware 
        const hasAdminPermissions = (req, res, next) => { 
         const { user } = res.locals 
         
         const role = knex 
         .select('name') 
         .from('roles') 
         .where({ 'user_id', user.id }) 
         
         if (role !== roles.ADMIN) { 
         throw new AppError(httpStatus.UNAUTHORIZED) 
         } 
         
         next() 
        } 
         
        // Delegate to a service call 
        const hasAdminPermissions = (req, res, next) => { 
         const { user } = res.locals 
         
         if (!userService.hasPermission(user.id)) {
         throw new AppError(httpStatus.UNAUTHORIZED) 
         } 
         
         next() 
        } 
        ```

11. Favor Handler Functions to Controller Classes

    * In MVC frameworks, HTTP handlers are grouped in controller classes. They usually extend a base class that provides the request and response logic. 
    * In Express and other minimalistic frameworks, classes are not required. 
    * Functions are easier to move around in separate files.
    * If you need to keep state and injecting something, it is simpler to use a factory function and pass it the objects we need. This is a useful practice to avoid mocking. 

    ```js
    export function createHandler(logger, userService) { 
     return { 
     updateDetails: (req, res) => { 
     // User the logger and service in here 
     }, 
    }; 
    } 
    ```
12. Use the Error Object or Extend it

    * Stick to the built-in `Error` and add additional details.
    * Notice `isOperational` flag is set to true to distinguish error raised by us. 
    * Stick with generic `AppError` class instead of specific `ValidationError`, `InternalServerError` and pass the status code, since most often is the only difference between them.  

    ```js
    // 👎 Don't throw plain error messages 
    const { error } = schema.validate(req.body);

    if (!product) { 
    throw "The request is not valid!"; 
    } 

    // 👍 Use the built-in Error object 
    const { error } = schema.validate(req.body);

    if (!product) { 
    throw new Error("The request is not valid"); 
    } 

    // 👍 Extend the built-in Error object 
    export default class AppError extends Error { 
    constructor( 
    statusCode, 
    message, 
    isOperational = true, 
    stack = "" 
    ) { 
    super(message); 
    this.statusCode = statusCode; 
    this.isOperational = isOperational; 
    if (stack) { 
    this.stack = stack; 
    } else { 
    Error.captureStackTrace(this, this.constructor); 
    } 
    } 
    } 

    // 👍 Use AppError instead 
    const { error } = schema.validate(req.body);

    if (!product) { 
    throw new AppError( 
    httpStatus.UNPROCESSABLE_ENTITY, 
    "The request is not valid" 
    ); 
    } 

    ```

13. Listen to Process Signals

    ```js
    process.on("uncaughtException", (err) => { 
    // Log the exception and exit 
    }); 

    process.on("SIGTERM", () => { 
    // Do something and exit 
    }); 
    ```
14. Create an Error Handling Module

    * Express based applications is easier to establish an unified error handling module
    * Put the error handler in one place at the core of the app. If you need to enrich it do it in the transport layer. 

    ```js
    // 👎 Don't handle errors on a case-by-case basis 👎
    const createUserHandler = (req, res) => { 
    // ... 
    try { 
    await userService.createNewUser(user) 
    } catch (err) { 
    logger.error(err) 
    mailer.sendMail( 
    configuration.adminMail, 
    'Critical error occured', 
    err 
    ) 
    res.status(500).send({ message: 'Error creating user' }) 
    } 
    } 

    // Propagate the error to a central error handler 
    const handleError = (err, res) => { 
    logger.error(err) 
    sendCriticalErrorNotification() 

    if (!err.isOperational) { 
    // 👍 Shut down the application if it's not an AppError 👍
    } 

    res.status(err.statusCode).send(err.message) 
    } 

    const createUserHandler = (req, res, next) => { 
    // ... 
    try { 
    await userService.createNewUser(user) 
    } catch (err) { 
    next(err) 
    } 
    } 

    app.use(async (err, req, res, next) => { 
    await handleError(err, res) 
    }) 

    process.on('uncaughtException', (error) => { 
    handleError(error) 
    }) 
    ```

15. Send 404 Response in Middleware

    * In Express add a middleware that get executed after all your routes.

    ```js
    app.use((err, req, res, next) => { 
     if (!err) { 
     next(new AppError(httpStatus.NOT_FOUND, "Not found")); 
     } 
    });
    ```

16. Don't send Error Responses in the Handler
17. Shut Down the App when you can't recover

    * If a library or tool fails and we don't know how to recover from it, it's best not to make any assumptions.
    * Make sure the error is logged, let the app shut down, and rely on the environment to restart it.
  
18. Enforce Consistency

    * Being consistent with your coding is more important that what standard you use.
    * When it comes to code style, you can never please everyone
    * Use `ESlint`, `Prettier`, `Husky` and run the linters on your CI pipeline.
    * Use all caps for constants, camel case for functions, pascal for classes and models, kebab for files. 

19. Co-locate Functionality.
    * It is easy to decide where routes, handlers and services should live in. 
    * When unsure where to place something locate close wherever it's used. 

    ```bash
    ├── order 
    | ├── order-handlers.js 
    | ├── order-service.js 
    | ├── order-queries.js 
    | ├── order-handlers.test.js 
    | ├── calculate-shipping 
    | | ├── index.js 
    | | ├── calculate-shipping.js 
    | | ├── calculate-shipping.test.js 
    | | ├── get-courier-cost.js 
    | | ├── calculate-packaging-cost.js 
    | | ├── calculate-discount.js 
    | | ├── is-free-shipping.js 
    | ├── index.js 
    ```
20. Export Immediately

    * Don't export at the end of the file, it makes it harder to explore. 

    ```js
    // Don't export at the bottom of the file 
    const createUserHandler = (req, res) => { 
    // ... 
    }; 
    
    const getUserDetailsHandler = (req, res) => { 
    // ... 
    }; 
    
    export { createUserHandler, getUserDetailsHandler }; 
    
    // Export together with the definition 
    export const createUserHandler = (req, res) => { 
    // ... 
    }; 
    
    export const getUserDetailsHandler = (req, res) => { 
    // ... 
    }; 
    ```
21. Keep routes in modules

    * Many applications break modularity by listing all routes together in a single file. While it is easy to understand, it also means multiple engineers may be touching the same file. 
    * It makes extracting a module into its own separate application easier. 

    ```js
    // Register the main routes 
    const router = express.Router(); 
    
    router.use("/user", jobs); 
    app.use("/v1", router);
    
    // user-routes.js 
    router 
    .route("/") 
    .get(isAuthenticated, handler.getUserDetails); 
    router 
    .route("/") 
    .put( 
    isAuthenticated, 
    validate(userDetailsSchema), 
    handler.updateUserDetails 
    );
    ```
22. Prefix API routes

    * It will take a long time for gRPC and GraphQL to get wide adoption level. 
    * To ensure backward compatibility, always prefix routes with the API version. `app.use("/v1", routes);`

23. Attach the user from authenticated requests

    * When handling a request that requires the user to be authenticated attach the object to `res.locals` so you can access it in the middleware. It's typed as `Record<string, any>` so you won't be fighting type errors. 
    * To ensure TS is using the right types for the user object you will need to utilize `TS declaration merging` and add it to the Req or Res object.

24. Avoid Callback-Based APIs

    ```js
    // 👎 Do not use callback-based APIs to avoid deep nesting 
    import fs from "node:fs"; 
    
    fs.open("./some/file/to/read", (err, file) => { 
    // Handle error... 
    
    // Do something with the file... 
    
    fs.close(file, (err) => { 
    // Handle closing error... 
    }); 
    }); 
    
    // 👍 Use promise-based APIs 
    import { open } from "node:fs/promises"; 
    
    const file = await open("./some/file/to/read"); 
    
    // Do something with the file... 
    
    await file.close(); 
    ```
25. Create Deep Modules with Shallow Interfaces

    * "A Philosophy of Software Design" book explain the concept of Deep Modules. "Iceberg" 
    * Strive for a small -  simple - abstract surface that hides a lot underneath. 
    * Don't use env variables directly, pass them down as config (as a parameter) and make it obvious that they are used

    ```js
    // 👍 Create Deep Interfaces
    export function verifyAndCreateUser(userData) { 
    const err = validateUserDetails(userData); 
    
    if (err.isValid) { 
    throw new Error(err.message); 
    } 
    
    const emailTaken = checkEmailTaken(userData.email); 
    
    if (emailTaken) { 
    throw new Error("Email already taken"); 
    } 
    
    try { 
    const user = await storeUser(user) 
    } catch(err) { 
    throw new Error("Error storing user"); 
    } 
    
    sendVerificationEmail(user); 
    } 
    ```

26. Focus on responsibilities, not on length

    * Long functions are perfectly fine if they encapsulate a complete operation or responsibility. Reusability must happen naturally. Use length as a guide not as an unbreakable rule.

27. Change the design when you make changes to the code.

    * When you find yourself changing an implementation to handle an edge case for a specific call site or adding boolean argument, review your design.
    * Duplication is annoying but it's easy to manage. Badly-written abstractions
    * Waiting to refactor make it harder.

28. Isolate complexity in places where it changes rarely. 

    * One way is abstraction. If the code changes rarely the complexity is eliminated.

29. Write comments that explain why
30. Consider inline and interface comments
31. Consider extracting a function when you have to write a comment
32. Favor closures over classes

    * A factory functions allows us to leverage the dependency injection pattern. D.I. is about making the values that a function is working with obvious. Instead import implementations from specific modules, we can specify an interface and have them passed to the factory function. 
    * Using a specific library or module inside a function makes it easy to work with but it leads to a more complex design. 

    ```js
    // 👎 Avoid relying on specific implementations 
    function createAnalyticsService(url) { 
    const httpClient = axios.create({ baseURL: url }); 
    
    return { 
    trackEvent(eventName, eventData) { 
    httpClient.post(); 
    }, 
    trackEventWithMetrics(eventName, eventData, metrics) { 
    httpClient.post(); 
    }, 
    }; 
    } 
    
    const userAnalyticsService = createAnalyticsService( 
    "https://example.com" 
    ); 
    
    // 👍 Accept them as arguments to make them visible 
    function createAnalyticsService(httpClient) { 
    return { 
    trackEvent(eventName, eventData) { 
    httpClient.post(); 
    }, 
    trackEventWithMetrics(eventName, eventData, metrics) { 
    httpClient.post(); 
    }, 
    }; 
    } 
    
    const axiosClient = axios.create({ 
    baseURL: "http://example.com", 
    }); 
    const userAnalyticsService = 
    createAnalyticsService(axiosClient); 
    ```
     * This pattern is best enforced with TS. `createEntity`naming convention. 
  
    ```js 
    interface HTTPClient<T> { 
    post: (url: string) => Promise<T>; 
    } 
    
    function createAnalyticsService(httpClient: 
    HTTPClient<AnalyticsResponse>) { 
    return { 
    trackEvent(eventName, eventData) { 
    httpClient.post(...); 
    }, 
    trackEventWithMetrics(eventName, eventData, metrics) { 
    httpClient.post(...); 
    }, 
    }; 
    } 
    ```
33. Favor Composition Over Inheritance
34. Avoid Null Values (undefined is better)
35. Eliminate Empty types

    ```js
    // 👍 By always returning a collection we remove all the edge 
    cases 
    function promotionalProductsHandler(req, res) { 
    const productsResult = service.getPromotionalProducts(); 
    return res.json({ products: productsResult }); 
    }
    ```
36. Avoid boolean flags in functions
37. Use the correct data structure for the problem (tree vs graph)
38. Create explanatory variables

    ```js
    // 👎 Avoid passing unclear parameters to functions 
    createUser(sanitizeInput(req.body), {}, "customer"); 
    
    // 👍 Add more context even if it makes your code more verbose 
    const sanitizedUserAttributes = sanitizeInput(req.body); 
    const options: Options = {}; 
    const userType: UserType = "customer"; 
    
    createUser(sanitizedUserAttributes, options, userType); 
    ```

39. Encapsulate Conditional Statements
40. Flatten Nested Conditional Statements
41. Redesign Conditional Statements

    * Avoid Conditional Chains. Implement the functionality inside the entity itself. This might require to make the change in the database. (Eg. product discounts)

42. Don't emit events to communicate

    * Avoid using events across your whole app. Call the functions (createListener - services from other modules) manually
    * Event listeners good practices on the browser but not on the server.
    * In a small scope are ok,

43. Use modules as Singletons

    * Singleton is a pattern used when you want to control how many instances of an object you have. A class implementation is the best way to illustrate it. 
    * In node is better to use it built-in system. 

    ```js
    export interface Logger { 
    log: LogFunction; 
    warn: LogFunction; 
    error: LogFunction; 
    } 

    type LogFunction = (...args: any[]) => void; 

    let logger: Logger = console; 

    export function setLogger(customLogger: Logger) { 
    logger = customLogger; 
    } 

    export default logger; 
    ```

44. Use consistent Async Practices
45. Avoid blanket try/catch statements

    * Use only in the parts that need to be protected
    * better to write modular `try/catch` to show the exact place that produces the error.

46. Favor Longer Names
47. Put most important functions on top
48. Aim for simplicity not ease
49. Accept and object is your function goes beyond 3 values
50. Program error out of existence
51. Group Values in Context Objects (eg. Options - Context )

## Chapter 2: Tooling

1. Favor minimalistic tooling
2. Favor Express as a framework
3. Favor Query builders over ORMs (Knex, Mongo driver, Prisma ok)
4. Favor Native methods to libraries
5. Extracting Libraries
6. Use a structured Logger (Splunk, new Relic, winston, pino)
7. Document the application (Swagger, TS types documentation)
8. Pin Dependency versions (remove ^ ~)
9. Use TS
10. Use Synk (log4j fiasco)
11. Containerize the app
12. Do not worry about DB/infra changes 
13. Encapsulate configuration
14. Use hierarchical config
15. Don't use Native ES modules
16. Create a project scaffold (template repo)
17. Stabilize Local Development and Deployments
18. Create Logger Object
19. Create enriched loggers
20. Logging for security purposes
21. Log notable operations
22. Use log management service

    * Notice we accept it as a parameter of the factory function
    * If you work with orchestrator (Kubernetes)

    ```js
    // logger.js 
    const pino = require("pino"); 

    function createLogger(level, transport) { 
    const logger = pino({ level }, transport); 
    return enrichLogger(logger); 
    } 

    // app.js 
    const pinoElastic = require("pino-elasticsearch"); 

    const ESTransport = pinoElastic({ 
    index: "an-index", 
    consistency: "one", 
    node: "http://localhost:9200", 
    "es-version": 7, 
    "flush-bytes": 1000, 
    }); 

    const logger = createLogger("info", ESTransport);
    ```

23. Report and visualize metrics (OS Prometheus - Graphana)
24. Deciding on instrumentation tools

    * tracing (Jaeger, Zipkin) monitoring (Prometheus) loggin ELK(Elasticsearch, Logstash, Kibana)

25. Distributed tracing
26. Configure alerts (AWS CloudWatch)
27. Consider OpenTelemetry (but not simpler than specific vendor)
28. Create runbooks (to solve common issues)
29. Create health checks 
30. What steps to add in your CI pipeline
31. Streamline the Deployment Process
32. use PR environments 
33. Utilize feature flags (unleash-flag, A/B)
34. Use Database migrations and Seeders 
35. Ensure your app restarts automatically

### Chapter 3: Testing

1. Favor Integration Testing
2. Consider Dependency Injection over mocking (avoid complex DI containers)
3. Unit Test the business logic (what is on your control)
4. Invest in high test coverage
5. Follow Arrange-Act-Assert Pattern
6. Use TDD with Care
7. Use an HTTP client for integrations tests
8. Intercept HTTP request to external services (Axios interceptor, Nock, mock the response)
9. Integration test should work in isolation. (populate db, delete isolation)
10. Test with realistic data (use `faker` library)
11. Avoid snapshot testing
12. Don't test private functions
13. Test Middleware functions (critical logic for auth, val)
14. Don't write complex tests (better duplication that abstractions, better long test files all cases, simpler that implementation tested)

### Chapter 4: Performance

1. Don't block the event loop

   * (parsing JSON, apply logic, complex regex, read files, ⇒ external queue)
   * assets => HTML, CSS, JS, img by CDN or S3 bucket
   * node i/o only

2. Don't optimize for algorithmic complexity (very rare, better optimize queries for DB, external services, cache)
3. Don't optimize prematurely (unless there is problem)
4. Access Data Performant (DB root of performance)
5. Be careful with async code (don't depend on async concurrent)(npm `dataloader` mostly GraphQL)
6. Specify response timeouts and retry limits (better on client level not per request )

### Chapter 5: Serverless Functions & GraphQL

1. Use serverless functions as glue
2. Serverless apps
3. Structuring serverless functions
4. Don't build serverless monoliths
5. Minimize Serverless Functions's execution time
6. Authentication in serverless functions
7. Use Cloud Services instead of custom code
8. Designing a serverless function
9. How to structure a GraphQL server
10. Avoid being a 1-1 Mapper to a call or Interface (in GraphQL)
11. Avoid versioning (in GraphQL) use `deprecated`
12. Create Specific Queries & Mutations
13. Designing Queries and Mutations

### Chapter 6: Scenarios 

1. Extract a microservice from a monolith
2. Changing the DB
3. Decoupling legacy monoliths with Lambda
4. Extracting microservices with GraphQl
5. Deciding on a DB
6. Authentication trade-offs
7. Applying Patterns to Existing Projects