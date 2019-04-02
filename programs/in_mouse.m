function A = in_mouse(n,fig,show_points)
%A = in_mouse(n,fig,show_points)
% /various/in_mouse.m
% This program reads from the window/mouse
% n coordinate points and store them in a 
% matrix [Aij], i=1,...,n and j=x,y .
%
% n is the number of points which are 
% 	  picked up from the windows 'fig'
%    (default n=1)
% fig is the active window number 
% 	  (default fig=3)
% show_points Yes=1(default), No=0
%    If Yes show on the selected windows 
%    the points which are chosen
%
% The University of York, UK.

if (nargin==0)
   n=1;
   fig=3;figure(fig);delete(fig);axis([0 10 0 10])
   show_points=1;
elseif nargin==1
   fig=3;figure(fig);delete(fig);axis([0 10 0 10])
   show_points=1;
elseif nargin==2
   show_points=1;
end
figure(fig)

for i=1:n
   [ax,ay] = ginput(1);
   A(i,1) = ax;
   A(i,2) = ay;
   if show_points
      hold on , plot(A(i,1),A(i,2),'x'); hold off %axis([0 10 0 10])
      %hold on , plot(A(i,1),A(i,2),num2str(i)); hold off 
   end
   
   %pause;
end
