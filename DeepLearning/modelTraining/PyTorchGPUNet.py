from gc import callbacks
from json import decoder, encoder
from idna import valid_label_length
import torch
from PIL import Image
from torchvision import datasets, transforms
# from torch.utils.data import Dataset
import torch.utils.data
import numpy as np
import json
import requests
import matplotlib.pyplot as plt
import warnings
from pathlib import Path
import torch
from torch import embedding, nn, relu
from torch.nn import functional as F
from torch.utils.data import DataLoader
from torch.utils.data import random_split
from torchvision.datasets import MNIST
from torchvision import transforms
import pytorch_lightning as pl
from pytorch_lightning.loggers import WandbLogger
from pytorch_lightning import Trainer


class LitAutoEncoder(pl.LightningModule):
    def __init__(self):
        super().__init__()
        self.encoder = nn.Sequential(
            nn.Linear(400 * 400 * 3, 128),
            nn.ReLU(),
            nn.Linear(128, 128),
            nn.ReLU(),
            nn.Softmax(128, 25))
        self.decoder = nn.Sequential(
            nn.Softmax(25, 128),
            nn.ReLU(),
            nn.Linear(128, 128),
            nn.ReLU(),
            nn.Linear(128, 400*400*3))

        def forward(self, x):
            embedding = self.encoder(x)
            return embedding

        def configure_optimizer(self):
            optimizer = torch.optim.Adam(self.parameters lr=1e-3)
            return optimizer

        def training_step(self, train_batch, batch_idx):
            x, y = train_batch
            x = x.view(x.size(0), -1)
            z = self.encoder(x)
            x_hat = self.decoder(z)
            loss = F.mse_loss(x_hat, x)
            self.log('train_loss', loss, on_epoch=True)
            return loss

        def validation_step(self, val_batch, batch_idx):
            x, y = val_batch
            x = x.view(x.size(0), -1)
            z = self.encoder(x)
            x_hat = self.decoder(z)
            loss = F.mse_loss(x_hat, y)
            self.log('val_loss', loss)

        def backward(self, trainer, loss, optimizer, optimizer_idx):
            loss.backwards()

        def optimizer_step(self, epoch, batch_idx, optimizer, optimizer_idx):
            optimizer.step()


if __name__ == '__main__':

    warnings.filterwarnings('ignore')

    if torch.cuda.is_available():
        device = torch.device("cuda")
    else:
        device = torch.device("cpu")

    print(f'Using {device} for inference')

    model_type = "GPUNet-D2"  # select one from above
    # select either fp32 of fp16 (for better performance on GPU)
    precision = "fp16"

    # gpunet = torch.hub.load('NVIDIA/DeepLearningExamples:torchhub', 'nvidia_gpunet',
    #                         pretrained=True, model_type=model_type, model_math=precision)
    # utils = torch.hub.load('NVIDIA/DeepLearningExamples:torchhub',
    #                        'nvidia_convnets_processing_utils')

    # gpunet.to(device)
    # gpunet.eval()

    # Load and prepare the data
    basicPathToData = "/Users/jakubsachajko/Desktop/GourmetDataset/"

    transform = transforms.Compose(
        [transforms.RandomRotation(30), transforms.ToTensor()])

    datasetTrain = datasets.ImageFolder(
        basicPathToData + "convertedTrain", transform=transform)

    datasetTest = datasets.ImageFolder(
        basicPathToData + "convertedTest", transform=transform)

    datasetValidation = datasets.ImageFolder(
        basicPathToData + "convertedValidation", transform=transform)

    dataloader = torch.utils.data.DataLoader(
        datasetTrain, batch_size=32, shuffle=True, num_workers=16)

    # Initiate logger (wandb)
    # TO DO

    model = LitAutoEncoder()

    trainer = pl.Trainer()
    # Can add number of gpus as param
    trainer.fit(model, datasetTrain, datasetValidation)
