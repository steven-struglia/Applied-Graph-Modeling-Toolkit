function Y_calc = sdp_W_min(W,n)
    cvx_begin sdp
    variable Y(n,n) semidefinite;
    minimize( trace(W*Y) );
    subject to
        diag(Y) == 1;
        sum(sum(Y)) == 0;
    cvx_end
    Y_calc = Y;
end


