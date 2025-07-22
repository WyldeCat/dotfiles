import torch

a = torch.randn(3).cuda()


for i in range(10):
    print(a)
