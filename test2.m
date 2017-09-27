n=3;
m=3;
A=zeros(n+m, n*m);
    for i=1:n
        for j=(m*(i-1)+1):(m*i)
            A(i,j)=1;
        end
    end
    for i=1:m
        for j=i:n:(n*m)
            A(n+i,j)=1;
        end
    end
    
  A