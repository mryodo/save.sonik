function A=GRAS(A0, u, v)
    % исходим из следующих предположений
    % А0 - базовая матрица
    % u -- вектор строковых сумм у целевой матрицы
    % v -- вектор стобцовых сумм у целевой матрицы
    % A -- целевая матрица
    % err -- бинарная переменная, отвечающая за ошибку, т.е. если наш метод
    % не сойдется или сломается, то err=1, иначе 0
    
    [n,m] = size(A0);
    N = zeros(n,m);
    N(A0<0) = -A0(A0<0);
    P = A0+N;

    r = ones(n,1);
    s = ones(1,m);
    i = 0;
    
    eps=1e-2;
    
    while true
       i=i+1;
       ps=P*s';
       pr=r'*P;
       ns=N*(1./s)';
       nr=(1./r)'*N;
       
       s1=s;
       r1=r;
       
       r1(ps == 0) = - ns(ps==0) ./ u(ps==0);
       r1(ps>0) = (u(ps>0)+sqrt(u(ps>0).*u(ps>0)+4*ps(ps>0).*ns(ps>0))) ./ (2*ps(ps>0));
       
       s1(pr == 0) = - nr(pr==0) ./ v(pr==0);
       s1(pr>0) = (v(pr>0)+sqrt(v(pr>0).*v(pr>0)+4*pr(pr>0).*nr(pr>0))) ./ (2*pr(pr>0));
       
       error1=max(abs(s1-s));
       error2=max(abs(r1-r));
       disp(num2str([i, error1, error2]));
       
       if (error1 < eps)
          break 
       end
       s=s1;
       r=r1;
    end
    A=diag(r)*P*diag(s)-diag(1./r)*N*diag(1./s);
end