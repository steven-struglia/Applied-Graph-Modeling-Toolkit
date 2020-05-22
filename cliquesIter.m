function z = cliquesIter(E,n,m,p)
    qp = zeros(1,m);
    A = zeros(n,n);
    edgelist = E(1,:);
    v_1 = edgelist(1);
    v_2 = edgelist(2);
    A(v_1,v_2) = 1;
    A(v_2,v_1) = 1;
    for k = 2:m
        edgelist = E(k,:);
            v_1 = edgelist(1);
            v_2 = edgelist(2);
            A(v_1,v_2) = 1;
            A(v_2,v_1) = 1;
            qp(k) = qp(k-1);
            switch p
                case 3
                    for j = 1:n
                        qp(k)= qp(k) + A(v_1,j)*A(v_2,j);
                    end
                case 4
                    for j = 1:n
                        for s = j+1:n
                            new = A(v_1,j)*A(v_1,s)*A(v_2,j)*A(v_2,s)*A(j,s);
                            qp(k)=qp(k)+new;
                        end
                    end
            end
    end
    z = qp;
end
