# Data
The “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) dataset was used for classifying face images using different machine learning algorithms.

# FaceClassification_ML

Based on the data Stat, shown in figure 1, number of observations for some response variables (labels) are not enogh for classification task. For example, in the "Face" label, there are not enough number of funny faces, or in the "Race" label there are not enough number of Black, asian and hispanic face images. Besides, some labels have unbalanced number of observations. For instance, in "Sex" label number of senior females are twice as many as the number of males. Overall, the response variable (lable) is female/male among adults' face images. Train and test set contain 2214 and 954 number of images respectively.

The feature engineering for face classification is important. Different features are used such as gray scale image intensity, Euclidean distances, and etc. However,  best classification results are obtained using the projection of images into the eigenspace. Dot product of each image , projection of each image into the eigenspace, gives a measure of similarity between that image and different eigenfaces. Covariance matrix has 16384 singular values, but the rate of change of singular values is monotonic at some point. Face classification results are obtained based on 10, 30, 70, 140, 310, 700 number of projections (features). 

Five different classifiers are used for binary classification as follows:

* Linear regression: as a base model.
* Logistic regression: returns probability of genders.
* LASSO: feature selection method.
* Decision tree (classification tree): binary classification.
* Gradient boosting method: powerful techniques for building predictive models.


