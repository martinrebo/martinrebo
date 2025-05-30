# AI Engineering by Chuan Huen

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
- -  A masked language model is trained to predict missing tokens anywhere in a sequence, using the context from both before and after the missing tokens. 
are commonly used for non-generative tasks such as sentiment analysis and text classification. They are also useful for tasks requiring an understanding of the overall context, such as code debugging
- - An autoregressive language model is trained to predict the next token in a sequence, using only the preceding tokens.

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


# Fun Facts


- The first AI program was written in 1951 by Christopher Strachey, who later became director of the Programming Research Group at the University of Oxford. It was a checkers (draughts) game that ran on the Ferranti Mark I computer at the University of Manchester. (Vibe Copilot suggestion)

- Fun fact: as of September 16, 2024, the website [_theresanaiforthat.com_](https://theresanaiforthat.com/) lists 16,814 AIs for 14,688 tasks and 4,803 jobs. (Chapter 1)
