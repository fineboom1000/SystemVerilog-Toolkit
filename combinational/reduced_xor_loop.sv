module reduced_xor_loop 
    #(parameter = N=8) 
        (
        input logic [N-1:0] a,
        output logic y            
        );

        always_comb
        begin
          logic tmp;
          tmp = a[0];
          for (int i=1; i<N; i = i+1)
            tmp = a[i] ^ tmp;
          y = tmp;
        end
    endmodule

/*
Think of having a daisy
chain of 8 xors.
The always block executes sequentially,
and note that _comb allows me to 
implicity inlcude all inputs(reminder)
We start of with the a[0] and will
loop forward with successive signals
unitl the end is reached.
Note that N=8 so use a strict ineq
/*