# -*- coding: utf-8 -*-
"""
Created on Tue Apr 14 10:06:45 2020

@author: think
"""

import pandas as pd
import numpy as np
from sklearn import tree
import graphviz
from sklearn.model_selection import cross_val_score
from sklearn.tree import DecisionTreeClassifier, plot_tree
import matplotlib.pyplot as plt
import pydotplus

# Load dataset 
data = pd.read_csv('DataSet/adult.csv', sep=',')
test = pd.read_csv('DataSet/test.csv', sep=',')

test = test[:(len(test)-1)] 

# Remove invalid data from table
data = data[(data.astype(str) != '?').all(axis=1)]
test = test[(test.astype(str) != '?').all(axis=1)]

# Create a new income_bi column
data['income_bi'] = data.apply(lambda row: 1 if '>50K'in row['income'] else 0, axis=1)
test['income_bi'] = test.apply(lambda row: 1 if '>50K.'in row['income'] else 0, axis=1)
# Remove redundant columns
data = data.drop(['income','fnlwgt','capital-gain','capital-loss','native-country'], axis=1)
test = test.drop(['income','fnlwgt','capital-gain','capital-loss','native-country'], axis=1)

# Use one-hot encoding on categorial columns
data = pd.get_dummies(data, columns=['workclass', 'education', 'marital-status', 'occupation', 'relationship', 'race', 'sex'])
test = pd.get_dummies(test, columns=['workclass', 'education', 'marital-status', 'occupation', 'relationship', 'race', 'sex'])

d_train_att = data.drop(['income_bi'], axis=1)
d_train_gt50 = data['income_bi']

d_test_att = test.drop(['income_bi'], axis=1)
d_test_gt50 = test['income_bi']

# Fit and plot a decision tree
plt.figure(figsize=(200,200))
t = tree.DecisionTreeClassifier(criterion='entropy', max_depth=7)
t = t.fit(d_train_att, d_train_gt50)
#plot_tree(t, filled=True)
plt.savefig("tree.png")

accuracy = t.score(d_test_att, d_test_gt50)

