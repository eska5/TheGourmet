from sqlalchemy import true
import tensorflow as tf
import wandb
from wandb.keras import WandbCallback
from pathlib import Path
import os
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

wandb.init(project="PhotoParamsTests", entity="gourmet")

print("Num GPUs Available: ", len(tf.config.list_physical_devices("GPU")))

tf.config.threading.set_inter_op_parallelism_threads(0)
tf.config.threading.set_intra_op_parallelism_threads(0)

train_dir = Path("D:\\naszeJedzenie\\convertedTrain")
train_filepaths = list(train_dir.glob(r"**/*.jpg"))

test_dir = Path("D:\\naszeJedzenie\\convertedTest")
test_filepaths = list(test_dir.glob(r"**/*.jpg"))

val_dir = Path("D:\\naszeJedzenie\\convertedValidation")
val_filepaths = list(val_dir.glob(r"**/*.jpg"))


def proc_img(filepath):
    # dla linuxa inny slash split
    labels = [str(filepath[i]).split("\\")[-2] for i in range(len(filepath))]

    filepath = pd.Series(filepath, name="Filepath").astype(str)
    labels = pd.Series(labels, name="Label")

    # Concatenate filepaths and labels
    df = pd.concat([filepath, labels], axis=1)

    # Shuffle the DataFrame and reset index
    # df = df.sample(frac=1).reset_index(drop=True)

    return df


train_df = proc_img(train_filepaths)
test_df = proc_img(test_filepaths)
val_df = proc_img(val_filepaths)

print("-- Training set --\n")
print(f"Number of pictures: {train_df.shape[0]}\n")
print(f"Number of different labels: {len(train_df.Label.unique())}\n")

print("-- Test set --\n")
print(f"Number of pictures: {test_df.shape[0]}\n")
print(f"Number of different labels: {len(test_df.Label.unique())}\n")

print("-- Validation set --\n")
print(f"Number of pictures: {val_df.shape[0]}\n")
print(f"Number of different labels: {len(val_df.Label.unique())}\n")
print(f"Labels: {val_df.Label.unique()}")

# Create a DataFrame with one Label of each category
df_unique = train_df.copy().drop_duplicates(subset=["Label"]).reset_index()

train_generator = tf.keras.preprocessing.image.ImageDataGenerator(
    preprocessing_function=tf.keras.applications.mobilenet_v3.preprocess_input
)

test_generator = tf.keras.preprocessing.image.ImageDataGenerator(
    preprocessing_function=tf.keras.applications.mobilenet_v3.preprocess_input
)

train_images = train_generator.flow_from_dataframe(
    dataframe=train_df,
    x_col="Filepath",
    y_col="Label",
    target_size=(400, 400),
    color_mode="rgb",
    class_mode="categorical",
    batch_size=16,
    shuffle=True,
    seed=0,
    rotation_range=45,
    zoom_range=0.3,
    width_shift_range=0.2,
    height_shift_range=0.2,
    shear_range=0.25,
    fill_mode="nearest",
)

val_images = train_generator.flow_from_dataframe(
    dataframe=val_df,
    x_col="Filepath",
    y_col="Label",
    target_size=(400, 400),
    color_mode="rgb",
    class_mode="categorical",
    batch_size=16,
    shuffle=True,
    seed=0,
    rotation_range=45,
    zoom_range=0.3,
    width_shift_range=0.2,
    height_shift_range=0.2,
    shear_range=0.25,
    fill_mode="nearest",
)

test_images = test_generator.flow_from_dataframe(
    dataframe=test_df,
    x_col="Filepath",
    y_col="Label",
    target_size=(400, 400),
    color_mode="rgb",
    class_mode="categorical",
    batch_size=16,
    shuffle=False,
)

# Load the pretained model
pretrained_model = tf.keras.applications.MobileNetV3Large(
    input_shape=(400, 400, 3),
    include_top=False,
    weights="imagenet",
    input_tensor=None,
    pooling="avg",
    classes=10,
    classifier_activation="softmax",
)
pretrained_model.trainable = False

# Train

inputs = pretrained_model.input

x = tf.keras.layers.Dense(128, activation="relu")(pretrained_model.output)
x = tf.keras.layers.Dense(128, activation="relu")(x)
outputs = tf.keras.layers.Dense(10, activation="softmax")(x)

model = tf.keras.Model(inputs=inputs, outputs=outputs)

model.compile(optimizer="adam", loss="categorical_crossentropy", metrics=["accuracy"])

callback = tf.keras.callbacks.EarlyStopping(monitor="val_loss", patience=1)

history = model.fit(
    train_images,
    validation_data=val_images,
    batch_size=16,  # jak to wp??ywa na proces uczenia?
    epochs=30,
    callbacks=[WandbCallback(), callback],
)

model.save("D:\\model.h5")
