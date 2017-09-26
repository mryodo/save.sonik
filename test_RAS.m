% данные взяты из статьи "A short note on RAS method" 
% http://www.scienpress.com/Upload/AMAE/Vol%203_4_12.pdf

A0=[21.2, 29.0, 19.9; 
    9.0, 48.8, 22.4;
    49.8, 62.2, 7.8];

u=[75; 82; 125];

v=[85, 150, 45];

% вызовем наш RAS

[A, err]=RAS(A0, u, v);

err
A
sum(A, 1)
sum(A, 2)