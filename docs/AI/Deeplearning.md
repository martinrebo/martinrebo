# Deepleaning

Notes on Courses from Deeplearning.ai

## OS models with HF

* Sylabus:
  1. Selecting Models
  2. NLP
  3. Translation and Summarization
  4. Sentence Embeddings
  5. Zero-shot Audio Classification
  6. Automatic Speech Recognition
  7. Text to Speech
  8. Object Dectection
  9. Image Segmentation
  10. Image Retrieval
  11. Image Captioning
  12. Multimodal Visual Q/A
  13. Zero-shot Image classification
  14. Deployment

* [ 🤗 pip install transfomers](https://pypi.org/project/transformers/)
  * Transformers acts as the model-definition framework for state-of-the-art machine learning models in text, computer vision, audio, video, and multimodal model, for both inference and training. It centralizes the model definition so that this definition is agreed upon across the ecosystem. `transformers` is the pivot across frameworks: if a model definition is supported, it will be compatible with the majority of training frameworks (Axolotl, Unsloth, DeepSpeed, FSDP, PyTorch-Lightning, ...), inference engines (vLLM, SGLang, TGI, ...), and adjacent modeling libraries (llama.cpp, mlx, ...) which leverage the model definition from transformers.
  * Get started with Transformers right away with the Pipeline API. The Pipeline is a high-level inference class that supports text, audio, vision, and multimodal tasks. It handles preprocessing the input and returns the appropriate output.
* 🔥 [pip install torch](https://pypi.org/project/torch/)
  * PyTorch is a Python package that provides two high-level features:
        Tensor computation (like NumPy) with strong GPU acceleration
        Deep neural networks built on a tape-based autograd system
        You can reuse your favorite Python packages such as NumPy, SciPy, and Cython to extend PyTorch when needed.
* 🐍 garbage collector [import gc](https://docs.python.org/3/library/gc.html)
  * This module provides an interface to the optional garbage collector. It provides the ability to disable the collector, tune the collection frequency, and set debugging options. It also provides access to unreachable objects that the collector found but cannot free.
* [pip install sentence-transformers](https://pypi.org/project/sentence-transformers/)
  * This framework provides an easy method to compute embeddings for accessing, using, and training state-of-the-art embedding and reranker models. It compute embeddings using Sentence Transformer models (quickstart) or to calculate similarity scores using Cross-Encoder (a.k.a. reranker) models (quickstart). This unlocks a wide range of applications, including semantic search, semantic textual similarity, and paraphrase mining.
* [pip install soundfile](https://pypi.org/project/soundfile/)
  * An audio library based on libsndfile, CFFI and NumPy.
* [pip install librosa](https://pypi.org/project/librosa/)
  * A python package for music and audio analysis.
* [pip install gradio](https://pypi.org/project/gradio/)
  * Python library for easily interacting with trained machine learning models. Gradio is an open-source Python package that allows you to quickly build a demo or web application for your machine learning model, API, or any arbitrary Python function.
* [pip install timm](https://pypi.org/project/timm/#introduction)
  * PyTorch Image Models (timm) is a collection of image models, layers, utilities, optimizers, schedulers, data-loaders / augmentations, and reference training / validation scripts that aim to pull together a wide variety of SOTA models with ability to reproduce ImageNet training results
* [pip install inflect](https://pypi.org/project/inflect/)
  * Correctly generate plurals, singular nouns, ordinals, indefinite articles
* [pip install phonemizer](https://pypi.org/project/phonemizer/)
  * Simple text to phones converter for multiple languages
* [pip install torchvision](https://pypi.org/project/torchvision/)
  The torchvision package consists of popular datasets, model architectures, and common image transformations for computer vision.

## Langchain for LLM app dev

* Sylabus:
  1. Models, prompts and parsers
  2. Memory
  3. Chains
  4. Q/A
  5. Eval
  6. Agents

* [pip install tiktoken](https://pypi.org/project/tiktoken/)
  * tiktoken is a fast BPE tokeniser for use with OpenAI's models
  * BPE: Byte pair encoding (BPE) is a way of converting text into tokens.
* [pip install pandas](https://pypi.org/project/pandas/)
  * Powerful data structures for data analysis, time series, and statistics
* [pip install -U wikipedia](https://pypi.org/project/wikipedia/)
  * Note: this library was designed for ease of use and simplicity, not for advanced use. If you plan on doing serious scraping or automated requests, please use Pywikipediabot (or one of the other more advanced Python MediaWiki API wrappers), which has a larger API, rate limiting, and other features so we can be considerate of the MediaWiki infrastructure.

## Serverless LLM Apps Amazon Bedrock

* Sylabus
  1. Amazon Bedrock generation
  2. Summarize an audio file
  3. Enable logging
  5. Deploy an AWS lambda function 
  6. Event driven generation

* [boto3](https://pypi.org/project/boto3/)
  * The AWS SDK for Python
  * AWS SDK [Bedrock docs](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/bedrock.html)
* [pip install Jinja2](https://pypi.org/project/Jinja2/)
  * Jinja is a fast, expressive, extensible templating engine. Special placeholders in the template allow writing code similar to Python syntax. Then the template is passed data to render the final document.

## ChatGPT Prompt Engineering for Devs

* Sylabus:
  1. Guidelines
  2. Iterative
  3. Summarizing
  4. Inferring
  5. Transforming
  6. Expanding
  7. Chatbot

#### Guidelines:
* 1. Write Clear and precise instructions
* 2. Get the model time to think

* Tactics for Write clear and precise intructions 
  * Tactic 1: Use delimiters to clearly indicate distinct parts of the input
    * Delimiters can be anything like: ```, """, < >, <tag> </tag>
  * Tactic 2: Ask for a structured output
  * Ask the model to check whether conditions are satisfied
  * Tactic 4: "Few-shot" promptin
* Tactics for Give the model time to think
  * Tactic 1: Specify the steps required to complete a task, as for output format
  * Tactic 2: Instruct to work out its own solution before rushing to conclusion
* Model Limitations
  * Hallucinations
    * First find relevant information, then answer the question. 

* pip install Redlines: Diff text
* pip install panel
  * The powerful data exploration & web app framework for Python.


## Javascript RAG Web Apps with Llamaindex

* Sylabus
  * into RAG
  * Full-stack web app
  * Advanced quereis with agents
  * Prod-ready techniques

* Create Query Engine
  * This convenience function combines several components:
    * Retriever
    * Postprocessing
    * Synthesizer

## Leta - LLMs as OS: Agent Memory

* Sylabus
  1. Editable Memory
  2. Understanding MemGPT
  3. Building Agents with Memory
  4. Programming Agent Memory
  5. Agentic RAG and External Memory
  6. Multi-agent orchestration

* LLM context window
  * LLM's have a context window (the set of tokens that go into the model) that is limited in size. That means we need to be smart about what we place into the context. Usually the context window for an agent is strucuted in a certain way. Depending on the agent framework, the structure will vary, but usually the context window contains:
    - A system prompt instructing the agent's behavior
    - A conservation history of previous conversations
  Because context windows are limited, only some of the conversation history can be included. Some frameworks will also place a recursive summary in the context, or retrieve relevant messages from an external database and also place them into the context. In MemGPT, we also reserver additional sections of the context for:
    - A recursive summary of all previous conversations
    - A core memory section that is read-writeable by the agent

* Understanding MemGPT
  * self-editing memory + inner thoughts + tool outputs + looping via heartbeats
  * autonomous and self-improving
  * Agent sate: Memories + tools + messages (MemGPT database)
  * Context compilation: 

## Building Gen Ai with Gradio

* Syllabus
  * NLP Task interface
  * Image Captioning app
  * Image generation app
  * Describe and generate game
  * Chat with any LLM

## Agent Communication Protocol (WIP)

Syllabus

* Why Agent Communication
* ACP Core Principles
* Building a RAG agent with crewAi
* Warting the RAG agent into an ACP server
* Calling ACP agent using the client
* Wrapping a smolagents into ACP. 

## Building Coding Agents with HG smolagents

Syllabus

  1. A brief history of agents
  2. Intro to coding agents
  3. Secure code execution
  4. Monitoring and evaluating your agents
  5. Build a Deep-Research agent

Notes

* Range of Agency Levels
  * simple processor, router, tool call, multi-step, multi-agent
  * [GAIA task](https://ai.meta.com/research/publications/gaia-a-benchmark-for-general-ai-assistants/)
* Introduction to code agents
  * Paper: Code Agents Perform Better: Xingyao Wang et al. 
* Secure Code Execution
  * LLM error - Supply chain attack - Prompt injection - 
* Monitoring and evaluationg
  * [pip install arize-phoenix-otel](https://pypi.org/project/arize-phoenix-otel/)
  * Provides a lightweight wrapper around OpenTelemetry primitives with Phoenix-aware defaults. Phoenix Otel also gives you acces to tracing decorators for common GenAI patterns.
* Build a Deep-Research Agent
  * Tavily: Connect Your LLM to the Web Empowering your AI applications with real-time accurate search results tailored for LLMs and RAG.

## Building toward Computer use with Anthropic

Syllabus

* Overview
* Working with API
* Multimodal Request
* Real World prompting
* Prompt caching
* Tool use

Notes
* Regular expressions [import re](https://docs.python.org/3/library/re.html)
* n-shot prompting (<examples>)
* 
  


## MCP: Build rich-context ai apps with Anthropic

Syllabus: 
  * MCP architecture
  * Chatbot example
  * Create MCP server + client
  * Connecting MCP chatbot to reference servers
  * Adding Prompt and resource feats
  * Config servers for Claude desktop
  * Create and deploy remote servers
 Notes:
  * https://arxiv.org/ 
  * https://render.com/
  * https://modelcontextprotocol.io/

## LangChain Chat with your data (RAG)

Syllabus:

* Document Loading
* Document Splitting
* VectorStores and Embdding
* Retrieval
* Question Answering
* Chat

Notes: 

* LangChain Components: Prompts, Models, Indexes, Chaings, Agents
* RAG: Chat with your data
* Document Loaders: (8 types)
  * pip install pypdf 
  * Loaders: deal with the specifics of accessing and coverting data
  * Accesing: Websites, youtube, db, arxiv..
  * converting: pdf, htlm, json, word...
  *  ! pip install yt_dlp ! pip install pydub
* Document splitting
  * Semantic relevant chunks: size and overlap
  * Types of splitters langchain.text_splitter
    * char, markdownHead, Token, SentenceTransformerToken, RecursiveCharacterTextSplitter, Language, NLTKText (Natual Language), Spacy
* Vectorstores and Embeddings
  * RAG: Load ⇒ split ⇒ storage ⇒ retrieval ⇒ output
  * numpy: It is a Python library that provides a multidimensional array object, various derived objects (such as masked arrays and matrices), and an assortment of routines for fast operations on arrays, including mathematical, logical, shape manipulation, sorting, selecting, I/O, discrete Fourier transforms, basic linear algebra, basic statistical operations, random simulation and much more.
  * `numpy.dot(a, b, out=None)` Dot product of two arrays.
  *  Chroma vector store (in memory)
     *  `docs = vectordb.similarity_search(question,k=3)`
* Retrieval
  * Types
    * Semantic similarity
    * Maximum Marginal Relevance (MMR) algorithm
      *  fetch_k - most diverse
    * Self Query - LLM Aided
      *  metadate Query parse (Filter + search term)
    * Compression:
     * shrinkin the responses to only the relevant info.
   * TF-IDF or SVM 
* `pip lark`: Lark is a modern general-purpose parsing library for Python. With Lark, you can parse any context-free grammar, efficiently, with very little code.
* Q/A
  * Context window
    * Stuff vs Map_reduce vs Refine vs Map_rerank
* Chat
  * Recall the overall workflow for retrieval augmented generation (RAG)
  * LangSmith (previously LangChain plus)
  * https://param.holoviz.org/
  * https://panel.holoviz.org/

## Langchain: Fn, tools, agents 

* ( October 2023 ) update June 2024
* Use LangChain Expression Language (LCEL), a new syntax to compose and customize chains and agents faster.

Sylabus:
  * OpenAi Function Calling
  * LangChain Expression Language (LCEL)
  * OpenAi Function Calling in LangChain
  * Tagging and Extraction
  * Tools and routing
  * Conversational Agent

 Notes
* OpenAi Function Calling
  * OpenAi finetune models to: Accept arguments to pass functions
  * return JSON fn with appropiate parameters
* LCEL
  * composes chains of components
  * input types -> Required methods -> Output types
  * Linux pipe syntax
  * Interface
    * Components implement "Runnable" protocol
    * Common methods: `ainvoke, astream, abatch`
    * common properties: input_schema, output_schema
    * common i/o
  * Benefits
    * Async Batch and streaming
    * Fallbacks, Parallelism, Logging.
  * `pip install pydantic` Data validation using Python type hints
  * chain = prompt | model | output_parser
* OpenAi Function calling in LangChain
  * pydantic: works with python type annotations used at runtime. Serialize json, dicts, 
* Tagging and extraction
  * doc tag https://lilianweng.github.io

  ```python 
  def flatten(matrix):
  """ put elements on the same array """
  flat_list = []
  for row in matrix:
      flat_list += row
  return flat_list
  ```
  * `from langchain.schema.runnable import RunnableLambda`
* Tools and Routing
  * Functions and services an LLM can utilize to exten its capabilieties are named tools in LangChain: "Search, Math, SQL, et..."
  * Routing is selecting from multiple tools. 
  * `@tool` decorators. `from langchain.agents import tool`
* Agents Basics
  * Agent: combination of LLMs and code
    * LLM reason about what steps to take and call for actions
  * Agent Loop: Choose tool to use ⇒ Observe output ⇒ repeat until condition
  * `from langchain.prompts import MessagesPlaceholder`
    * action + observation pair
    * agent_scratchpad

## Build LLM Apps with LangChain.js

Sylabus:
  * Building Blocks
  * Loading and preparing data
  * VectorStores and embedings
  * Q/A
  * Conversational Q/A
  * Shipping as a web API

Notes: 
  * `import { similarity } from "ml-distance";`
  * 

## Collaborative writing and coding with openAI Canvas

Syllabus

  * Collaborative writing, coding
  * Build a spaceship game
  * create sql database from architecture image
  * training the canvas

Notes: 
  * https://tieukhoimai.me/blog/dimensional-part-1
  * General Product Research Lifecycle
    * Model Behaviour spec => Eval => Prompt experimentation => Distillation
  * SWE: Reproduciblity, ablating components, solve wholistically. 
  * 

## Ai Agents in LangGraph

* June 2024

Syllabus:
  * Build an agent from scratch
  * LangGraph components
  * Agentic Search Tools
  * Persistence and streaming
  * Human in the llop
  * Essay writer

Notes: 

* Intro: 
  * ReAct, Self-refine, AphaCodium (arxiv)
  * cyclical graph, agentic search
  * human input, persistance, 
* Build and Agent from scratch
  * ReAct: Reasoning and acting (arxiv)
  * based on https://til.simonwillison.net/llms/python-react-pattern
  * Loop: Thought ⇒ Action ⇒ Pause ⇒ Observation
* LangGraph components
  * Is an extension of LangChaing that supports Graphs
  * Single and multiagent 
  * allows controlled flows
  * Built-in persistence allows for human in the loop workflows. 
  * Typing https://docs.python.org/3/library/typing.html
  * Agent State is accessible to all parts for the graph
    * local to the graph, can be stored in a persistance layer
  ```python
  class AgentState(TypedDict):
    messages: Annotated[list[AnyMessage], operator.add]
  
  class Agent:

    def __init__(self, model, tools, system=""):
        self.system = system
        graph = StateGraph(AgentState)
        graph.add_node("llm", self.call_openai)
        graph.add_node("action", self.take_action)
        graph.add_conditional_edges(
            "llm",
            self.exists_action,
            {True: "action", False: END}
        )
        graph.add_edge("action", "llm")
        graph.set_entry_point("llm")
        self.graph = graph.compile()
        self.tools = {t.name: t for t in tools}
        self.model = model.bind_tools(tools)

    def exists_action(self, state: AgentState):
        result = state['messages'][-1]
        return len(result.tool_calls) > 0

    def call_openai(self, state: AgentState):
        messages = state['messages']
        if self.system:
            messages = [SystemMessage(content=self.system)] + messages
        message = self.model.invoke(messages)
        return {'messages': [message]}

    def take_action(self, state: AgentState):
        tool_calls = state['messages'][-1].tool_calls
        results = []
        for t in tool_calls:
            print(f"Calling: {t}")
            if not t['name'] in self.tools:      # check for bad tool name from LLM
                print("\n ....bad tool name....")
                result = "bad tool name, retry"  # instruct LLM to retry if bad
            else:
                result = self.tools[t['name']].invoke(t['args'])
            results.append(ToolMessage(tool_call_id=t['id'], name=t['name'], content=str(result)))
        print("Back to the model!")
        return {'messages': results}

  ```

* Agentic Search
  * import BeautifulSoup: Beautiful Soup is a library that makes it easy to scrape information from web pages. It sits atop an HTML or XML parser, providing Pythonic idioms for iterating, searching, and modifying the parse tree.
* Persistance and Streaming
* Human in the Loop
* Essay Writter. 

## Building Systems with the chatGPT API

date released: may 2023

Syllabus
  * Language Models, the Chat Format and Tokens
  * Classification
  * Moderation
  * Chain of Thougth reasoning
  * Chaining Prompts
  * Check Outputs
  * Evaluation

Notes
  * Base LLMs => Instruction Tuned LLM
  * `import tiktoken` tiktoken is a fast BPE tokeniser for use with OpenAI's models
  * gpt3.5-turbo ~4000 tokens limit (input context + output completion)
  * system, Uses, Assitant messages. 
  * supervised learning vs prompt-based AI
  * Classification
    * delimiter = "####" (1 token)
  * Moderation API (free)
  * Evaluation
    * https://en.wikipedia.org/wiki/BLEU
  * https://github.com/openai/evals/blob/main/evals/registry/modelgraded/fact.yaml

## Vector DB: from embeddings to Apps

* Launch Nov2023

Syllabus:

  * How to obtain Vector represantiton of Data
  * Search for similar vectors
  * Approximate nearest neighbours
  * Sparse, Dense, Hybrid Search
  * App - multilingual search

Notes: 

  INTRO
  * Embbeddings: vector representations of data
  * Searching for similiar vectors - Distance metrics
  * Approximate Nearest Neighbours
    * ANN - Trade recall for accuracy
    * HNSW
  * Vector DB - CRUD + Objects + Vctors + Inverted Index + filtered search
  * Sparse vs Dense
    * ANN search over Dense embeddings
    * Sparse - Hybrid
  * Apps of VBS in industry

Distances
  * Euclidean Distance(L2)
  * Manhattan Distance(L1)
  * Dot Product
  * Cosine Distance

* Dot Product and Cosine Distance are commonly used in the field of NLP, to evaluate how similar two sentence embeddings are. So here we will only use those two.

Approximate Nearest Neigbours
* NSW: Navigable Small World => Constructon => Search
* HNSW: Hierarchical Naviable Small World
  * Runtime: Low likehood in higher levels goes down exponentially
  * Query time increases logarithmically
  * O(log(N)) runtime complexity
* NetworkX is a Python package for the creation, manipulation, and study of the structure, dynamics, and functions of complex networks.

Sparse, Dense & Hybrid
* Dense (Semantic Search)
  * Uses vector embedding representation of data to perform search
  * This types of search allows one capture and return semantically similar objects
  * baby dogs => content on puppies
  * Limits: Out of domain data - serial numbers, 
* Sparse search (keyword search)
  * Bag of words: easiest way to do kw match -> count how many times a word occurs in the query and data vector and then return objects with the highest matching requencies. 
  * Mostly Zeroes
  * Best matching BM25:
* Hybrid
  * Both in one query
  * combitate on a score system

Multilingual Search
* RAG advantages: 1. Reduce hallucinations 2. Enable LLM cite sources 3. Solve knowledge intensive task
  
