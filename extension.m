function [text] = extension(ima)
% Counting how many aparted fingers are in the image by edge detection.
% input: 
% 1. ima: name string of input image
% output
% 1. text: i.e. 'K'
% date: 2015.dec.5
% by W&OJ, BME 790.02L

% parameters
thper = 1.2; % threshold for foreground and background division
thclose = 0.4; % threshold for whether two tips for close
thproj = [0.2,0.3,0.5]; %thresholds for counting fingers by projection thickness
flagplot = 0; % 0 for not plot, 1 for plot
bck ='01-Blank.jpg';

% 1. count how many fingers in the image
[ ims,bina ] = w_readcolorful( ima,thper );
[ num_finger,binamask,edgemask ] = w_countfinger_edge( ims,bina,flagplot );
if num_finger == 1 % all fingers are together 
    % locate the center of 3 color tapes
    [ rmc,gmc,bmc ] = w_locatecolor( ima,thper,flagplot );
    
    if (gmc(2)>bmc(2)&& gmc(2)>rmc(2)) % Z
%         display('The input image is Z. I like Z.'); % green tag is far in the right
        text = 'Z';
    else
        [ nfinger ] = w_countfinger_proj( binamask,thproj );
        if(w_rbisclose(rmc,gmc,bmc,thclose)) % red and blue are close, I or F       
            if(nfinger<=2)
%                 display('The input image is I. Trust me.');
                text = 'I';
            else
%                 display('The input image is F. Dont be surprised.');
                text = 'F';
            end
        else
            if(nfinger==4) % B has 4 fingers together, is quite noticable
%                 display('The input image is B. It should be B.');
                text = 'B';
            else
%                 display('It looks like R, U or D. Im so confused.');
                rdu = w_dtm_rud(ims,bmc);
                switch(rdu)
                    case 1
%                         display('The sign looks like R. It is a hard decision');
                        text = 'R';
                    case 2
%                         display('The sign looks like D. It is a dfficult decision');
                        text = 'D';
                    case 3
%                         display('The sign looks like U. I guess');
                        text = 'U';
                    otherwise
%                         display('I can not decide, something went wrong');
                end
            end            
        end       
    end
else if num_finger == 2 % K, L, V
        [ centers,angle,wcenter] = w_fingertip_angle( binamask,0,flagplot );
        if(angle > 50) % L
%             display('The input image is L. I think it is right');
            text = 'L';
        else % K, V
%             display('It is K or V, the only thing I can tell you.');
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            
            [f_length] = w_countfinger_f(ima, bck);
            [ sign ] = f_KV(f_length);
            if sign == 1
%                 display('The input image is K.');
                text = 'K';
            else
%                 display('The input image is V.');
                text = 'V';
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    else % num_finger >= 3, W
        [ centers,angle,wcenter] = w_fingertip_angle( binamask,0,flagplot );
%         display('The input image is W. Im quite sure');
        text = 'W';
    end
end
end