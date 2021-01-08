# MIT face recognition project dataset
The “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) dataset was used for classifying face images using different machine learning algorithms.

# Data statistics
On the MIT class web page addition to the 3584 face images, there are also two two ascii data files ("faceDR", "faceDS") extracted from the Eigenface database. These files contain face images' labels including *"photoID","Sex","Age","Race","Face","Properties"*. All these lables are categorical variables and each one of them can be evaluated as follows:

* Photo ID: Face image number.
* Sex: Female/ Male.
* Age: Child/ Teen/ Adult/ Seniour.
* Race: White/ Black/ Asian/ Hispanic/ Other.
* Face: Smiling/ Serious/ Funny.
* properties: Glasses/ Hat bandana/ Hat/ Mustache/ Mustache beard, etc.

However, after careful scrutiny on "faceDR", "faceDS", the files looked to contain bias information. shown in the following figures, faceDR contains image 1 to 3222, and faceDS contains 3223 to 3995. Therefore, faceDR has all face images labeled by "child", and most of while there is no "child" in the faceDS which is supposed to be the test set. Thus, relying on the existent train and test set on the MIT web page might not lead to accurate face recognition results. The train and the test sets are sampled randomly.

![DataTable](https://user-images.githubusercontent.com/43753085/103963531-27e3ab00-511f-11eb-980b-6ada71e482fe.png)

## Preprocessing dataset
There are some face images in the dataset, shown in figure 2, that not only do not improve the classification performance but also they profoundly reduce model's accuracy. About 400 of face images are removed from the generic dataset due to at least one of the following reasons:

*Face aside images:* face images that are not looking toward the camera. Since in some cases half of the face is turned, capturing the facial features via any of machine learning techniques is not straitforward (possible).

*Infant/baby images:* there are about three to five infant images in the data set. They are not abundant to be considered as a label for classification; thus, these kind of images are removed.

*Images with lighting issue:* there are two sort of issues with images lighting that needs to be addressed. First, due to an extreme darkness in some cases, no face can be seen in the image. Second, some images labeled as "Race: white" have very dark images that may increase the classification error. Same issue with the images labeled as "Race: black" with very bright images.

* Blank images:* there are more than fifteen blanck images needing to be removed from the datasets.
* Two subjects:* some images contain more than two faces.
* Missing descriptor:* some images do not have any label.

![Removedimgs](https://user-images.githubusercontent.com/43753085/103963959-f8816e00-511f-11eb-925d-72fff4967ef8.png)

# FaceClassification_ML

Based on the data Stat, shown in figure 1, number of observations for some response variables (labels) are not enogh for classification task. For example, in the "Face" label, there are not enough number of funny faces, or in the "Race" label there are not enough number of Black, asian and hispanic face images. Besides, some labels have unbalanced number of observations. For instance, in "Sex" label number of senior females are twice as many as the number of males. Overall, the response variable (lable) is female/male among adults' face images. Train and test set contain 2214 and 954 number of images respectively.

The feature engineering for face classification is important. Different features are used such as gray scale image intensity, Euclidean distances, and etc. However,  best classification results are obtained using the projection of images into the eigenspace. Dot product of each image , projection of each image into the eigenspace, gives a measure of similarity between that image and different eigenfaces. Covariance matrix has 16384 singular values, but the rate of change of singular values is monotonic at some point. Face classification results are obtained based on 10, 30, 70, 140, 310, 700 number of projections (features). 

Five different classifiers are used for binary classification as follows:

* Linear regression: as a base model.
* Logistic regression: returns probability of genders.
* LASSO: feature selection method.
* Decision tree (classification tree): binary classification.
* Gradient boosting method: powerful techniques for building predictive models.

![missclassplotTable](https://user-images.githubusercontent.com/43753085/103964447-1ac7bb80-5121-11eb-9d99-a1d7e9fa8a0c.png)

