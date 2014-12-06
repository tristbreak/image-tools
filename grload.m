%----------------------------------------------------------------
% Function grload()
%    -- Xenios Papademetris papad@noodle.med.yale.edu 5th Sep 1995
%
%    -- used to load images stored in the simple format (.grl) used for the 
%    -- EE445a course, this has an unsigned short magic number (29571) 
%    -- and the width and height of the image in 4-byte integers
%    -- followed by the actual data in unsigned char format
%----------------------------------------------------------------

function outimage=grload(filename)

%----------------------------------------------------------------
% Step 1 -- Check for right number of parameters
%        -- and check for valid filename
%----------------------------------------------------------------


if nargin ~= 1  
  error('Requires one input argument eg grload(filename)');
elseif nargin == 1 & isstr(filename)
  if (isempty(findstr(filename,'.'))==1)
        filename=[filename,'.grl'];
  end
end

%----------------------------------------------------------------
% Step 2 -- Open filename
%        -- Check for valid file
%----------------------------------------------------------------

handle=fopen(filename,'r');

if handle == -1
    ff=['grload::cannot open file ' , filename];
    error (ff);
end

magic=fread(handle,1,'ushort');

if magic~=29571
    ff=['grload::file ' , filename,' is not a grl file'];
    error (ff);
end

%----------------------------------------------------------------
% Step 3 -- Read width and height   
%----------------------------------------------------------------

width=fread(handle,1,'int32');
height=fread(handle,1,'int32');

%----------------------------------------------------------------
% Step 4 -- Read actual Image
%----------------------------------------------------------------

outimage=fread(handle,[height,width],'uchar');
outimage=outimage'/max(max(outimage));

%----------------------------------------------------------------
% Step 5 -- Close file
%----------------------------------------------------------------

fclose(handle);

%----------------------------------------------------------------
