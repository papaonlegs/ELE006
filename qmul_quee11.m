%%
% qmul_qe7(videoname,a,threshold)
% videoname(TestSeq_1.avi)
% threshold is the threshold value
% a is the frame number

function qmul_quee11(videoname,a)
vidobj = VideoReader(videoname);
videoframes= read(vidobj);
Number_Of_Objects = zeros(1,140);

[m n c f] = size(videoframes);

%%
% to find the background of a video
% by making the percent 100 we will get the best background
x= 100/100 *f;

for i = 1:m
    for j=1:n
        for r =1:c
            reference (i,j,r)= mean(videoframes(i,j,r,1:x));
        end
    end
end

 ref = uint8(reference);
 
File = fopen('question11.txt','w');     

   %%
   % thresholding the image (diff) 
   
     diff = abs(double( videoframes(:,:,:,a))- double(ref));
     for i =1:352
         for j= 1:288
             if ((diff(j,i)>50))
                 result(j,i) = 255;
             else
                 result(j,i)= 0;
             end
         end
     end
    
     
     %%
     block_bw = colfilt(result,[8 8],'sliding',@mean);
     
     
     [L, N] = bwlabel(block_bw,4);
     rgb_label = label2rgb(L,@spring,'c','shuffle');
     figure,title(['colour label',imshow(rgb_label)]);
     stats = regionprops(L,'all');
     
     figure,imshow(uint8(videoframes(:,:,:,a)));
     hold on
     
     
     %%
 
 for k = 1:N
        bounding_box = stats(k).BoundingBox;
        rectangle('position',bounding_box,'EdgeColor','r','LineWidth',2);
      

        area = stats(k).Area;
        perimeter = stats(k).Perimeter;
        %compute thiness ratio
        th = 4*pi*(area/(perimeter^2));
        stats(k).ThinnessRatio = th;
        % compute the aspect ratio
        ar = (bounding_box(3)/bounding_box(4));
        stats(k).AspectRatio = ar;
        
     fprintf(File, 'Object Number:    %.0f\n', k);
     fprintf(File, ' area:            %0.00f\n',area);
     fprintf(File, ' perimeter:       %.00f\n',perimeter);
     fprintf(File, ' Thinness ratio:  %.0f\n',th);
     fprintf(File, ' Aspect ratio:    %.0f\n',ar);
 end
 hold off
     File = fclose('all');

     
     
     
    