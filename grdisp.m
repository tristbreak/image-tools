%----------------------------------------------------------------
% Function grdisp()
%    -- Xenios Papademetris papad@noodle.med.yale.edu 5th Sep 1995
%
%    -- used to display images stored as matrices
%    -- scales graylevls to 1..64 range for display within matlab
%----------------------------------------------------------------

function grdisp(img)

%----------------------------------------------------------------
% Step 1 -- Check for right number of parameters
%----------------------------------------------------------------

if nargin ~= 1  
  error('Requires one input argument e.g. grdisp(img)');
end

%----------------------------------------------------------------
% Step 2 - Scale image to make it in displayable range
%----------------------------------------------------------------

temp=img;
temp=temp-min(min(img));
temp=temp*64/(max(max(temp)));

%----------------------------------------------------------------
% Step 3 - Display Image and set colormap to grayscale
%----------------------------------------------------------------

image(temp);
colormap(gray);

%----------------------------------------------------------------
