clear; clc;

% load test.grl matrix
img = grload('test.grl');

% find the image's size
size(img)

% display the image in a separate window
grdisp(img)

% save the image in a file called 'saved.grl'
grsave(img, 'saved.img');
