%%
% qmul_qe7(videoname,a,threshold)
% videoname(TestSeq_1.avi)
% threshold is the threshold value
% a is the frame number

function qmul_quee10(videoname,threshold,a,b)
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
 
    

   %%
   % thresholding the image (diff) 
   
     diff = abs(double( videoframes(:,:,:,a))- double(ref));
     for i =1:352
         for j= 1:288
             if ((diff(j,i)>threshold))
                 result(j,i) = 255;
             else
                 result(j,i)= 0;
             end
         end
     end
     %%
     block_bw = colfilt(result,[8 8],'sliding',@mean);
     [L, numObjects] = bwlabel(block_bw,4);
     rgb_label = label2rgb(L,@spring,'c','shuffle');
     figure,title(['colour label',imshow(rgb_label)]);
     stats = regionprops(L,'basic');
     %%
  
 for Label = 1:length(stats)
         x_1(Label) =   stats(Label).Centroid(1);
         y_1(Label) =   stats(Label).Centroid(2);
 end
     %%
     %%
     
     diff1 = abs(double( videoframes(:,:,:,b))- double(ref));
     for i =1:352
         for j= 1:288
             if ((diff1(j,i)>threshold))
                 resultt(j,i) = 255;
             else
                 resultt(j,i)= 0;
             end
         end
     end
     %%
   % colfilt does columnwise neighborhood operations
   % process image result by rearranging each m-n block
   % and applying the function @mean
   % bwlabel labels object connected together
   % applied regionprops to the labeled objects
    
    block_bww = colfilt(resultt,[8 8],'sliding',@mean);
    
     
     [LL, numObjects] = bwlabel(block_bww,4);
     rgb_label = label2rgb(LL,@spring,'c','shuffle');
     figure,title(['colour label',imshow(rgb_label)]);
     statss = regionprops(LL,'basic');
    
     for Labell = 1:length(statss)
         x_2 (Labell) =   statss(Labell).Centroid(1);
         y_2 (Labell) =   statss(Labell).Centroid(2);  
      end
   
    
  %%
     
    link =zeros([length(stats) 2]);
     
         for v = 1:length(stats)
             link(v,1)= v;
           
             for w = 1:length(statss)
                 x(w)= (x_1(v) - x_2(w))^2;
                 y(w)= (y_1(v) - y_2(w))^2;
                 displacement(w)= sqrt((x(w))+(y(w)));
             end
             
                 [minDist(v), d]= min(displacement);
           
                 link (v,2)= d;
         end
         figure,imshow(uint8(videoframes(:,:,:,a)));
         hold on
         %%
         for k=1:length(stats)
         Bounding_Box = stats(k).BoundingBox;
         if(k==1)
         rectangle('Position',Bounding_Box,'EdgeColor','r','LineWidth',2);
         end
         if (k==2)
            rectangle('Position',Bounding_Box,'EdgeColor','b','LineWidth',2); 
         end
            if(k==3)
                rectangle('Position',Bounding_Box,'EdgeColor','w','LineWidth',2);
            end
                if (k==4)
                    rectangle('Position',Bounding_Box,'EdgeColor','y','LineWidth',2);
                end
                    if (k==5)
                        
                   rectangle('Position',Bounding_Box,'EdgeColor','k','LineWidth',2);
                    end
                     if (k==6)
                        
                   rectangle('Position',Bounding_Box,'EdgeColor','g','LineWidth',2);
                     end
                     if (k==7)
                        
                   rectangle('Position',Bounding_Box,'EdgeColor','c','LineWidth',2);
                    end
         end
         hold off;
         %% 
                   
                    figure,imshow(uint8(videoframes(:,:,:,b)));
                    hold on
                    numin = min(length(stats),length(statss));
                    for k = 1:numin
                      Bounding_Box2 = statss(k).BoundingBox; 
                      if (link(k,2)==1)
                          rectangle('Position',Bounding_Box2,'EdgeColor','r','LineWidth',2);
                      end
                      if (link(k,2)==2)
                          
                          rectangle('Position',Bounding_Box2,'EdgeColor','b','LineWidth',2);
                          
                      end
                          if (link(k,2)==3)
                              rectangle('Position',Bounding_Box2,'EdgeColor','w','LineWidth',2);
                          end
                          if (link(k,2)==4)
                              rectangle('Position',Bounding_Box2,'EdgeColor','y','LineWidth',2);
                          end
                          if (link(k,2)==5)
                              rectangle('Position',Bounding_Box2,'EdgeColor','k','LineWidth',2);
                          end
                          if (link(k,2)==6)
                              rectangle('Position',Bounding_Box2,'EdgeColor','g','LineWidth',2);
                          end
                          if (link(k,2)==7)
                              rectangle('Position',Bounding_Box2,'EdgeColor','c','LineWidth',2);
                          end
                    end
                    hold off;
                     File = fopen('ELE006_Question_10.txt','w');
                    
                     for v =1:length(stats)
                        for w = 1:length(statss) 
                            if (link(v,1)== v && link(v,2)== w)
                                
                              x(v)= (x_1(v)-x_2(w));
                              y(v)= (y_1(v)-y_2(w));
                               Angel(v)= atand(y(v)/x(v));
                               if (y(v)> 0)
                                  fprintf(File,'frame number1,frame number2:%.0f,%.0f\n', a,b);
                                  fprintf(File,'Object Number(first frame),Object Number(second frame): %.0f,%.0f\n', Label,Labell);
                                  fprintf(File,'Direction: north west\n', y(v));
                               else
                                  fprintf(File,'frame number1,frame number2: %.0f,%.0f\n', a,b);
                                  fprintf(File,'Object Number(first frame),Object Number(second frame): %.0f,%.0f\n', Label,Labell);
                                  fprintf(File,'Direction: south west\n', y(v));   
                               end
                            end
                        end
                     end
                                   
                File = fclose('all');              
                        
                    

     





   
     