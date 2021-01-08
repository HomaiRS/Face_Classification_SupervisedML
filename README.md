# MIT face recognition project dataset
In this project, the dataset from “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) was used for classifying face images using different machine learning algorithms including. The dataset contains face images from different age, race and sex groups makes the classification task more challenging. Also, cumulatively, there are about 400 infant, face aside, too dark, too bright, and blank images in the dataset. Therefore, these images should either be preprocessed or excluded before the classification analysis. 

# Face classification: an evaluation of supervised learning methods

The goal of this repository is to provide a benchmarking pipeline for classification on face images using multiple state-of-the-art machine learning methods.

## Implemented Algorithms

| Name               | Paper               | 
|--------------------|---------------------|
| Decision tree | [DECISION TREE LEARNING BASED FEATURE EVALUATION AND SELECTION FOR IMAGE CLASSIFICATION](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=8108975&casa_token=iWkSURiW--EAAAAA:mzz_bGwJ7xSn91H8AMJFyw0lsXox-3WplnuUhYDUoayPnaAv8yIsnOw2IPWoVqBMZnYb_N8rXyA), International Conference on Machine Learning and Cybernetics (ICMLC) 2017 |
|LASSO | [Support Vector Feature Extraction Based Lasso For Gender Recognition From Object Classification](https://www.researchgate.net/deref/http%3A%2F%2Fdx.doi.org%2F10.21203%2Frs.3.rs-17037%2Fv1?_sg%5B0%5D=P7Gg9IQ_lj09Y7p9-OLEkzmSlhB3QQVXXF8_YtruKj4V9vaDYApHcNf7Upk_unkjxIfWhzEm0cx0Hkx8KSpg61iNoQ.9am_7aUYSiKjB1N0YHWaNlfEm3B0moRfOAb3gCPb6CRQ2xiLsWSW1K9fLOH98krILfG6vNIy-7V8lGBeiRcDAw) |
|Logistic regression | [Face recognition based on PCA and logistic regression analysis](https://www.sciencedirect.com/science/article/pii/S0030402614008511?casa_token=UrmuyUqEutcAAAAA:NWhr2ZjNThxpvfBTC_pJ2W7dvDyim75WPVguRb7Rid9DGLUgRGIspxTAlxe3kD-PvcsbRm73OHk), Optik 2014 |
| Linear regression | [Linear regression for face recognition.](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=5506092&casa_token=i_KLyjrTRAwAAAAA:0bTJTjbmtcxwr10SuKtvHChK_i896txaak1ON0HMIwlDmnqtRPWPdRNhpbvFBBP1K44pv8icfMo&tag=1), IEEE transactions on pattern analysis and machine intelligence 2010 |



Based on the data Stat, shown in figure 1, number of observations for some response variables (labels) are not enogh for classification task. For example, in the "Face" label, there are not enough number of funny faces, or in the "Race" label there are not enough number of Black, asian and hispanic face images. Besides, some labels have unbalanced number of observations. For instance, in "Sex" label number of senior females are twice as many as the number of males. Overall, the response variable (lable) is female/male among adults' face images. Train and test set contain 2214 and 954 number of images respectively.

The feature engineering for face classification is important. Different features are used such as gray scale image intensity, Euclidean distances, and etc. However,  best classification results are obtained using the projection of images into the eigenspace. Dot product of each image , projection of each image into the eigenspace, gives a measure of similarity between that image and different eigenfaces. Covariance matrix has 16384 singular values, but the rate of change of singular values is monotonic at some point. Face classification results are obtained based on 10, 30, 70, 140, 310, 700 number of projections (features). 

Five different classifiers are used for binary classification as follows:

* Linear regression: as a base model.
* Logistic regression: returns probability of genders.
* LASSO: feature selection method.
* Decision tree (classification tree): binary classification.
* Gradient boosting method: powerful techniques for building predictive models.
