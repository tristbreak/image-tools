%----------------------------------------------------------------
% Function grsave()
%    -- Xenios Papademetris papad@noodle.med.yale.edu 5th Sep 1995
%
%    -- used to save images stored in the simple format (.grl) used for the 
%    -- EE445a course, this has an unsigned short magic number (29571) 
%    -- and the width and height of the image in 4-byte integers
%    -- followed by the actual data in unsigned char format
%    -- if numbers outside 0..255 it will scale to fit range
%----------------------------------------------------------------

function grsave(outimage,filename)

%----------------------------------------------------------------
% Step 1 -- Check for right number of parameters
%        -- and check for valid filename
%----------------------------------------------------------------

if nargin ~= 2
  error('Requires two input arguments grsave(img,filename)');
elseif nargin == 2 & isstr(filename)
  if (isempty(findstr(filename,'.'))==1)
        filename=[filename,'.grl'];
  end
end

handle=fopen(filename,'w');

if handle == -1 
    ff=['grsave::cannot open file ' , filename];
    error (ff); 
end

%----------------------------------------------------------------
% Step 2 -- Save Header first 
%        -- header = [ Magic Number , width , height ]
%----------------------------------------------------------------

magic=29571;
fwrite(handle,magic,'ushort');
[width height]=size(outimage);
fwrite(handle,width,'int32');
fwrite(handle,height,'int32');

%----------------------------------------------------------------
% Step 3 -- Scale image if needed to fit 8-bit range
%        -- 0..255
%----------------------------------------------------------------

temp=outimage';
if min(min(temp))<0 
    temp=temp-min(min(img));
  end

temp=temp*255/(max(max(temp)));


%----------------------------------------------------------------
% Step 4 -- Save image itself in unsigned char format
%        -- and close file
%----------------------------------------------------------------

fwrite(handle,temp,'uchar');
fclose(handle);

%----------------------------------------------------------------
