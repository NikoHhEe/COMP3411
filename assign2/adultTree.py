# -*- coding: utf-8 -*-
"""
Created on Sun Apr 12 15:27:06 2020

@author: think
"""

print(__doc__)

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import pointbiserialr, spearmanr
from sklearn.feature_selection import SelectKBest
from sklearn.model_selection import cross_val_score
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.ensemble import RandomForestClassifier

# Parameters
# n_classes = 2
# plot_colors = "rb"
# plot_step = 0.02

# create and load data structure
# data

# target

# feature_names
# feature_names = ['age', 'workclass', 'fnlwgt', 'education', 'education-num', 'marital-status', 'occupation', 'realtionship', 'race', 'sex', 'capital-gain', 'capital-loss', 'hours-per-week', 'native-country']
# target_names
# target_names = ['<= 50k', '>50k']

# load data
data = pd.read_csv("Dataset/adult.csv")
n_records = data.shape[0]
n_greater_50k = data[data['income'] == '>50K'].shape[0]
n_at_most_50k = data[data['income'] == '<=50K'].shape[0]
greater_percent = (n_greater_50k / n_records) * 100

# data preprocessing
col_names = data.columns
for c in col_names:
    num_non = data[c].isin(["?"]).sum()
    if num_non > 0:
        print (c)
        print (num_non)
        print ("{0:.2f}%".format(float(num_non) / n_records * 100))
# eliminate incomplete data
data = data[data["workclass"] != "?"]
data = data[data["occupation"] != "?"]
data = data[data["native-country"] != "?"]
        
# normalization
# from sklearn.preprocessing import MinMaxScaler
# scaler = MinMaxScaler()
# numerical = ['age', 'education-num', 'gain', 'loss', 'hours']
# features_log_minmax_transform = pd.DataFrame(data = features_log_transformed)
# features_log_minmax_transform[numerical] = scaler.fit_transform(features_log_minmax_transform[numerical])
# display(features_log_minmax_transform.head(n = 5))

# preprocess categorical feature
features_final = pd.get_dummies(data)
income = income.map({'<=50K': 0, '>50K': 1})
encoded = list(features_final.columns)
print("{} total features after one-hot encoding.".format(len(encoded)))
encoded