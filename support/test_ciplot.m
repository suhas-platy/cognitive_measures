x = 1:10;
sem_x = .25*rand(1,10);

figure(1);
ciplot( x-sem_x,x+sem_x,x, [0 0 1], .5 );

x = [0.0188    0.0300    0.0343    0.0336    0.0311];
sem_x = [0.0011    0.0017    0.0018    0.0018    0.0017];

figure(2);
ciplot( x-sem_x,x+sem_x,1:5, [0 0 1], .5 );

figure(3);
ciplot( (x-sem_x)',(x+sem_x)',(1:5)', [0 0 1], .5 );
