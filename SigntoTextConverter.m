function[text] = SigntoTextConverter(image)
% Function takes a snapshot of the hand of an individual (wearing the 
% Beacon glove), and converts the sign language alphabet letter being shown
% into a text representation of English alphabet letter.
% PARAMETERS
% image str: the image file name (i.e. 'A.jpg')
% OUTPUT
% text str: a single character corresponding to correct sign language letter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          PRELIMINARY COMMANDS                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Define all error messages

Error1 = 'ERROR: Variable ''primary_class'' must have value ''extended'', ''fist'', or ''sideways''!';
Error2 = 'ERROR: Variable ''primary_class'' must be a string!';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           DETERMINE WHAT PRIMARY CLASS THE IMAGE BELONGS TO             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

background = '01-Blank.jpg';

primary_class = firstSort(image, background);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            EXTENDED CLASS                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    if strcmp(primary_class,'extended') == 1
        
        [letter] = extension(image);
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              FIST CLASS                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strcmp(primary_class,'fist') == 1
        
        % 1. Find fist subclass('thumbless', 'indexless', or 'all')
        [fist_class] = fistsubclass(image); 
        
        % 2. Determine letter if in thumbless subclass
        if strcmp(fist_class,'thumbless') == 1
            [letter] = fist_thumbless(image);
           
        % 3. Determine letter if in indexless subclass
        elseif strcmp(fist_class,'indexless') == 1
            [letter] = fist_indexless(image);
        
        % 4. Determine letter if in all subclass
        else
            fist_class = 'all';
            [letter] = fist_all(image);
            
        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            SIDEWAYS CLASS                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strcmp(primary_class,'sideways') == 1
        
        % 1. Find sideways subclass ('wristless', or 'all')
        [side_class] = sidesubclass(image);
        
        % 2. Determine letter if in wristless subclass
        if strcmp(side_class,'wristless') == 1
            [letter] = side_wristless(image);
        
        % 3. Determine letter if in all subclass
        else
            side_class = 'all';
            [letter] = sideways_all(image);
            
        end

    else
        error(Error1)
    end
    
    %%%%%%%%%%%%%%%%%%%%%%      PRINT LETTER      %%%%%%%%%%%%%%%%%%%%%%%%%
    text = letter;
    
catch
    error(Error2)
end

end