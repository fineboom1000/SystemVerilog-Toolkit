/*
How this works:
Recall that for any binary number, we can have it represent a signed magnitude by 
reserving the MSB bit for the sign. If you wanted to ask why we do not use the LSB, well
I do not know...thinking of it, I suppose we could, but I think we would run into trouble
when we need a sign change, and the overflow could be annoying. That said, with
the line of thought that the following implemenation has, I believe it is doable.

To design, first think about how it should operate:

Same sign between operands? Keep sign.
Different sign? Take the sign of the larger one (when abs valued).

In the first case we can just add the lower bits. In the second case we can sub max-min
and keep the max sign.

What we do from here is handle each part:
Sort numbers by mag and route to max and min signals.
Then preform case 1 or case 2 arithmetic.
that will involve comparing the signs.

*/

module sign_mag_add
#(parameter N = 4)
(
    input  logic [N-1:0] a, 
    input  logic [N-1:0] b,
    output logic [N-1:0] sum
);

    // signal declarations
    logic [N-2:0] mag_a, mag_b, mag_sum, max, min;
    logic sign_a, sign_b, sign_sum;

    // body
    always_comb begin
        // separate magnitude and sign
        mag_a = a[N-2:0];
        mag_b = b[N-2:0];
        sign_a = a[N-1];
        sign_b = b[N-1];

        // sort according to magnitude
        if (mag_a > mag_b) begin
            max = mag_a;
            min = mag_b;
            sign_sum = sign_a;
        end else begin
            max = mag_b;
            min = mag_a;
            sign_sum = sign_b;
        end

        // add/subtract magnitude
        if (sign_a == sign_b)
            mag_sum = max + min;
        else
            mag_sum = max - min;

        // form output
        sum = {sign_sum, mag_sum};
    end

endmodule
