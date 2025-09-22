---
title: 🧠 System Design Cheatsheet for Engineers
date: 2025-09-22
tags: [System Design, Backend, Scalability, Architecture]
categories: [Engineering]
description: A concise cheatsheet for understanding and mastering system design concepts. Ideal for software engineers preparing for interviews or designing scalable systems.
---

# 🧠 System Design Cheatsheet

System Design is the process of defining the architecture, components, and data flow of a system to meet specified requirements of **scalability**, **reliability**, **availability**, and **maintainability**.

---

## 📌 Core Concepts

| 🧠 Concept                     | 📘 Definition                                                                         | 🏷️ Brands  / Services                        |
| ---------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------- |
| **Scalability**                    | Ability of a system to handle increased load                                         | AWS Auto Scaling, GCP Compute, Kubernetes |
| **Availability**                   | Percentage of time a system remains operational                                      | AWS Route 53, Cloudflare, GCP HA          |
| **SPOF** (Single Point of Failure) | Component whose failure can bring down the system                                    | Mitigated via redundancy, LB, replication |
| **CAP Theorem**                    | Trade-off between Consistency, Availability, and Partition Tolerance                 | Cassandra (AP), MongoDB (CP), RDBMS (CA*) |
| **ACID Transactions**              | Guarantees for reliable DB operations: Atomicity, Consistency, Isolation, Durability | PostgreSQL, MySQL, Oracle DB              |
| **Consistency Patterns**           | Strategies for managing data consistency across nodes                                | Eventual Consistency, Strong, Causal      |
| **Idempotency**                    | Ensures repeated requests have no additional effect                                  | Stripe, PayPal, REST APIs                 |

---

| **Networking & Communication** | 📘 Definition                                                           | 🏷️ Brands / Services                |
| ------------------------------ | ---------------------------------------------------------------------- | ------------------------------------ |
| **DNS**                        | Resolves domain names to IP addresses                                  | Cloudflare DNS, Google DNS, Route 53 |
| **Proxy vs Reverse Proxy**     | Proxy hides the client, reverse proxy hides the server                 | NGINX, HAProxy, Cloudflare           |
| **API Design**                 | Structuring and documenting interfaces for services                    | Swagger, Postman, OpenAPI            |
| **APIs**                       | Interfaces to interact with a service                                  | REST, GraphQL, gRPC                  |
| **Rate Limiting**              | Restricts number of requests a client can make                         | API Gateway, Cloudflare, Kong        |
| **Load Balancing**             | Distributes traffic across multiple servers                            | AWS ELB, HAProxy, NGINX, GCP LB      |
| **API Gateway**                | Central entry point for microservices with features like rate-limiting | Kong, Amazon API Gateway, Apigee     |
| **WebSockets**                 | Persistent full-duplex communication between client and server         | Socket.io, Pusher, AWS AppSync       |

---

| **Caching**                        | 📘 Definition                                            | 🏷️ Brands / Services                   |
| ---------------------------------- | ------------------------------------------------------- | ------------------------------------- |
| **Caching**                        | Storing frequently accessed data closer to the user     | Redis, Memcached, Cloudflare          |
| **Caching Strategies**             | Techniques like TTL, LRU, Write-through, Write-back     | Varnish, CDN configs, Redis           |
| **Distributed Caching**            | Caching across multiple nodes to scale read performance | Redis Cluster, Hazelcast, Couchbase   |
| **Content Delivery Network (CDN)** | Distributes static content near users                   | Cloudflare, Akamai, Amazon CloudFront |

---

| **Databases**              | 📘 Definition                                                   | 🏷️ Brands / Services                    |
| -------------------------- | -------------------------------------------------------------- | -------------------------------------- |
| **Databases Types**        | SQL (Relational) vs NoSQL (Key-Value, Document, Graph)         | PostgreSQL, MongoDB, DynamoDB, Neo4j   |
| **SQL vs NoSQL**           | Structured vs flexible schemas and consistency trade-offs      | PostgreSQL, MySQL, Redis, Cassandra    |
| **Database Indexes**       | Structures to speed up data retrieval                          | B-Tree, Hash Index (PostgreSQL, MySQL) |
| **Database Scaling**       | Scaling reads/writes across instances (Vertical vs Horizontal) | Read Replicas, Partitioning            |
| **Database Sharding**      | Horizontal partitioning of data across DB instances            | MongoDB, Vitess, Citus                 |
| **Data Replication**       | Copying data across nodes for availability and performance     | MySQL Replica, MongoDB Replica Set     |
| **Data Redundancy**        | Duplicating data to avoid data loss                            | RAID, Backup strategies, Multi-AZ      |
| **Database Architectures** | Centralized, Master-Slave, Multi-Master                        | PostgreSQL Cluster, Galera Cluster     |
| **Failover**               | Automatic switching to a standby system                        | RDS Failover, PgBouncer, Keepalived    |

---

| **Distributed Systems**  | 📘 Definition                                                      | 🏷️ Brands / Services                      |
| ------------------------ | ----------------------------------------------------------------- | ---------------------------------------- |
| **Gossip Protocol**      | Nodes share state info with random peers periodically             | Cassandra, Serf, Consul                  |
| **HeartBeats**           | Signals sent to detect node liveness                              | Consul, Zookeeper                        |
| **Consensus Algorithms** | Algorithms to agree on a single data value in distributed systems | Raft, Paxos, etcd, Zookeeper             |
| **Service Discovery**    | Auto-discover services in dynamic environments                    | Consul, Eureka, Zookeeper, AWS Cloud Map |
| **Distributed Locking**  | Coordinate access to shared resources                             | Redis Redlock, Zookeeper, etcd           |
| **Bloom Filters**        | Probabilistic structures for set membership testing               | HBase, Cassandra, Guava                  |
| **Message Queues**       | Async message passing for decoupling services                     | RabbitMQ, Kafka, SQS                     |
| **Checksums**            | Detect data corruption during transmission or storage             | CRC32, SHA, AWS S3 checksums             |

---

| **Reliability & Observability** | 📘 Definition                                                        | 🏷️ Brands / Services                      |
| ------------------------------- | ------------------------------------------------------------------- | ---------------------------------------- |
| **Circuit Breaker**             | Prevents cascading failure by cutting off calls to failing services | Netflix Hystrix, Resilience4j, Istio     |
| **Fault Tolerance**             | System's ability to continue operating despite failures             | Kubernetes, Load Balancers, Replication  |
| **Disaster Recovery**           | Strategies to recover systems and data after catastrophic failure   | AWS DR Plans, Azure Site Recovery        |
| **Distributed Tracing**         | Tracks requests across services for performance/debugging           | Jaeger, Zipkin, AWS X-Ray, OpenTelemetry |

---
| 🏗️ Architecture Pattern          | 📘 Definition                                                                                   | 🧩 Types / Subtypes                                         |
|----------------------------------|--------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| **Client-Server Architecture**   | Divides the system into clients (requesters) and servers (responders).                          | 2-Tier, 3-Tier, N-Tier, MVC (Model-View-Controller)         |
| **Microservices Architecture**   | Breaks down applications into small, independent services that communicate via APIs.  | Domain-Driven Design (DDD), BFF (Backend for Frontend), Service Mesh |
| **Serverless Architecture**      | Developers write functions executed on-demand; infrastructure is managed by the cloud provider. | FaaS (Function as a Service), BaaS (Backend as a Service)   |
| **Event-Driven Architecture**    | Components produce and consume events asynchronously through a messaging system.                 | Pub/Sub, Event Sourcing, CQRS (Command Query Responsibility Segregation) |
| **Peer-to-Peer (P2P) Architecture** | Each node is equal and can act as both a client and a server, sharing resources directly.     | Structured (DHTs like Kademlia), Unstructured (Gnutella), Hybrid P2P |

## 🏗️ System Design Framework (FAANG Interviews)

1. **Requirements Gathering**
   - Functional: What should the system do?
   - Non-Functional: Scale, latency, availability, etc.
   - Constraints: Traffic, storage, latency, etc.

2. **High-Level Design**
   - Define major components
   - Interaction between modules

3. **Component Design**
   - Database schema
   - APIs
   - Background workers

4. **Scaling**
   - Load balancer
   - Caching
   - Sharding
   - Replication
   - CDN

5. **Bottlenecks & Trade-offs**
   - Latency vs throughput
   - CAP theorem
   - Cost vs reliability

---

## 🔁 Load Balancing

- **Algorithms**: Round Robin, Least Connections, IP Hash
- **Types**: L4 (TCP), L7 (HTTP-aware)
- **Tools**: NGINX, HAProxy, AWS ALB

---

## 🗃️ Database Design

| Feature  | SQL (Relational)  | NoSQL (Document, Key-Value)  |
| -------- | ----------------- | ---------------------------- |
| Schema   | Fixed             | Flexible                     |
| Joins    | Supported         | Not Supported (denormalized) |
| Examples | PostgreSQL, MySQL | MongoDB, DynamoDB, Redis     |

🛠 **Techniques**:  
- **Replication**: Improve availability  
- **Sharding**: Improve scalability  
- **Indexing**: Improve query speed  

---

## 🚀 Caching Strategy

- **Client-side Cache**
- **CDN**: Cloudflare, Akamai
- **Server-side**: Redis, Memcached

**Cache Invalidation Strategies**:
- Write-through
- Write-around
- Write-back
- TTL (Time-To-Live)

---

## 🧵 Asynchronous Processing

- **Message Queues**: Kafka, RabbitMQ, SQS
- Use cases:
  - Send email
  - Process uploads
  - Data transformation

---

## 📦 API Design

- REST vs GraphQL
- Pagination
- Rate Limiting
- Authentication: JWT, OAuth
- Versioning

---

## ⚠️ Failure Handling

- Retry with exponential backoff
- Circuit Breakers
- Health Checks
- Monitoring & Alerts: Prometheus, Grafana, Datadog

---

## 🔐 Security Essentials

- HTTPS everywhere
- Data encryption at rest & in transit
- Input validation
- DDoS protection

---

## ⚖️ CAP Theorem

```
       Consistency
        /       \
       /         \
      /           \
     /             \
Availability --- Partition Tolerance
```

- **CP**: Consistent + Partition tolerant (e.g., HBase)
- **AP**: Available + Partition tolerant (e.g., CouchDB)
- **CA**: Consistent + Available (not possible under network partition)

---

## 🧩 Sample Architecture

```
Client
  ↓
Load Balancer
  ↓
App Servers ↔ Cache (Redis)
  ↓
Database (Sharded + Replicated)
  ↔ Message Queue ↔ Workers
  ↓
CDN (for static assets)
```

---

## 📚 Further Learning

### 🧠 Books
- Designing Data-Intensive Applications – Martin Kleppmann
- System Design Interview Vol 1 & 2 – Alex Xu
- Site Reliability Engineering – Google
- The Art of Scalability – Abbott & Fisher

### 🎥 YouTube Channels
- [Gaurav Sen](https://www.youtube.com/@GauravSen)
- [System Design Interview](https://www.youtube.com/@SystemDesignInterview)
- [Tech Dummies](https://www.youtube.com/@techdummies)

### 🧪 Practice Sites
- [Excalidraw system design diagrams](https://excalidraw.com/)
- [ByteByteGo Visuals](https://bytebytego.com/)
- [Grokking the System Design Interview](https://www.educative.io/courses/grokking-the-system-design-interview)

---

## ✅ Quick Design Checklist

- [ ] Functional & non-functional requirements listed
- [ ] High-level architecture defined
- [ ] Bottlenecks identified
- [ ] Data model selected
- [ ] Caching considered
- [ ] Scaling strategy included
- [ ] Async processing outlined
- [ ] Security and observability added

---

> “A good engineer knows how to build. A great engineer knows what to trade off.” – Unknown

---
