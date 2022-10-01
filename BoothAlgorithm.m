clc;
clear all
%Enter Multiplicand
M1=dec2bin(6)
M2=char(num2cell(M1));
M3=reshape(str2num(M2),1,[])
if (length(M3)<4)
    M4=zeros(1,1)
    M=horzcat(M4,M3)
else
    M=reshape(str2num(M2),1,[])
end

%Enter Multiplier
Q1=dec2bin(6)
Q2=char(num2cell(Q1));
Q3=reshape(str2num(Q2),1,[])
C=abs(length(M)-length(Q3))
Q4=zeros(1,C)
Q=horzcat(Q4,Q3)

A=[0 0 0 0]
Q_neg=0
n=length(Q)

for i=1:n
    if(Q(n)==Q_neg)
       fprintf('Operation 1: Arithmetic Right Shift')
       B=horzcat(A,Q)
       Q_neg=B(length(B))
       B=circshift(B,[0,1])
       p=length(B)
       A=B(1:(p/2))
       Q=B(((p/2)+1):p)
    else
        if(Q(n)==0 && Q_neg==1)
            %A=A+M;
            fprintf('Operation 2: Addition followed by Arithmetic Right Shift')
            s=dec2bin(bin2dec(num2str(A))+bin2dec(num2str(M)))
            A2=char(num2cell(s))
            A=reshape(str2num(A2),1,[])
            if(length(A)>4)
                A(1)=[]
            end
            B=horzcat(A,Q)
            Q_neg=B(length(B))
            B=circshift(B,[0,1])
            p=length(B)
            A=B(1:(p/2))
            Q=B(((p/2)+1):p)
        end
       
        if(Q(n)==1 && Q_neg==0)
            %A=A-M;
            fprintf('Operation 3: Subtraction of 2s complement followed by Arithmetic Right Shift')
            if(length(M1)<length(A))
                C=length(A)-length(M1)
                A2=zeros(1,C)
                a1=reshape(num2str(A2),1,[])
                M1=horzcat(a1,M1)
            end
            c1=not(M1-'0')   % one's complement
            d=1;
            for k=numel(M1):-1:1
                r=d & c1(k)
                c2(1,k)=xor(d,c1(k))  % c2 is two's complement
                d=r
            end
            s=dec2bin(bin2dec(num2str(A))+bin2dec(num2str(c2)))
            A3=A
            A2=char(num2cell(s))
            A=reshape(str2num(A2),1,[])
            if (length(A)>length(M))
                A(1)=[]
            end
            if (length(A)<length(M))
                C=length(M)-length(A)
                A=horzcat(zeros(1,C),A)
            end
            B=horzcat(A,Q)
            Q_neg=B(length(B))
            B=circshift(B,[0,1])
            p=length(B)
            A=B(1:(p/2))
            Q=B(((p/2)+1):p)
        end 
    end        
end
A
Q
Q_neg
B
a1=reshape(num2str(B),1,[])
bin2dec(a1)