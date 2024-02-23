module testare;
integer file,file2;
reg [31:0] t = "TEST";
integer x = 235;
integer err_no;
    initial begin
        //t<="TEST";
file=$fopen("file.txt.txt");  
file2=$fopen("file2.txt");
$fdisplay(file,"%s || %d", t, x);
//$fwrite(file2,"%s",t);
always@ (posedge clock)begin
$fmonitor(file2,"time_c=%g",$time);
end 
err_no=$ferror(file,t);
$fclose(file);
end

endmodule
