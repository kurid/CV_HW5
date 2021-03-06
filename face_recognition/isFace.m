function isFace = isFace( img )
% Decides if a given image is a human face
%   INPUT:
%       img - a grayscale image, size 120 x 100
%   OUTPUT:
%       isFace - should be true if the image is a human face, false if not.

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                     %
    %                       YOUR PART 4 CODE HERE                         %
    %                                                                     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Design your own method to decide if the image is a human face
    isFace = false;
    [rawFaceMatrix, imageOwner, ~, ~] = readInFaces();
    meanFace = sum(rawFaceMatrix, 2) / size(rawFaceMatrix, 2);
    A = rawFaceMatrix - repmat(meanFace, 1, size(rawFaceMatrix, 2));
    testImg = img(:) - meanFace;
    
    dist_mean = sum(testImg.^2);
    
    numComponentsToKeep = 20;
    [prinComponents, weightCols] = doPCA(A, numComponentsToKeep);
    weightTest = (testImg' * prinComponents)';
    [dist_pca, ~] = indexOfClosestColumn(weightCols, weightTest);
        
    [prinComponents, weightCols] = fisherfaces(A,imageOwner,numComponentsToKeep);
    weightTest = (testImg' * prinComponents)';
    [dist_fisherfaces, ~] = indexOfClosestColumn(weightCols, weightTest);
    
    c =  1.0e+07;
     if dist_mean < 3.6  * c
         if dist_pca < 0.0004 * c
             if dist_fisherfaces < 0.0004 * c
                 isFace = true;
             end
         end
     end

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                     %
    %                            END YOUR CODE                            %
    %                                                                     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [minDist, indexOfClosest] = indexOfClosestColumn(A, testColumn)
        dist = pdist2(A', testColumn');
        minDist = min(dist);
        indexOfClosest = find(dist == minDist, 1);
    end
    
end

