# MIT face recognition project dataset
In this project, the dataset from “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) was used for classifying face images using different machine learning algorithms including. The dataset contains face images from different age, race and sex groups makes the classification task more challenging. Also, cumulatively, there are about 400 infant, face aside, too dark, too bright, and blank images in the dataset. Therefore, these images should either be preprocessed or excluded before the classification analysis. 

# Face classification: an evaluation of supervised learning methods

The goal of this repository is to provide a benchmarking pipeline for classification on face images using multiple state-of-the-art machine learning methods.

## Implemented Algorithms

| Name               | Paper               | 
|--------------------|---------------------|
| Linear regression for image classification | [Linear regression for face recognition.](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=5506092&casa_token=i_KLyjrTRAwAAAAA:0bTJTjbmtcxwr10SuKtvHChK_i896txaak1ON0HMIwlDmnqtRPWPdRNhpbvFBBP1K44pv8icfMo&tag=1), IEEE transactions on pattern analysis and machine intelligence. 2010   |
|  |[LSTM-based encoder-decoder for multi-sensor anomaly detection](https://arxiv.org/pdf/1607.00148.pdf), ICML 2016|
| Autoencoder | [Outlier detection using replicator neural networks](https://link.springer.com/content/pdf/10.1007%2F3-540-46145-0_17.pdf), DaWaK 2002 |
| Donut| [Unsupervised Anomaly Detection via Variational Auto-Encoder for Seasonal KPIs in Web Applications](https://arxiv.org/pdf/1802.03903.pdf), WWW 2018 |
| REBM | [Deep structured energy based models for anomaly detection](http://proceedings.mlr.press/v48/zhai16.pdf), ICML 2016|
|DAGMM| [Deep autoencoding gaussian mixture model for unsupervised anomaly detection](https://openreview.net/pdf?id=BJJLHbb0-), ICLR 2018|
|LSTM-DAGMM | Extension of [DAGMM](https://openreview.net/pdf?id=BJJLHbb0-) using an [LSTM](https://www.bioinf.jku.at/publications/older/2604.pdf)-Autoencoder instead of a Neural Network Autoencoder|


Based on the data Stat, shown in figure 1, number of observations for some response variables (labels) are not enogh for classification task. For example, in the "Face" label, there are not enough number of funny faces, or in the "Race" label there are not enough number of Black, asian and hispanic face images. Besides, some labels have unbalanced number of observations. For instance, in "Sex" label number of senior females are twice as many as the number of males. Overall, the response variable (lable) is female/male among adults' face images. Train and test set contain 2214 and 954 number of images respectively.

The feature engineering for face classification is important. Different features are used such as gray scale image intensity, Euclidean distances, and etc. However,  best classification results are obtained using the projection of images into the eigenspace. Dot product of each image , projection of each image into the eigenspace, gives a measure of similarity between that image and different eigenfaces. Covariance matrix has 16384 singular values, but the rate of change of singular values is monotonic at some point. Face classification results are obtained based on 10, 30, 70, 140, 310, 700 number of projections (features). 

Five different classifiers are used for binary classification as follows:

* Linear regression: as a base model.
* Logistic regression: returns probability of genders.
* LASSO: feature selection method.
* Decision tree (classification tree): binary classification.
* Gradient boosting method: powerful techniques for building predictive models.
