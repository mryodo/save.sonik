function res=PsiStat(x, xt)
    xt(xt==0)=1e-6;
    s=0.5*(abs(x)+abs(xt));
    res=sum(sum(abs(xt).*abs(log(xt./s))+abs(x).*abs(log(x./s))))/sum(sum(xt));
end