function entropy = gsw_entropy_from_CT(SA,CT)

% gsw_entropy_from_CT                     specific entropy of seawater with  
%                         Conservative Temperature as the input temperature 
%==========================================================================
%
% USAGE:
%  entropy  =  gsw_entropy_from_CT(SA,CT)
%
% DESCRIPTION:
%  Calculates specific entropy of seawater. 
%
% INPUT:
%  SA  =  Absolute Salinity                                     [ g kg^-1 ]
%  CT  =  Conservative Temperature (ITS-90)                       [ deg C ]
%
%  SA & CT need to have the same dimensions.
%
% OUTPUT:
%  entropy  =  specific entropy                                [ J/(kg*K) ]
%
% AUTHOR: 
%  Trevor McDougall and Paul Barker                   [ help_gsw@csiro.au ]
%      
% VERSION NUMBER: 3.0 (4th April, 2011)
%
% REFERENCES:
%  IOC, SCOR and IAPSO, 2010: The international thermodynamic equation of 
%   seawater - 2010: Calculation and use of thermodynamic properties.  
%   Intergovernmental Oceanographic Commission, Manuals and Guides No. 56,
%   UNESCO (English), 196 pp.  Available from http://www.TEOS-10.org
%    See appendix A.10 of this TEOS-10 Manual. 
%
%  The software is available from http://www.TEOS-10.org
%
%==========================================================================

%--------------------------------------------------------------------------
% Check variables and resize if necessary
%--------------------------------------------------------------------------

if ~(nargin == 2)
   error('gsw_entropy_from_CT:  Requires two inputs')
end %if

[ms,ns] = size(SA);
[mt,nt] = size(CT);

if (mt ~= ms | nt ~= ns)
    error('gsw_entropy_from_CT: SA and CT must have same dimensions')
end

if ms == 1
    SA = SA.';
    CT = CT.';
    transposed = 1;
else
    transposed = 0;
end

%--------------------------------------------------------------------------
% Start of the calculation
%--------------------------------------------------------------------------

% These few lines ensure that SA is non-negative.
[I_neg_SA] = find(SA < 0);
if ~isempty(I_neg_SA)
    SA(I_neg_SA) = 0;
end

n0 = 0; 
n1 = 1;

pt0 = gsw_pt_from_CT(SA,CT);
pr0 = zeros(size(SA)); 
entropy = -gsw_gibbs(n0,n1,n0,SA,pt0,pr0);

if transposed
    entropy = entropy.';
end

end