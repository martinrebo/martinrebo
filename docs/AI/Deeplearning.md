# Deepleaning

Notes on Courses from Deeplearning.ai

## OS models with HugginFace

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