function c = interleave( a, b )
% @brief interleave two row vectors
% from https://stackoverflow.com/questions/10316304/interweaving-vectors
   ar = a(:).';    % make sure ar is a row vector
   br = b(:).';    % make sure br is a row vector
   A = [ar;br];   % concatenate them vertically
   c = A(:);      % flatten the result
   c = c';