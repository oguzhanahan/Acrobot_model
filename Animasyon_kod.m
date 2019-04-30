function Animasyon_kod(Aci,tout)
Y=Aci.signals.values;
T=tout;
l1=0.5;
l2=0.6;
L=l1+l2;
% Calculating joint coordinates for animation purposes
x = [ l1*sin(Y(:,1)),  l1*sin(Y(:,1))+l2*sin(Y(:,1)+Y(:,2))];
y = [ -l1*cos(Y(:,1)),  -l1*cos(Y(:,1))-l2*cos(Y(:,1)+Y(:,2))];

% Convert radians to degrees
ang = Y(:,1:2)*180/pi;

figure(5);
subplot(2,1,1);
plot(T, ang, 'LineWidth', 2);
hh1(1) = line(T(1), ang(1,1), 'Marker', '.', 'MarkerSize', 20, 'Color', 'b');
hh1(2) = line(T(1), ang(1,2), 'Marker', '.', 'MarkerSize', 20, 'Color', [0 .5 0]);
xlabel('SÜRE (s)'); ylabel('AÇI (  ^0  )');

subplot(2,1,2);
hh2 = plot([0, x(1,1);x(1,1), x(1,2)], [0, y(1,1);y(1,1), y(1,2)], ...
      '.-', 'MarkerSize', 20, 'LineWidth', 2);
axis equal
axis([-L L -L L]);
ht = title(sprintf('SÜRE: %0.2f s', T(1)));


% Preallocate movie structure.
mov(1:length(T)) = struct('cdata', [], 'colormap', []);

v = VideoWriter('peaks.avi');
       open(v);
       
for id = 1:length(T)
   % Update XData and YData
   set(hh1(1), 'XData', T(id)          , 'YData', ang(id, 1));
   set(hh1(2), 'XData', T(id)          , 'YData', ang(id, 2));
   set(hh2(1), 'XData', [0, x(id, 1)]  , 'YData', [0, y(id, 1)]);
   set(hh2(2), 'XData', x(id, :)       , 'YData', y(id, :));
   set(ht, 'String', sprintf('SÜRE: %0.2f s', T(id)));

   % Get frame as an image
   
   mov(id) = getframe(gcf);
   writeVideo(v,mov(id));
end
close(v);


clear mov