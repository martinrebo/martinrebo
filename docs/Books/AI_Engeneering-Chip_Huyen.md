# AI Engineering by Chip Huyen

## Metadata
Github: chip huen  https://github.com/chiphuyen/aie-book

## Chapter 1: Introduction to AI Engineering

### Books

- DMLS focuses on building applications on top of traditional ML models, which involves more tabular data annotations, feature engineering, and model training. 

- AIE focuses on building applications on top of foundation models, which involves more prompt engineering, context construction, and parameter-efficient finetuning. Both books are self-contained and modular, so you can read either book independently.

### AI Concepts

- **Language Model:** A language model encodes statistical information about one or more languages. Intuitively, this information tells us how likely a word is to appear in a given context.
- **Token:** The basic unit of a language model is token. A token can be a character, a word, or a part of a word (like -tion), depending on the model.
    The process of breaking the original text into tokens is called tokenization. For GPT-4, an average token is approximately ¾ the length of a word. So, 100 tokens are approximately 75 words.
    The set of all tokens a model can work with is the model’s vocabulary. You can use a small number of tokens to construct a large number of distinct words, similar to how you can use a few letters in the alphabet to construct many words.

- **Masked vs Autogregressive (Language Model):**
  - A masked language model is trained to predict missing tokens anywhere in a sequence, using the context from both before and after the missing tokens. 
are commonly used for non-generative tasks such as sentiment analysis and text classification. They are also useful for tasks requiring an understanding of the overall context, such as code debugging
  - An autoregressive language model is trained to predict the next token in a sequence, using only the preceding tokens.

- **Modeling and training:** Modeling and training refers to the process of coming up with a model architecture, training it, and finetuning it. Examples of tools in this category are Google’s TensorFlow, Hugging Face’s Transformers, and Meta’s PyTorch.

- **Dataset engineering:** Dataset engineering refers to curating, generating, and annotating the data needed for training and adapting AI models.
    Another difference is that traditional ML engineering works more with tabular data, whereas foundation models work with unstructured data. In AI engineering, data manipulation is more about deduplication, tokenization, context retrieval, and quality control, including removing sensitive information and toxic data.

- **Inference optimization:** Inference optimization refers to the process of making a model run faster and more efficiently in production. This includes quantization, distillation, pruning and parallelism

- **Prompt engineering:** Prompt engineering is the process of designing and optimizing prompts to elicit the desired response from a language model. This includes constructing effective prompts, managing context, and using techniques like few-shot learning to improve model performance on specific tasks.
  
- **MMLU:** MMLU (Massive Multitask Language Understanding) is a benchmark for evaluating the performance of language models across a wide range of tasks. It tests the model's ability to understand and generate text in various contexts, including multiple-choice questions, open-ended questions, and more. MMLU is used to assess the generalization capabilities of language models and their understanding of complex language tasks.

### JavaScript AI Libraries

- [LangChain.js](https://github.com/langchain-ai/langchainjs)
- [Transformers.js](https://github.com/huggingface/transformers.js)
- [OpenAI’s Node library](https://github.com/openai/openai-node)
- [Vercel’s AI SDK](https://github.com/vercel/ai)

## Chapter 2: Undestanding Foundation Models

### Training Data

- **Sampling:** Sampling is how a model chooses an output from all possible options

- [Colossal Clean Crawled Corpus (C4)](https://arxiv.org/abs/1910.10683v4)

- Multilingual Models:
- Domain-Specific Models: [DeepMind’s AlphaFold](https://oreil.ly/JX37g), trained on the sequences and 3D structures of around 100,000 known proteins. [NVIDIA’s BioNeMo](https://oreil.ly/M1Nsc) is another model that focuses on biomolecular data for drug discovery. [Google’s Med-PaLM2](https://oreil.ly/F76hq) combined the power of an LLM with medical data to answer medical queries with higher accuracy.

### Modeling

#### Transformer Architecture

- **Transformer Architecture:** The transformer architecture is a neural network design that uses self-attention mechanisms to process input data in parallel, allowing for efficient handling of long-range dependencies in sequences. It consists of an encoder and decoder, with each layer containing multi-head self-attention and feed-forward networks.
  
- **seq2seq:** Sequence-to-sequence (seq2seq) models are a type of neural network architecture designed for tasks where the input and output are both sequences, such as translation or summarization. They typically use an encoder to process the input sequence and a decoder to generate the output sequence.
  - eq2seq contains an encoder that processes inputs and a decoder that generates outputs. Both inputs and outputs are sequences of tokens, hence the name. Seq2seq uses RNNs (recurrent neural networks) as its encoder and decoder. In its most basic form, the encoder processes the input tokens sequentially, outputting the final hidden state that represents the input. The decoder then generates output tokens sequentially, conditioned on both the final hidden state of the input and the previously generated token.

- **RNNs:** Recurrent Neural Networks (RNNs) are a type of neural network designed for sequential data, where the output from previous steps is fed as input to the current step. They are particularly useful for tasks like language modeling and time series prediction, but they can struggle with long-range dependencies due to vanishing gradients.
  
- **Attention Mechanism:** The attention mechanism allows a model to focus on specific parts of the input sequence when generating an output, improving performance on tasks like translation and summarization. It calculates a weighted sum of the input representations, enabling the model to attend to relevant information dynamically.
  
- **Query Vector:** The query vector is a representation of the current token or context that the model is processing. It is used to compute attention scores against the key vectors of the input sequence.
- **Key Vector:** The key vector is a representation of each token in the input sequence. It is used to compute attention scores against the query vector, determining how much attention should be paid to each token.
- **Value Vector:** The value vector is a representation of the input tokens that are used to compute the final output of the attention mechanism. It is weighted by the attention scores derived from the query and key vectors.

- **Transformer Block:** A transformer block is a building block of the transformer architecture, consisting of multi-head self-attention and feed-forward networks. It processes input sequences in parallel, allowing for efficient handling of long-range dependencies. The exact content of the block varies between models, but, in general, each transformer block contains the attention module and the MLP (multi-layer perceptron) module. 
  - **Attention module:** Each attention module consists of four weight matrices: query, key, value, and output projection.
  - **MLP module** is a feed-forward neural network that processes the output of the attention module. It typically consists of two linear layers with a non-linear activation function (like ReLU) in between.
  
#### Model Size

- **Model Size:** The size of a model refers to the number of parameters it contains. Larger models generally have more capacity to learn complex patterns but require more computational resources and data to train effectively. Model size is often measured in billions of parameters, with larger models typically achieving better performance on a wide range of tasks.
- **Parameter Count:** The number of parameters in a model is a key factor in its capacity and performance. Larger models with more parameters can capture more complex patterns in the data, but they also require more computational resources and data to train effectively. The parameter count is often used as a measure of a model's size and complexity.
- **Mixture of Experts (MoE):** Mixture of Experts (MoE) is a model architecture that uses multiple expert networks, each specialized in different aspects of the data. During inference, only a subset of these experts is activated, allowing for efficient computation while maintaining high performance. MoE models can achieve better performance with fewer parameters by leveraging the strengths of multiple specialized networks.
- **Sparse vs Dense Models:** Sparse models have a small number of active parameters at any given time, while dense models have all parameters active. Sparse models can be more efficient in terms of memory and computation, as they only use a subset of parameters for each input. Dense models, on the other hand, use all parameters for every input, which can lead to better performance but requires more resources.
- **FLOP:** FLOP (Floating Point Operations) is a measure of computational complexity that quantifies the number of floating-point operations required to perform a specific task. It is often used to compare the efficiency of different models or algorithms, with lower FLOP counts indicating more efficient computations.
- **Scaling Laws:** Scaling laws describe how the performance of a model changes as its size, data, or compute resources are increased. They provide insights into how to effectively scale models to achieve better performance on various tasks. Scaling laws can help guide decisions about model architecture, training data, and computational resources.
  
#### Post-Training

Post-training is unlocking the capabilities that the pre-trained model already has but are hard for users to access via prompting alone.

- **Supervised finetuning (SFT)**: Finetune the pre-trained model on high-quality instruction data to optimize models for conversations instead of completion.
- **Preference finetuning:** Further finetune the model to output responses that align with human preference. Preference finetuning is typically done with reinforcement learning (RL)

#### Sampling

- **Sampling:** Sampling is the process of selecting a subset of data from a larger dataset to train or evaluate a model. It can be done randomly or based on specific criteria, and it is essential for creating representative datasets that capture the underlying patterns in the data.

- **Logits:** Logits are the raw output scores produced by a model before applying a softmax function to convert them into probabilities. They represent the unnormalized confidence of the model for each class or token in a classification task.

- **Softmax:** Softmax is a mathematical function that converts logits into probabilities by exponentiating each logit and normalizing the results. It ensures that the output probabilities sum to 1, making them interpretable as confidence scores for each class or token.

- **Temperature:** Temperature is a hyperparameter that controls the randomness of the sampling process. A higher temperature results in more diverse and creative outputs, while a lower temperature produces more conservative and focused responses. It is often used to balance exploration and exploitation in model outputs. Temperature is a constant used to adjust the logits before the softmax transformation

- **Top-k sampling:** Top-k is a sampling strategy to reduce the computation workload without sacrificing too much of the model’s response diversity. Top-k sampling is a technique that restricts the sampling process to the top k most probable tokens, ensuring that only the most likely options are considered. This helps to reduce randomness and improve the quality of generated text by focusing on high-probability tokens. A smaller k value makes the text more predictable but less interesting, as the model is limited to a smaller set of likely words.

- **Top-p sampling (nucleus sampling):** Top-p sampling is a technique that selects tokens based on their cumulative probability, ensuring that the sum of probabilities of the selected tokens is greater than or equal to a specified threshold p.
  In top-p sampling, the model sums the probabilities of the most likely next values in descending order and stops when the sum reaches p.

- **Stopping Condition:** The stopping condition is a criterion used to determine when to stop generating text. It can be based on various factors, such as reaching a maximum length, encountering a specific token (like an end-of-sentence token), or achieving a certain level of confidence in the generated output. Setting appropriate stopping conditions is crucial for controlling the length and coherence of generated text.

- **Test Time Compute:**  ()Test time compute refers to the computational resources required to run a model during inference or testing. It includes the time and memory needed to process input data, generate predictions, and perform any necessary post-processing. Efficient test time compute is essential for deploying models in real-time applications where quick responses are required.

- **Structured Output:** Structured output refers to generating outputs that follow a specific format or structure, such as JSON, XML, or other predefined formats. This is particularly useful for tasks like data extraction, where the model needs to produce outputs that can be easily parsed and used in downstream applications.

## Chapter 3: Evaluation Methodology

### Understanding Evaluation Methodology

- **Entropy:** Entropy measures how much information, on average, a token carries. The higher the entropy, the more information each token carries, and the more bits are needed to represent a token. Intuitively, entropy measures how difficult it is to predict what comes next in a language. The lower a language’s entropy (the less information a token of a language carries), the more predictable that language.
- **Cross-Entropy:** A language model’s cross entropy on a dataset measures how difficult it is for the language model to predict what comes next in this dataset. 
  Cross-entropy is a measure of the difference between two probability distributions, often used to evaluate how well a model's predicted distribution matches the true distribution of the data. It quantifies the average number of bits needed to encode the true distribution using the model's predicted distribution.

- **Bits Per Character (BPC):** Bits per character is a metric that measures the average number of bits required to represent each character in a text. It is calculated by dividing the cross-entropy by the logarithm of the base 2 of the vocabulary size. BPC provides a way to compare the efficiency of different language models in terms of how well they compress text data.
- **Bits per Byte (BPP):** Bits per byte is a metric similar to bits per character, but it measures the average number of bits required to represent each byte in a text. It is calculated by dividing the cross-entropy by the logarithm of the base 2 of 256 (the number of possible byte values). BPP is often used to evaluate the efficiency of models in terms of how well they compress binary data.
- **Perplexity:** Perplexity is a measure of how well a language model predicts a sample. It is calculated as the exponentiation of the cross-entropy, providing an intuitive understanding of how "confused" the model is when predicting the next token. Lower perplexity indicates better performance, as it means the model is more confident in its predictions.
  Remember that the more uncertainty the model has in predicting what comes next in a given dataset, the higher the perplexity.
  More structured data gives lower expected perplexity
  The bigger the vocabulary, the higher the perplexity
  The longer the context length, the lower the perplexity

### Exact Evaluation

- **Functional Correctness:** Functional correctness evaluation means evaluating a system based on whether it performs the intended functionality.
  Popular benchmarks for evaluating AI’s code generation capabilities, such as OpenAI’s HumanEval and Google’s MBPP (Mostly Basic Python Problems Dataset) use functional correctness as their metrics. Benchmarks for text-to-SQL (generating SQL queries from natural languages) like Spider (Yu et al., 2018), BIRD-SQL (Big Bench for Large-scale Database Grounded Text-to-SQL Evaluation) (Li et al., 2023), and WikiSQL (Zhong, et al., 2017) also rely on functional correctness.
- **Similar Mesurements against Reference Data:** Each example in the reference data follows the format (input, reference responses). An input can have multiple reference responses, such as multiple possible English translations of a French sentence. Reference responses are also called ground truths or canonical responses. Metrics that require references are reference-based, and metrics that don’t are reference-free.
  Since this evaluation approach requires reference data, it’s bottlenecked by how much and how fast reference data can be generated. Reference data is generated typically by humans and increasingly by AIs. Using human-generated data as the reference means that we treat human performance as the gold standard, and AI’s performance is measured against human performance. Human-generated data can be expensive and time-consuming to generate, leading many to use AI to generate reference data instead.

    1. Asking an evaluator to make the judgment whether two texts are the same

    2. Exact match: whether the generated response matches one of the reference responses exactly

    3. Lexical similarity: how similar the generated response looks to the reference responses

    4. Semantic similarity: how close the generated response is to the reference responses in meaning (semantics)

- **Exact Match (EM):** Exact match is a metric that evaluates whether the generated response matches one of the reference responses exactly. It is a strict measure of correctness, as it requires an exact match between the generated and reference responses. EM is commonly used in tasks like question answering and text generation, where precise answers are expected.

- **Lexical Similarity:** Lexical similarity measures how similar the generated response looks to the reference responses in terms of word choice and structure. It can be calculated using various methods: Common metrics for lexical similarity are BLEU, ROUGE, METEOR++, TER, and CIDEr. They differ in exactly how the overlapping is calculated. Lexical similarity is useful for evaluating tasks like text generation and summarization, where maintaining similar wording is important. Since the rise of foundation models, fewer benchmarks use lexical similarity. 
  
- **Semantic Similarity:** Semantic similarity measures how close the generated response is to the reference responses in meaning, regardless of the exact wording. It can be calculated using methods like cosine similarity between embeddings or using specialized models like BERTScore. Semantic similarity is particularly useful for tasks like paraphrase generation and text summarization, where the meaning is more important than the exact wording.
  While I put semantic similarity in the exact evaluation category, it can be considered subjective, as different embedding algorithms can produce different embeddings. However, given two embeddings, the similarity score between them is computed exactly.

  - Cosine similarity is a common method for calculating semantic similarity, where the cosine of the angle between two vectors (embeddings) is used to measure their similarity. A cosine similarity of 1 indicates that the vectors are identical, while a cosine similarity of 0 indicates that they are orthogonal (completely dissimilar).
  - Metrics for semantic textual similarity include BERTScore (embeddings are generated by BERT) and MoverScore (embeddings are generated by a mixture of algorithms). 

  However, the reliability of semantic similarity depends on the quality of the underlying embedding algorithm. Two texts with the same meaning can still have a low semantic similarity score if their embeddings are bad.

- **Embeddings:** Embeddings are numerical representations of text that capture semantic meaning. They are often used in natural language processing tasks to compare the similarity between texts. Embeddings can be generated using various models, such as BERT, GPT, or Word2Vec, and they allow for efficient computation of semantic similarity.
  Embeddings are used in many tasks, including classification, topic modeling, recommender systems, and RAG. An example of benchmarks that measure embedding quality on multiple tasks is MTEB, Massive Text Embedding Benchmark (Muennighoff et al., 2023).

### AI as a Judge
  
  Because there are many possible ways to use AI judges, there are many possible specialized AI judges. Here, I’ll go over examples of three specialized judges: reward models, reference-based judges, and preference models:

- **Reward Models:** Reward models are AI systems trained to evaluate the quality of generated responses based on specific criteria. They assign a numerical score to each response, indicating its quality or relevance. Reward models can be used to guide the training of other models, such as reinforcement learning agents, by providing feedback on their performance. Cappy is an example of a reward model developed by Google (2023).
  
- **Reference-based Judges:** Reference-based judges are AI systems that evaluate generated responses by comparing them to reference responses. They can use various metrics, such as exact match, lexical similarity, or semantic similarity, to assess the quality of the generated text. Reference-based judges are useful for tasks where a specific set of reference responses is available, such as question answering or text generation.
  
- **Preference Models:** Preference models are AI systems that learn to rank generated responses based on human preferences. They can be trained using pairwise comparisons, where humans indicate which of two responses they prefer. Preference models can be used to improve the quality of generated text by selecting the most preferred responses from a set of candidates.

- **Pairwise Comparisons:** Pairwise comparisons are a method of evaluating generated responses by comparing them in pairs and determining which one is preferred. This approach allows for more nuanced evaluations, as it captures human preferences more effectively than single-response evaluations. Pairwise comparisons can be used to train preference models or to evaluate the quality of generated text in a more detailed manner.

## Chapter 4: Evaluating AI Systems

 A model is only useful if it works for its intended purposes. You need to evaluate models in the context of your application

 Which is worse—an application that has never been deployed or an application that is deployed but no one knows whether it’s working? When I asked this question at conferences, most people said the latter. An application that is deployed but can’t be evaluated is worse. It costs to maintain, but if you want to take it down, it might cost even more.

### Evaluation Criteria

- **Domain Specific Capability:** Domain-specific capabilities are commonly evaluated using exact evaluation.While functional correctness is important, it might not be the only aspect that you care about. You might also care about efficiency and cost.

- **Generation Capability:** Metrics used to evaluate the quality of generated texts back then included fluency and coherence. Fluency measures whether the text is grammatically correct and natural-sounding (does this sound like something written by a fluent speaker?). Coherence measures how well-structured the whole text is (does it follow a logical structure?). Each task might also have its own metrics. For example, a metric a translation task might use is faithfulness: how faithful is the generated translation to the original sentence? A metric that a summarization task might use is relevance: does the summary focus on the most important aspects of the source document? (Li et al., 2022).

  Generative models, with their new capabilities and new use cases, have new issues that require new metrics to track. The most pressing issue is undesired hallucinations. Hallucinations are desirable for creative tasks, not for tasks that depend on factuality. A metric that many application developers want to measure is factual consistency. Another issue commonly tracked is safety: can the generated outputs cause harm to users and society? Safety is an umbrella term for all types of toxicity and biases.

  - **Factual Consistency:** Factual consistency is a measure of how well the generated text aligns with known facts or information. It evaluates whether the content is accurate and reliable, especially in tasks like question answering, summarization, and information retrieval. Factual consistency is crucial for applications that require trustworthiness and credibility in the generated outputs.
  
    Verifying whether a statement is consistent with a given context can also be framed as textual entailment, which is a long-standing NLP task.4 Textual entailment is the task of determining the relationship between two statements. Given a premise (context), it determines which category a hypothesis (the output or part of the output) falls into:

      Entailment: the hypothesis can be inferred from the premise.
      Contradiction: the hypothesis contradicts the premise.
      Neutral: the premise neither entails nor contradicts the hypothesis.
  
- **Intruction Following:** Instruction following is a measure of how well a model can understand and execute instructions provided in natural language. It evaluates the model's ability to comprehend the task requirements and generate appropriate responses or actions based on those instructions. Instruction following is essential for applications that involve user interaction, such as chatbots and virtual assistants.

### Model Selection

- **Model Selection:** Model selection is the process of choosing the best model for a specific task or application based on evaluation criteria. It involves comparing different models' performance, efficiency, and suitability for the intended use case. Model selection is crucial for ensuring that the chosen model meets the requirements and expectations of the application.

  Hard attributes are often the results of decisions made by model providers (licenses, training data, model size) or your own policies (privacy, control).

  Soft attributes are attributes that can be improved upon, such as accuracy, toxicity, or factual consistency.

Workflow - Build vs Buy - Navigate public benchmarks. 

You can detect contamination using heuristics like n-gram overlapping and perplexity

### Designing your Evaluation Pipeline

1. Evaluate All components in a System
2. Create an Evaluation Guideline
3. Define Evaluation Methods and Data

## Chapter 5: Prompt Engineering

### Intro

- A prompt is an instruction given to a model to perform a task.
- How much prompt engineering is needed depends on how robust the model is to prompt perturbation.
- Most models, including GPT-4, empirically perform better when the task description is at the beginning of the prompt. However, some models, including Llama 3, seem to perform better when the task description is at the end of the prompt.

#### In-Context Learning: Zero-Shot and Few-Shot

- Teaching models what to do via prompts is also known as in-context learning.
  - In-context learning allows a model to incorporate new information continually to make decisions, preventing it from becoming outdated.
  - Each example provided in the prompt is called a shot. Teaching a model to learn from examples in the prompt is also called few-shot learning. With five examples, it’s 5-shot learning. When no example is provided, it’s zero-shot learning.

#### System Prompt and user prompt

- Many model APIs give you the option to split a prompt into a system prompt and a user prompt. You can think of the system prompt as the task description and the user prompt as the task.
- Training a model to prioritize system prompts also helps mitigate prompt attacks, as discussed later in this chapter.

#### Context Length and Context Efficiency

Not all parts of a prompt are equal. Research has shown that a model is much better at understanding instructions given at the beginning and the end of a prompt than in the middle (Liu et al., 2023). One way to evaluate the effectiveness of different parts of a prompt is to use a test commonly known as the needle in a haystack (NIAH). The idea is to insert a random piece of information (the needle) in different locations in a prompt (the haystack) and ask the model to find it

### Prompt best practices

Each model provide its own prompting guides and best practices. 

1. Write clear and Explicit intructions
2. Provide sufficient Context
3. Break complex tasks into subtaks
4. Give model time to think using chain-of-thought (CoT) and self-critique prompting.
5. Iterate your prompts
6. Evaluate Prompt Engineering Tools
7. Organize and Version Prompts

### Defensive Prompt Engineering

1. Prompt extraction
    Extracting the application’s prompt, including the system prompt, either to replicate or exploit the application

2. Jailbreaking and prompt injection
  Getting the model to do bad things

3. Information extraction
  Getting the model to reveal its training data or information used in its context

## Chapter 6: RAG and Agents

- This chapter focuses on how to construct the relevant context for each query. Two dominating patterns for context construction are RAG, or retrieval-augmented generation, and agents. The RAG pattern allows the model to retrieve relevant information from external data sources. The agentic pattern allows the model to use tools such as web search and news APIs to gather information.

### RAG

- RAG is a technique that enhances a model's generation by retrieving the relevant information from external memory sources. (DB, chat sessions, internet ... ). It constructs context specific to each query. 

#### RAG Architecture

- A RAG system has two components: a retriever that retrieves information from external memory sources and a generator that generates a response based on the retrieved information. 
- The success of a RAG system depends on the quality of its retriever. A retriever has two main functions: indexing and querying. Indexing involves processing data so that it can be quickly retrieved later. Sending a query to retrieve data relevant to it is called querying. How to index data depends on how you want to retrieve it later on.

#### Retrieval algorithms

- Retrieval algorithms: Sparse vs Dense // term-based vs embedding-based
- **Term-based:** lexical retrieval: Elasticsearch and BM25. TF-IDF is an algorithm that combines these two metrics: term frequency (TF) and inverse document frequency (IDF).
- **Embedding-based:** semantic retrieval: Rank documents based on how closely their meaning align with the query, generating a `vector database`. (FAISS: FB AI Similarity Search / ScaNN: Scalable Nearest Neighbors google / Spotify Annoy )
  - Vector DB organize data into buckets, trees or graphs. Vectors can be quantized (reduce precision) or made sparse. Check [zilliz](https://zilliz.com/learn/vector-index)
- Context precision and context recall
  
#### Retrieval Optimization

- **Chunking strategy** 
- **Reranking**
- **Query rewriting** (reformulation | normalization | expansion)
- **Contextual retrieval**  (add tags and keywords)

#### RAG beyond Texts

- Multimodal RAG
- RAG with tabular data

### Agents

- The goal of AI, emerging field with no frameworks to define, develop and evaluate them. 
  
#### Overview

- An agent is anything that can perceive its environment and act upon that environment. (games, internet, road...)

#### Tools

- **Knowledge augmentation**
- **Capability extension**
- **Write actions**

#### Planning

- Planning overview: Decoupled from execution
- Foundations models as planners
- Plan generation

#### Agent Failure Modes and Evaluation

- Planing failures
- Tool failures
- Efficiency

### Memory

- Memory refers to mechanisms that allow a model to retain and utilize information. A memory system is especially useful for knowledge-rich applications like RAG and multi-step applications like agents. 


## Chapter 7: Finetuning

### Overview

* Finetuning is the process of adapting a model to a specific task by further training the whole model or part of the model. Finetuning adapts a model by adjusting its weights.
* Finetuning isn’t the only way to do transfer learning. Another approach is feature-based transfer. In this approach, a model is trained to extract features from the data, usually as embedding vectors, which are then used by another model.
* Finetuning is commonly used to improve a model’s ability to generate outputs following specific structures, such as JSON or YAML formats.
* While finetuning a model for a specific task can improve its performance for that task, it can degrade its performance for other tasks.
* Someone complains that prompting is ineffective and insists on finetuning. Upon investigation, it turns out that prompt experiments were minimal and unsystematic. Instructions were unclear, examples didn’t represent actual data, and metrics were poorly defined. After refining the prompt experiment process, the prompt quality improved enough to be sufficient for their application
* In short, finetuning is for form, and RAG is for facts. 

### Memory BottleNeck

Because of the scale of foundation models, memory is a bottleneck for working with them, both for inference and for finetuning. The memory needed for finetuning is typically much higher than the memory needed for inference because of the way neural networks are trained.

The key contributors to a model’s memory footprint during finetuning are its number of parameters, its number of trainable parameters, and its numerical representations.

The more trainable parameters, the higher the memory footprint. You can reduce memory requirement for finetuning by reducing the number of trainable parameters. Reducing the number of trainable parameters is the motivation for PEFT, parameter-efficient finetuning.

Quantization refers to the practice of converting a model from a format with more bits to a format with fewer bits. Quantization is a straightforward and efficient way to reduce a model’s memory footprint. For a model of 13 billion parameters, using FP32 means 4 bytes per weight or 52 GB for the whole weights. If you can reduce each value to only 2 bytes, the memory needed for the model’s weights decreases to 26 GB.

Inference is typically done using as few bits as possible, such as 16 bits, 8 bits, and even 4 bits.

Training is more sensitive to numerical precision, so it’s harder to train a model in lower precision. Training is typically done in mixed precision, with some operations done in higher precision (e.g., 32-bit) and some in lower precision (e.g., 16-bit or 8-bit).

Training memory = model weights + activations + gradients + optimizer states


- **Numerical values** in neural networks are traditionally represented as float numbers. The most common family of floating point formats is the FP family, which adheres to the Institute of Electrical and Electronics Engineers (IEEE) standard for Floating-Point Arithmetic (IEEE 754):

While FP64 is still used in many computations—as of this writing, FP64 is the default format for NumPy and pandas—it’s rarely used in neural networks because of its memory footprint. 

- **Quantization** Strictly speaking, it’s quantization only if the target format is integer. However, in practice, quantization is used to refer to all techniques that convert values to a lower-precision format. In this book, I use quantization to refer to precision reduction, to keep it consistent with the literature.

### Finetuning Techniques

- **Parameter-Efficient Finetuning (PEFT)** he idea of PEFT (parameter-efficient finetuning) was introduced by Houlsby et al. (2019). The authors showed that by inserting additional parameters into the model in the right places, you can achieve strong finetuning performance using a small number of trainable parameters. The existing prolific world of PEFT generally falls into two buckets: adapter-based methods and soft prompt-based methods. However, it’s likely that newer buckets will be introduced in the future.
- **LoRA (Low-Rank Adaptation)** (Hu et al., 2021) incorporates additional parameters in a way that doesn’t incur extra inference latency. Instead of introducing additional layers to the base model, LoRA uses modules that can be merged back to the original layers.
- **Model Merging and Multitask finetunning**
- Finetuning tactics
  - Base models
  - Finetuning methods
  - Frameworks (LLaMA-Factory, unsloth, PEFT, Axolotl, and LitGPT. )
  - Finetune hyperparameters
    - Learning rate
    - Batch size
    - Number of epochs
    - Prompt loss weight

## Chapter 8: Dataset Engineering

* For the same model, different training phases aim to teach the model different capabilities, and, therefore, require datasets with different attributes. For example, data quantity for pre-training is often measured in the number of tokens, whereas data quantity for supervised finetuning is often measured in the number of examples. 
* There are best practices you can follow and tools that you can use to automate parts of the process. However, data will mostly just be toil, tears, and sweat.

### Data Curation

- For self-supervised finetuning, you need sequences of data. For instruction finetuning, you need data in the (instruction, response) format. For preference finetuning, you need data in the (instruction, winning response, losing response) format. To train a reward model, you can use the same data format as preference finetuning or use data with annotated scores for each of your examples in the ((instruction, response), score) format.
- When curating data for applications with conversation interfaces, you need to consider whether you require single-turn data, multi-turn data, or both. Single-turn data helps train a model to respond to individual instructions. Multi-turn data, on the other hand, teaches the model how to solve tasks—many real-world tasks involve back-and-forth. For instance, when given a query, a model may need to first clarify the user’s intent before addressing the task. After the model’s response, the user might provide corrections or additional information for the next step.
- Data Quality: A small amount of high-quality data can outperform a large amount of noisy data, e.g., data that is irrelevant or inconsistent. The creators of the Yi model family found that 10K carefully crafted instructions are superior to hundreds of thousands of noisy instructions (Young et al., 2024). In general, data can be considered high-quality if it has the following six characteristics: relevant, aligned with task requirements, consistent, correctly formatted, unique, and compliant.
- Data Coverage: Coverage requires sufficient data diversity, which is why many refer to this attribute as data diversity.
- Data Quantity: Many things, other than data, can impact finetuning’s results, such as the choice of hyperparameters (e.g., the learning rate is too high or too low), data quality, poorly crafted prompts, etc. In the vast majority of cases, you should see improvements after finetuning with 50–100 examples.
- Data Acquisition and annotation

### Data Synthesis (~Augmentation)

- Data augmentation creates new data from existing data (which is real). For example, given a real image of a cat, you can flip it to create a new image of the same cat.8

- Data synthesis generates data to mimic the properties of real data. For example, you can simulate how a mouse moves through a web page to generate data for what bot movements would look like.

- Traditional vs AI 

### Model Distillation

- Model distillation (also called knowledge distillation) is a method in which a small model (student) is trained to mimic a larger model (teacher) (Hinton et al., 2015). The knowledge of the big model is distilled into the small model, hence the term distillation.

### Data Processing

- Inspect Data
- Deduplicate data
- Clean and Filter Data
- Format Data

## Chapter 9: Inference Optimization

- Up until now, the book has discussed various techniques for making models better. This chapter focuses on making them faster and cheaper.
- Inference optimization can be done at the model, hardware, and service levels. At the model level, you can reduce a trained model’s size or develop more efficient architectures, such as one without the computation bottlenecks in the attention mechanism often used in transformer models. At the hardware level, you can design more powerful hardware.

### Understanding IO

#### Overview

- In production, the component that runs model inference is called an inference server. It hosts the available models and has access to the necessary hardware. Based on requests from applications (e.g., user prompts), it allocates resources to execute the appropriate models and returns the responses to users. An inference server is part of a broader inference service, which is also responsible for receiving, routing, and possibly preprocessing requests before they reach the inference server.
  
#### Inference Performance metrics

- Latency, TTFT, TPOT
- Throughput and goodput
- Utilization, MFU, and MBU

#### AI Accelerators

- An accelerator is a chip designed to accelerate a specific type of computational workload. An AI accelerator is designed for AI workloads. The dominant type of AI accelerator is GPUs, and the biggest economic driver during the AI boom in the early 2020s is undoubtedly NVIDIA.
  
- GPU v CPU
- Computational capabilities
- Memory size & Bandwidth
- Power consumption

#### Inference Optimization

- Model Optimization
- Inference Service Optimization

## Chapter 10: AI Architecture and User Feedback

### AI Architecture

- Step 1: Enhance Context
- Step 2: Put Guardrails
- Step 3: Add Model Router Gateway
- Step 4: Reduce Latency with Caches
- Step 5: Add Agent Patterns
- Monitoring and Observability
- AI Pipeline Orchestration

### User Feedback

- Extracting conversational feedback
- Design
- Limitations



## Fun Facts

- The first AI program was written in 1951 by Christopher Strachey, who later became director of the Programming Research Group at the University of Oxford. It was a checkers (draughts) game that ran on the Ferranti Mark I computer at the University of Manchester. (Vibe Copilot suggestion)

- Fun fact: as of September 16, 2024, the website [_theresanaiforthat.com_](https://theresanaiforthat.com/) lists 16,814 AIs for 14,688 tasks and 4,803 jobs. (Chapter 1)
