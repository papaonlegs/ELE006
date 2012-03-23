function [ boundedPicture ] = QMUL_partC12( vid, frame)
    %
    %QMUL_part8    Object bounding
    % Counts number of objects in frame and outlines them in bounds
    %
    % boundedPicture = QMUL_partB8(vidFrames, frame)
    %
    % INPUT
    % vidFrames - Frames of the video
    % frame - Frame to use
    %
    % OUTPUT
    % boundedPicture - The picture with objects bounded
    %
    % SOURCES NEEDED
    % QMUL_partA5.m , QMUL_thresholding.m and QMUL_FloodFill.m

  %if we want video
  docNode = com.mathworks.xml.XMLUtils.createDocument... 
    ('Frame');
    docRootNode = docNode.getDocumentElement;
    thisElement = docNode.createElement('Number')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%d',frame)));
    docRootNode.appendChild(thisElement);
  
  
  
  colourList(1,:) = [255 255 255]; %White
  colourList(2,:) = [0 0 0]; %Black
  colourList(3,:) = [255 0 0]; %Red
  colourList(4,:) = [0 255 0]; %Green
  colourList(5,:) = [0 0 255]; %Blue
  colourList(6,:) = [255 140 0]; %Orange
  colourList(7,:) = [160 32 240]; %Purple
  colourList(8,:) = [255 105 180]; %Pink
  colourList(9,:) = [255 255 0]; %Yellow
  colourList(10,:) = [0 255 255]; %Cyan
  colourList(11,:) = [139 69 19]; %Brown
  colourList(12,:) = [148 0 211]; %Dark Violet
  colourList(13,:) = [190 190 190]; %Gray
  
  follow = zeros(1,1); %To know index of object in next frame
  xdis = zeros(1); %movement along x
  ydis = zeros(1); %movement along y
  dis = zeros(1); %actual movement calculated using xdis and ydis
  xydif = zeros(1,2); %keep linked differences
  
  boundedPicture = vid(:,:,:,frame);
  
  vidFrame = vid(:,:,:,frame);
  nextFrame = vid(:,:,:,frame+1);
  background = QMUL_partA5(vid, 100, 'average');
  
  tic;
  
  [details centre avg] = QMUL_partC10i(vidFrame, background);
  [details2 centre2 avg] = QMUL_partC10i(nextFrame, background);
  
  for i=1:length(centre)
      fprintf(output,'\n\t<Object> %d', i);
      
      objElement = docNode.createElement('Object');
      docRootNode.appendChild(objElement);
      thisElement = docNode.createElement('Number')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%d',i)));
    objElement.appendChild(thisElement);
      
      follow(i,1) = i;
      
      for j=1:length(centre2)
          xdis(j) = centre(i,1) - centre2(j,2);
          ydis(j) = centre(i,2) - centre2(j,2);
          dis(j) = sqrt((xdis(j)^2) + (ydis(j)^2));
      end
      
      [minDis index] = min(dis);
      follow(i,2) = index; %follow object
      xydif(i,:) = [xdis(index) ydis(index)];
      
      thisElement = docNode.createElement('Displacement')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%.00f %.00f %.00f',xdis(index),ydis(index), minDis)));
    objElement.appendChild(thisElement);
      
      
      if xdis(index) < 0 && ydis(index) < 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('SW')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) < 0 && ydis(index) == 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('W')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) < 0 && ydis(index) > 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('NW')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) == 0 && ydis(index) > 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('N')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) > 0 && ydis(index) > 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('NE')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) > 0 && ydis(index) == 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('E')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) > 0 && ydis(index) < 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('SE')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) == 0 && ydis(index) < 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('S')));
    objElement.appendChild(thisElement);
      end
      if xdis(index) == 0 && ydis(index) == 0
          thisElement = docNode.createElement('Direction')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('N/A')));
    objElement.appendChild(thisElement);
      end
      
      color = colourList(i,:);
      
      thisElement = docNode.createElement('Box_colour')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%d %d %d',color(1),color(2),color(3))));
    objElement.appendChild(thisElement);
      
      area = details(i,3) * details(i,4);
      perimeter = 2* (details(i,3) * details(i,4));
      thicknessRatio = area/perimeter;
      
      fprintf(output,'\tArea : %d',area);
      fprintf(output,'\tPerimeter : %d',perimeter);
      fprintf(output,'\tThickness Ratio : %.00f', thicknessRatio);
      
      thisElement = docNode.createElement('Area')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%d',area)));
    objElement.appendChild(thisElement);
    
    thisElement = docNode.createElement('Perimeter')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%d',perimeter)));
    objElement.appendChild(thisElement);
    
    thisElement = docNode.createElement('Thickness_Ratio')
    thisElement.appendChild... 
        (docNode.createTextNode(sprintf('%.00f', thicknessRatio)));
    objElement.appendChild(thisElement);
      
  end
  
  xmlFileName = ['question12.xml'];
    xmlwrite(xmlFileName,docNode);
    type(xmlFileName);
  toc
end


