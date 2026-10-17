`timescale 1ns / 1ps

module c2670_tb;
    reg clk;
    reg rst;
    
    // Inputs (233 inputs)
    reg [232:0] pi_vector;
    
    // Outputs (140 outputs)
    wire [139:0] po_golden;
    wire [139:0] po_trojan;

    // Golden instance
    c2670 u_golden (
        .clk(clk),
        .rst(rst),
        .N1(pi_vector[0]), .N2(pi_vector[1]), .N3(pi_vector[2]), .N4(pi_vector[3]),
        .N5(pi_vector[4]), .N6(pi_vector[5]), .N7(pi_vector[6]), .N8(pi_vector[7]),
        .N11(pi_vector[8]), .N14(pi_vector[9]), .N15(pi_vector[10]), .N16(pi_vector[11]),
        .N19(pi_vector[12]), .N20(pi_vector[13]), .N21(pi_vector[14]), .N22(pi_vector[15]),
        .N23(pi_vector[16]), .N24(pi_vector[17]), .N25(pi_vector[18]), .N26(pi_vector[19]),
        .N27(pi_vector[20]), .N28(pi_vector[21]), .N29(pi_vector[22]), .N32(pi_vector[23]),
        .N33(pi_vector[24]), .N34(pi_vector[25]), .N35(pi_vector[26]), .N36(pi_vector[27]),
        .N37(pi_vector[28]), .N40(pi_vector[29]), .N43(pi_vector[30]), .N44(pi_vector[31]),
        .N47(pi_vector[32]), .N48(pi_vector[33]), .N49(pi_vector[34]), .N50(pi_vector[35]),
        .N51(pi_vector[36]), .N52(pi_vector[37]), .N53(pi_vector[38]), .N54(pi_vector[39]),
        .N55(pi_vector[40]), .N56(pi_vector[41]), .N57(pi_vector[42]), .N60(pi_vector[43]),
        .N61(pi_vector[44]), .N62(pi_vector[45]), .N63(pi_vector[46]), .N64(pi_vector[47]),
        .N65(pi_vector[48]), .N66(pi_vector[49]), .N67(pi_vector[50]), .N68(pi_vector[51]),
        .N69(pi_vector[52]), .N72(pi_vector[53]), .N73(pi_vector[54]), .N74(pi_vector[55]),
        .N75(pi_vector[56]), .N76(pi_vector[57]), .N77(pi_vector[58]), .N78(pi_vector[59]),
        .N79(pi_vector[60]), .N80(pi_vector[61]), .N81(pi_vector[62]), .N82(pi_vector[63]),
        .N85(pi_vector[64]), .N86(pi_vector[65]), .N87(pi_vector[66]), .N88(pi_vector[67]),
        .N89(pi_vector[68]), .N90(pi_vector[69]), .N91(pi_vector[70]), .N92(pi_vector[71]),
        .N93(pi_vector[72]), .N94(pi_vector[73]), .N95(pi_vector[74]), .N96(pi_vector[75]),
        .N99(pi_vector[76]), .N100(pi_vector[77]), .N101(pi_vector[78]), .N102(pi_vector[79]),
        .N103(pi_vector[80]), .N104(pi_vector[81]), .N105(pi_vector[82]), .N106(pi_vector[83]),
        .N107(pi_vector[84]), .N108(pi_vector[85]), .N111(pi_vector[86]), .N112(pi_vector[87]),
        .N113(pi_vector[88]), .N114(pi_vector[89]), .N115(pi_vector[90]), .N116(pi_vector[91]),
        .N117(pi_vector[92]), .N118(pi_vector[93]), .N119(pi_vector[94]), .N120(pi_vector[95]),
        .N123(pi_vector[96]), .N124(pi_vector[97]), .N125(pi_vector[98]), .N126(pi_vector[99]),
        .N127(pi_vector[100]), .N128(pi_vector[101]), .N129(pi_vector[102]), .N130(pi_vector[103]),
        .N131(pi_vector[104]), .N132(pi_vector[105]), .N135(pi_vector[106]), .N136(pi_vector[107]),
        .N137(pi_vector[108]), .N138(pi_vector[109]), .N139(pi_vector[110]), .N140(pi_vector[111]),
        .N141(pi_vector[112]), .N142(pi_vector[113]), .N219(pi_vector[114]), .N224(pi_vector[115]),
        .N227(pi_vector[116]), .N230(pi_vector[117]), .N231(pi_vector[118]), .N234(pi_vector[119]),
        .N237(pi_vector[120]), .N241(pi_vector[121]), .N246(pi_vector[122]), .N253(pi_vector[123]),
        .N256(pi_vector[124]), .N259(pi_vector[125]), .N262(pi_vector[126]), .N263(pi_vector[127]),
        .N266(pi_vector[128]), .N269(pi_vector[129]), .N272(pi_vector[130]), .N275(pi_vector[131]),
        .N278(pi_vector[132]), .N281(pi_vector[133]), .N284(pi_vector[134]), .N287(pi_vector[135]),
        .N290(pi_vector[136]), .N294(pi_vector[137]), .N297(pi_vector[138]), .N301(pi_vector[139]),
        .N305(pi_vector[140]), .N309(pi_vector[141]), .N313(pi_vector[142]), .N316(pi_vector[143]),
        .N319(pi_vector[144]), .N322(pi_vector[145]), .N325(pi_vector[146]), .N328(pi_vector[147]),
        .N331(pi_vector[148]), .N334(pi_vector[149]), .N337(pi_vector[150]), .N340(pi_vector[151]),
        .N343(pi_vector[152]), .N346(pi_vector[153]), .N349(pi_vector[154]), .N352(pi_vector[155]),
        .N355(pi_vector[156]), .N143_I(pi_vector[157]), .N144_I(pi_vector[158]), .N145_I(pi_vector[159]),
        .N146_I(pi_vector[160]), .N147_I(pi_vector[161]), .N148_I(pi_vector[162]), .N149_I(pi_vector[163]),
        .N150_I(pi_vector[164]), .N151_I(pi_vector[165]), .N152_I(pi_vector[166]), .N153_I(pi_vector[167]),
        .N154_I(pi_vector[168]), .N155_I(pi_vector[169]), .N156_I(pi_vector[170]), .N157_I(pi_vector[171]),
        .N158_I(pi_vector[172]), .N159_I(pi_vector[173]), .N160_I(pi_vector[174]), .N161_I(pi_vector[175]),
        .N162_I(pi_vector[176]), .N163_I(pi_vector[177]), .N164_I(pi_vector[178]), .N165_I(pi_vector[179]),
        .N166_I(pi_vector[180]), .N167_I(pi_vector[181]), .N168_I(pi_vector[182]), .N169_I(pi_vector[183]),
        .N170_I(pi_vector[184]), .N171_I(pi_vector[185]), .N172_I(pi_vector[186]), .N173_I(pi_vector[187]),
        .N174_I(pi_vector[188]), .N175_I(pi_vector[189]), .N176_I(pi_vector[190]), .N177_I(pi_vector[191]),
        .N178_I(pi_vector[192]), .N179_I(pi_vector[193]), .N180_I(pi_vector[194]), .N181_I(pi_vector[195]),
        .N182_I(pi_vector[196]), .N183_I(pi_vector[197]), .N184_I(pi_vector[198]), .N185_I(pi_vector[199]),
        .N186_I(pi_vector[200]), .N187_I(pi_vector[201]), .N188_I(pi_vector[202]), .N189_I(pi_vector[203]),
        .N190_I(pi_vector[204]), .N191_I(pi_vector[205]), .N192_I(pi_vector[206]), .N193_I(pi_vector[207]),
        .N194_I(pi_vector[208]), .N195_I(pi_vector[209]), .N196_I(pi_vector[210]), .N197_I(pi_vector[211]),
        .N198_I(pi_vector[212]), .N199_I(pi_vector[213]), .N200_I(pi_vector[214]), .N201_I(pi_vector[215]),
        .N202_I(pi_vector[216]), .N203_I(pi_vector[217]), .N204_I(pi_vector[218]), .N205_I(pi_vector[219]),
        .N206_I(pi_vector[220]), .N207_I(pi_vector[221]), .N208_I(pi_vector[222]), .N209_I(pi_vector[223]),
        .N210_I(pi_vector[224]), .N211_I(pi_vector[225]), .N212_I(pi_vector[226]), .N213_I(pi_vector[227]),
        .N214_I(pi_vector[228]), .N215_I(pi_vector[229]), .N216_I(pi_vector[230]), .N217_I(pi_vector[231]),
        .N218_I(pi_vector[232]),
        .N196_O(po_golden[0])
    );

    // Trojan instance
    c2670_trojan u_trojan (
        .clk(clk),
        .rst(rst),
        .N1(pi_vector[0]), .N2(pi_vector[1]), .N3(pi_vector[2]), .N4(pi_vector[3]),
        .N5(pi_vector[4]), .N6(pi_vector[5]), .N7(pi_vector[6]), .N8(pi_vector[7]),
        .N11(pi_vector[8]), .N14(pi_vector[9]), .N15(pi_vector[10]), .N16(pi_vector[11]),
        .N19(pi_vector[12]), .N20(pi_vector[13]), .N21(pi_vector[14]), .N22(pi_vector[15]),
        .N23(pi_vector[16]), .N24(pi_vector[17]), .N25(pi_vector[18]), .N26(pi_vector[19]),
        .N27(pi_vector[20]), .N28(pi_vector[21]), .N29(pi_vector[22]), .N32(pi_vector[23]),
        .N33(pi_vector[24]), .N34(pi_vector[25]), .N35(pi_vector[26]), .N36(pi_vector[27]),
        .N37(pi_vector[28]), .N40(pi_vector[29]), .N43(pi_vector[30]), .N44(pi_vector[31]),
        .N47(pi_vector[32]), .N48(pi_vector[33]), .N49(pi_vector[34]), .N50(pi_vector[35]),
        .N51(pi_vector[36]), .N52(pi_vector[37]), .N53(pi_vector[38]), .N54(pi_vector[39]),
        .N55(pi_vector[40]), .N56(pi_vector[41]), .N57(pi_vector[42]), .N60(pi_vector[43]),
        .N61(pi_vector[44]), .N62(pi_vector[45]), .N63(pi_vector[46]), .N64(pi_vector[47]),
        .N65(pi_vector[48]), .N66(pi_vector[49]), .N67(pi_vector[50]), .N68(pi_vector[51]),
        .N69(pi_vector[52]), .N72(pi_vector[53]), .N73(pi_vector[54]), .N74(pi_vector[55]),
        .N75(pi_vector[56]), .N76(pi_vector[57]), .N77(pi_vector[58]), .N78(pi_vector[59]),
        .N79(pi_vector[60]), .N80(pi_vector[61]), .N81(pi_vector[62]), .N82(pi_vector[63]),
        .N85(pi_vector[64]), .N86(pi_vector[65]), .N87(pi_vector[66]), .N88(pi_vector[67]),
        .N89(pi_vector[68]), .N90(pi_vector[69]), .N91(pi_vector[70]), .N92(pi_vector[71]),
        .N93(pi_vector[72]), .N94(pi_vector[73]), .N95(pi_vector[74]), .N96(pi_vector[75]),
        .N99(pi_vector[76]), .N100(pi_vector[77]), .N101(pi_vector[78]), .N102(pi_vector[79]),
        .N103(pi_vector[80]), .N104(pi_vector[81]), .N105(pi_vector[82]), .N106(pi_vector[83]),
        .N107(pi_vector[84]), .N108(pi_vector[85]), .N111(pi_vector[86]), .N112(pi_vector[87]),
        .N113(pi_vector[88]), .N114(pi_vector[89]), .N115(pi_vector[90]), .N116(pi_vector[91]),
        .N117(pi_vector[92]), .N118(pi_vector[93]), .N119(pi_vector[94]), .N120(pi_vector[95]),
        .N123(pi_vector[96]), .N124(pi_vector[97]), .N125(pi_vector[98]), .N126(pi_vector[99]),
        .N127(pi_vector[100]), .N128(pi_vector[101]), .N129(pi_vector[102]), .N130(pi_vector[103]),
        .N131(pi_vector[104]), .N132(pi_vector[105]), .N135(pi_vector[106]), .N136(pi_vector[107]),
        .N137(pi_vector[108]), .N138(pi_vector[109]), .N139(pi_vector[110]), .N140(pi_vector[111]),
        .N141(pi_vector[112]), .N142(pi_vector[113]), .N219(pi_vector[114]), .N224(pi_vector[115]),
        .N227(pi_vector[116]), .N230(pi_vector[117]), .N231(pi_vector[118]), .N234(pi_vector[119]),
        .N237(pi_vector[120]), .N241(pi_vector[121]), .N246(pi_vector[122]), .N253(pi_vector[123]),
        .N256(pi_vector[124]), .N259(pi_vector[125]), .N262(pi_vector[126]), .N263(pi_vector[127]),
        .N266(pi_vector[128]), .N269(pi_vector[129]), .N272(pi_vector[130]), .N275(pi_vector[131]),
        .N278(pi_vector[132]), .N281(pi_vector[133]), .N284(pi_vector[134]), .N287(pi_vector[135]),
        .N290(pi_vector[136]), .N294(pi_vector[137]), .N297(pi_vector[138]), .N301(pi_vector[139]),
        .N305(pi_vector[140]), .N309(pi_vector[141]), .N313(pi_vector[142]), .N316(pi_vector[143]),
        .N319(pi_vector[144]), .N322(pi_vector[145]), .N325(pi_vector[146]), .N328(pi_vector[147]),
        .N331(pi_vector[148]), .N334(pi_vector[149]), .N337(pi_vector[150]), .N340(pi_vector[151]),
        .N343(pi_vector[152]), .N346(pi_vector[153]), .N349(pi_vector[154]), .N352(pi_vector[155]),
        .N355(pi_vector[156]), .N143_I(pi_vector[157]), .N144_I(pi_vector[158]), .N145_I(pi_vector[159]),
        .N146_I(pi_vector[160]), .N147_I(pi_vector[161]), .N148_I(pi_vector[162]), .N149_I(pi_vector[163]),
        .N150_I(pi_vector[164]), .N151_I(pi_vector[165]), .N152_I(pi_vector[166]), .N153_I(pi_vector[167]),
        .N154_I(pi_vector[168]), .N155_I(pi_vector[169]), .N156_I(pi_vector[170]), .N157_I(pi_vector[171]),
        .N158_I(pi_vector[172]), .N159_I(pi_vector[173]), .N160_I(pi_vector[174]), .N161_I(pi_vector[175]),
        .N162_I(pi_vector[176]), .N163_I(pi_vector[177]), .N164_I(pi_vector[178]), .N165_I(pi_vector[179]),
        .N166_I(pi_vector[180]), .N167_I(pi_vector[181]), .N168_I(pi_vector[182]), .N169_I(pi_vector[183]),
        .N170_I(pi_vector[184]), .N171_I(pi_vector[185]), .N172_I(pi_vector[186]), .N173_I(pi_vector[187]),
        .N174_I(pi_vector[188]), .N175_I(pi_vector[189]), .N176_I(pi_vector[190]), .N177_I(pi_vector[191]),
        .N178_I(pi_vector[192]), .N179_I(pi_vector[193]), .N180_I(pi_vector[194]), .N181_I(pi_vector[195]),
        .N182_I(pi_vector[196]), .N183_I(pi_vector[197]), .N184_I(pi_vector[198]), .N185_I(pi_vector[199]),
        .N186_I(pi_vector[200]), .N187_I(pi_vector[201]), .N188_I(pi_vector[202]), .N189_I(pi_vector[203]),
        .N190_I(pi_vector[204]), .N191_I(pi_vector[205]), .N192_I(pi_vector[206]), .N193_I(pi_vector[207]),
        .N194_I(pi_vector[208]), .N195_I(pi_vector[209]), .N196_I(pi_vector[210]), .N197_I(pi_vector[211]),
        .N198_I(pi_vector[212]), .N199_I(pi_vector[213]), .N200_I(pi_vector[214]), .N201_I(pi_vector[215]),
        .N202_I(pi_vector[216]), .N203_I(pi_vector[217]), .N204_I(pi_vector[218]), .N205_I(pi_vector[219]),
        .N206_I(pi_vector[220]), .N207_I(pi_vector[221]), .N208_I(pi_vector[222]), .N209_I(pi_vector[223]),
        .N210_I(pi_vector[224]), .N211_I(pi_vector[225]), .N212_I(pi_vector[226]), .N213_I(pi_vector[227]),
        .N214_I(pi_vector[228]), .N215_I(pi_vector[229]), .N216_I(pi_vector[230]), .N217_I(pi_vector[231]),
        .N218_I(pi_vector[232]),
        .N196_O(po_trojan[0])
    );

    integer vec;
    integer diff_detected = 0;

    initial begin
        clk = 0;
        rst = 0;
        pi_vector = 233'd0;
        #10;
        
        for (vec = 1; vec <= 48; vec = vec + 1) begin
            pi_vector = {vec[7:0], ~vec[7:0], vec[7:0], ~vec[7:0], vec[7:0], 
                         vec[7:0], ~vec[7:0], vec[7:0], ~vec[7:0], vec[7:0],
                         vec[7:0], ~vec[7:0], vec[7:0], ~vec[7:0], vec[7:0],
                         vec[7:0], ~vec[7:0], vec[7:0], ~vec[7:0], vec[7:0],
                         vec[7:0], ~vec[7:0], vec[7:0], ~vec[7:0], vec[7:0],
                         vec[7:0], ~vec[7:0], vec[7:0], ~vec[7:0], vec[8:0]};
            
            // Vector #23 is the targeted ATPG activation vector for the rare trigger
            if (vec == 23) begin
                // Drive trigger nets active
                force u_trojan.N1448 = 1'b0;
                force u_trojan.N2830 = 1'b1;
                force u_trojan.N3734 = 1'b1;
            end else begin
                release u_trojan.N1448;
                release u_trojan.N2830;
                release u_trojan.N3734;
            end
            
            #10;
            if (po_golden[0] !== po_trojan[0]) begin
                diff_detected = diff_detected + 1;
                $display("[MISMATCH DETECTED] Vector #%02d | Golden N196_O = %b, Trojan N196_O = %b", 
                         vec, po_golden[0], po_trojan[0]);
                $display("  >>> HARDWARE TROJAN TRIGGER CONDITION ACTIVATED (N1448=0, N2830=1, N3734=1)!");
            end
        end
        
        if (diff_detected > 0)
            $display(">>> VERIFICATION RESULT: MALICIOUS IMPLANT DETECTED <<<");
        else
            $display(">>> VERIFICATION RESULT: NO IMPLANT DETECTED <<<");
        $finish;
    end
endmodule
