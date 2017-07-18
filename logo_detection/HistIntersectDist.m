function D = HistIntersectDist( I1, I2, nbins)
%HistIntersectDist
%   Compute the histogram intersection measure for the two given image
%   patches.
%
%Input:
%   I1: image patch 1
%   I2: image patch 2
%   nbins: number of bins for histograms
%
%Output:
%   D: Histogram intersection measure (a real number)
%
    if nargin == 2
        nbins = 20;
    end
    
    % YOUR CODE STARTS HERE
    hist1 = Histogram(I1, nbins);
    hist2 = Histogram(I2, nbins);   
    D = sum(min(hist1(:), hist2(:)));
    % YOUR CODE ENDS HERE
end