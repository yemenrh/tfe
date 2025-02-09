import torch
import torch.nn as nn
import torch.nn.functional as F

# define a class network 
class Net(nn.Module):

    def __init__(self):
        super(Net, self).__init__()
        # 1 input image channel, 6 output channels, 5x5 square convolution
        # kernel
        self.conv1 = nn.Conv2d(1, 6, 5)
        self.conv2 = nn.Conv2d(6, 16, 5)
        # an affine operation: y = Wx + b
        self.fc1 = nn.Linear(16 * 5 * 5, 120)  # 5*5 from image dimension
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        # Max pooling over a (2, 2) window
        x = F.max_pool2d(F.relu(self.conv1(x)), (2, 2))
        # If the size is a square, you can specify with a single number
        x = F.max_pool2d(F.relu(self.conv2(x)), 2)
        x = torch.flatten(x, 1) # flatten all dimensions except the batch dimension
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x

net = Net()
# lets try to make an input
input = torch.randn(1,1,32,32)
out = net(input)
print(out)

# backward prop 
net.zero_grad()
out.backward(torch.randn(1,10))

# Loss function 

output = net(input)
target = torch.randn(10)
print(target)
target = target.view(1, -1)
print(target)
criterion = nn.MSELoss()


loss = criterion(output, target)
print(loss)






