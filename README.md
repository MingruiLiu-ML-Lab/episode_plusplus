# Federated Learning with Client Subsampling, Data Heterogeneity, and Unbounded Smoothness: A New Algorithm and Lower Bounds

### Abstract
We study the problem of Federated Learning (FL) under client subsampling and data heterogeneity with an objective function that has potentially unbounded smoothness. This problem is motivated by empirical evidence that the class of relaxed smooth functions, where the Lipschitz constant of the gradient scales linearly with the gradient norm, closely resembles the loss functions of certain neural networks such as recurrent neural networks (RNNs) with possibly exploding gradient. We introduce EPISODE++, the first algorithm to solve this problem. It maintains historical statistics for each client to construct control variates and decide clipping behavior for sampled clients in the current round. We prove that EPISODE++ achieves linear speedup in the number of participating clients, reduced communication rounds, and resilience to data heterogeneity. Our upper bound proof relies on novel techniques of recursively bounding the client updates under unbounded smoothness and client subsampling, together with a refined high probability analysis. In addition, we prove a lower bound showing that the convergence rate of a special case of clipped minibatch SGD (without randomness in the stochastic gradient and with randomness in client subsampling) suffers from an explicit dependence on the maximum gradient norm of the objective in a sublevel set, which may be arbitrarily large. This effectively demonstrates that applying gradient clipping to minibatch SGD in our setting does not eliminate the problem of exploding gradients.  Our lower bound is based on new constructions of hard instances tailored to client subsampling and a novel analysis of the trajectory of the algorithm in the presence of clipping. Lastly, we provide an experimental evaluation of EPISODE++ when training RNNs on federated text classification tasks, demonstrating that EPISODE++ outperforms strong baselines in FL.

### Instructions
We include code for all experiments in the paper: SNLI and Sentiment140. The experiments may be run with the scripts ``scripts/effect_of_S.sh`` and ``scripts/effect_of_H.sh``. Both of these scripts are meant to be run on a single node with eight GPUs each. If you want to run the code across multiple nodes (e.g. two nodes with four GPUs each), you'll have to edit these scripts to call run.sh with the appropriate values for the arguments ``TOTAL_NODES``, ``NODE``, and ``GPUS_PER_NODE``. You can plot the results using the various python scripts in ``scripts/``.

You'll need to download and process the datasets yourself to run the experiments. For SNLI, follow the instructions from the [SNLI Corpus](https://nlp.stanford.edu/projects/snli/) and place the resulting dataset at ``data/snli``. For Sentiment140, follow the instructions from the [LEAF benchmark](https://github.com/TalwalkarLab/leaf) and place the resulting dataset at ``data/sent140``.

All of the experiments are in Python with PyTorch and only require common packages like numpy.

### Citation
If you found this repository helpful, please cite our paper:
```
@inproceedings{crawshaw2023episodeplus,
  title={Federated Learning with Client Subsampling, Data Heterogeneity, and Unbounded Smoothness: A New Algorithm and Lower Bounds},
  author={Crawshaw, Michael and Bao, Yajie and Liu, Mingrui},
  booktitle={Advances in Neural Information Processing Systems},
  year={2023}
}
```
