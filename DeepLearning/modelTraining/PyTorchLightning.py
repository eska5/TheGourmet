import enum
from gc import callbacks
from json import decoder, encoder
from sched import scheduler
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
from efficientnet_pytorch import EfficientNet
from torch_lr_finder import LRFinder
from tqdm import tqdm
from torch.utils.tensorboard import SummaryWriter

import gc
gc.collect()
# class LitAutoEncoder(pl.LightningModule):
#     def __init__(self):
#         super().__init__()
#         self.encoder = nn.Sequential(
#             nn.Linear(400 * 400 * 3, 128),
#             nn.ReLU(),
#             nn.Linear(128, 128),
#             nn.ReLU(),
#             nn.Softmax(128, 25))
#         self.decoder = nn.Sequential(
#             nn.Softmax(25, 128),
#             nn.ReLU(),
#             nn.Linear(128, 128),
#             nn.ReLU(),
#             nn.Linear(128, 400*400*3))

#         def forward(self, x):
#             embedding = self.encoder(x)
#             return embedding

#         def configure_optimizer(self):
#             optimizer = torch.optim.Adam(self.parameters lr=1e-3)
#             return optimizer

#         def training_step(self, train_batch, batch_idx):
#             x, y = train_batch
#             x = x.view(x.size(0), -1)
#             z = self.encoder(x)
#             x_hat = self.decoder(z)
#             loss = F.mse_loss(x_hat, x)
#             self.log('train_loss', loss, on_epoch=True)
#             return loss

#         def validation_step(self, val_batch, batch_idx):
#             x, y = val_batch
#             x = x.view(x.size(0), -1)
#             z = self.encoder(x)
#             x_hat = self.decoder(z)
#             loss = F.mse_loss(x_hat, y)
#             self.log('val_loss', loss)

#         def backward(self, trainer, loss, optimizer, optimizer_idx):
#             loss.backwards()

#         def optimizer_step(self, epoch, batch_idx, optimizer, optimizer_idx):
#             optimizer.step()


if __name__ == '__main__':
    torch.cuda.empty_cache()
    warnings.filterwarnings('ignore')
    print(torch.cuda.memory_allocated())


    if torch.cuda.is_available():
        device = torch.device("cuda")
    else:
        device = torch.device("cpu")

    print(f'Using {device} for inference')

    # model_type = "GPUNet-D2"  # select one from above
    # select either fp32 of fp16 (for better performance on GPU)
    # precision = "fp16"

    # gpunet = torch.hub.load('NVIDIA/DeepLearningExamples:torchhub', 'nvidia_gpunet',
    #                         pretrained=True, model_type=model_type, model_math=precision)
    # utils = torch.hub.load('NVIDIA/DeepLearningExamples:torchhub',
    #                        'nvidia_convnets_processing_utils')

    # gpunet.to(device)
    # gpunet.eval()

    # Load and prepare the data
    basicPathToData = "C:\\Users\\kubas\\OneDrive\\Desktop\\GourmetData\\"

    transform = transforms.Compose(
        [transforms.RandomRotation(30), transforms.RandomHorizontalFlip(), transforms.RandomAffine(15), transforms.Resize(224) , transforms.ToTensor()])

    datasetTrain = datasets.ImageFolder(
        basicPathToData + "convertedTrain", transform=transform)

    datasetTest = datasets.ImageFolder(
        basicPathToData + "convertedTest", transform=transform)

    datasetValidation = datasets.ImageFolder(
        basicPathToData + "convertedValidation", transform=transform)

    traindataloader = torch.utils.data.DataLoader(
        datasetTrain, batch_size=32, shuffle=True, num_workers=1, pin_memory=True)

    validationdataloader = torch.utils.data.DataLoader(
        datasetValidation, batch_size=32, shuffle=True, num_workers=1, pin_memory=True)
    print(torch.cuda.memory_allocated())


    model = EfficientNet.from_pretrained('efficientnet-b3')

    model._dropout = torch.nn.Dropout(0.5)
    model._fc = torch.nn.Linear(2048, 101)

    criterion = torch.nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.00001)
    lr_finder = LRFinder(model, optimizer, criterion, device=device)
    lr_finder.range_test(traindataloader, end_lr=0.001, num_iter=25)
    lr_finder.plot()
    lr_finder.reset()

    cuda = True
    epochs = 25
    model_name = 'effnetB3.pt'
    optimizer = torch.optim.Adam(
        model.parameters(), lr=4e-4, weight_decay=0.001)
    criterion = torch.nn.CrossEntropyLoss()
    scheduler = torch.optim.lr_scheduler.ReduceLROnPlateau(optimizer,
                                                           'min', factor=0.1, patience=2, verbose=True)

    writer = SummaryWriter()  # for TENSORBOARD
    early_stop_count = 0
    ES_patience = 5
    best = 0.0

    if cuda:
        model.cuda()



    for epoch in range(epochs):

        # Training
        model.train()
        correct = 0
        train_loss = 0.0
        tbar = tqdm(traindataloader, dest='Training', position=0, leave=True)
        for i, (inp, lbl) in enumerate(tbar):
            optimizer.zero_grad()
            if cuda:
                inp, lbl = inp.cuda(), lbl.cuda()
            out = model(inp)
            loss = criterion(out, lbl)
            train_loss += loss
            out = out.argmax(dim=1)
            correct += (out == lbl).sum.item()
            loss.backward()
            optimizer.step()
            tbar.set_description(
                f"Epoch: {epoch+1}, loss: {loss.item():.5f}, acc: {100.0*correct/((i+1)*traindataloader.batch_size):.4f}%")
            train_acc = 100.0*correct/len(traindataloader.dataset)
            train_loss /= (len(traindataloader.dataset) /
                           traindataloader.batch_size)

        # Validation
        model.eval()
        with torch.no_grad():
            correct = 0
            val_loss = 0.0
            vbar = tqdm(validationdataloader,
                        desc="Validation", position=0, leave=True)
            for i, (inp, lbl) in enumerate(vbar):
                if cuda:
                    inp, lbl = inp.cuda(), lbl.cuda()
                out = model(inp)
                val_loss += criterion(out, lbl)
                out = out.argmax(dim=1)
                correct += (out == lbl).sum().item()
            val_acc = 100.0 * correct/len(validationdataloader.dataset)
            val_loss /= (len(validationdataloader.dataset) /
                         validationdataloader.batch_size)

        print(f'\nEpoch: {epoch+1}/{epochs}')
        print(f'Train loss: {train_loss}, Train Accuracy: {train_acc}')
        print(f'Validation loss: {val_loss}, Validation Accuracy: {val_acc}\n')

        scheduler.step(val_loss)

        # write to tensorboard
        writer.add_scalar("Loss/train", train_loss, epoch)
        writer.add_scalar("Loss/val", val_loss, epoch)
        writer.add_scalar("Accuracy/train", train_acc, epoch)
        writer.add_scalar("Accuracy/val", val_acc, epoch)

        if val_acc > best:
            best = val_acc
            torch.save(model, model_name)
            early_stop_count = 0
            print('Accuracy Improved, model saved.\n')
        else:
            early_stop_count += 1

        if early_stop_count == ES_patience:
            print('Early Stopping Initiated...')
            print(
                f'Best Accuracy achieved: {best:.2f}% at epoch:{epoch+1-ES_patience}')
            print(f'Model saved as {model_name}')
        break

    writer.flush()
# Initiate logger (wandb)

    # TO DO

    # model = LitAutoEncoder()

    # trainer = pl.Trainer()
    # # Can add number of gpus as param
    # trainer.fit(model, datasetTrain, datasetValidation)
