A0=[21.2, 29.0, 19.9; 
    9.0, 48.8, 22.4;
    49.8, 62.2, 7.8];

u=[75; 82; 125];

v=[85, 150, 45];



 [n,m] = size(A0);
    N = zeros(n,m);
    N(A0<0) = -A0(A0<0);
    P = A0+N;

    s = ones(m,1);
    r = ones(1,n);
    i = 0;
    
    while true
       i=i+1;
       ps=P*s;
       pr=r*P;
       ns=N*(1./s);
       nr=(1./r)*N;
       
       s1=s;
       r1=r;
       
       for j=1:len(ps)
          if (ps(j)==0)
              r1(j)=-ns(j)/u(j);
          else
              r1(j)=(u(j)+sqrt(u(j)*u(i)+4*ps(i)*ns(i)))/(2*ps(i));
          end
       end
       
       for j=1:len(pr)
          if (ps(i)==0)
              r1(i)=-ns(i)/u(i);
          else
              r1(i)=(u(i)+sqrt(u(i)*u(i)+4*ps(i)*ns(i)))/(2*ps(i));
          end
       end
       
       %r1(ps == 0) = - ns(ps==0) ./ u(ps==0);
       %r1(ps>0) = (u(ps>0)+sqrt(u(ps>0).*u(ps>0)+4*ps(ps>0).*ns(ps>0))) ./ (2*ps(ps>0));
       
       %s1(pr == 0) = - nr(pr==0) ./ v(pr==0);
       %s1(pr>0) = (v(pr>0)+sqrt(v(pr>0).*v(pr>0)+4*pr(pr>0).*nr(pr>0))) ./ (2*pr(pr>0));
       
       error1=max(abs(s1-s));
       error2=max(abs(r1-r));
       disp(num2str([i, error1, error2]));
       
       if (error1 < eps) && (error2 < eps)
          break 
       end
       s=s1;
       r=r1;
    end
    A=diag(r)*P*diag(s)-diag(1./r)*N*diag(1./s);