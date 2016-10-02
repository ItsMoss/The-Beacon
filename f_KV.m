function [ sign ] = f_KV(edge)
% Determining whether the sign is K or V
% inputs:
% 1. edge: the edge figure generated from w_countfinger
% output: 
% 1: sign: the letter either K or V

upperregion = 100;
fingerlength = 20;
L = 0;
N = 0;

%%

for n = 1:1:100
    if L <= 5
        if edge(n) == 4
            L = L + 1;
        else
            L == 0;
        end
    else
        if edge(n) ==4
            L = L + 1;
        else
            if N <= 3
                N = N +1;
            else 
                break
            end
        end
    end
end

if L >= 24
    sign = 2;
else
    sign = 1;
end
end

