
module tristate ( in, out, enable );
input  [15:0] in;
output [15:0] out;
input  enable;
    wire n181;
    tri \out<9> , \out<0> , \out<10> , \out<14> , \out<4> , \out<6> , 
        \out<12> , \out<2> , \out<13> , \out<3> , \out<7> , \out<15> , 
        \out<5> , \out<8> , \out<1> , \out<11> ;
    assign out[15] = \out<15> ;
    assign out[14] = \out<14> ;
    assign out[13] = \out<13> ;
    assign out[12] = \out<12> ;
    assign out[11] = \out<11> ;
    assign out[10] = \out<10> ;
    assign out[9] = \out<9> ;
    assign out[8] = \out<8> ;
    assign out[7] = \out<7> ;
    assign out[6] = \out<6> ;
    assign out[5] = \out<5> ;
    assign out[4] = \out<4> ;
    assign out[3] = \out<3> ;
    assign out[2] = \out<2> ;
    assign out[1] = \out<1> ;
    assign out[0] = \out<0> ;
    BUFT \out_tri<7>  ( .O(\out<7> ), .I(in[7]), .T(n181) );
    BUFT \out_tri<8>  ( .O(\out<8> ), .I(in[8]), .T(n181) );
    BUFT \out_tri<3>  ( .O(\out<3> ), .I(in[3]), .T(n181) );
    BUFT \out_tri<1>  ( .O(\out<1> ), .I(in[1]), .T(n181) );
    BUFT \out_tri<14>  ( .O(\out<14> ), .I(in[14]), .T(n181) );
    BUFT \out_tri<5>  ( .O(\out<5> ), .I(in[5]), .T(n181) );
    BUFT \out_tri<10>  ( .O(\out<10> ), .I(in[10]), .T(n181) );
    BUFT \out_tri<12>  ( .O(\out<12> ), .I(in[12]), .T(n181) );
    BUFT \out_tri<15>  ( .O(\out<15> ), .I(in[15]), .T(n181) );
    BUFT \out_tri<13>  ( .O(\out<13> ), .I(in[13]), .T(n181) );
    BUFT \out_tri<11>  ( .O(\out<11> ), .I(in[11]), .T(n181) );
    BUFT \out_tri<9>  ( .O(\out<9> ), .I(in[9]), .T(n181) );
    BUFT \out_tri<4>  ( .O(\out<4> ), .I(in[4]), .T(n181) );
    BUFT \out_tri<6>  ( .O(\out<6> ), .I(in[6]), .T(n181) );
    BUFT \out_tri<2>  ( .O(\out<2> ), .I(in[2]), .T(n181) );
    BUFT \out_tri<0>  ( .O(\out<0> ), .I(in[0]), .T(n181) );
    INV U8 ( .O(n181), .I(enable) );
endmodule


module mux2x1 ( in0, in1, out, select );
input  [15:0] in0;
input  [15:0] in1;
output [15:0] out;
input  select;
    wire n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, 
        n412, n413, n414, n415, n416, n417, n418, n419, n420, n421, n423, n425, 
        n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436, n437, 
        n438, n439, n440, n441, n442, n443, n444, n445, n446, n447, n448, n449, 
        n450;
    INV U42 ( .O(n401), .I(in0[0]) );
    NAND2 U43 ( .O(n403), .I1(select), .I0(in1[0]) );
    OR2 U44 ( .O(n402), .I1(select), .I0(n401) );
    NAND2 U45 ( .O(out[0]), .I1(n402), .I0(n403) );
    INV U46 ( .O(n404), .I(in0[10]) );
    NAND2 U47 ( .O(n406), .I1(select), .I0(in1[10]) );
    OR2 U48 ( .O(n405), .I1(select), .I0(n404) );
    NAND2 U49 ( .O(out[10]), .I1(n405), .I0(n406) );
    INV U50 ( .O(n407), .I(in0[11]) );
    NAND2 U51 ( .O(n409), .I1(select), .I0(in1[11]) );
    OR2 U52 ( .O(n408), .I1(select), .I0(n407) );
    NAND2 U53 ( .O(out[11]), .I1(n408), .I0(n409) );
    INV U54 ( .O(n410), .I(in0[12]) );
    NAND2 U55 ( .O(n412), .I1(select), .I0(in1[12]) );
    OR2 U56 ( .O(n411), .I1(select), .I0(n410) );
    NAND2 U57 ( .O(out[12]), .I1(n411), .I0(n412) );
    INV U58 ( .O(n413), .I(in0[13]) );
    NAND2 U59 ( .O(n415), .I1(select), .I0(in1[13]) );
    OR2 U60 ( .O(n414), .I1(select), .I0(n413) );
    NAND2 U61 ( .O(out[13]), .I1(n414), .I0(n415) );
    INV U62 ( .O(n416), .I(in0[14]) );
    NAND2 U63 ( .O(n418), .I1(select), .I0(in1[14]) );
    OR2 U64 ( .O(n417), .I1(select), .I0(n416) );
    NAND2 U65 ( .O(out[14]), .I1(n417), .I0(n418) );
    INV U66 ( .O(n419), .I(in0[15]) );
    NAND2 U67 ( .O(n421), .I1(select), .I0(in1[15]) );
    OR2 U68 ( .O(n420), .I1(select), .I0(n419) );
    NAND2 U69 ( .O(out[15]), .I1(n420), .I0(n421) );
    INV U70 ( .O(n423), .I(in0[1]) );
    NAND2 U71 ( .O(n426), .I1(select), .I0(in1[1]) );
    OR2 U72 ( .O(n425), .I1(select), .I0(n423) );
    NAND2 U73 ( .O(out[1]), .I1(n425), .I0(n426) );
    INV U74 ( .O(n427), .I(in0[2]) );
    NAND2 U75 ( .O(n429), .I1(select), .I0(in1[2]) );
    OR2 U76 ( .O(n428), .I1(select), .I0(n427) );
    NAND2 U77 ( .O(out[2]), .I1(n428), .I0(n429) );
    INV U78 ( .O(n430), .I(in0[3]) );
    NAND2 U79 ( .O(n432), .I1(select), .I0(in1[3]) );
    OR2 U80 ( .O(n431), .I1(select), .I0(n430) );
    NAND2 U81 ( .O(out[3]), .I1(n431), .I0(n432) );
    INV U82 ( .O(n433), .I(in0[4]) );
    NAND2 U83 ( .O(n435), .I1(select), .I0(in1[4]) );
    OR2 U84 ( .O(n434), .I1(select), .I0(n433) );
    NAND2 U85 ( .O(out[4]), .I1(n434), .I0(n435) );
    INV U86 ( .O(n436), .I(in0[5]) );
    NAND2 U87 ( .O(n438), .I1(select), .I0(in1[5]) );
    OR2 U88 ( .O(n437), .I1(select), .I0(n436) );
    NAND2 U89 ( .O(out[5]), .I1(n437), .I0(n438) );
    INV U90 ( .O(n439), .I(in0[6]) );
    NAND2 U91 ( .O(n441), .I1(select), .I0(in1[6]) );
    OR2 U92 ( .O(n440), .I1(select), .I0(n439) );
    NAND2 U93 ( .O(out[6]), .I1(n440), .I0(n441) );
    INV U94 ( .O(n442), .I(in0[7]) );
    NAND2 U95 ( .O(n444), .I1(select), .I0(in1[7]) );
    OR2 U96 ( .O(n443), .I1(select), .I0(n442) );
    NAND2 U97 ( .O(out[7]), .I1(n443), .I0(n444) );
    INV U98 ( .O(n445), .I(in0[8]) );
    NAND2 U99 ( .O(n447), .I1(select), .I0(in1[8]) );
    OR2 U100 ( .O(n446), .I1(select), .I0(n445) );
    NAND2 U101 ( .O(out[8]), .I1(n446), .I0(n447) );
    INV U102 ( .O(n448), .I(in0[9]) );
    NAND2 U103 ( .O(n450), .I1(select), .I0(in1[9]) );
    OR2 U104 ( .O(n449), .I1(select), .I0(n448) );
    NAND2 U105 ( .O(out[9]), .I1(n449), .I0(n450) );
endmodule


module flagmuxer ( in0, in1, out, select, iflag );
input  [4:0] in0;
input  [15:0] in1;
output [15:0] out;
input  select, iflag;
    wire n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, 
        n70, n71, n72, n73;
    INV U40 ( .O(n56), .I(in0[0]) );
    NAND2 U41 ( .O(n58), .I1(select), .I0(in1[0]) );
    OR2 U42 ( .O(n57), .I1(select), .I0(n56) );
    NAND2 U43 ( .O(out[0]), .I1(n57), .I0(n58) );
    INV U44 ( .O(n59), .I(in0[1]) );
    NAND2 U45 ( .O(n61), .I1(select), .I0(in1[1]) );
    OR2 U46 ( .O(n60), .I1(select), .I0(n59) );
    NAND2 U47 ( .O(out[1]), .I1(n60), .I0(n61) );
    INV U48 ( .O(n62), .I(in0[2]) );
    NAND2 U49 ( .O(n64), .I1(select), .I0(in1[2]) );
    OR2 U50 ( .O(n63), .I1(select), .I0(n62) );
    NAND2 U51 ( .O(out[2]), .I1(n63), .I0(n64) );
    INV U52 ( .O(n65), .I(in0[3]) );
    NAND2 U53 ( .O(n67), .I1(select), .I0(in1[3]) );
    OR2 U54 ( .O(n66), .I1(select), .I0(n65) );
    NAND2 U55 ( .O(out[3]), .I1(n66), .I0(n67) );
    INV U56 ( .O(n68), .I(in0[4]) );
    NAND2 U57 ( .O(n70), .I1(select), .I0(in1[4]) );
    OR2 U58 ( .O(n69), .I1(select), .I0(n68) );
    NAND2 U59 ( .O(out[4]), .I1(n69), .I0(n70) );
    INV U60 ( .O(n71), .I(iflag) );
    NAND2 U61 ( .O(n73), .I1(select), .I0(in1[5]) );
    OR2 U62 ( .O(n72), .I1(select), .I0(n71) );
    NAND2 U63 ( .O(out[5]), .I1(n72), .I0(n73) );
    AND2 U64 ( .O(out[10]), .I1(in1[10]), .I0(select) );
    AND2 U65 ( .O(out[11]), .I1(in1[11]), .I0(select) );
    AND2 U66 ( .O(out[12]), .I1(in1[12]), .I0(select) );
    AND2 U67 ( .O(out[13]), .I1(in1[13]), .I0(select) );
    AND2 U68 ( .O(out[14]), .I1(in1[14]), .I0(select) );
    AND2 U69 ( .O(out[15]), .I1(in1[15]), .I0(select) );
    AND2 U70 ( .O(out[6]), .I1(in1[6]), .I0(select) );
    AND2 U71 ( .O(out[7]), .I1(in1[7]), .I0(select) );
    AND2 U72 ( .O(out[8]), .I1(in1[8]), .I0(select) );
    AND2 U73 ( .O(out[9]), .I1(in1[9]), .I0(select) );
endmodule


module regstore ( regwr, rega, regb, wr_addr, a_addr, b_addr, wr_clk, clk, 
    regstore_reset, alu_flags2 );
input  [15:0] regwr;
output [15:0] rega;
input  [3:0] b_addr;
output [15:0] regb;
input  [3:0] a_addr;
output [15:0] alu_flags2;
input  [3:0] wr_addr;
input  wr_clk, clk, regstore_reset;
    wire \register0<12> , \register8<2> , \register4<10> , \register11<12> , 
        \register14<2> , \register3<9> , \register6<4> , \register15<10> , 
        \register5<7> , \register5<13> , \register11<6> , \register12<5> , 
        \register0<3> , \register3<0> , \register1<11> , \register14<13> , 
        n_2317, \register10<11> , \register5<3> , \register15<14> , 
        \register6<0> , \register14<6> , \register12<8> , \register4<14> , 
        \register8<6> , \register10<15> , \register3<4> , \register0<7> , 
        \register1<15> , \register6<9> , \register12<1> , \register11<2> , 
        \register0<5> , \register3<6> , \register5<8> , n_2413, 
        \register11<0> , \register12<3> , n_2029, \register5<15> , n_1741, 
        \register14<15> , \register8<4> , \register0<14> , \register6<2> , 
        \register5<1> , \register14<4> , \register11<9> , \register11<14> , 
        \register8<9> , \register14<11> , \register10<13> , \register5<11> , 
        \register14<9> , \register12<7> , \register11<4> , \register14215<5> , 
        \register3<2> , \register0<1> , n_1165, \register1<13> , 
        \register11<10> , \register14<0> , \register0<8> , \register5<5> , 
        \register15<12> , \register6<6> , \register0<10> , \register8<0> , 
        \register4<12> , \register6<14> , \register2<6> , \register1<5> , 
        n_1261, \register4<8> , \register13<3> , \register10<0> , 
        \register8<10> , \register4<1> , \register7<2> , \register15<4> , 
        \register3<15> , \register10<9> , \register9<13> , \register9<4> , 
        \register12<15> , \register8<14> , \register15<9> , \register10<4> , 
        \register13<7> , \register13<12> , \register1<1> , n_2590, 
        \register2<2> , \register6<10> , \register9<9> , \register2<12> , 
        \register12<11> , \register9<0> , n_1837, \register3<11> , 
        \register15<0> , \register1<8> , \register7<6> , \register4<5> , 
        \register7<13> , \register3<13> , \register15<2> , \register2<9> , 
        \register7<11> , \register4<7> , \register7<4> , \register12<13> , 
        \register9<2> , \register9<15> , \register6<12> , \register2<10> , 
        \register13<5> , \register10<6> , \register13<10> , \register2<0> , 
        \register1<3> , \register9<11> , \register9<6> , \register7<0> , 
        \register4<3> , \register7<15> , \register15<6> , \register13<8> , 
        \register13<14> , \register1<7> , \register2<4> , \register7<9> , 
        \register10<2> , \register13<1> , \register8<12> , \register2<14> , 
        \register9<10> , \register9<7> , \register4<2> , \register7<14> , 
        \register7<1> , \register13<9> , \register15<7> , \register7<8> , 
        \register13<15> , \register2<5> , \register1<6> , \register8<13> , 
        \register10<3> , \register13<0> , \register2<15> , \register15<3> , 
        \register3<12> , \register7<5> , \register4<6> , \register7<10> , 
        \register2<8> , \register9<3> , n_1549, \register12<12> , 
        \register9<14> , \register6<13> , \register2<11> , n_1645, 
        \register10<7> , \register13<4> , \register13<11> , \register1<2> , 
        n_2221, \register2<1> , \register10<5> , \register13<6> , 
        \register8<15> , \register15<8> , \register13<13> , \register2<3> , 
        \register1<0> , \register6<11> , \register9<8> , \register2<13> , 
        \register9<1> , \register12<10> , \register15<1> , \register3<10> , 
        \register4<4> , \register7<12> , \register7<7> , \register1<9> , 
        \register6<15> , \register4<9> , \register1<4> , \register2<7> , 
        \register8<11> , \register10<1> , \register13<2> , \register7<3> , 
        \register4<0> , \register3<14> , \register10<8> , \register15<5> , 
        \register9<12> , \register12<14> , \register9<5> , \register8<8> , 
        \register14<10> , \register10<12> , \register11<5> , \register12<6> , 
        \register0<0> , \register5<10> , \register14<8> , \register3<3> , 
        \register1<12> , \register14<1> , \register11<11> , \register6<7> , 
        \register5<4> , \register15<13> , \register0<9> , \register8<1> , 
        \register0<11> , \register4<13> , \register5<9> , \register3<7> , 
        \register0<4> , \register5<14> , \register12<2> , \register11<1> , 
        n_1357, \register14<14> , \register0<15> , \register8<5> , 
        \register5<0> , \register6<3> , \register11<8> , \register11<15> , 
        \register14<5> , \register6<1> , \register5<2> , \register15<15> , 
        \register12<9> , \register14<7> , \register4<15> , \register8<7> , 
        n_1933, \register10<14> , \register6<8> , \register0<6> , 
        \register3<5> , n_2125, \register1<14> , \register11<3> , 
        \register12<0> , \register8<3> , \register0<13> , \register4<11> , 
        \register14<3> , \register11<13> , \register15<11> , \register5<6> , 
        \register6<5> , \register3<8> , \register12<4> , \register11<7> , 
        \register5<12> , \register3<1> , \register0<2> , \register1<10> , 
        n_1453, \register14<12> , \register10<10> , n1378, n1379, n1380, n1381, 
        n1382, n1383, n1384, n1385, n1386, n1387, n1388, n1389, n1390, n1391, 
        n1392, n1393, n1394, n1395, n1396, n1397, n1398, n1399, n1400, n1401, 
        n1402, n1403, n1404, n1405, n1406, n1407, n1408, n1409, n1410, n1416, 
        n1417, n1418, n1419, n1420, n1421, n1422, n1423, n1424, n1425, n1426, 
        n1427, n1428, n1429, n1430, n1431, n1432, n1433, n1434, n1435, n1436, 
        n1437, n1438, n1439, n1440, n1441, n1442, n1443, n1444, n1445, n1446, 
        n1447, n1448, n1449, n1450, n1451, n1452, n1453, n1454, n1455, n1456, 
        n1457, n1458, n1459, n1460, n1461, n1462, n1463, n1464, n1465, n1466, 
        n1467, n1468, n1469, n1470, n1471, n1472, n1473, n1474, n1475, n1476, 
        n1477, n1478, n1479, n1480, n1481, n1482, n1483, n1484, n1485, n1486, 
        n1487, n1488, n1489, n1490, n1491, n1492, n1493, n1494, n1495, n1496, 
        n1497, n1498, n1499, n1500, n1501, n1502, n1503, n1504, n1505, n1506, 
        n1507, n1508, n1509, n1510, n1511, n1512, n1513, n1514, n1515, n1516, 
        n1517, n1518, n1519, n1520, n1521, n1522, n1523, n1524, n1525, n1526, 
        n1527, n1528, n1529, n1530, n1531, n1532, n1533, n1534, n1535, n1536, 
        n1537, n1538, n1539, n1540, n1541, n1542, n1543, n1544, n1545, n1546, 
        n1547, n1548, n1549, n1550, n1551, n1552, n1553, n1554, n1555, n1556, 
        n1557, n1558, n1559, n1560, n1561, n1562, n1563, n1564, n1565, n1566, 
        n1567, n1568, n1569, n1570, n1571, n1572, n1573, n1574, n1575, n1576, 
        n1577, n1578, n1579, n1580, n1581, n1582, n1583, n1584, n1585, n1586, 
        n1587, n1588, n1589, n1590, n1591, n1592, n1593, n1594, n1595, n1596, 
        n1597, n1598, n1599, n1600, n1601, n1602, n1603, n1604, n1605, n1606, 
        n1607, n1608, n1609, n1610, n1611, n1612, n1613, n1614, n1615, n1616, 
        n1617, n1618, n1619, n1620, n1621, n1622, n1623, n1624, n1625, n1626, 
        n1627, n1628, n1629, n1630, n1631, n1632, n1633, n1634, n1635, n1636, 
        n1637, n1638, n1639, n1640, n1641, n1642, n1643, n1644, n1645, n1646, 
        n1647, n1648, n1649, n1650, n1651, n1652, n1653, n1654, n1655, n1656, 
        n1657, n1658, n1659, n1660, n1661, n1662, n1663, n1664, n1665, n1666, 
        n1667, n1668, n1669, n1670, n1671, n2001, n2002, n2003, n2004, n2007, 
        n2008, n2009, n2010, n2013, n2014, n2015, n2016, n2019, n2020, n2021, 
        n2022, n2025, n2026, n2027, n2028, n2031, n2032, n2033, n2034, n2035, 
        n2036, n2037, n2038, n2039, n2040, n2041, n2042, n2043, n2044, n2045, 
        n2046, n2047, n2048, n2049, n2050, n2051, n2052, n2053, n2054, n2055, 
        n2056, n2057, n2058, n2059, n2060, n2061, n2062, n2063, n2064, n2065, 
        n2066, n2067, n2068, n2069, n2070, n2071, n2072, n2073, n2074, n2075, 
        n2076, n2077, n2078, n2079, n2080, n2081, n2082, n2083, n2084, n2085, 
        n2086, n2087, n2088, n2089, n2090, n2091, n2092, n2093, n2094, n2095, 
        n2096, n2097, n2098, n2099, n2100, n2101, n2102, n2103, n2104, n2105, 
        n2106, n2107, n2108, n2109, n2110, n2111, n2112, n2113, n2114, n2115, 
        n2116, n2117, n2118, n2119, n2120, n2121, n2122, n2123, n2124, n2125, 
        n2126, n2127, n2128, n2129, n2130, n2131, n2132, n2133, n2134, n2135, 
        n2136, n2137, n2138, n2139, n2140, n2141, n2142, n2143, n2144, n2145, 
        n2146, n2147, n2148, n2149, n2150, n2151, n2152, n2153, n2154, n2155, 
        n2156, n2157, n2158, n2159, n2160, n2161, n2162, n2163, n2164, n2165, 
        n2166, n2167, n2168, n2169, n2170, n2171, n2172, n2173, n2174, n2175, 
        n2176, n2177, n2178, n2179, n2180, n2181, n2182, n2183, n2184, n2185, 
        n2186, n2187, n2188, n2189, n2190, n2191, n2192, n2193, n2194, n2195, 
        n2196, n2197, n2198, n2199, n2200, n2201, n2202, n2203, n2204, n2205, 
        n2206, n2207, n2208, n2209, n2210, n2211, n2212, n2213, n2214, n2215, 
        n2216, n2217, n2218, n2219, n2220, n2221, n2222, n2223, n2224, n2225, 
        n2226, n2227, n2228, n2229, n2230, n2231, n2232, n2233, n2234, n2235, 
        n2236, n2237, n2238, n2239, n2240, n2241, n2242, n2243, n2244, n2245, 
        n2246, n2247, n2248, n2249, n2250, n2251, n2252, n2253, n2254, n2255, 
        n2256, n2257, n2258, n2259, n2260, n2261, n2262, n2263, n2264, n2265, 
        n2266, n2267, n2268, n2269, n2270, n2271, n2272, n2273, n2274, n2275, 
        n2276, n2277, n2278, n2279, n2280, n2281, n2282, n2283, n2284, n2285, 
        n2286, n2287, n2288, n2289, n2290, n2291, n2292, n2293, n2294, n2295, 
        n2296, n2297, n2298, n2299, n2300, n2301, n2302, n2303, n2304, n2305, 
        n2306, n2307, n2308, n2309, n2310, n2311, n2312, n2313, n2314, n2315, 
        n2316, n2317, n2318, n2319, n2320, n2321, n2322, n2323, n2324, n2325, 
        n2326, n2327, n2328, n2329, n2330, n2331, n2332, n2333, n2334, n2335, 
        n2336, n2337, n2338, n2339, n2340, n2341, n2342, n2343, n2344, n2345, 
        n2346, n2347, n2348, n2349, n2350, n2351, n2352, n2353, n2354, n2355, 
        n2356, n2357, n2358, n2359, n2360, n2361, n2362, n2363, n2364, n2365, 
        n2366, n2367, n2368, n2369, n2370, n2371, n2372, n2373, n2374, n2375, 
        n2376, n2377, n2378, n2379, n2380, n2381, n2382, n2383, n2384, n2385, 
        n2386, n2387, n2388, n2389, n2390, n2391, n2392, n2393, n2394, n2395, 
        n2396, n2397, n2398, n2399, n2400, n2401, n2402, n2403, n2404, n2405, 
        n2406, n2407, n2408, n2409, n2410, n2411, n2412, n2413, n2414, n2415, 
        n2416, n2417, n2418, n2419, n2420, n2421, n2422, n2423, n2424, n2425, 
        n2426, n2427, n2428, n2429, n2430, n2431, n2432, n2433, n2434, n2435, 
        n2436, n2437, n2438, n2439, n2440, n2441, n2442, n2443, n2444, n2445, 
        n2446, n2447, n2448, n2449, n2450, n2451, n2452, n2453, n2454, n2455, 
        n2456, n2457, n2458, n2459, n2460, n2461, n2462, n2463, n2464, n2465, 
        n2466, n2467, n2468, n2469, n2470, n2471, n2472, n2473, n2474, n2475, 
        n2476, n2477, n2478, n2479, n2480, n2481, n2482, n2483, n2484, n2485, 
        n2486, n2487, n2488, n2489, n2490, n2491, n2492, n2493, n2494, n2495, 
        n2496, n2497, n2498, n2499, n2500, n2501, n2502, n2503, n2504, n2505, 
        n2506, n2507, n2508, n2509, n2510, n2511, n2512, n2513, n2514, n2515, 
        n2517, n2518, n2519, n2520, n2521, n2522, n2523, n2524, n2525, n2526, 
        n2527, n2528, n2529, n2530, n2531, n2532, n2533, n2534, n2535, n2536, 
        n2537, n2538, n2539, n2540, n2541, n2542, n2543, n2544, n2545, n2546, 
        n2547, n2548, n2549, n2550, n2551, n2552, n2553, n2554, n2555, n2556, 
        n2557, n2558, n2559, n2560, n2561, n2562, n2563, n2564, n2565, n2566, 
        n2567, n2569, n2570, n2572, n2573, n2575, n2576, n2578, n2579, n2581, 
        n2582, n2583, n2584, n2585, n2586, n2587, n2588, n2589, n2590, n2591, 
        n2592, n2593, n2594, n2595, n2596, n2597, n2598, n2599, n2600, n2601, 
        n2602, n2603, n2604, n2605, n2606, n2607, n2609, n2610, n2611, n2612, 
        n2613, n2614, n2615, n2616, n2618, n2619, n2620, n2621, n2622, n2623, 
        n2624, n2625, n2627, n2628, n2629, n2630, n2631, n2632, n2633, n2634, 
        n2636, n2637, n2638, n2639, n2640, n2641, n2642, n2643, n2645, n2646, 
        n2647, n2648, n2649, n2650, n2651, n2652, n2653, n2654, n2655, n2656, 
        n2657, n2658, n2659, n2660, n2661, n2662, n2663, n2664, n2665, n2666, 
        n2667, n2668, n2669, n2670, n2671, n2672, n2673, n2674, n2675, n2676, 
        n2677, n2678, n2679, n2680, n2681, n2682, n2683, n2684, n2685, n2686, 
        n2687, n2688, n2689, n2690, n2691, n2692, n2693, n2694, n2695, n2696, 
        n2697, n2698, n2699, n2700, n2701, n2702, n2703, n2704, n2705, n2706, 
        n2707, n2708, n2709, n2710, n2711, n2712, n2713, n2714;
    tri \regwr<0> , \regwr<9> , \regwr<4> , \regwr<6> , \regwr<2> , 
        \regwr<10> , \regwr<14> , \regwr<12> , \regwr<13> , \regwr<15> , 
        \regwr<11> , \regwr<3> , \regwr<7> , \regwr<5> , \regwr<1> , 
        \regwr<8> ;
    assign \regwr<15>  = regwr[15];
    assign \regwr<14>  = regwr[14];
    assign \regwr<13>  = regwr[13];
    assign \regwr<12>  = regwr[12];
    assign \regwr<11>  = regwr[11];
    assign \regwr<10>  = regwr[10];
    assign \regwr<9>  = regwr[9];
    assign \regwr<8>  = regwr[8];
    assign \regwr<7>  = regwr[7];
    assign \regwr<6>  = regwr[6];
    assign \regwr<5>  = regwr[5];
    assign \regwr<4>  = regwr[4];
    assign \regwr<3>  = regwr[3];
    assign \regwr<2>  = regwr[2];
    assign \regwr<1>  = regwr[1];
    assign \regwr<0>  = regwr[0];
    NAND2 U861 ( .O(n2002), .I1(n1380), .I0(\register13<9> ) );
    NAND2 U862 ( .O(n2001), .I1(n1381), .I0(\register12<9> ) );
    NAND2 U863 ( .O(n1422), .I1(n2001), .I0(n2002) );
    NAND2 U864 ( .O(n2004), .I1(n1382), .I0(\register11<9> ) );
    NAND2 U865 ( .O(n2003), .I1(n1383), .I0(\register10<9> ) );
    NAND2 U866 ( .O(n1421), .I1(n2003), .I0(n2004) );
    FDC \register14_reg<14>  ( .Q(\register14<14> ), .D(1'b0), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \register14_reg<15>  ( .Q(\register14<15> ), .D(1'b0), .C(wr_clk), 
        .CLR(regstore_reset) );
    NAND2 U869 ( .O(n2008), .I1(n1392), .I0(\register1<8> ) );
    NAND2 U870 ( .O(n2007), .I1(n1393), .I0(\register0<8> ) );
    NAND2 U871 ( .O(n1424), .I1(n2007), .I0(n2008) );
    NAND2 U872 ( .O(n2010), .I1(n1378), .I0(\register15<9> ) );
    NAND2 U873 ( .O(n2009), .I1(n1379), .I0(\register14<9> ) );
    NAND2 U874 ( .O(n1423), .I1(n2009), .I0(n2010) );
    FDC \register14_reg<12>  ( .Q(\register14<12> ), .D(1'b0), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \register14_reg<13>  ( .Q(\register14<13> ), .D(1'b0), .C(wr_clk), 
        .CLR(regstore_reset) );
    NAND2 U877 ( .O(n2014), .I1(n1388), .I0(\register5<8> ) );
    NAND2 U878 ( .O(n2013), .I1(n1389), .I0(\register4<8> ) );
    NAND2 U879 ( .O(n1426), .I1(n2013), .I0(n2014) );
    NAND2 U880 ( .O(n2016), .I1(n1390), .I0(\register3<8> ) );
    NAND2 U881 ( .O(n2015), .I1(n1391), .I0(\register2<8> ) );
    NAND2 U882 ( .O(n1425), .I1(n2015), .I0(n2016) );
    FDC \register14_reg<10>  ( .Q(\register14<10> ), .D(1'b0), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \register14_reg<11>  ( .Q(\register14<11> ), .D(1'b0), .C(wr_clk), 
        .CLR(regstore_reset) );
    NAND2 U885 ( .O(n2020), .I1(n1384), .I0(\register9<8> ) );
    NAND2 U886 ( .O(n2019), .I1(n1385), .I0(\register8<8> ) );
    NAND2 U887 ( .O(n1428), .I1(n2019), .I0(n2020) );
    NAND2 U888 ( .O(n2022), .I1(n1386), .I0(\register7<8> ) );
    NAND2 U889 ( .O(n2021), .I1(n1387), .I0(\register6<8> ) );
    NAND2 U890 ( .O(n1427), .I1(n2021), .I0(n2022) );
    FDC \register14_reg<8>  ( .Q(\register14<8> ), .D(1'b0), .C(wr_clk), .CLR(
        regstore_reset) );
    FDC \register14_reg<9>  ( .Q(\register14<9> ), .D(1'b0), .C(wr_clk), .CLR(
        regstore_reset) );
    NAND2 U893 ( .O(n2026), .I1(n1380), .I0(\register13<8> ) );
    NAND2 U894 ( .O(n2025), .I1(n1381), .I0(\register12<8> ) );
    NAND2 U895 ( .O(n1430), .I1(n2025), .I0(n2026) );
    NAND2 U896 ( .O(n2028), .I1(n1382), .I0(\register11<8> ) );
    NAND2 U897 ( .O(n2027), .I1(n1383), .I0(\register10<8> ) );
    NAND2 U898 ( .O(n1429), .I1(n2027), .I0(n2028) );
    FDC \register14_reg<6>  ( .Q(\register14<6> ), .D(1'b0), .C(wr_clk), .CLR(
        regstore_reset) );
    FDC \register14_reg<7>  ( .Q(\register14<7> ), .D(1'b0), .C(wr_clk), .CLR(
        regstore_reset) );
    NAND2 U901 ( .O(n2032), .I1(n1392), .I0(\register1<7> ) );
    NAND2 U902 ( .O(n2031), .I1(n1393), .I0(\register0<7> ) );
    NAND2 U903 ( .O(n1432), .I1(n2031), .I0(n2032) );
    NAND2 U904 ( .O(n2034), .I1(n1378), .I0(\register15<8> ) );
    NAND2 U905 ( .O(n2033), .I1(n1379), .I0(\register14<8> ) );
    NAND2 U906 ( .O(n1431), .I1(n2033), .I0(n2034) );
    FDCE \register0_reg<14>  ( .Q(\register0<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<15>  ( .Q(\register0<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U907 ( .O(n2036), .I1(n1388), .I0(\register5<7> ) );
    NAND2 U908 ( .O(n2035), .I1(n1389), .I0(\register4<7> ) );
    NAND2 U909 ( .O(n1434), .I1(n2035), .I0(n2036) );
    NAND2 U910 ( .O(n2038), .I1(n1390), .I0(\register3<7> ) );
    NAND2 U911 ( .O(n2037), .I1(n1391), .I0(\register2<7> ) );
    NAND2 U912 ( .O(n1433), .I1(n2037), .I0(n2038) );
    FDCE \register0_reg<12>  ( .Q(\register0<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<13>  ( .Q(\register0<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U913 ( .O(n2040), .I1(n1384), .I0(\register9<7> ) );
    NAND2 U914 ( .O(n2039), .I1(n1385), .I0(\register8<7> ) );
    NAND2 U915 ( .O(n1436), .I1(n2039), .I0(n2040) );
    NAND2 U916 ( .O(n2042), .I1(n1386), .I0(\register7<7> ) );
    NAND2 U917 ( .O(n2041), .I1(n1387), .I0(\register6<7> ) );
    NAND2 U918 ( .O(n1435), .I1(n2041), .I0(n2042) );
    FDCE \register0_reg<10>  ( .Q(\register0<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<11>  ( .Q(\register0<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U919 ( .O(n2044), .I1(n1380), .I0(\register13<7> ) );
    NAND2 U920 ( .O(n2043), .I1(n1381), .I0(\register12<7> ) );
    NAND2 U921 ( .O(n1438), .I1(n2043), .I0(n2044) );
    NAND2 U922 ( .O(n2046), .I1(n1382), .I0(\register11<7> ) );
    NAND2 U923 ( .O(n2045), .I1(n1383), .I0(\register10<7> ) );
    NAND2 U924 ( .O(n1437), .I1(n2045), .I0(n2046) );
    FDCE \register0_reg<8>  ( .Q(\register0<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<9>  ( .Q(\register0<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U925 ( .O(n2048), .I1(n1392), .I0(\register1<6> ) );
    NAND2 U926 ( .O(n2047), .I1(n1393), .I0(\register0<6> ) );
    NAND2 U927 ( .O(n1440), .I1(n2047), .I0(n2048) );
    NAND2 U928 ( .O(n2050), .I1(n1378), .I0(\register15<7> ) );
    NAND2 U929 ( .O(n2049), .I1(n1379), .I0(\register14<7> ) );
    NAND2 U930 ( .O(n1439), .I1(n2049), .I0(n2050) );
    FDCE \register0_reg<6>  ( .Q(\register0<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<7>  ( .Q(\register0<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U931 ( .O(n2052), .I1(n1388), .I0(\register5<6> ) );
    NAND2 U932 ( .O(n2051), .I1(n1389), .I0(\register4<6> ) );
    NAND2 U933 ( .O(n1442), .I1(n2051), .I0(n2052) );
    NAND2 U934 ( .O(n2054), .I1(n1390), .I0(\register3<6> ) );
    NAND2 U935 ( .O(n2053), .I1(n1391), .I0(\register2<6> ) );
    NAND2 U936 ( .O(n1441), .I1(n2053), .I0(n2054) );
    FDCE \register0_reg<4>  ( .Q(\register0<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<5>  ( .Q(\register0<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U937 ( .O(n2056), .I1(n1384), .I0(\register9<6> ) );
    NAND2 U938 ( .O(n2055), .I1(n1385), .I0(\register8<6> ) );
    NAND2 U939 ( .O(n1444), .I1(n2055), .I0(n2056) );
    NAND2 U940 ( .O(n2058), .I1(n1386), .I0(\register7<6> ) );
    NAND2 U941 ( .O(n2057), .I1(n1387), .I0(\register6<6> ) );
    NAND2 U942 ( .O(n1443), .I1(n2057), .I0(n2058) );
    FDCE \register0_reg<2>  ( .Q(\register0<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<3>  ( .Q(\register0<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U943 ( .O(n2060), .I1(n1380), .I0(\register13<6> ) );
    NAND2 U944 ( .O(n2059), .I1(n1381), .I0(\register12<6> ) );
    NAND2 U945 ( .O(n1446), .I1(n2059), .I0(n2060) );
    NAND2 U946 ( .O(n2062), .I1(n1382), .I0(\register11<6> ) );
    NAND2 U947 ( .O(n2061), .I1(n1383), .I0(\register10<6> ) );
    NAND2 U948 ( .O(n1445), .I1(n2061), .I0(n2062) );
    FDCE \register0_reg<0>  ( .Q(\register0<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    FDCE \register0_reg<1>  ( .Q(\register0<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1165), .CLR(regstore_reset) );
    NAND2 U949 ( .O(n2064), .I1(n1379), .I0(\register14<5> ) );
    NAND2 U950 ( .O(n2063), .I1(n1393), .I0(\register0<5> ) );
    NAND2 U951 ( .O(n1448), .I1(n2063), .I0(n2064) );
    NAND2 U952 ( .O(n2066), .I1(n1378), .I0(\register15<6> ) );
    NAND2 U953 ( .O(n2065), .I1(n1379), .I0(\register14<6> ) );
    NAND2 U954 ( .O(n1447), .I1(n2065), .I0(n2066) );
    FDCE \register1_reg<14>  ( .Q(\register1<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<15>  ( .Q(\register1<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U955 ( .O(n2068), .I1(n1389), .I0(\register4<5> ) );
    NAND2 U956 ( .O(n2067), .I1(n1390), .I0(\register3<5> ) );
    NAND2 U957 ( .O(n1450), .I1(n2067), .I0(n2068) );
    NAND2 U958 ( .O(n2070), .I1(n1391), .I0(\register2<5> ) );
    NAND2 U959 ( .O(n2069), .I1(n1392), .I0(\register1<5> ) );
    NAND2 U960 ( .O(n1449), .I1(n2069), .I0(n2070) );
    FDCE \register1_reg<12>  ( .Q(\register1<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<13>  ( .Q(\register1<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U961 ( .O(n2072), .I1(n1385), .I0(\register8<5> ) );
    NAND2 U962 ( .O(n2071), .I1(n1386), .I0(\register7<5> ) );
    NAND2 U963 ( .O(n1452), .I1(n2071), .I0(n2072) );
    NAND2 U964 ( .O(n2074), .I1(n1387), .I0(\register6<5> ) );
    NAND2 U965 ( .O(n2073), .I1(n1388), .I0(\register5<5> ) );
    NAND2 U966 ( .O(n1451), .I1(n2073), .I0(n2074) );
    FDCE \register1_reg<10>  ( .Q(\register1<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<11>  ( .Q(\register1<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U967 ( .O(n2076), .I1(n1381), .I0(\register12<5> ) );
    NAND2 U968 ( .O(n2075), .I1(n1382), .I0(\register11<5> ) );
    NAND2 U969 ( .O(n1454), .I1(n2075), .I0(n2076) );
    NAND2 U970 ( .O(n2078), .I1(n1383), .I0(\register10<5> ) );
    NAND2 U971 ( .O(n2077), .I1(n1384), .I0(\register9<5> ) );
    NAND2 U972 ( .O(n1453), .I1(n2077), .I0(n2078) );
    FDCE \register1_reg<8>  ( .Q(\register1<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<9>  ( .Q(\register1<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U973 ( .O(n2080), .I1(n1379), .I0(\register14<4> ) );
    NAND2 U974 ( .O(n2079), .I1(n1393), .I0(\register0<4> ) );
    NAND2 U975 ( .O(n1456), .I1(n2079), .I0(n2080) );
    NAND2 U976 ( .O(n2082), .I1(n1378), .I0(\register15<5> ) );
    NAND2 U977 ( .O(n2081), .I1(n1380), .I0(\register13<5> ) );
    NAND2 U978 ( .O(n1455), .I1(n2081), .I0(n2082) );
    FDCE \register1_reg<6>  ( .Q(\register1<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<7>  ( .Q(\register1<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U979 ( .O(n2084), .I1(n1389), .I0(\register4<4> ) );
    NAND2 U980 ( .O(n2083), .I1(n1390), .I0(\register3<4> ) );
    NAND2 U981 ( .O(n1458), .I1(n2083), .I0(n2084) );
    NAND2 U982 ( .O(n2086), .I1(n1391), .I0(\register2<4> ) );
    NAND2 U983 ( .O(n2085), .I1(n1392), .I0(\register1<4> ) );
    NAND2 U984 ( .O(n1457), .I1(n2085), .I0(n2086) );
    FDCE \register1_reg<4>  ( .Q(\register1<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<5>  ( .Q(\register1<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U985 ( .O(n2088), .I1(n1385), .I0(\register8<4> ) );
    NAND2 U986 ( .O(n2087), .I1(n1386), .I0(\register7<4> ) );
    NAND2 U987 ( .O(n1460), .I1(n2087), .I0(n2088) );
    NAND2 U988 ( .O(n2090), .I1(n1387), .I0(\register6<4> ) );
    NAND2 U989 ( .O(n2089), .I1(n1388), .I0(\register5<4> ) );
    NAND2 U990 ( .O(n1459), .I1(n2089), .I0(n2090) );
    FDCE \register1_reg<2>  ( .Q(\register1<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<3>  ( .Q(\register1<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U991 ( .O(n2092), .I1(n1381), .I0(\register12<4> ) );
    NAND2 U992 ( .O(n2091), .I1(n1382), .I0(\register11<4> ) );
    NAND2 U993 ( .O(n1462), .I1(n2091), .I0(n2092) );
    NAND2 U994 ( .O(n2094), .I1(n1383), .I0(\register10<4> ) );
    NAND2 U995 ( .O(n2093), .I1(n1384), .I0(\register9<4> ) );
    NAND2 U996 ( .O(n1461), .I1(n2093), .I0(n2094) );
    FDCE \register1_reg<0>  ( .Q(\register1<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    FDCE \register1_reg<1>  ( .Q(\register1<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1261), .CLR(regstore_reset) );
    NAND2 U997 ( .O(n2096), .I1(n1379), .I0(\register14<3> ) );
    NAND2 U998 ( .O(n2095), .I1(n1393), .I0(\register0<3> ) );
    NAND2 U999 ( .O(n1464), .I1(n2095), .I0(n2096) );
    NAND2 U1000 ( .O(n2098), .I1(n1378), .I0(\register15<4> ) );
    NAND2 U1001 ( .O(n2097), .I1(n1380), .I0(\register13<4> ) );
    NAND2 U1002 ( .O(n1463), .I1(n2097), .I0(n2098) );
    FDCE \register2_reg<14>  ( .Q(\register2<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<15>  ( .Q(\register2<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1003 ( .O(n2100), .I1(n1389), .I0(\register4<3> ) );
    NAND2 U1004 ( .O(n2099), .I1(n1390), .I0(\register3<3> ) );
    NAND2 U1005 ( .O(n1466), .I1(n2099), .I0(n2100) );
    NAND2 U1006 ( .O(n2102), .I1(n1391), .I0(\register2<3> ) );
    NAND2 U1007 ( .O(n2101), .I1(n1392), .I0(\register1<3> ) );
    NAND2 U1008 ( .O(n1465), .I1(n2101), .I0(n2102) );
    FDCE \register2_reg<12>  ( .Q(\register2<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<13>  ( .Q(\register2<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1009 ( .O(n2104), .I1(n1385), .I0(\register8<3> ) );
    NAND2 U1010 ( .O(n2103), .I1(n1386), .I0(\register7<3> ) );
    NAND2 U1011 ( .O(n1468), .I1(n2103), .I0(n2104) );
    NAND2 U1012 ( .O(n2106), .I1(n1387), .I0(\register6<3> ) );
    NAND2 U1013 ( .O(n2105), .I1(n1388), .I0(\register5<3> ) );
    NAND2 U1014 ( .O(n1467), .I1(n2105), .I0(n2106) );
    FDCE \register2_reg<10>  ( .Q(\register2<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<11>  ( .Q(\register2<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1015 ( .O(n2108), .I1(n1381), .I0(\register12<3> ) );
    NAND2 U1016 ( .O(n2107), .I1(n1382), .I0(\register11<3> ) );
    NAND2 U1017 ( .O(n1470), .I1(n2107), .I0(n2108) );
    NAND2 U1018 ( .O(n2110), .I1(n1383), .I0(\register10<3> ) );
    NAND2 U1019 ( .O(n2109), .I1(n1384), .I0(\register9<3> ) );
    NAND2 U1020 ( .O(n1469), .I1(n2109), .I0(n2110) );
    FDCE \register2_reg<8>  ( .Q(\register2<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<9>  ( .Q(\register2<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1021 ( .O(n2112), .I1(n1379), .I0(\register14<2> ) );
    NAND2 U1022 ( .O(n2111), .I1(n1393), .I0(\register0<2> ) );
    NAND2 U1023 ( .O(n1472), .I1(n2111), .I0(n2112) );
    NAND2 U1024 ( .O(n2114), .I1(n1378), .I0(\register15<3> ) );
    NAND2 U1025 ( .O(n2113), .I1(n1380), .I0(\register13<3> ) );
    NAND2 U1026 ( .O(n1471), .I1(n2113), .I0(n2114) );
    FDCE \register2_reg<6>  ( .Q(\register2<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<7>  ( .Q(\register2<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1027 ( .O(n2116), .I1(n1389), .I0(\register4<2> ) );
    NAND2 U1028 ( .O(n2115), .I1(n1390), .I0(\register3<2> ) );
    NAND2 U1029 ( .O(n1474), .I1(n2115), .I0(n2116) );
    NAND2 U1030 ( .O(n2118), .I1(n1391), .I0(\register2<2> ) );
    NAND2 U1031 ( .O(n2117), .I1(n1392), .I0(\register1<2> ) );
    NAND2 U1032 ( .O(n1473), .I1(n2117), .I0(n2118) );
    FDCE \register2_reg<4>  ( .Q(\register2<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<5>  ( .Q(\register2<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1033 ( .O(n2120), .I1(n1385), .I0(\register8<2> ) );
    NAND2 U1034 ( .O(n2119), .I1(n1386), .I0(\register7<2> ) );
    NAND2 U1035 ( .O(n1476), .I1(n2119), .I0(n2120) );
    NAND2 U1036 ( .O(n2122), .I1(n1387), .I0(\register6<2> ) );
    NAND2 U1037 ( .O(n2121), .I1(n1388), .I0(\register5<2> ) );
    NAND2 U1038 ( .O(n1475), .I1(n2121), .I0(n2122) );
    FDCE \register2_reg<2>  ( .Q(\register2<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<3>  ( .Q(\register2<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1039 ( .O(n2124), .I1(n1381), .I0(\register12<2> ) );
    NAND2 U1040 ( .O(n2123), .I1(n1382), .I0(\register11<2> ) );
    NAND2 U1041 ( .O(n1478), .I1(n2123), .I0(n2124) );
    NAND2 U1042 ( .O(n2126), .I1(n1383), .I0(\register10<2> ) );
    NAND2 U1043 ( .O(n2125), .I1(n1384), .I0(\register9<2> ) );
    NAND2 U1044 ( .O(n1477), .I1(n2125), .I0(n2126) );
    FDCE \register2_reg<0>  ( .Q(\register2<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    FDCE \register2_reg<1>  ( .Q(\register2<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1357), .CLR(regstore_reset) );
    NAND2 U1045 ( .O(n2128), .I1(n1379), .I0(\register14<1> ) );
    NAND2 U1046 ( .O(n2127), .I1(n1393), .I0(\register0<1> ) );
    NAND2 U1047 ( .O(n1480), .I1(n2127), .I0(n2128) );
    NAND2 U1048 ( .O(n2130), .I1(n1378), .I0(\register15<2> ) );
    NAND2 U1049 ( .O(n2129), .I1(n1380), .I0(\register13<2> ) );
    NAND2 U1050 ( .O(n1479), .I1(n2129), .I0(n2130) );
    FDCE \register3_reg<14>  ( .Q(\register3<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<15>  ( .Q(\register3<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1051 ( .O(n2132), .I1(n1389), .I0(\register4<1> ) );
    NAND2 U1052 ( .O(n2131), .I1(n1390), .I0(\register3<1> ) );
    NAND2 U1053 ( .O(n1482), .I1(n2131), .I0(n2132) );
    NAND2 U1054 ( .O(n2134), .I1(n1391), .I0(\register2<1> ) );
    NAND2 U1055 ( .O(n2133), .I1(n1392), .I0(\register1<1> ) );
    NAND2 U1056 ( .O(n1481), .I1(n2133), .I0(n2134) );
    FDCE \register3_reg<12>  ( .Q(\register3<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<13>  ( .Q(\register3<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1057 ( .O(n2136), .I1(n1385), .I0(\register8<1> ) );
    NAND2 U1058 ( .O(n2135), .I1(n1386), .I0(\register7<1> ) );
    NAND2 U1059 ( .O(n1484), .I1(n2135), .I0(n2136) );
    NAND2 U1060 ( .O(n2138), .I1(n1387), .I0(\register6<1> ) );
    NAND2 U1061 ( .O(n2137), .I1(n1388), .I0(\register5<1> ) );
    NAND2 U1062 ( .O(n1483), .I1(n2137), .I0(n2138) );
    FDCE \register3_reg<10>  ( .Q(\register3<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<11>  ( .Q(\register3<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1063 ( .O(n2140), .I1(n1381), .I0(\register12<1> ) );
    NAND2 U1064 ( .O(n2139), .I1(n1382), .I0(\register11<1> ) );
    NAND2 U1065 ( .O(n1486), .I1(n2139), .I0(n2140) );
    NAND2 U1066 ( .O(n2142), .I1(n1383), .I0(\register10<1> ) );
    NAND2 U1067 ( .O(n2141), .I1(n1384), .I0(\register9<1> ) );
    NAND2 U1068 ( .O(n1485), .I1(n2141), .I0(n2142) );
    FDCE \register3_reg<8>  ( .Q(\register3<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<9>  ( .Q(\register3<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1069 ( .O(n2144), .I1(n1392), .I0(\register1<15> ) );
    NAND2 U1070 ( .O(n2143), .I1(n1393), .I0(\register0<15> ) );
    NAND2 U1071 ( .O(n1488), .I1(n2143), .I0(n2144) );
    NAND2 U1072 ( .O(n2146), .I1(n1378), .I0(\register15<1> ) );
    NAND2 U1073 ( .O(n2145), .I1(n1380), .I0(\register13<1> ) );
    NAND2 U1074 ( .O(n1487), .I1(n2145), .I0(n2146) );
    FDCE \register3_reg<6>  ( .Q(\register3<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<7>  ( .Q(\register3<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1075 ( .O(n2148), .I1(n1388), .I0(\register5<15> ) );
    NAND2 U1076 ( .O(n2147), .I1(n1389), .I0(\register4<15> ) );
    NAND2 U1077 ( .O(n1490), .I1(n2147), .I0(n2148) );
    NAND2 U1078 ( .O(n2150), .I1(n1390), .I0(\register3<15> ) );
    NAND2 U1079 ( .O(n2149), .I1(n1391), .I0(\register2<15> ) );
    NAND2 U1080 ( .O(n1489), .I1(n2149), .I0(n2150) );
    FDCE \register3_reg<4>  ( .Q(\register3<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<5>  ( .Q(\register3<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1081 ( .O(n2152), .I1(n1384), .I0(\register9<15> ) );
    NAND2 U1082 ( .O(n2151), .I1(n1385), .I0(\register8<15> ) );
    NAND2 U1083 ( .O(n1492), .I1(n2151), .I0(n2152) );
    NAND2 U1084 ( .O(n2154), .I1(n1386), .I0(\register7<15> ) );
    NAND2 U1085 ( .O(n2153), .I1(n1387), .I0(\register6<15> ) );
    NAND2 U1086 ( .O(n1491), .I1(n2153), .I0(n2154) );
    FDCE \register3_reg<2>  ( .Q(\register3<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<3>  ( .Q(\register3<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1087 ( .O(n2156), .I1(n1380), .I0(\register13<15> ) );
    NAND2 U1088 ( .O(n2155), .I1(n1381), .I0(\register12<15> ) );
    NAND2 U1089 ( .O(n1494), .I1(n2155), .I0(n2156) );
    NAND2 U1090 ( .O(n2158), .I1(n1382), .I0(\register11<15> ) );
    NAND2 U1091 ( .O(n2157), .I1(n1383), .I0(\register10<15> ) );
    NAND2 U1092 ( .O(n1493), .I1(n2157), .I0(n2158) );
    FDCE \register3_reg<0>  ( .Q(\register3<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    FDCE \register3_reg<1>  ( .Q(\register3<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1453), .CLR(regstore_reset) );
    NAND2 U1093 ( .O(n2160), .I1(n1392), .I0(\register1<14> ) );
    NAND2 U1094 ( .O(n2159), .I1(n1393), .I0(\register0<14> ) );
    NAND2 U1095 ( .O(n1496), .I1(n2159), .I0(n2160) );
    NAND2 U1096 ( .O(n2162), .I1(n1378), .I0(\register15<15> ) );
    NAND2 U1097 ( .O(n2161), .I1(n1379), .I0(\register14<15> ) );
    NAND2 U1098 ( .O(n1495), .I1(n2161), .I0(n2162) );
    FDCE \register4_reg<14>  ( .Q(\register4<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<15>  ( .Q(\register4<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1099 ( .O(n2164), .I1(n1388), .I0(\register5<14> ) );
    NAND2 U1100 ( .O(n2163), .I1(n1389), .I0(\register4<14> ) );
    NAND2 U1101 ( .O(n1498), .I1(n2163), .I0(n2164) );
    NAND2 U1102 ( .O(n2166), .I1(n1390), .I0(\register3<14> ) );
    NAND2 U1103 ( .O(n2165), .I1(n1391), .I0(\register2<14> ) );
    NAND2 U1104 ( .O(n1497), .I1(n2165), .I0(n2166) );
    FDCE \register4_reg<12>  ( .Q(\register4<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<13>  ( .Q(\register4<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1105 ( .O(n2168), .I1(n1384), .I0(\register9<14> ) );
    NAND2 U1106 ( .O(n2167), .I1(n1385), .I0(\register8<14> ) );
    NAND2 U1107 ( .O(n1500), .I1(n2167), .I0(n2168) );
    NAND2 U1108 ( .O(n2170), .I1(n1386), .I0(\register7<14> ) );
    NAND2 U1109 ( .O(n2169), .I1(n1387), .I0(\register6<14> ) );
    NAND2 U1110 ( .O(n1499), .I1(n2169), .I0(n2170) );
    FDCE \register4_reg<10>  ( .Q(\register4<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<11>  ( .Q(\register4<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1111 ( .O(n2172), .I1(n1380), .I0(\register13<14> ) );
    NAND2 U1112 ( .O(n2171), .I1(n1381), .I0(\register12<14> ) );
    NAND2 U1113 ( .O(n1502), .I1(n2171), .I0(n2172) );
    NAND2 U1114 ( .O(n2174), .I1(n1382), .I0(\register11<14> ) );
    NAND2 U1115 ( .O(n2173), .I1(n1383), .I0(\register10<14> ) );
    NAND2 U1116 ( .O(n1501), .I1(n2173), .I0(n2174) );
    FDCE \register4_reg<8>  ( .Q(\register4<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<9>  ( .Q(\register4<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1117 ( .O(n2176), .I1(n1392), .I0(\register1<13> ) );
    NAND2 U1118 ( .O(n2175), .I1(n1393), .I0(\register0<13> ) );
    NAND2 U1119 ( .O(n1504), .I1(n2175), .I0(n2176) );
    NAND2 U1120 ( .O(n2178), .I1(n1378), .I0(\register15<14> ) );
    NAND2 U1121 ( .O(n2177), .I1(n1379), .I0(\register14<14> ) );
    NAND2 U1122 ( .O(n1503), .I1(n2177), .I0(n2178) );
    FDCE \register4_reg<6>  ( .Q(\register4<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<7>  ( .Q(\register4<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1123 ( .O(n2180), .I1(n1388), .I0(\register5<13> ) );
    NAND2 U1124 ( .O(n2179), .I1(n1389), .I0(\register4<13> ) );
    NAND2 U1125 ( .O(n1506), .I1(n2179), .I0(n2180) );
    NAND2 U1126 ( .O(n2182), .I1(n1390), .I0(\register3<13> ) );
    NAND2 U1127 ( .O(n2181), .I1(n1391), .I0(\register2<13> ) );
    NAND2 U1128 ( .O(n1505), .I1(n2181), .I0(n2182) );
    FDCE \register4_reg<4>  ( .Q(\register4<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<5>  ( .Q(\register4<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1129 ( .O(n2184), .I1(n1384), .I0(\register9<13> ) );
    NAND2 U1130 ( .O(n2183), .I1(n1385), .I0(\register8<13> ) );
    NAND2 U1131 ( .O(n1508), .I1(n2183), .I0(n2184) );
    NAND2 U1132 ( .O(n2186), .I1(n1386), .I0(\register7<13> ) );
    NAND2 U1133 ( .O(n2185), .I1(n1387), .I0(\register6<13> ) );
    NAND2 U1134 ( .O(n1507), .I1(n2185), .I0(n2186) );
    FDCE \register4_reg<2>  ( .Q(\register4<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<3>  ( .Q(\register4<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1135 ( .O(n2188), .I1(n1380), .I0(\register13<13> ) );
    NAND2 U1136 ( .O(n2187), .I1(n1381), .I0(\register12<13> ) );
    NAND2 U1137 ( .O(n1510), .I1(n2187), .I0(n2188) );
    NAND2 U1138 ( .O(n2190), .I1(n1382), .I0(\register11<13> ) );
    NAND2 U1139 ( .O(n2189), .I1(n1383), .I0(\register10<13> ) );
    NAND2 U1140 ( .O(n1509), .I1(n2189), .I0(n2190) );
    FDCE \register4_reg<0>  ( .Q(\register4<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    FDCE \register4_reg<1>  ( .Q(\register4<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1549), .CLR(regstore_reset) );
    NAND2 U1141 ( .O(n2192), .I1(n1392), .I0(\register1<12> ) );
    NAND2 U1142 ( .O(n2191), .I1(n1393), .I0(\register0<12> ) );
    NAND2 U1143 ( .O(n1512), .I1(n2191), .I0(n2192) );
    NAND2 U1144 ( .O(n2194), .I1(n1378), .I0(\register15<13> ) );
    NAND2 U1145 ( .O(n2193), .I1(n1379), .I0(\register14<13> ) );
    NAND2 U1146 ( .O(n1511), .I1(n2193), .I0(n2194) );
    FDCE \register5_reg<14>  ( .Q(\register5<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<15>  ( .Q(\register5<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1147 ( .O(n2196), .I1(n1388), .I0(\register5<12> ) );
    NAND2 U1148 ( .O(n2195), .I1(n1389), .I0(\register4<12> ) );
    NAND2 U1149 ( .O(n1514), .I1(n2195), .I0(n2196) );
    NAND2 U1150 ( .O(n2198), .I1(n1390), .I0(\register3<12> ) );
    NAND2 U1151 ( .O(n2197), .I1(n1391), .I0(\register2<12> ) );
    NAND2 U1152 ( .O(n1513), .I1(n2197), .I0(n2198) );
    FDCE \register5_reg<12>  ( .Q(\register5<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<13>  ( .Q(\register5<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1153 ( .O(n2200), .I1(n1384), .I0(\register9<12> ) );
    NAND2 U1154 ( .O(n2199), .I1(n1385), .I0(\register8<12> ) );
    NAND2 U1155 ( .O(n1516), .I1(n2199), .I0(n2200) );
    NAND2 U1156 ( .O(n2202), .I1(n1386), .I0(\register7<12> ) );
    NAND2 U1157 ( .O(n2201), .I1(n1387), .I0(\register6<12> ) );
    NAND2 U1158 ( .O(n1515), .I1(n2201), .I0(n2202) );
    FDCE \register5_reg<10>  ( .Q(\register5<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<11>  ( .Q(\register5<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1159 ( .O(n2204), .I1(n1380), .I0(\register13<12> ) );
    NAND2 U1160 ( .O(n2203), .I1(n1381), .I0(\register12<12> ) );
    NAND2 U1161 ( .O(n1518), .I1(n2203), .I0(n2204) );
    NAND2 U1162 ( .O(n2206), .I1(n1382), .I0(\register11<12> ) );
    NAND2 U1163 ( .O(n2205), .I1(n1383), .I0(\register10<12> ) );
    NAND2 U1164 ( .O(n1517), .I1(n2205), .I0(n2206) );
    FDCE \register5_reg<8>  ( .Q(\register5<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<9>  ( .Q(\register5<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1165 ( .O(n2208), .I1(n1392), .I0(\register1<11> ) );
    NAND2 U1166 ( .O(n2207), .I1(n1393), .I0(\register0<11> ) );
    NAND2 U1167 ( .O(n1520), .I1(n2207), .I0(n2208) );
    NAND2 U1168 ( .O(n2210), .I1(n1378), .I0(\register15<12> ) );
    NAND2 U1169 ( .O(n2209), .I1(n1379), .I0(\register14<12> ) );
    NAND2 U1170 ( .O(n1519), .I1(n2209), .I0(n2210) );
    FDCE \register5_reg<6>  ( .Q(\register5<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<7>  ( .Q(\register5<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1171 ( .O(n2212), .I1(n1388), .I0(\register5<11> ) );
    NAND2 U1172 ( .O(n2211), .I1(n1389), .I0(\register4<11> ) );
    NAND2 U1173 ( .O(n1522), .I1(n2211), .I0(n2212) );
    NAND2 U1174 ( .O(n2214), .I1(n1390), .I0(\register3<11> ) );
    NAND2 U1175 ( .O(n2213), .I1(n1391), .I0(\register2<11> ) );
    NAND2 U1176 ( .O(n1521), .I1(n2213), .I0(n2214) );
    FDCE \register5_reg<4>  ( .Q(\register5<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<5>  ( .Q(\register5<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1177 ( .O(n2216), .I1(n1384), .I0(\register9<11> ) );
    NAND2 U1178 ( .O(n2215), .I1(n1385), .I0(\register8<11> ) );
    NAND2 U1179 ( .O(n1524), .I1(n2215), .I0(n2216) );
    NAND2 U1180 ( .O(n2218), .I1(n1386), .I0(\register7<11> ) );
    NAND2 U1181 ( .O(n2217), .I1(n1387), .I0(\register6<11> ) );
    NAND2 U1182 ( .O(n1523), .I1(n2217), .I0(n2218) );
    FDCE \register5_reg<2>  ( .Q(\register5<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<3>  ( .Q(\register5<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1183 ( .O(n2220), .I1(n1380), .I0(\register13<11> ) );
    NAND2 U1184 ( .O(n2219), .I1(n1381), .I0(\register12<11> ) );
    NAND2 U1185 ( .O(n1526), .I1(n2219), .I0(n2220) );
    NAND2 U1186 ( .O(n2222), .I1(n1382), .I0(\register11<11> ) );
    NAND2 U1187 ( .O(n2221), .I1(n1383), .I0(\register10<11> ) );
    NAND2 U1188 ( .O(n1525), .I1(n2221), .I0(n2222) );
    FDCE \register5_reg<0>  ( .Q(\register5<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    FDCE \register5_reg<1>  ( .Q(\register5<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1645), .CLR(regstore_reset) );
    NAND2 U1189 ( .O(n2224), .I1(n1392), .I0(\register1<10> ) );
    NAND2 U1190 ( .O(n2223), .I1(n1393), .I0(\register0<10> ) );
    NAND2 U1191 ( .O(n1528), .I1(n2223), .I0(n2224) );
    NAND2 U1192 ( .O(n2226), .I1(n1378), .I0(\register15<11> ) );
    NAND2 U1193 ( .O(n2225), .I1(n1379), .I0(\register14<11> ) );
    NAND2 U1194 ( .O(n1527), .I1(n2225), .I0(n2226) );
    FDCE \register6_reg<14>  ( .Q(\register6<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<15>  ( .Q(\register6<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1195 ( .O(n2228), .I1(n1388), .I0(\register5<10> ) );
    NAND2 U1196 ( .O(n2227), .I1(n1389), .I0(\register4<10> ) );
    NAND2 U1197 ( .O(n1530), .I1(n2227), .I0(n2228) );
    NAND2 U1198 ( .O(n2230), .I1(n1390), .I0(\register3<10> ) );
    NAND2 U1199 ( .O(n2229), .I1(n1391), .I0(\register2<10> ) );
    NAND2 U1200 ( .O(n1529), .I1(n2229), .I0(n2230) );
    FDCE \register6_reg<12>  ( .Q(\register6<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<13>  ( .Q(\register6<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1201 ( .O(n2232), .I1(n1384), .I0(\register9<10> ) );
    NAND2 U1202 ( .O(n2231), .I1(n1385), .I0(\register8<10> ) );
    NAND2 U1203 ( .O(n1532), .I1(n2231), .I0(n2232) );
    NAND2 U1204 ( .O(n2234), .I1(n1386), .I0(\register7<10> ) );
    NAND2 U1205 ( .O(n2233), .I1(n1387), .I0(\register6<10> ) );
    NAND2 U1206 ( .O(n1531), .I1(n2233), .I0(n2234) );
    FDCE \register6_reg<10>  ( .Q(\register6<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<11>  ( .Q(\register6<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1207 ( .O(n2236), .I1(n1380), .I0(\register13<10> ) );
    NAND2 U1208 ( .O(n2235), .I1(n1381), .I0(\register12<10> ) );
    NAND2 U1209 ( .O(n1534), .I1(n2235), .I0(n2236) );
    NAND2 U1210 ( .O(n2238), .I1(n1382), .I0(\register11<10> ) );
    NAND2 U1211 ( .O(n2237), .I1(n1383), .I0(\register10<10> ) );
    NAND2 U1212 ( .O(n1533), .I1(n2237), .I0(n2238) );
    FDCE \register6_reg<8>  ( .Q(\register6<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<9>  ( .Q(\register6<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1213 ( .O(n2240), .I1(n1379), .I0(\register14<0> ) );
    NAND2 U1214 ( .O(n2239), .I1(n1393), .I0(\register0<0> ) );
    NAND2 U1215 ( .O(n1536), .I1(n2239), .I0(n2240) );
    NAND2 U1216 ( .O(n2242), .I1(n1378), .I0(\register15<10> ) );
    NAND2 U1217 ( .O(n2241), .I1(n1379), .I0(\register14<10> ) );
    NAND2 U1218 ( .O(n1535), .I1(n2241), .I0(n2242) );
    FDCE \register6_reg<6>  ( .Q(\register6<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<7>  ( .Q(\register6<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1219 ( .O(n2244), .I1(n1389), .I0(\register4<0> ) );
    NAND2 U1220 ( .O(n2243), .I1(n1390), .I0(\register3<0> ) );
    NAND2 U1221 ( .O(n1538), .I1(n2243), .I0(n2244) );
    NAND2 U1222 ( .O(n2246), .I1(n1391), .I0(\register2<0> ) );
    NAND2 U1223 ( .O(n2245), .I1(n1392), .I0(\register1<0> ) );
    NAND2 U1224 ( .O(n1537), .I1(n2245), .I0(n2246) );
    FDCE \register6_reg<4>  ( .Q(\register6<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<5>  ( .Q(\register6<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1225 ( .O(n2248), .I1(n1385), .I0(\register8<0> ) );
    NAND2 U1226 ( .O(n2247), .I1(n1386), .I0(\register7<0> ) );
    NAND2 U1227 ( .O(n1540), .I1(n2247), .I0(n2248) );
    NAND2 U1228 ( .O(n2250), .I1(n1387), .I0(\register6<0> ) );
    NAND2 U1229 ( .O(n2249), .I1(n1388), .I0(\register5<0> ) );
    NAND2 U1230 ( .O(n1539), .I1(n2249), .I0(n2250) );
    FDCE \register6_reg<2>  ( .Q(\register6<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<3>  ( .Q(\register6<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1231 ( .O(n2252), .I1(n1381), .I0(\register12<0> ) );
    NAND2 U1232 ( .O(n2251), .I1(n1382), .I0(\register11<0> ) );
    NAND2 U1233 ( .O(n1542), .I1(n2251), .I0(n2252) );
    NAND2 U1234 ( .O(n2254), .I1(n1383), .I0(\register10<0> ) );
    NAND2 U1235 ( .O(n2253), .I1(n1384), .I0(\register9<0> ) );
    NAND2 U1236 ( .O(n1541), .I1(n2253), .I0(n2254) );
    FDCE \register6_reg<0>  ( .Q(\register6<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    FDCE \register6_reg<1>  ( .Q(\register6<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1741), .CLR(regstore_reset) );
    NAND2 U1237 ( .O(n2256), .I1(n1408), .I0(\register1<9> ) );
    NAND2 U1238 ( .O(n2255), .I1(n1409), .I0(\register0<9> ) );
    NAND2 U1239 ( .O(n1544), .I1(n2255), .I0(n2256) );
    NAND2 U1240 ( .O(n2258), .I1(n1378), .I0(\register15<0> ) );
    NAND2 U1241 ( .O(n2257), .I1(n1380), .I0(\register13<0> ) );
    NAND2 U1242 ( .O(n1543), .I1(n2257), .I0(n2258) );
    FDCE \register7_reg<14>  ( .Q(\register7<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<15>  ( .Q(\register7<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1243 ( .O(n2260), .I1(n1404), .I0(\register5<9> ) );
    NAND2 U1244 ( .O(n2259), .I1(n1405), .I0(\register4<9> ) );
    NAND2 U1245 ( .O(n1546), .I1(n2259), .I0(n2260) );
    NAND2 U1246 ( .O(n2262), .I1(n1406), .I0(\register3<9> ) );
    NAND2 U1247 ( .O(n2261), .I1(n1407), .I0(\register2<9> ) );
    NAND2 U1248 ( .O(n1545), .I1(n2261), .I0(n2262) );
    FDCE \register7_reg<12>  ( .Q(\register7<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<13>  ( .Q(\register7<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1249 ( .O(n2264), .I1(n1400), .I0(\register9<9> ) );
    NAND2 U1250 ( .O(n2263), .I1(n1401), .I0(\register8<9> ) );
    NAND2 U1251 ( .O(n1548), .I1(n2263), .I0(n2264) );
    NAND2 U1252 ( .O(n2266), .I1(n1402), .I0(\register7<9> ) );
    NAND2 U1253 ( .O(n2265), .I1(n1403), .I0(\register6<9> ) );
    NAND2 U1254 ( .O(n1547), .I1(n2265), .I0(n2266) );
    FDCE \register7_reg<10>  ( .Q(\register7<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<11>  ( .Q(\register7<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1255 ( .O(n2268), .I1(n1396), .I0(\register13<9> ) );
    NAND2 U1256 ( .O(n2267), .I1(n1397), .I0(\register12<9> ) );
    NAND2 U1257 ( .O(n1550), .I1(n2267), .I0(n2268) );
    NAND2 U1258 ( .O(n2270), .I1(n1398), .I0(\register11<9> ) );
    NAND2 U1259 ( .O(n2269), .I1(n1399), .I0(\register10<9> ) );
    NAND2 U1260 ( .O(n1549), .I1(n2269), .I0(n2270) );
    FDCE \register7_reg<8>  ( .Q(\register7<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<9>  ( .Q(\register7<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1261 ( .O(n2272), .I1(n1408), .I0(\register1<8> ) );
    NAND2 U1262 ( .O(n2271), .I1(n1409), .I0(\register0<8> ) );
    NAND2 U1263 ( .O(n1552), .I1(n2271), .I0(n2272) );
    NAND2 U1264 ( .O(n2274), .I1(n1394), .I0(\register15<9> ) );
    NAND2 U1265 ( .O(n2273), .I1(n1395), .I0(\register14<9> ) );
    NAND2 U1266 ( .O(n1551), .I1(n2273), .I0(n2274) );
    FDCE \register7_reg<6>  ( .Q(\register7<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<7>  ( .Q(\register7<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1267 ( .O(n2276), .I1(n1404), .I0(\register5<8> ) );
    NAND2 U1268 ( .O(n2275), .I1(n1405), .I0(\register4<8> ) );
    NAND2 U1269 ( .O(n1554), .I1(n2275), .I0(n2276) );
    NAND2 U1270 ( .O(n2278), .I1(n1406), .I0(\register3<8> ) );
    NAND2 U1271 ( .O(n2277), .I1(n1407), .I0(\register2<8> ) );
    NAND2 U1272 ( .O(n1553), .I1(n2277), .I0(n2278) );
    FDCE \register7_reg<4>  ( .Q(\register7<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<5>  ( .Q(\register7<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1273 ( .O(n2280), .I1(n1400), .I0(\register9<8> ) );
    NAND2 U1274 ( .O(n2279), .I1(n1401), .I0(\register8<8> ) );
    NAND2 U1275 ( .O(n1556), .I1(n2279), .I0(n2280) );
    NAND2 U1276 ( .O(n2282), .I1(n1402), .I0(\register7<8> ) );
    NAND2 U1277 ( .O(n2281), .I1(n1403), .I0(\register6<8> ) );
    NAND2 U1278 ( .O(n1555), .I1(n2281), .I0(n2282) );
    FDCE \register7_reg<2>  ( .Q(\register7<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<3>  ( .Q(\register7<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1279 ( .O(n2284), .I1(n1396), .I0(\register13<8> ) );
    NAND2 U1280 ( .O(n2283), .I1(n1397), .I0(\register12<8> ) );
    NAND2 U1281 ( .O(n1558), .I1(n2283), .I0(n2284) );
    NAND2 U1282 ( .O(n2286), .I1(n1398), .I0(\register11<8> ) );
    NAND2 U1283 ( .O(n2285), .I1(n1399), .I0(\register10<8> ) );
    NAND2 U1284 ( .O(n1557), .I1(n2285), .I0(n2286) );
    FDCE \register7_reg<0>  ( .Q(\register7<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    FDCE \register7_reg<1>  ( .Q(\register7<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1837), .CLR(regstore_reset) );
    NAND2 U1285 ( .O(n2288), .I1(n1408), .I0(\register1<7> ) );
    NAND2 U1286 ( .O(n2287), .I1(n1409), .I0(\register0<7> ) );
    NAND2 U1287 ( .O(n1560), .I1(n2287), .I0(n2288) );
    NAND2 U1288 ( .O(n2290), .I1(n1394), .I0(\register15<8> ) );
    NAND2 U1289 ( .O(n2289), .I1(n1395), .I0(\register14<8> ) );
    NAND2 U1290 ( .O(n1559), .I1(n2289), .I0(n2290) );
    FDCE \register8_reg<14>  ( .Q(\register8<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<15>  ( .Q(\register8<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1291 ( .O(n2292), .I1(n1404), .I0(\register5<7> ) );
    NAND2 U1292 ( .O(n2291), .I1(n1405), .I0(\register4<7> ) );
    NAND2 U1293 ( .O(n1562), .I1(n2291), .I0(n2292) );
    NAND2 U1294 ( .O(n2294), .I1(n1406), .I0(\register3<7> ) );
    NAND2 U1295 ( .O(n2293), .I1(n1407), .I0(\register2<7> ) );
    NAND2 U1296 ( .O(n1561), .I1(n2293), .I0(n2294) );
    FDCE \register8_reg<12>  ( .Q(\register8<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<13>  ( .Q(\register8<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1297 ( .O(n2296), .I1(n1400), .I0(\register9<7> ) );
    NAND2 U1298 ( .O(n2295), .I1(n1401), .I0(\register8<7> ) );
    NAND2 U1299 ( .O(n1564), .I1(n2295), .I0(n2296) );
    NAND2 U1300 ( .O(n2298), .I1(n1402), .I0(\register7<7> ) );
    NAND2 U1301 ( .O(n2297), .I1(n1403), .I0(\register6<7> ) );
    NAND2 U1302 ( .O(n1563), .I1(n2297), .I0(n2298) );
    FDCE \register8_reg<10>  ( .Q(\register8<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<11>  ( .Q(\register8<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1303 ( .O(n2300), .I1(n1396), .I0(\register13<7> ) );
    NAND2 U1304 ( .O(n2299), .I1(n1397), .I0(\register12<7> ) );
    NAND2 U1305 ( .O(n1566), .I1(n2299), .I0(n2300) );
    NAND2 U1306 ( .O(n2302), .I1(n1398), .I0(\register11<7> ) );
    NAND2 U1307 ( .O(n2301), .I1(n1399), .I0(\register10<7> ) );
    NAND2 U1308 ( .O(n1565), .I1(n2301), .I0(n2302) );
    FDCE \register8_reg<8>  ( .Q(\register8<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<9>  ( .Q(\register8<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1309 ( .O(n2304), .I1(n1408), .I0(\register1<6> ) );
    NAND2 U1310 ( .O(n2303), .I1(n1409), .I0(\register0<6> ) );
    NAND2 U1311 ( .O(n1568), .I1(n2303), .I0(n2304) );
    NAND2 U1312 ( .O(n2306), .I1(n1394), .I0(\register15<7> ) );
    NAND2 U1313 ( .O(n2305), .I1(n1395), .I0(\register14<7> ) );
    NAND2 U1314 ( .O(n1567), .I1(n2305), .I0(n2306) );
    FDCE \register8_reg<6>  ( .Q(\register8<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<7>  ( .Q(\register8<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1315 ( .O(n2308), .I1(n1404), .I0(\register5<6> ) );
    NAND2 U1316 ( .O(n2307), .I1(n1405), .I0(\register4<6> ) );
    NAND2 U1317 ( .O(n1570), .I1(n2307), .I0(n2308) );
    NAND2 U1318 ( .O(n2310), .I1(n1406), .I0(\register3<6> ) );
    NAND2 U1319 ( .O(n2309), .I1(n1407), .I0(\register2<6> ) );
    NAND2 U1320 ( .O(n1569), .I1(n2309), .I0(n2310) );
    FDCE \register8_reg<4>  ( .Q(\register8<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<5>  ( .Q(\register8<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1321 ( .O(n2312), .I1(n1400), .I0(\register9<6> ) );
    NAND2 U1322 ( .O(n2311), .I1(n1401), .I0(\register8<6> ) );
    NAND2 U1323 ( .O(n1572), .I1(n2311), .I0(n2312) );
    NAND2 U1324 ( .O(n2314), .I1(n1402), .I0(\register7<6> ) );
    NAND2 U1325 ( .O(n2313), .I1(n1403), .I0(\register6<6> ) );
    NAND2 U1326 ( .O(n1571), .I1(n2313), .I0(n2314) );
    FDCE \register8_reg<2>  ( .Q(\register8<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<3>  ( .Q(\register8<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1327 ( .O(n2316), .I1(n1396), .I0(\register13<6> ) );
    NAND2 U1328 ( .O(n2315), .I1(n1397), .I0(\register12<6> ) );
    NAND2 U1329 ( .O(n1574), .I1(n2315), .I0(n2316) );
    NAND2 U1330 ( .O(n2318), .I1(n1398), .I0(\register11<6> ) );
    NAND2 U1331 ( .O(n2317), .I1(n1399), .I0(\register10<6> ) );
    NAND2 U1332 ( .O(n1573), .I1(n2317), .I0(n2318) );
    FDCE \register8_reg<0>  ( .Q(\register8<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    FDCE \register8_reg<1>  ( .Q(\register8<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_1933), .CLR(regstore_reset) );
    NAND2 U1333 ( .O(n2320), .I1(n1395), .I0(\register14<5> ) );
    NAND2 U1334 ( .O(n2319), .I1(n1409), .I0(\register0<5> ) );
    NAND2 U1335 ( .O(n1576), .I1(n2319), .I0(n2320) );
    NAND2 U1336 ( .O(n2322), .I1(n1394), .I0(\register15<6> ) );
    NAND2 U1337 ( .O(n2321), .I1(n1395), .I0(\register14<6> ) );
    NAND2 U1338 ( .O(n1575), .I1(n2321), .I0(n2322) );
    FDCE \register9_reg<14>  ( .Q(\register9<14> ), .D(\regwr<14> ), .C(wr_clk
        ), .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<15>  ( .Q(\register9<15> ), .D(\regwr<15> ), .C(wr_clk
        ), .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1339 ( .O(n2324), .I1(n1405), .I0(\register4<5> ) );
    NAND2 U1340 ( .O(n2323), .I1(n1406), .I0(\register3<5> ) );
    NAND2 U1341 ( .O(n1578), .I1(n2323), .I0(n2324) );
    NAND2 U1342 ( .O(n2326), .I1(n1407), .I0(\register2<5> ) );
    NAND2 U1343 ( .O(n2325), .I1(n1408), .I0(\register1<5> ) );
    NAND2 U1344 ( .O(n1577), .I1(n2325), .I0(n2326) );
    FDCE \register9_reg<12>  ( .Q(\register9<12> ), .D(\regwr<12> ), .C(wr_clk
        ), .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<13>  ( .Q(\register9<13> ), .D(\regwr<13> ), .C(wr_clk
        ), .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1345 ( .O(n2328), .I1(n1401), .I0(\register8<5> ) );
    NAND2 U1346 ( .O(n2327), .I1(n1402), .I0(\register7<5> ) );
    NAND2 U1347 ( .O(n1580), .I1(n2327), .I0(n2328) );
    NAND2 U1348 ( .O(n2330), .I1(n1403), .I0(\register6<5> ) );
    NAND2 U1349 ( .O(n2329), .I1(n1404), .I0(\register5<5> ) );
    NAND2 U1350 ( .O(n1579), .I1(n2329), .I0(n2330) );
    FDCE \register9_reg<10>  ( .Q(\register9<10> ), .D(\regwr<10> ), .C(wr_clk
        ), .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<11>  ( .Q(\register9<11> ), .D(\regwr<11> ), .C(wr_clk
        ), .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1351 ( .O(n2332), .I1(n1397), .I0(\register12<5> ) );
    NAND2 U1352 ( .O(n2331), .I1(n1398), .I0(\register11<5> ) );
    NAND2 U1353 ( .O(n1582), .I1(n2331), .I0(n2332) );
    NAND2 U1354 ( .O(n2334), .I1(n1399), .I0(\register10<5> ) );
    NAND2 U1355 ( .O(n2333), .I1(n1400), .I0(\register9<5> ) );
    NAND2 U1356 ( .O(n1581), .I1(n2333), .I0(n2334) );
    FDCE \register9_reg<8>  ( .Q(\register9<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<9>  ( .Q(\register9<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1357 ( .O(n2336), .I1(n1395), .I0(\register14<4> ) );
    NAND2 U1358 ( .O(n2335), .I1(n1409), .I0(\register0<4> ) );
    NAND2 U1359 ( .O(n1584), .I1(n2335), .I0(n2336) );
    NAND2 U1360 ( .O(n2338), .I1(n1394), .I0(\register15<5> ) );
    NAND2 U1361 ( .O(n2337), .I1(n1396), .I0(\register13<5> ) );
    NAND2 U1362 ( .O(n1583), .I1(n2337), .I0(n2338) );
    FDCE \register9_reg<6>  ( .Q(\register9<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<7>  ( .Q(\register9<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1363 ( .O(n2340), .I1(n1405), .I0(\register4<4> ) );
    NAND2 U1364 ( .O(n2339), .I1(n1406), .I0(\register3<4> ) );
    NAND2 U1365 ( .O(n1586), .I1(n2339), .I0(n2340) );
    NAND2 U1366 ( .O(n2342), .I1(n1407), .I0(\register2<4> ) );
    NAND2 U1367 ( .O(n2341), .I1(n1408), .I0(\register1<4> ) );
    NAND2 U1368 ( .O(n1585), .I1(n2341), .I0(n2342) );
    FDCE \register9_reg<4>  ( .Q(\register9<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<5>  ( .Q(\register9<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1369 ( .O(n2344), .I1(n1401), .I0(\register8<4> ) );
    NAND2 U1370 ( .O(n2343), .I1(n1402), .I0(\register7<4> ) );
    NAND2 U1371 ( .O(n1588), .I1(n2343), .I0(n2344) );
    NAND2 U1372 ( .O(n2346), .I1(n1403), .I0(\register6<4> ) );
    NAND2 U1373 ( .O(n2345), .I1(n1404), .I0(\register5<4> ) );
    NAND2 U1374 ( .O(n1587), .I1(n2345), .I0(n2346) );
    FDCE \register9_reg<2>  ( .Q(\register9<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<3>  ( .Q(\register9<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1375 ( .O(n2348), .I1(n1397), .I0(\register12<4> ) );
    NAND2 U1376 ( .O(n2347), .I1(n1398), .I0(\register11<4> ) );
    NAND2 U1377 ( .O(n1590), .I1(n2347), .I0(n2348) );
    NAND2 U1378 ( .O(n2350), .I1(n1399), .I0(\register10<4> ) );
    NAND2 U1379 ( .O(n2349), .I1(n1400), .I0(\register9<4> ) );
    NAND2 U1380 ( .O(n1589), .I1(n2349), .I0(n2350) );
    FDCE \register9_reg<0>  ( .Q(\register9<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    FDCE \register9_reg<1>  ( .Q(\register9<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_2029), .CLR(regstore_reset) );
    NAND2 U1381 ( .O(n2352), .I1(n1395), .I0(\register14<3> ) );
    NAND2 U1382 ( .O(n2351), .I1(n1409), .I0(\register0<3> ) );
    NAND2 U1383 ( .O(n1592), .I1(n2351), .I0(n2352) );
    NAND2 U1384 ( .O(n2354), .I1(n1394), .I0(\register15<4> ) );
    NAND2 U1385 ( .O(n2353), .I1(n1396), .I0(\register13<4> ) );
    NAND2 U1386 ( .O(n1591), .I1(n2353), .I0(n2354) );
    FDCE \register10_reg<14>  ( .Q(\register10<14> ), .D(\regwr<14> ), .C(
        wr_clk), .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<15>  ( .Q(\register10<15> ), .D(\regwr<15> ), .C(
        wr_clk), .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1387 ( .O(n2356), .I1(n1405), .I0(\register4<3> ) );
    NAND2 U1388 ( .O(n2355), .I1(n1406), .I0(\register3<3> ) );
    NAND2 U1389 ( .O(n1594), .I1(n2355), .I0(n2356) );
    NAND2 U1390 ( .O(n2358), .I1(n1407), .I0(\register2<3> ) );
    NAND2 U1391 ( .O(n2357), .I1(n1408), .I0(\register1<3> ) );
    NAND2 U1392 ( .O(n1593), .I1(n2357), .I0(n2358) );
    FDCE \register10_reg<12>  ( .Q(\register10<12> ), .D(\regwr<12> ), .C(
        wr_clk), .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<13>  ( .Q(\register10<13> ), .D(\regwr<13> ), .C(
        wr_clk), .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1393 ( .O(n2360), .I1(n1401), .I0(\register8<3> ) );
    NAND2 U1394 ( .O(n2359), .I1(n1402), .I0(\register7<3> ) );
    NAND2 U1395 ( .O(n1596), .I1(n2359), .I0(n2360) );
    NAND2 U1396 ( .O(n2362), .I1(n1403), .I0(\register6<3> ) );
    NAND2 U1397 ( .O(n2361), .I1(n1404), .I0(\register5<3> ) );
    NAND2 U1398 ( .O(n1595), .I1(n2361), .I0(n2362) );
    FDCE \register10_reg<10>  ( .Q(\register10<10> ), .D(\regwr<10> ), .C(
        wr_clk), .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<11>  ( .Q(\register10<11> ), .D(\regwr<11> ), .C(
        wr_clk), .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1399 ( .O(n2364), .I1(n1397), .I0(\register12<3> ) );
    NAND2 U1400 ( .O(n2363), .I1(n1398), .I0(\register11<3> ) );
    NAND2 U1401 ( .O(n1598), .I1(n2363), .I0(n2364) );
    NAND2 U1402 ( .O(n2366), .I1(n1399), .I0(\register10<3> ) );
    NAND2 U1403 ( .O(n2365), .I1(n1400), .I0(\register9<3> ) );
    NAND2 U1404 ( .O(n1597), .I1(n2365), .I0(n2366) );
    FDCE \register10_reg<8>  ( .Q(\register10<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<9>  ( .Q(\register10<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1405 ( .O(n2368), .I1(n1395), .I0(\register14<2> ) );
    NAND2 U1406 ( .O(n2367), .I1(n1409), .I0(\register0<2> ) );
    NAND2 U1407 ( .O(n1600), .I1(n2367), .I0(n2368) );
    NAND2 U1408 ( .O(n2370), .I1(n1394), .I0(\register15<3> ) );
    NAND2 U1409 ( .O(n2369), .I1(n1396), .I0(\register13<3> ) );
    NAND2 U1410 ( .O(n1599), .I1(n2369), .I0(n2370) );
    FDCE \register10_reg<6>  ( .Q(\register10<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<7>  ( .Q(\register10<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1411 ( .O(n2372), .I1(n1405), .I0(\register4<2> ) );
    NAND2 U1412 ( .O(n2371), .I1(n1406), .I0(\register3<2> ) );
    NAND2 U1413 ( .O(n1602), .I1(n2371), .I0(n2372) );
    NAND2 U1414 ( .O(n2374), .I1(n1407), .I0(\register2<2> ) );
    NAND2 U1415 ( .O(n2373), .I1(n1408), .I0(\register1<2> ) );
    NAND2 U1416 ( .O(n1601), .I1(n2373), .I0(n2374) );
    FDCE \register10_reg<4>  ( .Q(\register10<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<5>  ( .Q(\register10<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1417 ( .O(n2376), .I1(n1401), .I0(\register8<2> ) );
    NAND2 U1418 ( .O(n2375), .I1(n1402), .I0(\register7<2> ) );
    NAND2 U1419 ( .O(n1604), .I1(n2375), .I0(n2376) );
    NAND2 U1420 ( .O(n2378), .I1(n1403), .I0(\register6<2> ) );
    NAND2 U1421 ( .O(n2377), .I1(n1404), .I0(\register5<2> ) );
    NAND2 U1422 ( .O(n1603), .I1(n2377), .I0(n2378) );
    FDCE \register10_reg<2>  ( .Q(\register10<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<3>  ( .Q(\register10<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1423 ( .O(n2380), .I1(n1397), .I0(\register12<2> ) );
    NAND2 U1424 ( .O(n2379), .I1(n1398), .I0(\register11<2> ) );
    NAND2 U1425 ( .O(n1606), .I1(n2379), .I0(n2380) );
    NAND2 U1426 ( .O(n2382), .I1(n1399), .I0(\register10<2> ) );
    NAND2 U1427 ( .O(n2381), .I1(n1400), .I0(\register9<2> ) );
    NAND2 U1428 ( .O(n1605), .I1(n2381), .I0(n2382) );
    FDCE \register10_reg<0>  ( .Q(\register10<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    FDCE \register10_reg<1>  ( .Q(\register10<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_2125), .CLR(regstore_reset) );
    NAND2 U1429 ( .O(n2384), .I1(n1395), .I0(\register14<1> ) );
    NAND2 U1430 ( .O(n2383), .I1(n1409), .I0(\register0<1> ) );
    NAND2 U1431 ( .O(n1608), .I1(n2383), .I0(n2384) );
    NAND2 U1432 ( .O(n2386), .I1(n1394), .I0(\register15<2> ) );
    NAND2 U1433 ( .O(n2385), .I1(n1396), .I0(\register13<2> ) );
    NAND2 U1434 ( .O(n1607), .I1(n2385), .I0(n2386) );
    FDCE \register11_reg<14>  ( .Q(\register11<14> ), .D(\regwr<14> ), .C(
        wr_clk), .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<15>  ( .Q(\register11<15> ), .D(\regwr<15> ), .C(
        wr_clk), .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1435 ( .O(n2388), .I1(n1405), .I0(\register4<1> ) );
    NAND2 U1436 ( .O(n2387), .I1(n1406), .I0(\register3<1> ) );
    NAND2 U1437 ( .O(n1610), .I1(n2387), .I0(n2388) );
    NAND2 U1438 ( .O(n2390), .I1(n1407), .I0(\register2<1> ) );
    NAND2 U1439 ( .O(n2389), .I1(n1408), .I0(\register1<1> ) );
    NAND2 U1440 ( .O(n1609), .I1(n2389), .I0(n2390) );
    FDCE \register11_reg<12>  ( .Q(\register11<12> ), .D(\regwr<12> ), .C(
        wr_clk), .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<13>  ( .Q(\register11<13> ), .D(\regwr<13> ), .C(
        wr_clk), .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1441 ( .O(n2392), .I1(n1401), .I0(\register8<1> ) );
    NAND2 U1442 ( .O(n2391), .I1(n1402), .I0(\register7<1> ) );
    NAND2 U1443 ( .O(n1612), .I1(n2391), .I0(n2392) );
    NAND2 U1444 ( .O(n2394), .I1(n1403), .I0(\register6<1> ) );
    NAND2 U1445 ( .O(n2393), .I1(n1404), .I0(\register5<1> ) );
    NAND2 U1446 ( .O(n1611), .I1(n2393), .I0(n2394) );
    FDCE \register11_reg<10>  ( .Q(\register11<10> ), .D(\regwr<10> ), .C(
        wr_clk), .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<11>  ( .Q(\register11<11> ), .D(\regwr<11> ), .C(
        wr_clk), .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1447 ( .O(n2396), .I1(n1397), .I0(\register12<1> ) );
    NAND2 U1448 ( .O(n2395), .I1(n1398), .I0(\register11<1> ) );
    NAND2 U1449 ( .O(n1614), .I1(n2395), .I0(n2396) );
    NAND2 U1450 ( .O(n2398), .I1(n1399), .I0(\register10<1> ) );
    NAND2 U1451 ( .O(n2397), .I1(n1400), .I0(\register9<1> ) );
    NAND2 U1452 ( .O(n1613), .I1(n2397), .I0(n2398) );
    FDCE \register11_reg<8>  ( .Q(\register11<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<9>  ( .Q(\register11<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1453 ( .O(n2400), .I1(n1408), .I0(\register1<15> ) );
    NAND2 U1454 ( .O(n2399), .I1(n1409), .I0(\register0<15> ) );
    NAND2 U1455 ( .O(n1616), .I1(n2399), .I0(n2400) );
    NAND2 U1456 ( .O(n2402), .I1(n1394), .I0(\register15<1> ) );
    NAND2 U1457 ( .O(n2401), .I1(n1396), .I0(\register13<1> ) );
    NAND2 U1458 ( .O(n1615), .I1(n2401), .I0(n2402) );
    FDCE \register11_reg<6>  ( .Q(\register11<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<7>  ( .Q(\register11<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1459 ( .O(n2404), .I1(n1404), .I0(\register5<15> ) );
    NAND2 U1460 ( .O(n2403), .I1(n1405), .I0(\register4<15> ) );
    NAND2 U1461 ( .O(n1618), .I1(n2403), .I0(n2404) );
    NAND2 U1462 ( .O(n2406), .I1(n1406), .I0(\register3<15> ) );
    NAND2 U1463 ( .O(n2405), .I1(n1407), .I0(\register2<15> ) );
    NAND2 U1464 ( .O(n1617), .I1(n2405), .I0(n2406) );
    FDCE \register11_reg<4>  ( .Q(\register11<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<5>  ( .Q(\register11<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1465 ( .O(n2408), .I1(n1400), .I0(\register9<15> ) );
    NAND2 U1466 ( .O(n2407), .I1(n1401), .I0(\register8<15> ) );
    NAND2 U1467 ( .O(n1620), .I1(n2407), .I0(n2408) );
    NAND2 U1468 ( .O(n2410), .I1(n1402), .I0(\register7<15> ) );
    NAND2 U1469 ( .O(n2409), .I1(n1403), .I0(\register6<15> ) );
    NAND2 U1470 ( .O(n1619), .I1(n2409), .I0(n2410) );
    FDCE \register11_reg<2>  ( .Q(\register11<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<3>  ( .Q(\register11<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1471 ( .O(n2412), .I1(n1396), .I0(\register13<15> ) );
    NAND2 U1472 ( .O(n2411), .I1(n1397), .I0(\register12<15> ) );
    NAND2 U1473 ( .O(n1622), .I1(n2411), .I0(n2412) );
    NAND2 U1474 ( .O(n2414), .I1(n1398), .I0(\register11<15> ) );
    NAND2 U1475 ( .O(n2413), .I1(n1399), .I0(\register10<15> ) );
    NAND2 U1476 ( .O(n1621), .I1(n2413), .I0(n2414) );
    FDCE \register11_reg<0>  ( .Q(\register11<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    FDCE \register11_reg<1>  ( .Q(\register11<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_2221), .CLR(regstore_reset) );
    NAND2 U1477 ( .O(n2416), .I1(n1408), .I0(\register1<14> ) );
    NAND2 U1478 ( .O(n2415), .I1(n1409), .I0(\register0<14> ) );
    NAND2 U1479 ( .O(n1624), .I1(n2415), .I0(n2416) );
    NAND2 U1480 ( .O(n2418), .I1(n1394), .I0(\register15<15> ) );
    NAND2 U1481 ( .O(n2417), .I1(n1395), .I0(\register14<15> ) );
    NAND2 U1482 ( .O(n1623), .I1(n2417), .I0(n2418) );
    FDCE \register12_reg<14>  ( .Q(\register12<14> ), .D(\regwr<14> ), .C(
        wr_clk), .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<15>  ( .Q(\register12<15> ), .D(\regwr<15> ), .C(
        wr_clk), .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1483 ( .O(n2420), .I1(n1404), .I0(\register5<14> ) );
    NAND2 U1484 ( .O(n2419), .I1(n1405), .I0(\register4<14> ) );
    NAND2 U1485 ( .O(n1626), .I1(n2419), .I0(n2420) );
    NAND2 U1486 ( .O(n2422), .I1(n1406), .I0(\register3<14> ) );
    NAND2 U1487 ( .O(n2421), .I1(n1407), .I0(\register2<14> ) );
    NAND2 U1488 ( .O(n1625), .I1(n2421), .I0(n2422) );
    FDCE \register12_reg<12>  ( .Q(\register12<12> ), .D(\regwr<12> ), .C(
        wr_clk), .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<13>  ( .Q(\register12<13> ), .D(\regwr<13> ), .C(
        wr_clk), .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1489 ( .O(n2424), .I1(n1400), .I0(\register9<14> ) );
    NAND2 U1490 ( .O(n2423), .I1(n1401), .I0(\register8<14> ) );
    NAND2 U1491 ( .O(n1628), .I1(n2423), .I0(n2424) );
    NAND2 U1492 ( .O(n2426), .I1(n1402), .I0(\register7<14> ) );
    NAND2 U1493 ( .O(n2425), .I1(n1403), .I0(\register6<14> ) );
    NAND2 U1494 ( .O(n1627), .I1(n2425), .I0(n2426) );
    FDCE \register12_reg<10>  ( .Q(\register12<10> ), .D(\regwr<10> ), .C(
        wr_clk), .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<11>  ( .Q(\register12<11> ), .D(\regwr<11> ), .C(
        wr_clk), .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1495 ( .O(n2428), .I1(n1396), .I0(\register13<14> ) );
    NAND2 U1496 ( .O(n2427), .I1(n1397), .I0(\register12<14> ) );
    NAND2 U1497 ( .O(n1630), .I1(n2427), .I0(n2428) );
    NAND2 U1498 ( .O(n2430), .I1(n1398), .I0(\register11<14> ) );
    NAND2 U1499 ( .O(n2429), .I1(n1399), .I0(\register10<14> ) );
    NAND2 U1500 ( .O(n1629), .I1(n2429), .I0(n2430) );
    FDCE \register12_reg<8>  ( .Q(\register12<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<9>  ( .Q(\register12<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1501 ( .O(n2432), .I1(n1408), .I0(\register1<13> ) );
    NAND2 U1502 ( .O(n2431), .I1(n1409), .I0(\register0<13> ) );
    NAND2 U1503 ( .O(n1632), .I1(n2431), .I0(n2432) );
    NAND2 U1504 ( .O(n2434), .I1(n1394), .I0(\register15<14> ) );
    NAND2 U1505 ( .O(n2433), .I1(n1395), .I0(\register14<14> ) );
    NAND2 U1506 ( .O(n1631), .I1(n2433), .I0(n2434) );
    FDCE \register12_reg<6>  ( .Q(\register12<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<7>  ( .Q(\register12<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1507 ( .O(n2436), .I1(n1404), .I0(\register5<13> ) );
    NAND2 U1508 ( .O(n2435), .I1(n1405), .I0(\register4<13> ) );
    NAND2 U1509 ( .O(n1634), .I1(n2435), .I0(n2436) );
    NAND2 U1510 ( .O(n2438), .I1(n1406), .I0(\register3<13> ) );
    NAND2 U1511 ( .O(n2437), .I1(n1407), .I0(\register2<13> ) );
    NAND2 U1512 ( .O(n1633), .I1(n2437), .I0(n2438) );
    FDCE \register12_reg<4>  ( .Q(\register12<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<5>  ( .Q(\register12<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1513 ( .O(n2440), .I1(n1400), .I0(\register9<13> ) );
    NAND2 U1514 ( .O(n2439), .I1(n1401), .I0(\register8<13> ) );
    NAND2 U1515 ( .O(n1636), .I1(n2439), .I0(n2440) );
    NAND2 U1516 ( .O(n2442), .I1(n1402), .I0(\register7<13> ) );
    NAND2 U1517 ( .O(n2441), .I1(n1403), .I0(\register6<13> ) );
    NAND2 U1518 ( .O(n1635), .I1(n2441), .I0(n2442) );
    FDCE \register12_reg<2>  ( .Q(\register12<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<3>  ( .Q(\register12<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1519 ( .O(n2444), .I1(n1396), .I0(\register13<13> ) );
    NAND2 U1520 ( .O(n2443), .I1(n1397), .I0(\register12<13> ) );
    NAND2 U1521 ( .O(n1638), .I1(n2443), .I0(n2444) );
    NAND2 U1522 ( .O(n2446), .I1(n1398), .I0(\register11<13> ) );
    NAND2 U1523 ( .O(n2445), .I1(n1399), .I0(\register10<13> ) );
    NAND2 U1524 ( .O(n1637), .I1(n2445), .I0(n2446) );
    FDCE \register12_reg<0>  ( .Q(\register12<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    FDCE \register12_reg<1>  ( .Q(\register12<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_2317), .CLR(regstore_reset) );
    NAND2 U1525 ( .O(n2448), .I1(n1408), .I0(\register1<12> ) );
    NAND2 U1526 ( .O(n2447), .I1(n1409), .I0(\register0<12> ) );
    NAND2 U1527 ( .O(n1640), .I1(n2447), .I0(n2448) );
    NAND2 U1528 ( .O(n2450), .I1(n1394), .I0(\register15<13> ) );
    NAND2 U1529 ( .O(n2449), .I1(n1395), .I0(\register14<13> ) );
    NAND2 U1530 ( .O(n1639), .I1(n2449), .I0(n2450) );
    FDCE \register13_reg<14>  ( .Q(\register13<14> ), .D(\regwr<14> ), .C(
        wr_clk), .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<15>  ( .Q(\register13<15> ), .D(\regwr<15> ), .C(
        wr_clk), .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1531 ( .O(n2452), .I1(n1404), .I0(\register5<12> ) );
    NAND2 U1532 ( .O(n2451), .I1(n1405), .I0(\register4<12> ) );
    NAND2 U1533 ( .O(n1642), .I1(n2451), .I0(n2452) );
    NAND2 U1534 ( .O(n2454), .I1(n1406), .I0(\register3<12> ) );
    NAND2 U1535 ( .O(n2453), .I1(n1407), .I0(\register2<12> ) );
    NAND2 U1536 ( .O(n1641), .I1(n2453), .I0(n2454) );
    FDCE \register13_reg<12>  ( .Q(\register13<12> ), .D(\regwr<12> ), .C(
        wr_clk), .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<13>  ( .Q(\register13<13> ), .D(\regwr<13> ), .C(
        wr_clk), .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1537 ( .O(n2456), .I1(n1400), .I0(\register9<12> ) );
    NAND2 U1538 ( .O(n2455), .I1(n1401), .I0(\register8<12> ) );
    NAND2 U1539 ( .O(n1644), .I1(n2455), .I0(n2456) );
    NAND2 U1540 ( .O(n2458), .I1(n1402), .I0(\register7<12> ) );
    NAND2 U1541 ( .O(n2457), .I1(n1403), .I0(\register6<12> ) );
    NAND2 U1542 ( .O(n1643), .I1(n2457), .I0(n2458) );
    FDCE \register13_reg<10>  ( .Q(\register13<10> ), .D(\regwr<10> ), .C(
        wr_clk), .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<11>  ( .Q(\register13<11> ), .D(\regwr<11> ), .C(
        wr_clk), .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1543 ( .O(n2460), .I1(n1396), .I0(\register13<12> ) );
    NAND2 U1544 ( .O(n2459), .I1(n1397), .I0(\register12<12> ) );
    NAND2 U1545 ( .O(n1646), .I1(n2459), .I0(n2460) );
    NAND2 U1546 ( .O(n2462), .I1(n1398), .I0(\register11<12> ) );
    NAND2 U1547 ( .O(n2461), .I1(n1399), .I0(\register10<12> ) );
    NAND2 U1548 ( .O(n1645), .I1(n2461), .I0(n2462) );
    FDCE \register13_reg<8>  ( .Q(\register13<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<9>  ( .Q(\register13<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1549 ( .O(n2464), .I1(n1408), .I0(\register1<11> ) );
    NAND2 U1550 ( .O(n2463), .I1(n1409), .I0(\register0<11> ) );
    NAND2 U1551 ( .O(n1648), .I1(n2463), .I0(n2464) );
    NAND2 U1552 ( .O(n2466), .I1(n1394), .I0(\register15<12> ) );
    NAND2 U1553 ( .O(n2465), .I1(n1395), .I0(\register14<12> ) );
    NAND2 U1554 ( .O(n1647), .I1(n2465), .I0(n2466) );
    FDCE \register13_reg<6>  ( .Q(\register13<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<7>  ( .Q(\register13<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1555 ( .O(n2468), .I1(n1404), .I0(\register5<11> ) );
    NAND2 U1556 ( .O(n2467), .I1(n1405), .I0(\register4<11> ) );
    NAND2 U1557 ( .O(n1650), .I1(n2467), .I0(n2468) );
    NAND2 U1558 ( .O(n2470), .I1(n1406), .I0(\register3<11> ) );
    NAND2 U1559 ( .O(n2469), .I1(n1407), .I0(\register2<11> ) );
    NAND2 U1560 ( .O(n1649), .I1(n2469), .I0(n2470) );
    FDCE \register13_reg<4>  ( .Q(\register13<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<5>  ( .Q(\register13<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1561 ( .O(n2472), .I1(n1400), .I0(\register9<11> ) );
    NAND2 U1562 ( .O(n2471), .I1(n1401), .I0(\register8<11> ) );
    NAND2 U1563 ( .O(n1652), .I1(n2471), .I0(n2472) );
    NAND2 U1564 ( .O(n2474), .I1(n1402), .I0(\register7<11> ) );
    NAND2 U1565 ( .O(n2473), .I1(n1403), .I0(\register6<11> ) );
    NAND2 U1566 ( .O(n1651), .I1(n2473), .I0(n2474) );
    FDCE \register13_reg<2>  ( .Q(\register13<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<3>  ( .Q(\register13<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1567 ( .O(n2476), .I1(n1396), .I0(\register13<11> ) );
    NAND2 U1568 ( .O(n2475), .I1(n1397), .I0(\register12<11> ) );
    NAND2 U1569 ( .O(n1654), .I1(n2475), .I0(n2476) );
    NAND2 U1570 ( .O(n2478), .I1(n1398), .I0(\register11<11> ) );
    NAND2 U1571 ( .O(n2477), .I1(n1399), .I0(\register10<11> ) );
    NAND2 U1572 ( .O(n1653), .I1(n2477), .I0(n2478) );
    FDCE \register13_reg<0>  ( .Q(\register13<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    FDCE \register13_reg<1>  ( .Q(\register13<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_2413), .CLR(regstore_reset) );
    NAND2 U1573 ( .O(n2480), .I1(n1408), .I0(\register1<10> ) );
    NAND2 U1574 ( .O(n2479), .I1(n1409), .I0(\register0<10> ) );
    NAND2 U1575 ( .O(n1656), .I1(n2479), .I0(n2480) );
    NAND2 U1576 ( .O(n2482), .I1(n1394), .I0(\register15<11> ) );
    NAND2 U1577 ( .O(n2481), .I1(n1395), .I0(\register14<11> ) );
    NAND2 U1578 ( .O(n1655), .I1(n2481), .I0(n2482) );
    FDCE \register15_reg<8>  ( .Q(\register15<8> ), .D(\regwr<8> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    FDCE \register15_reg<1>  ( .Q(\register15<1> ), .D(\regwr<1> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    NAND2 U1579 ( .O(n2484), .I1(n1404), .I0(\register5<10> ) );
    NAND2 U1580 ( .O(n2483), .I1(n1405), .I0(\register4<10> ) );
    NAND2 U1581 ( .O(n1658), .I1(n2483), .I0(n2484) );
    NAND2 U1582 ( .O(n2486), .I1(n1406), .I0(\register3<10> ) );
    NAND2 U1583 ( .O(n2485), .I1(n1407), .I0(\register2<10> ) );
    NAND2 U1584 ( .O(n1657), .I1(n2485), .I0(n2486) );
    FDCE \register15_reg<7>  ( .Q(\register15<7> ), .D(\regwr<7> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    FDCE \register15_reg<5>  ( .Q(\register15<5> ), .D(\regwr<5> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    NAND2 U1585 ( .O(n2488), .I1(n1400), .I0(\register9<10> ) );
    NAND2 U1586 ( .O(n2487), .I1(n1401), .I0(\register8<10> ) );
    NAND2 U1587 ( .O(n1660), .I1(n2487), .I0(n2488) );
    NAND2 U1588 ( .O(n2490), .I1(n1402), .I0(\register7<10> ) );
    NAND2 U1589 ( .O(n2489), .I1(n1403), .I0(\register6<10> ) );
    NAND2 U1590 ( .O(n1659), .I1(n2489), .I0(n2490) );
    FDCE \register15_reg<12>  ( .Q(\register15<12> ), .D(\regwr<12> ), .C(
        wr_clk), .CE(n_2590), .CLR(regstore_reset) );
    FDCE \register15_reg<3>  ( .Q(\register15<3> ), .D(\regwr<3> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    NAND2 U1591 ( .O(n2492), .I1(n1396), .I0(\register13<10> ) );
    NAND2 U1592 ( .O(n2491), .I1(n1397), .I0(\register12<10> ) );
    NAND2 U1593 ( .O(n1662), .I1(n2491), .I0(n2492) );
    NAND2 U1594 ( .O(n2494), .I1(n1398), .I0(\register11<10> ) );
    NAND2 U1595 ( .O(n2493), .I1(n1399), .I0(\register10<10> ) );
    NAND2 U1596 ( .O(n1661), .I1(n2493), .I0(n2494) );
    FDCE \register15_reg<10>  ( .Q(\register15<10> ), .D(\regwr<10> ), .C(
        wr_clk), .CE(n_2590), .CLR(regstore_reset) );
    FDCE \register15_reg<14>  ( .Q(\register15<14> ), .D(\regwr<14> ), .C(
        wr_clk), .CE(n_2590), .CLR(regstore_reset) );
    NAND2 U1597 ( .O(n2496), .I1(n1395), .I0(\register14<0> ) );
    NAND2 U1598 ( .O(n2495), .I1(n1409), .I0(\register0<0> ) );
    NAND2 U1599 ( .O(n1664), .I1(n2495), .I0(n2496) );
    NAND2 U1600 ( .O(n2498), .I1(n1394), .I0(\register15<10> ) );
    NAND2 U1601 ( .O(n2497), .I1(n1395), .I0(\register14<10> ) );
    NAND2 U1602 ( .O(n1663), .I1(n2497), .I0(n2498) );
    FDPE \register15_reg<15>  ( .Q(\register15<15> ), .D(\regwr<15> ), .C(
        wr_clk), .CE(n_2590), .PRE(regstore_reset) );
    FDCE \register15_reg<11>  ( .Q(\register15<11> ), .D(\regwr<11> ), .C(
        wr_clk), .CE(n_2590), .CLR(regstore_reset) );
    NAND2 U1603 ( .O(n2500), .I1(n1405), .I0(\register4<0> ) );
    NAND2 U1604 ( .O(n2499), .I1(n1406), .I0(\register3<0> ) );
    NAND2 U1605 ( .O(n1666), .I1(n2499), .I0(n2500) );
    NAND2 U1606 ( .O(n2502), .I1(n1407), .I0(\register2<0> ) );
    NAND2 U1607 ( .O(n2501), .I1(n1408), .I0(\register1<0> ) );
    NAND2 U1608 ( .O(n1665), .I1(n2501), .I0(n2502) );
    FDCE \register15_reg<2>  ( .Q(\register15<2> ), .D(\regwr<2> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    FDCE \register15_reg<13>  ( .Q(\register15<13> ), .D(\regwr<13> ), .C(
        wr_clk), .CE(n_2590), .CLR(regstore_reset) );
    NAND2 U1609 ( .O(n2504), .I1(n1401), .I0(\register8<0> ) );
    NAND2 U1610 ( .O(n2503), .I1(n1402), .I0(\register7<0> ) );
    NAND2 U1611 ( .O(n1668), .I1(n2503), .I0(n2504) );
    NAND2 U1612 ( .O(n2506), .I1(n1403), .I0(\register6<0> ) );
    NAND2 U1613 ( .O(n2505), .I1(n1404), .I0(\register5<0> ) );
    NAND2 U1614 ( .O(n1667), .I1(n2505), .I0(n2506) );
    FDCE \register15_reg<4>  ( .Q(\register15<4> ), .D(\regwr<4> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    FDCE \register15_reg<6>  ( .Q(\register15<6> ), .D(\regwr<6> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    NAND2 U1615 ( .O(n2508), .I1(n1397), .I0(\register12<0> ) );
    NAND2 U1616 ( .O(n2507), .I1(n1398), .I0(\register11<0> ) );
    NAND2 U1617 ( .O(n1670), .I1(n2507), .I0(n2508) );
    NAND2 U1618 ( .O(n2510), .I1(n1399), .I0(\register10<0> ) );
    NAND2 U1619 ( .O(n2509), .I1(n1400), .I0(\register9<0> ) );
    NAND2 U1620 ( .O(n1669), .I1(n2509), .I0(n2510) );
    FDCE \register15_reg<9>  ( .Q(\register15<9> ), .D(\regwr<9> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    FDCE \register15_reg<0>  ( .Q(\register15<0> ), .D(\regwr<0> ), .C(wr_clk), 
        .CE(n_2590), .CLR(regstore_reset) );
    INV U1621 ( .O(n2511), .I(\register14215<5> ) );
    OR2 U1622 ( .O(n2513), .I1(regstore_reset), .I0(n2511) );
    NAND2 U1623 ( .O(n2512), .I1(regstore_reset), .I0(alu_flags2[5]) );
    NAND2 U1624 ( .O(n2517), .I1(n2512), .I0(n2513) );
    NAND2 U1625 ( .O(n2515), .I1(n1394), .I0(\register15<0> ) );
    NAND2 U1626 ( .O(n2514), .I1(n1396), .I0(\register13<0> ) );
    NAND2 U1627 ( .O(n1671), .I1(n2514), .I0(n2515) );
    FDC \alu_flags2_reg<5>  ( .Q(alu_flags2[5]), .D(n2517), .C(wr_clk), .CLR(
        1'b0) );
    NAND2 U1629 ( .O(n2519), .I1(n1384), .I0(\register9<9> ) );
    NAND2 U1630 ( .O(n2518), .I1(n1385), .I0(\register8<9> ) );
    NAND2 U1631 ( .O(n1420), .I1(n2518), .I0(n2519) );
    NAND2 U1632 ( .O(n2521), .I1(n1386), .I0(\register7<9> ) );
    NAND2 U1633 ( .O(n2520), .I1(n1387), .I0(\register6<9> ) );
    NAND2 U1634 ( .O(n1419), .I1(n2520), .I0(n2521) );
    NAND2 U1635 ( .O(n2523), .I1(n1388), .I0(\register5<9> ) );
    NAND2 U1636 ( .O(n2522), .I1(n1389), .I0(\register4<9> ) );
    NAND2 U1637 ( .O(n1418), .I1(n2522), .I0(n2523) );
    NAND2 U1638 ( .O(n2525), .I1(n1390), .I0(\register3<9> ) );
    NAND2 U1639 ( .O(n2524), .I1(n1391), .I0(\register2<9> ) );
    NAND2 U1640 ( .O(n1417), .I1(n2524), .I0(n2525) );
    NAND2 U1641 ( .O(n2527), .I1(n1392), .I0(\register1<9> ) );
    NAND2 U1642 ( .O(n2526), .I1(n1393), .I0(\register0<9> ) );
    NAND2 U1643 ( .O(n1416), .I1(n2526), .I0(n2527) );
    AND4 U1644 ( .O(n_2590), .I3(wr_addr[0]), .I2(wr_addr[1]), .I1(wr_addr[2]), 
        .I0(wr_addr[3]) );
    NOR4 U1645 ( .O(n1409), .I3(a_addr[0]), .I2(a_addr[1]), .I1(a_addr[2]), 
        .I0(a_addr[3]) );
    INV U1646 ( .O(n2528), .I(a_addr[0]) );
    NOR4 U1647 ( .O(n1408), .I3(n2528), .I2(a_addr[1]), .I1(a_addr[2]), .I0(
        a_addr[3]) );
    INV U1648 ( .O(n2529), .I(a_addr[1]) );
    NOR4 U1649 ( .O(n1407), .I3(n2529), .I2(a_addr[0]), .I1(a_addr[2]), .I0(
        a_addr[3]) );
    INV U1650 ( .O(n2530), .I(a_addr[0]) );
    INV U1651 ( .O(n2531), .I(a_addr[1]) );
    NOR4 U1652 ( .O(n1406), .I3(a_addr[3]), .I2(a_addr[2]), .I1(n2530), .I0(
        n2531) );
    INV U1653 ( .O(n2532), .I(a_addr[2]) );
    NOR4 U1654 ( .O(n1405), .I3(n2532), .I2(a_addr[0]), .I1(a_addr[1]), .I0(
        a_addr[3]) );
    INV U1655 ( .O(n2533), .I(a_addr[0]) );
    INV U1656 ( .O(n2534), .I(a_addr[2]) );
    NOR4 U1657 ( .O(n1404), .I3(a_addr[3]), .I2(a_addr[1]), .I1(n2533), .I0(
        n2534) );
    INV U1658 ( .O(n2535), .I(a_addr[1]) );
    INV U1659 ( .O(n2536), .I(a_addr[2]) );
    NOR4 U1660 ( .O(n1403), .I3(a_addr[3]), .I2(a_addr[0]), .I1(n2535), .I0(
        n2536) );
    INV U1661 ( .O(n2537), .I(a_addr[3]) );
    AND4 U1662 ( .O(n1402), .I3(n2537), .I2(a_addr[0]), .I1(a_addr[1]), .I0(
        a_addr[2]) );
    INV U1663 ( .O(n2538), .I(a_addr[3]) );
    NOR4 U1664 ( .O(n1401), .I3(n2538), .I2(a_addr[0]), .I1(a_addr[1]), .I0(
        a_addr[2]) );
    INV U1665 ( .O(n2539), .I(a_addr[0]) );
    INV U1666 ( .O(n2540), .I(a_addr[3]) );
    NOR4 U1667 ( .O(n1400), .I3(a_addr[2]), .I2(a_addr[1]), .I1(n2539), .I0(
        n2540) );
    INV U1668 ( .O(n2541), .I(a_addr[1]) );
    INV U1669 ( .O(n2542), .I(a_addr[3]) );
    NOR4 U1670 ( .O(n1399), .I3(a_addr[2]), .I2(a_addr[0]), .I1(n2541), .I0(
        n2542) );
    INV U1671 ( .O(n2543), .I(a_addr[2]) );
    AND4 U1672 ( .O(n1398), .I3(n2543), .I2(a_addr[0]), .I1(a_addr[1]), .I0(
        a_addr[3]) );
    INV U1673 ( .O(n2544), .I(a_addr[2]) );
    INV U1674 ( .O(n2545), .I(a_addr[3]) );
    NOR4 U1675 ( .O(n1397), .I3(a_addr[1]), .I2(a_addr[0]), .I1(n2544), .I0(
        n2545) );
    INV U1676 ( .O(n2546), .I(a_addr[1]) );
    AND4 U1677 ( .O(n1396), .I3(n2546), .I2(a_addr[0]), .I1(a_addr[2]), .I0(
        a_addr[3]) );
    INV U1678 ( .O(n2547), .I(a_addr[0]) );
    AND4 U1679 ( .O(n1395), .I3(n2547), .I2(a_addr[1]), .I1(a_addr[2]), .I0(
        a_addr[3]) );
    AND4 U1680 ( .O(n1394), .I3(a_addr[0]), .I2(a_addr[1]), .I1(a_addr[2]), 
        .I0(a_addr[3]) );
    NOR4 U1681 ( .O(n1393), .I3(b_addr[0]), .I2(b_addr[1]), .I1(b_addr[2]), 
        .I0(b_addr[3]) );
    INV U1682 ( .O(n2548), .I(b_addr[0]) );
    NOR4 U1683 ( .O(n1392), .I3(n2548), .I2(b_addr[1]), .I1(b_addr[2]), .I0(
        b_addr[3]) );
    INV U1684 ( .O(n2549), .I(b_addr[1]) );
    NOR4 U1685 ( .O(n1391), .I3(n2549), .I2(b_addr[0]), .I1(b_addr[2]), .I0(
        b_addr[3]) );
    INV U1686 ( .O(n2550), .I(b_addr[0]) );
    INV U1687 ( .O(n2551), .I(b_addr[1]) );
    NOR4 U1688 ( .O(n1390), .I3(b_addr[3]), .I2(b_addr[2]), .I1(n2550), .I0(
        n2551) );
    INV U1689 ( .O(n2552), .I(b_addr[2]) );
    NOR4 U1690 ( .O(n1389), .I3(n2552), .I2(b_addr[0]), .I1(b_addr[1]), .I0(
        b_addr[3]) );
    INV U1691 ( .O(n2553), .I(b_addr[0]) );
    INV U1692 ( .O(n2554), .I(b_addr[2]) );
    NOR4 U1693 ( .O(n1388), .I3(b_addr[3]), .I2(b_addr[1]), .I1(n2553), .I0(
        n2554) );
    INV U1694 ( .O(n2555), .I(b_addr[1]) );
    INV U1695 ( .O(n2556), .I(b_addr[2]) );
    NOR4 U1696 ( .O(n1387), .I3(b_addr[3]), .I2(b_addr[0]), .I1(n2555), .I0(
        n2556) );
    INV U1697 ( .O(n2557), .I(b_addr[3]) );
    AND4 U1698 ( .O(n1386), .I3(n2557), .I2(b_addr[0]), .I1(b_addr[1]), .I0(
        b_addr[2]) );
    INV U1699 ( .O(n2558), .I(b_addr[3]) );
    NOR4 U1700 ( .O(n1385), .I3(n2558), .I2(b_addr[0]), .I1(b_addr[1]), .I0(
        b_addr[2]) );
    INV U1701 ( .O(n2559), .I(b_addr[0]) );
    INV U1702 ( .O(n2560), .I(b_addr[3]) );
    NOR4 U1703 ( .O(n1384), .I3(b_addr[2]), .I2(b_addr[1]), .I1(n2559), .I0(
        n2560) );
    INV U1704 ( .O(n2561), .I(b_addr[1]) );
    INV U1705 ( .O(n2562), .I(b_addr[3]) );
    NOR4 U1706 ( .O(n1383), .I3(b_addr[2]), .I2(b_addr[0]), .I1(n2561), .I0(
        n2562) );
    INV U1707 ( .O(n2563), .I(b_addr[2]) );
    AND4 U1708 ( .O(n1382), .I3(n2563), .I2(b_addr[0]), .I1(b_addr[1]), .I0(
        b_addr[3]) );
    INV U1709 ( .O(n2564), .I(b_addr[2]) );
    INV U1710 ( .O(n2565), .I(b_addr[3]) );
    NOR4 U1711 ( .O(n1381), .I3(b_addr[1]), .I2(b_addr[0]), .I1(n2564), .I0(
        n2565) );
    INV U1712 ( .O(n2566), .I(b_addr[1]) );
    AND4 U1713 ( .O(n1380), .I3(n2566), .I2(b_addr[0]), .I1(b_addr[2]), .I0(
        b_addr[3]) );
    INV U1714 ( .O(n2567), .I(b_addr[0]) );
    AND4 U1715 ( .O(n1379), .I3(n2567), .I2(b_addr[1]), .I1(b_addr[2]), .I0(
        b_addr[3]) );
    AND4 U1716 ( .O(n1378), .I3(b_addr[0]), .I2(b_addr[1]), .I1(b_addr[2]), 
        .I0(b_addr[3]) );
    AND2 U1717 ( .O(n2570), .I1(alu_flags2[6]), .I0(regstore_reset) );
    AND2 U1718 ( .O(n2569), .I1(alu_flags2[7]), .I0(regstore_reset) );
    FDC \alu_flags2_reg<7>  ( .Q(alu_flags2[7]), .D(n2569), .C(wr_clk), .CLR(
        1'b0) );
    FDC \alu_flags2_reg<6>  ( .Q(alu_flags2[6]), .D(n2570), .C(wr_clk), .CLR(
        1'b0) );
    AND2 U1720 ( .O(n2573), .I1(alu_flags2[8]), .I0(regstore_reset) );
    AND2 U1721 ( .O(n2572), .I1(alu_flags2[9]), .I0(regstore_reset) );
    FDC \alu_flags2_reg<9>  ( .Q(alu_flags2[9]), .D(n2572), .C(wr_clk), .CLR(
        1'b0) );
    FDC \alu_flags2_reg<8>  ( .Q(alu_flags2[8]), .D(n2573), .C(wr_clk), .CLR(
        1'b0) );
    AND2 U1723 ( .O(n2576), .I1(alu_flags2[10]), .I0(regstore_reset) );
    AND2 U1724 ( .O(n2575), .I1(alu_flags2[11]), .I0(regstore_reset) );
    FDC \alu_flags2_reg<11>  ( .Q(alu_flags2[11]), .D(n2575), .C(wr_clk), 
        .CLR(1'b0) );
    FDC \alu_flags2_reg<10>  ( .Q(alu_flags2[10]), .D(n2576), .C(wr_clk), 
        .CLR(1'b0) );
    AND2 U1726 ( .O(n2579), .I1(alu_flags2[12]), .I0(regstore_reset) );
    AND2 U1727 ( .O(n2578), .I1(alu_flags2[13]), .I0(regstore_reset) );
    FDC \alu_flags2_reg<13>  ( .Q(alu_flags2[13]), .D(n2578), .C(wr_clk), 
        .CLR(1'b0) );
    FDC \alu_flags2_reg<12>  ( .Q(alu_flags2[12]), .D(n2579), .C(wr_clk), 
        .CLR(1'b0) );
    AND2 U1729 ( .O(n2582), .I1(alu_flags2[14]), .I0(regstore_reset) );
    AND2 U1730 ( .O(n2581), .I1(alu_flags2[15]), .I0(regstore_reset) );
    FDC \alu_flags2_reg<15>  ( .Q(alu_flags2[15]), .D(n2581), .C(wr_clk), 
        .CLR(1'b0) );
    FDC \alu_flags2_reg<14>  ( .Q(alu_flags2[14]), .D(n2582), .C(wr_clk), 
        .CLR(1'b0) );
    INV U1732 ( .O(n2583), .I(wr_addr[1]) );
    AND4 U1733 ( .O(n_2413), .I3(n2583), .I2(wr_addr[0]), .I1(wr_addr[2]), 
        .I0(wr_addr[3]) );
    INV U1734 ( .O(n2584), .I(wr_addr[3]) );
    AND4 U1735 ( .O(n_1837), .I3(n2584), .I2(wr_addr[0]), .I1(wr_addr[1]), 
        .I0(wr_addr[2]) );
    INV U1736 ( .O(n2585), .I(wr_addr[0]) );
    INV U1737 ( .O(n2586), .I(wr_addr[2]) );
    NOR4 U1738 ( .O(n_1645), .I3(wr_addr[3]), .I2(wr_addr[1]), .I1(n2585), 
        .I0(n2586) );
    INV U1739 ( .O(n2587), .I(wr_addr[2]) );
    INV U1740 ( .O(n2588), .I(wr_addr[3]) );
    NOR4 U1741 ( .O(n_2317), .I3(wr_addr[1]), .I2(wr_addr[0]), .I1(n2587), 
        .I0(n2588) );
    INV U1742 ( .O(n2589), .I(wr_addr[2]) );
    AND4 U1743 ( .O(n_2221), .I3(n2589), .I2(wr_addr[0]), .I1(wr_addr[1]), 
        .I0(wr_addr[3]) );
    INV U1744 ( .O(n2590), .I(wr_addr[3]) );
    NOR4 U1745 ( .O(n_1933), .I3(n2590), .I2(wr_addr[0]), .I1(wr_addr[1]), 
        .I0(wr_addr[2]) );
    INV U1746 ( .O(n2591), .I(wr_addr[1]) );
    INV U1747 ( .O(n2592), .I(wr_addr[2]) );
    NOR4 U1748 ( .O(n_1741), .I3(wr_addr[3]), .I2(wr_addr[0]), .I1(n2591), 
        .I0(n2592) );
    INV U1749 ( .O(n2593), .I(wr_addr[2]) );
    NOR4 U1750 ( .O(n_1549), .I3(n2593), .I2(wr_addr[0]), .I1(wr_addr[1]), 
        .I0(wr_addr[3]) );
    INV U1751 ( .O(n2594), .I(wr_addr[1]) );
    INV U1752 ( .O(n2595), .I(wr_addr[3]) );
    NOR4 U1753 ( .O(n_2125), .I3(wr_addr[2]), .I2(wr_addr[0]), .I1(n2594), 
        .I0(n2595) );
    INV U1754 ( .O(n2596), .I(wr_addr[0]) );
    INV U1755 ( .O(n2597), .I(wr_addr[3]) );
    NOR4 U1756 ( .O(n_2029), .I3(wr_addr[2]), .I2(wr_addr[1]), .I1(n2596), 
        .I0(n2597) );
    INV U1757 ( .O(n2598), .I(wr_addr[0]) );
    INV U1758 ( .O(n2599), .I(wr_addr[1]) );
    NOR4 U1759 ( .O(n_1453), .I3(wr_addr[3]), .I2(wr_addr[2]), .I1(n2598), 
        .I0(n2599) );
    INV U1760 ( .O(n2600), .I(wr_addr[1]) );
    NOR4 U1761 ( .O(n_1357), .I3(n2600), .I2(wr_addr[0]), .I1(wr_addr[2]), 
        .I0(wr_addr[3]) );
    INV U1762 ( .O(n2601), .I(wr_addr[0]) );
    NOR4 U1763 ( .O(n_1261), .I3(n2601), .I2(wr_addr[1]), .I1(wr_addr[2]), 
        .I0(wr_addr[3]) );
    NOR4 U1764 ( .O(n_1165), .I3(wr_addr[0]), .I2(wr_addr[1]), .I1(wr_addr[2]), 
        .I0(wr_addr[3]) );
    INV U1765 ( .O(n2602), .I(n2609) );
    OR2 U1766 ( .O(n2604), .I1(regstore_reset), .I0(n2602) );
    NAND2 U1767 ( .O(n2603), .I1(regstore_reset), .I0(alu_flags2[0]) );
    NAND2 U1768 ( .O(n2610), .I1(n2603), .I0(n2604) );
    INV U1769 ( .O(n2605), .I(\register14<0> ) );
    OR2 U1770 ( .O(n2607), .I1(n1410), .I0(n2605) );
    NAND2 U1771 ( .O(n2606), .I1(n1410), .I0(\regwr<0> ) );
    NAND2 U1772 ( .O(n2609), .I1(n2606), .I0(n2607) );
    FDC \register14_reg<0>  ( .Q(\register14<0> ), .D(n2609), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \alu_flags2_reg<0>  ( .Q(alu_flags2[0]), .D(n2610), .C(wr_clk), .CLR(
        1'b0) );
    INV U1774 ( .O(n2611), .I(n2618) );
    OR2 U1775 ( .O(n2613), .I1(regstore_reset), .I0(n2611) );
    NAND2 U1776 ( .O(n2612), .I1(regstore_reset), .I0(alu_flags2[1]) );
    NAND2 U1777 ( .O(n2619), .I1(n2612), .I0(n2613) );
    INV U1778 ( .O(n2614), .I(\register14<1> ) );
    OR2 U1779 ( .O(n2616), .I1(n1410), .I0(n2614) );
    NAND2 U1780 ( .O(n2615), .I1(n1410), .I0(\regwr<1> ) );
    NAND2 U1781 ( .O(n2618), .I1(n2615), .I0(n2616) );
    FDC \register14_reg<1>  ( .Q(\register14<1> ), .D(n2618), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \alu_flags2_reg<1>  ( .Q(alu_flags2[1]), .D(n2619), .C(wr_clk), .CLR(
        1'b0) );
    INV U1783 ( .O(n2620), .I(n2627) );
    OR2 U1784 ( .O(n2622), .I1(regstore_reset), .I0(n2620) );
    NAND2 U1785 ( .O(n2621), .I1(regstore_reset), .I0(alu_flags2[2]) );
    NAND2 U1786 ( .O(n2628), .I1(n2621), .I0(n2622) );
    INV U1787 ( .O(n2623), .I(\register14<2> ) );
    OR2 U1788 ( .O(n2625), .I1(n1410), .I0(n2623) );
    NAND2 U1789 ( .O(n2624), .I1(n1410), .I0(\regwr<2> ) );
    NAND2 U1790 ( .O(n2627), .I1(n2624), .I0(n2625) );
    FDC \register14_reg<2>  ( .Q(\register14<2> ), .D(n2627), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \alu_flags2_reg<2>  ( .Q(alu_flags2[2]), .D(n2628), .C(wr_clk), .CLR(
        1'b0) );
    INV U1792 ( .O(n2629), .I(n2636) );
    OR2 U1793 ( .O(n2631), .I1(regstore_reset), .I0(n2629) );
    NAND2 U1794 ( .O(n2630), .I1(regstore_reset), .I0(alu_flags2[3]) );
    NAND2 U1795 ( .O(n2637), .I1(n2630), .I0(n2631) );
    INV U1796 ( .O(n2632), .I(\register14<3> ) );
    OR2 U1797 ( .O(n2634), .I1(n1410), .I0(n2632) );
    NAND2 U1798 ( .O(n2633), .I1(n1410), .I0(\regwr<3> ) );
    NAND2 U1799 ( .O(n2636), .I1(n2633), .I0(n2634) );
    FDC \register14_reg<3>  ( .Q(\register14<3> ), .D(n2636), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \alu_flags2_reg<3>  ( .Q(alu_flags2[3]), .D(n2637), .C(wr_clk), .CLR(
        1'b0) );
    INV U1801 ( .O(n2638), .I(n2645) );
    OR2 U1802 ( .O(n2640), .I1(regstore_reset), .I0(n2638) );
    NAND2 U1803 ( .O(n2639), .I1(regstore_reset), .I0(alu_flags2[4]) );
    NAND2 U1804 ( .O(n2646), .I1(n2639), .I0(n2640) );
    INV U1805 ( .O(n2641), .I(\register14<4> ) );
    OR2 U1806 ( .O(n2643), .I1(n1410), .I0(n2641) );
    NAND2 U1807 ( .O(n2642), .I1(n1410), .I0(\regwr<4> ) );
    NAND2 U1808 ( .O(n2645), .I1(n2642), .I0(n2643) );
    FDC \register14_reg<4>  ( .Q(\register14<4> ), .D(n2645), .C(wr_clk), 
        .CLR(regstore_reset) );
    FDC \alu_flags2_reg<4>  ( .Q(alu_flags2[4]), .D(n2646), .C(wr_clk), .CLR(
        1'b0) );
    INV U1810 ( .O(n2647), .I(\register14<5> ) );
    OR2 U1811 ( .O(n2649), .I1(n1410), .I0(n2647) );
    NAND2 U1812 ( .O(n2648), .I1(n1410), .I0(\regwr<5> ) );
    NAND2 U1813 ( .O(\register14215<5> ), .I1(n2648), .I0(n2649) );
    INV U1814 ( .O(n2650), .I(wr_addr[0]) );
    AND4 U1815 ( .O(n1410), .I3(n2650), .I2(wr_addr[1]), .I1(wr_addr[2]), .I0(
        wr_addr[3]) );
    FDC \register14_reg<5>  ( .Q(\register14<5> ), .D(\register14215<5> ), .C(
        wr_clk), .CLR(regstore_reset) );
    OR2 U1816 ( .O(rega[0]), .I1(n2651), .I0(n2652) );
    OR4 U1817 ( .O(n2652), .I3(n1671), .I2(n1670), .I1(n1669), .I0(n1668) );
    OR4 U1818 ( .O(n2651), .I3(n1667), .I2(n1666), .I1(n1665), .I0(n1664) );
    OR2 U1819 ( .O(rega[10]), .I1(n2653), .I0(n2654) );
    OR4 U1820 ( .O(n2654), .I3(n1663), .I2(n1662), .I1(n1661), .I0(n1660) );
    OR4 U1821 ( .O(n2653), .I3(n1659), .I2(n1658), .I1(n1657), .I0(n1656) );
    OR2 U1822 ( .O(rega[11]), .I1(n2655), .I0(n2656) );
    OR4 U1823 ( .O(n2656), .I3(n1655), .I2(n1654), .I1(n1653), .I0(n1652) );
    OR4 U1824 ( .O(n2655), .I3(n1651), .I2(n1650), .I1(n1649), .I0(n1648) );
    OR2 U1825 ( .O(rega[12]), .I1(n2657), .I0(n2658) );
    OR4 U1826 ( .O(n2658), .I3(n1647), .I2(n1646), .I1(n1645), .I0(n1644) );
    OR4 U1827 ( .O(n2657), .I3(n1643), .I2(n1642), .I1(n1641), .I0(n1640) );
    OR2 U1828 ( .O(rega[13]), .I1(n2659), .I0(n2660) );
    OR4 U1829 ( .O(n2660), .I3(n1639), .I2(n1638), .I1(n1637), .I0(n1636) );
    OR4 U1830 ( .O(n2659), .I3(n1635), .I2(n1634), .I1(n1633), .I0(n1632) );
    OR2 U1831 ( .O(rega[14]), .I1(n2661), .I0(n2662) );
    OR4 U1832 ( .O(n2662), .I3(n1631), .I2(n1630), .I1(n1629), .I0(n1628) );
    OR4 U1833 ( .O(n2661), .I3(n1627), .I2(n1626), .I1(n1625), .I0(n1624) );
    OR2 U1834 ( .O(rega[15]), .I1(n2663), .I0(n2664) );
    OR4 U1835 ( .O(n2664), .I3(n1623), .I2(n1622), .I1(n1621), .I0(n1620) );
    OR4 U1836 ( .O(n2663), .I3(n1619), .I2(n1618), .I1(n1617), .I0(n1616) );
    OR2 U1837 ( .O(rega[1]), .I1(n2665), .I0(n2666) );
    OR4 U1838 ( .O(n2666), .I3(n1615), .I2(n1614), .I1(n1613), .I0(n1612) );
    OR4 U1839 ( .O(n2665), .I3(n1611), .I2(n1610), .I1(n1609), .I0(n1608) );
    OR2 U1840 ( .O(rega[2]), .I1(n2667), .I0(n2668) );
    OR4 U1841 ( .O(n2668), .I3(n1607), .I2(n1606), .I1(n1605), .I0(n1604) );
    OR4 U1842 ( .O(n2667), .I3(n1603), .I2(n1602), .I1(n1601), .I0(n1600) );
    OR2 U1843 ( .O(rega[3]), .I1(n2670), .I0(n2669) );
    OR4 U1844 ( .O(n2670), .I3(n1595), .I2(n1594), .I1(n1593), .I0(n1592) );
    OR4 U1845 ( .O(n2669), .I3(n1599), .I2(n1598), .I1(n1597), .I0(n1596) );
    OR2 U1846 ( .O(rega[4]), .I1(n2672), .I0(n2671) );
    OR4 U1847 ( .O(n2672), .I3(n1587), .I2(n1586), .I1(n1585), .I0(n1584) );
    OR4 U1848 ( .O(n2671), .I3(n1591), .I2(n1590), .I1(n1589), .I0(n1588) );
    OR2 U1849 ( .O(rega[5]), .I1(n2673), .I0(n2674) );
    OR4 U1850 ( .O(n2674), .I3(n1583), .I2(n1582), .I1(n1581), .I0(n1580) );
    OR4 U1851 ( .O(n2673), .I3(n1579), .I2(n1578), .I1(n1577), .I0(n1576) );
    OR2 U1852 ( .O(rega[6]), .I1(n2675), .I0(n2676) );
    OR4 U1853 ( .O(n2676), .I3(n1575), .I2(n1574), .I1(n1573), .I0(n1572) );
    OR4 U1854 ( .O(n2675), .I3(n1571), .I2(n1570), .I1(n1569), .I0(n1568) );
    OR2 U1855 ( .O(rega[7]), .I1(n2677), .I0(n2678) );
    OR4 U1856 ( .O(n2678), .I3(n1567), .I2(n1566), .I1(n1565), .I0(n1564) );
    OR4 U1857 ( .O(n2677), .I3(n1563), .I2(n1562), .I1(n1561), .I0(n1560) );
    OR2 U1858 ( .O(rega[8]), .I1(n2680), .I0(n2679) );
    OR4 U1859 ( .O(n2680), .I3(n1555), .I2(n1554), .I1(n1553), .I0(n1552) );
    OR4 U1860 ( .O(n2679), .I3(n1559), .I2(n1558), .I1(n1557), .I0(n1556) );
    OR2 U1861 ( .O(rega[9]), .I1(n2681), .I0(n2682) );
    OR4 U1862 ( .O(n2682), .I3(n1551), .I2(n1550), .I1(n1549), .I0(n1548) );
    OR4 U1863 ( .O(n2681), .I3(n1547), .I2(n1546), .I1(n1545), .I0(n1544) );
    OR2 U1864 ( .O(regb[0]), .I1(n2684), .I0(n2683) );
    OR4 U1865 ( .O(n2684), .I3(n1539), .I2(n1538), .I1(n1537), .I0(n1536) );
    OR4 U1866 ( .O(n2683), .I3(n1543), .I2(n1542), .I1(n1541), .I0(n1540) );
    OR2 U1867 ( .O(regb[10]), .I1(n2685), .I0(n2686) );
    OR4 U1868 ( .O(n2686), .I3(n1535), .I2(n1534), .I1(n1533), .I0(n1532) );
    OR4 U1869 ( .O(n2685), .I3(n1531), .I2(n1530), .I1(n1529), .I0(n1528) );
    OR2 U1870 ( .O(regb[11]), .I1(n2687), .I0(n2688) );
    OR4 U1871 ( .O(n2688), .I3(n1527), .I2(n1526), .I1(n1525), .I0(n1524) );
    OR4 U1872 ( .O(n2687), .I3(n1523), .I2(n1522), .I1(n1521), .I0(n1520) );
    OR2 U1873 ( .O(regb[12]), .I1(n2689), .I0(n2690) );
    OR4 U1874 ( .O(n2690), .I3(n1519), .I2(n1518), .I1(n1517), .I0(n1516) );
    OR4 U1875 ( .O(n2689), .I3(n1515), .I2(n1514), .I1(n1513), .I0(n1512) );
    OR2 U1876 ( .O(regb[13]), .I1(n2691), .I0(n2692) );
    OR4 U1877 ( .O(n2692), .I3(n1511), .I2(n1510), .I1(n1509), .I0(n1508) );
    OR4 U1878 ( .O(n2691), .I3(n1507), .I2(n1506), .I1(n1505), .I0(n1504) );
    OR2 U1879 ( .O(regb[14]), .I1(n2694), .I0(n2693) );
    OR4 U1880 ( .O(n2694), .I3(n1499), .I2(n1498), .I1(n1497), .I0(n1496) );
    OR4 U1881 ( .O(n2693), .I3(n1503), .I2(n1502), .I1(n1501), .I0(n1500) );
    OR2 U1882 ( .O(regb[15]), .I1(n2695), .I0(n2696) );
    OR4 U1883 ( .O(n2696), .I3(n1495), .I2(n1494), .I1(n1493), .I0(n1492) );
    OR4 U1884 ( .O(n2695), .I3(n1491), .I2(n1490), .I1(n1489), .I0(n1488) );
    OR2 U1885 ( .O(regb[1]), .I1(n2697), .I0(n2698) );
    OR4 U1886 ( .O(n2698), .I3(n1487), .I2(n1486), .I1(n1485), .I0(n1484) );
    OR4 U1887 ( .O(n2697), .I3(n1483), .I2(n1482), .I1(n1481), .I0(n1480) );
    OR2 U1888 ( .O(regb[2]), .I1(n2700), .I0(n2699) );
    OR4 U1889 ( .O(n2700), .I3(n1475), .I2(n1474), .I1(n1473), .I0(n1472) );
    OR4 U1890 ( .O(n2699), .I3(n1479), .I2(n1478), .I1(n1477), .I0(n1476) );
    OR2 U1891 ( .O(regb[3]), .I1(n2701), .I0(n2702) );
    OR4 U1892 ( .O(n2702), .I3(n1471), .I2(n1470), .I1(n1469), .I0(n1468) );
    OR4 U1893 ( .O(n2701), .I3(n1467), .I2(n1466), .I1(n1465), .I0(n1464) );
    OR2 U1894 ( .O(regb[4]), .I1(n2704), .I0(n2703) );
    OR4 U1895 ( .O(n2704), .I3(n1459), .I2(n1458), .I1(n1457), .I0(n1456) );
    OR4 U1896 ( .O(n2703), .I3(n1463), .I2(n1462), .I1(n1461), .I0(n1460) );
    OR2 U1897 ( .O(regb[5]), .I1(n2706), .I0(n2705) );
    OR4 U1898 ( .O(n2706), .I3(n1451), .I2(n1450), .I1(n1449), .I0(n1448) );
    OR4 U1899 ( .O(n2705), .I3(n1455), .I2(n1454), .I1(n1453), .I0(n1452) );
    OR2 U1900 ( .O(regb[6]), .I1(n2708), .I0(n2707) );
    OR4 U1901 ( .O(n2708), .I3(n1443), .I2(n1442), .I1(n1441), .I0(n1440) );
    OR4 U1902 ( .O(n2707), .I3(n1447), .I2(n1446), .I1(n1445), .I0(n1444) );
    OR2 U1903 ( .O(regb[7]), .I1(n2710), .I0(n2709) );
    OR4 U1904 ( .O(n2710), .I3(n1435), .I2(n1434), .I1(n1433), .I0(n1432) );
    OR4 U1905 ( .O(n2709), .I3(n1439), .I2(n1438), .I1(n1437), .I0(n1436) );
    OR2 U1906 ( .O(regb[8]), .I1(n2712), .I0(n2711) );
    OR4 U1907 ( .O(n2712), .I3(n1427), .I2(n1426), .I1(n1425), .I0(n1424) );
    OR4 U1908 ( .O(n2711), .I3(n1431), .I2(n1430), .I1(n1429), .I0(n1428) );
    OR2 U1909 ( .O(regb[9]), .I1(n2713), .I0(n2714) );
    OR4 U1910 ( .O(n2714), .I3(n1423), .I2(n1422), .I1(n1421), .I0(n1420) );
    OR4 U1911 ( .O(n2713), .I3(n1419), .I2(n1418), .I1(n1417), .I0(n1416) );
endmodule


module alu_DW01_sub_5_0 ( A, B, CI, DIFF, CO );
input  [4:0] A;
input  [4:0] B;
output [4:0] DIFF;
input  CI;
output CO;
    wire n7, n9, n10, n11, n12, n13, n14, n15, n16, n17, n39, n40, n41;
    OR2 U11 ( .O(n11), .I1(n7), .I0(A[3]) );
    NAND2 U12 ( .O(n10), .I1(n9), .I0(B[3]) );
    NAND2 U13 ( .O(n9), .I1(n7), .I0(A[3]) );
    NAND2 U14 ( .O(DIFF[4]), .I1(n10), .I0(n11) );
    OR2 U15 ( .O(n14), .I1(n41), .I0(B[2]) );
    NAND2 U16 ( .O(n13), .I1(n12), .I0(A[2]) );
    NAND2 U17 ( .O(n12), .I1(n41), .I0(B[2]) );
    NAND2 U18 ( .O(n7), .I1(n13), .I0(n14) );
    OR2 U19 ( .O(n40), .I1(A[1]), .I0(n17) );
    NAND3 U20 ( .O(n39), .I2(B[0]), .I1(n16), .I0(n15) );
    NAND2 U21 ( .O(n15), .I1(A[1]), .I0(n17) );
    INV U22 ( .O(n16), .I(A[0]) );
    INV U23 ( .O(n17), .I(B[1]) );
    NAND2 U24 ( .O(n41), .I1(n39), .I0(n40) );
endmodule


module alu_DW01_add_9_0 ( A, B, CI, SUM, CO );
input  [8:0] A;
input  [8:0] B;
output [8:0] SUM;
input  CI;
output CO;
    wire n11, n12, n13, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, 
        n29, n30, n31, n32, n33, n34, n35, n36, n37, n38;
    XOR2 U20 ( .O(SUM[0]), .I1(B[0]), .I0(A[0]) );
    OR3 U21 ( .O(n22), .I2(n19), .I1(n18), .I0(n20) );
    NAND2 U22 ( .O(n21), .I1(n20), .I0(n19) );
    AND2 U23 ( .O(n18), .I1(A[1]), .I0(B[1]) );
    XNOR2 U24 ( .O(n19), .I1(B[1]), .I0(A[1]) );
    AND2 U25 ( .O(n20), .I1(A[0]), .I0(B[0]) );
    NAND2 U26 ( .O(SUM[1]), .I1(n21), .I0(n22) );
    XOR3 U27 ( .O(SUM[2]), .I2(n12), .I1(B[2]), .I0(A[2]) );
    XOR3 U28 ( .O(SUM[3]), .I2(n13), .I1(A[3]), .I0(B[3]) );
    NAND2 U29 ( .O(n26), .I1(n24), .I0(n23) );
    NAND2 U30 ( .O(n23), .I1(n13), .I0(A[3]) );
    NAND2 U31 ( .O(n24), .I1(n25), .I0(B[3]) );
    OR2 U32 ( .O(n25), .I1(A[3]), .I0(n13) );
    XOR2 U33 ( .O(SUM[4]), .I1(B[4]), .I0(n26) );
    XOR2 U34 ( .O(SUM[5]), .I1(B[5]), .I0(n11) );
    XOR2 U35 ( .O(SUM[7]), .I1(n27), .I0(B[7]) );
    AND3 U36 ( .O(n27), .I2(B[5]), .I1(n11), .I0(B[6]) );
    AND4 U37 ( .O(SUM[8]), .I3(n11), .I2(B[7]), .I1(B[6]), .I0(B[5]) );
    XOR2 U38 ( .O(SUM[6]), .I1(n28), .I0(B[6]) );
    AND2 U39 ( .O(n28), .I1(n11), .I0(B[5]) );
    NAND2 U40 ( .O(n32), .I1(n30), .I0(n29) );
    NAND2 U41 ( .O(n29), .I1(n13), .I0(A[3]) );
    NAND2 U42 ( .O(n30), .I1(n31), .I0(B[3]) );
    OR2 U43 ( .O(n31), .I1(A[3]), .I0(n13) );
    AND2 U44 ( .O(n11), .I1(n32), .I0(B[4]) );
    NAND2 U45 ( .O(n35), .I1(n12), .I0(B[2]) );
    NAND2 U46 ( .O(n34), .I1(n33), .I0(A[2]) );
    OR2 U47 ( .O(n33), .I1(B[2]), .I0(n12) );
    NAND2 U48 ( .O(n13), .I1(n34), .I0(n35) );
    NAND2 U49 ( .O(n38), .I1(A[1]), .I0(B[1]) );
    NAND3 U50 ( .O(n37), .I2(B[0]), .I1(n36), .I0(A[0]) );
    OR2 U51 ( .O(n36), .I1(B[1]), .I0(A[1]) );
    NAND2 U52 ( .O(n12), .I1(n37), .I0(n38) );
endmodule


module alu_DW01_sub_17_0 ( A, B, CI, DIFF, CO );
input  [16:0] A;
input  [16:0] B;
output [16:0] DIFF;
input  CI;
output CO;
    wire n189, n190, n192, n193, n199, n200, n202, n203, n205, n206, n208, 
        n209, n211, n212, n276, n277, n278, n279, n280, n331, n332, n333, n334, 
        n335, n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, 
        n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358, 
        n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369, n370, 
        n371, n372, n373, n374, n375, n376, n377, n378, n379, n380, n381, n382, 
        n383, n384, n385, n386, n387, n388, n389, n390, n391, n392;
    XNOR3 U60 ( .O(DIFF[10]), .I2(n205), .I1(B[10]), .I0(A[10]) );
    XNOR3 U61 ( .O(DIFF[11]), .I2(n206), .I1(B[11]), .I0(A[11]) );
    XNOR3 U62 ( .O(DIFF[12]), .I2(n208), .I1(B[12]), .I0(A[12]) );
    XNOR3 U63 ( .O(DIFF[13]), .I2(n209), .I1(B[13]), .I0(A[13]) );
    XNOR3 U64 ( .O(DIFF[14]), .I2(n211), .I1(B[14]), .I0(A[14]) );
    XNOR3 U65 ( .O(DIFF[15]), .I2(n212), .I1(B[15]), .I0(A[15]) );
    INV U66 ( .O(n278), .I(B[0]) );
    OR3 U67 ( .O(n331), .I2(n277), .I1(n279), .I0(n276) );
    NAND2 U68 ( .O(n280), .I1(n277), .I0(n279) );
    AND2 U69 ( .O(n276), .I1(B[1]), .I0(A[1]) );
    XNOR2 U70 ( .O(n277), .I1(A[1]), .I0(B[1]) );
    NOR2 U71 ( .O(n279), .I1(n278), .I0(A[0]) );
    NAND2 U72 ( .O(DIFF[1]), .I1(n280), .I0(n331) );
    XNOR3 U73 ( .O(DIFF[2]), .I2(n189), .I1(B[2]), .I0(A[2]) );
    XNOR3 U74 ( .O(DIFF[3]), .I2(n190), .I1(B[3]), .I0(A[3]) );
    XNOR3 U75 ( .O(DIFF[4]), .I2(n192), .I1(B[4]), .I0(A[4]) );
    XNOR3 U76 ( .O(DIFF[5]), .I2(n193), .I1(B[5]), .I0(A[5]) );
    XNOR3 U77 ( .O(DIFF[6]), .I2(n199), .I1(B[6]), .I0(A[6]) );
    XNOR3 U78 ( .O(DIFF[7]), .I2(n200), .I1(B[7]), .I0(A[7]) );
    XNOR3 U79 ( .O(DIFF[8]), .I2(n202), .I1(B[8]), .I0(A[8]) );
    XNOR3 U80 ( .O(DIFF[9]), .I2(n203), .I1(B[9]), .I0(A[9]) );
    XOR2 U81 ( .O(DIFF[0]), .I1(A[0]), .I0(B[0]) );
    OR2 U82 ( .O(n334), .I1(n212), .I0(A[15]) );
    NAND2 U83 ( .O(n333), .I1(n332), .I0(B[15]) );
    NAND2 U84 ( .O(n332), .I1(n212), .I0(A[15]) );
    NAND2 U85 ( .O(DIFF[16]), .I1(n333), .I0(n334) );
    OR2 U86 ( .O(n338), .I1(B[14]), .I0(n336) );
    NAND2 U87 ( .O(n337), .I1(n335), .I0(A[14]) );
    NAND2 U88 ( .O(n335), .I1(n336), .I0(B[14]) );
    INV U89 ( .O(n336), .I(n211) );
    NAND2 U90 ( .O(n212), .I1(n337), .I0(n338) );
    OR2 U91 ( .O(n342), .I1(B[13]), .I0(n340) );
    NAND2 U92 ( .O(n341), .I1(n339), .I0(A[13]) );
    NAND2 U93 ( .O(n339), .I1(n340), .I0(B[13]) );
    INV U94 ( .O(n340), .I(n209) );
    NAND2 U95 ( .O(n211), .I1(n341), .I0(n342) );
    OR2 U96 ( .O(n346), .I1(B[12]), .I0(n344) );
    NAND2 U97 ( .O(n345), .I1(n343), .I0(A[12]) );
    NAND2 U98 ( .O(n343), .I1(n344), .I0(B[12]) );
    INV U99 ( .O(n344), .I(n208) );
    NAND2 U100 ( .O(n209), .I1(n345), .I0(n346) );
    OR2 U101 ( .O(n350), .I1(B[11]), .I0(n348) );
    NAND2 U102 ( .O(n349), .I1(n347), .I0(A[11]) );
    NAND2 U103 ( .O(n347), .I1(n348), .I0(B[11]) );
    INV U104 ( .O(n348), .I(n206) );
    NAND2 U105 ( .O(n208), .I1(n349), .I0(n350) );
    OR2 U106 ( .O(n354), .I1(B[10]), .I0(n352) );
    NAND2 U107 ( .O(n353), .I1(n351), .I0(A[10]) );
    NAND2 U108 ( .O(n351), .I1(n352), .I0(B[10]) );
    INV U109 ( .O(n352), .I(n205) );
    NAND2 U110 ( .O(n206), .I1(n353), .I0(n354) );
    OR2 U111 ( .O(n358), .I1(B[9]), .I0(n356) );
    NAND2 U112 ( .O(n357), .I1(n355), .I0(A[9]) );
    NAND2 U113 ( .O(n355), .I1(n356), .I0(B[9]) );
    INV U114 ( .O(n356), .I(n203) );
    NAND2 U115 ( .O(n205), .I1(n357), .I0(n358) );
    OR2 U116 ( .O(n362), .I1(B[8]), .I0(n360) );
    NAND2 U117 ( .O(n361), .I1(n359), .I0(A[8]) );
    NAND2 U118 ( .O(n359), .I1(n360), .I0(B[8]) );
    INV U119 ( .O(n360), .I(n202) );
    NAND2 U120 ( .O(n203), .I1(n361), .I0(n362) );
    OR2 U121 ( .O(n366), .I1(B[7]), .I0(n364) );
    NAND2 U122 ( .O(n365), .I1(n363), .I0(A[7]) );
    NAND2 U123 ( .O(n363), .I1(n364), .I0(B[7]) );
    INV U124 ( .O(n364), .I(n200) );
    NAND2 U125 ( .O(n202), .I1(n365), .I0(n366) );
    OR2 U126 ( .O(n370), .I1(B[6]), .I0(n368) );
    NAND2 U127 ( .O(n369), .I1(n367), .I0(A[6]) );
    NAND2 U128 ( .O(n367), .I1(n368), .I0(B[6]) );
    INV U129 ( .O(n368), .I(n199) );
    NAND2 U130 ( .O(n200), .I1(n369), .I0(n370) );
    OR2 U131 ( .O(n374), .I1(B[5]), .I0(n372) );
    NAND2 U132 ( .O(n373), .I1(n371), .I0(A[5]) );
    NAND2 U133 ( .O(n371), .I1(n372), .I0(B[5]) );
    INV U134 ( .O(n372), .I(n193) );
    NAND2 U135 ( .O(n199), .I1(n373), .I0(n374) );
    OR2 U136 ( .O(n378), .I1(B[4]), .I0(n376) );
    NAND2 U137 ( .O(n377), .I1(n375), .I0(A[4]) );
    NAND2 U138 ( .O(n375), .I1(n376), .I0(B[4]) );
    INV U139 ( .O(n376), .I(n192) );
    NAND2 U140 ( .O(n193), .I1(n377), .I0(n378) );
    OR2 U141 ( .O(n382), .I1(B[3]), .I0(n380) );
    NAND2 U142 ( .O(n381), .I1(n379), .I0(A[3]) );
    NAND2 U143 ( .O(n379), .I1(n380), .I0(B[3]) );
    INV U144 ( .O(n380), .I(n190) );
    NAND2 U145 ( .O(n192), .I1(n381), .I0(n382) );
    OR2 U146 ( .O(n386), .I1(B[2]), .I0(n384) );
    NAND2 U147 ( .O(n385), .I1(n383), .I0(A[2]) );
    NAND2 U148 ( .O(n383), .I1(n384), .I0(B[2]) );
    INV U149 ( .O(n384), .I(n189) );
    NAND2 U150 ( .O(n190), .I1(n385), .I0(n386) );
    INV U151 ( .O(n387), .I(B[0]) );
    OR2 U152 ( .O(n392), .I1(B[1]), .I0(n390) );
    NAND2 U153 ( .O(n391), .I1(n389), .I0(n388) );
    OR2 U154 ( .O(n388), .I1(n387), .I0(A[0]) );
    NAND2 U155 ( .O(n389), .I1(B[1]), .I0(n390) );
    INV U156 ( .O(n390), .I(A[1]) );
    NAND2 U157 ( .O(n189), .I1(n391), .I0(n392) );
endmodule


module alu_DW01_add_17_0 ( A, B, CI, SUM, CO );
input  [16:0] A;
input  [16:0] B;
output [16:0] SUM;
input  CI;
output CO;
    wire n245, n246, n248, n249, n251, n252, n254, n255, n257, n258, n260, 
        n261, n263, n264, n281, n282, n283, n284, n285, n286, n287, n288, n289, 
        n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, 
        n302, n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, 
        n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, 
        n326, n327, n328, n329, n330;
    XOR2 U58 ( .O(SUM[0]), .I1(B[0]), .I0(A[0]) );
    XOR3 U59 ( .O(SUM[10]), .I2(n257), .I1(B[10]), .I0(A[10]) );
    XOR3 U60 ( .O(SUM[11]), .I2(n258), .I1(A[11]), .I0(B[11]) );
    XOR3 U61 ( .O(SUM[12]), .I2(n260), .I1(B[12]), .I0(A[12]) );
    XOR3 U62 ( .O(SUM[13]), .I2(n261), .I1(A[13]), .I0(B[13]) );
    XOR3 U63 ( .O(SUM[14]), .I2(n263), .I1(B[14]), .I0(A[14]) );
    XOR3 U64 ( .O(SUM[15]), .I2(n264), .I1(A[15]), .I0(B[15]) );
    OR3 U65 ( .O(n285), .I2(n282), .I1(n281), .I0(n283) );
    NAND2 U66 ( .O(n284), .I1(n283), .I0(n282) );
    AND2 U67 ( .O(n281), .I1(A[1]), .I0(B[1]) );
    XNOR2 U68 ( .O(n282), .I1(B[1]), .I0(A[1]) );
    AND2 U69 ( .O(n283), .I1(A[0]), .I0(B[0]) );
    NAND2 U70 ( .O(SUM[1]), .I1(n284), .I0(n285) );
    XOR3 U71 ( .O(SUM[2]), .I2(n245), .I1(B[2]), .I0(A[2]) );
    XOR3 U72 ( .O(SUM[3]), .I2(n246), .I1(A[3]), .I0(B[3]) );
    XOR3 U73 ( .O(SUM[4]), .I2(n248), .I1(B[4]), .I0(A[4]) );
    XOR3 U74 ( .O(SUM[5]), .I2(n249), .I1(A[5]), .I0(B[5]) );
    XOR3 U75 ( .O(SUM[6]), .I2(n251), .I1(B[6]), .I0(A[6]) );
    XOR3 U76 ( .O(SUM[7]), .I2(n252), .I1(A[7]), .I0(B[7]) );
    XOR3 U77 ( .O(SUM[8]), .I2(n254), .I1(B[8]), .I0(A[8]) );
    XOR3 U78 ( .O(SUM[9]), .I2(n255), .I1(A[9]), .I0(B[9]) );
    NAND2 U79 ( .O(n288), .I1(n264), .I0(A[15]) );
    NAND2 U80 ( .O(n287), .I1(n286), .I0(B[15]) );
    OR2 U81 ( .O(n286), .I1(A[15]), .I0(n264) );
    NAND2 U82 ( .O(SUM[16]), .I1(n287), .I0(n288) );
    NAND2 U83 ( .O(n291), .I1(n263), .I0(B[14]) );
    NAND2 U84 ( .O(n290), .I1(n289), .I0(A[14]) );
    OR2 U85 ( .O(n289), .I1(B[14]), .I0(n263) );
    NAND2 U86 ( .O(n264), .I1(n290), .I0(n291) );
    NAND2 U87 ( .O(n294), .I1(n261), .I0(A[13]) );
    NAND2 U88 ( .O(n293), .I1(n292), .I0(B[13]) );
    OR2 U89 ( .O(n292), .I1(A[13]), .I0(n261) );
    NAND2 U90 ( .O(n263), .I1(n293), .I0(n294) );
    NAND2 U91 ( .O(n297), .I1(n260), .I0(B[12]) );
    NAND2 U92 ( .O(n296), .I1(n295), .I0(A[12]) );
    OR2 U93 ( .O(n295), .I1(B[12]), .I0(n260) );
    NAND2 U94 ( .O(n261), .I1(n296), .I0(n297) );
    NAND2 U95 ( .O(n300), .I1(n258), .I0(A[11]) );
    NAND2 U96 ( .O(n299), .I1(n298), .I0(B[11]) );
    OR2 U97 ( .O(n298), .I1(A[11]), .I0(n258) );
    NAND2 U98 ( .O(n260), .I1(n299), .I0(n300) );
    NAND2 U99 ( .O(n303), .I1(n257), .I0(B[10]) );
    NAND2 U100 ( .O(n302), .I1(n301), .I0(A[10]) );
    OR2 U101 ( .O(n301), .I1(B[10]), .I0(n257) );
    NAND2 U102 ( .O(n258), .I1(n302), .I0(n303) );
    NAND2 U103 ( .O(n306), .I1(n255), .I0(A[9]) );
    NAND2 U104 ( .O(n305), .I1(n304), .I0(B[9]) );
    OR2 U105 ( .O(n304), .I1(A[9]), .I0(n255) );
    NAND2 U106 ( .O(n257), .I1(n305), .I0(n306) );
    NAND2 U107 ( .O(n309), .I1(n254), .I0(B[8]) );
    NAND2 U108 ( .O(n308), .I1(n307), .I0(A[8]) );
    OR2 U109 ( .O(n307), .I1(B[8]), .I0(n254) );
    NAND2 U110 ( .O(n255), .I1(n308), .I0(n309) );
    NAND2 U111 ( .O(n312), .I1(n252), .I0(A[7]) );
    NAND2 U112 ( .O(n311), .I1(n310), .I0(B[7]) );
    OR2 U113 ( .O(n310), .I1(A[7]), .I0(n252) );
    NAND2 U114 ( .O(n254), .I1(n311), .I0(n312) );
    NAND2 U115 ( .O(n315), .I1(n251), .I0(B[6]) );
    NAND2 U116 ( .O(n314), .I1(n313), .I0(A[6]) );
    OR2 U117 ( .O(n313), .I1(B[6]), .I0(n251) );
    NAND2 U118 ( .O(n252), .I1(n314), .I0(n315) );
    NAND2 U119 ( .O(n318), .I1(n249), .I0(A[5]) );
    NAND2 U120 ( .O(n317), .I1(n316), .I0(B[5]) );
    OR2 U121 ( .O(n316), .I1(A[5]), .I0(n249) );
    NAND2 U122 ( .O(n251), .I1(n317), .I0(n318) );
    NAND2 U123 ( .O(n321), .I1(n248), .I0(B[4]) );
    NAND2 U124 ( .O(n320), .I1(n319), .I0(A[4]) );
    OR2 U125 ( .O(n319), .I1(B[4]), .I0(n248) );
    NAND2 U126 ( .O(n249), .I1(n320), .I0(n321) );
    NAND2 U127 ( .O(n324), .I1(n246), .I0(A[3]) );
    NAND2 U128 ( .O(n323), .I1(n322), .I0(B[3]) );
    OR2 U129 ( .O(n322), .I1(A[3]), .I0(n246) );
    NAND2 U130 ( .O(n248), .I1(n323), .I0(n324) );
    NAND2 U131 ( .O(n327), .I1(n245), .I0(B[2]) );
    NAND2 U132 ( .O(n326), .I1(n325), .I0(A[2]) );
    OR2 U133 ( .O(n325), .I1(B[2]), .I0(n245) );
    NAND2 U134 ( .O(n246), .I1(n326), .I0(n327) );
    NAND2 U135 ( .O(n330), .I1(A[1]), .I0(B[1]) );
    NAND3 U136 ( .O(n329), .I2(B[0]), .I1(n328), .I0(A[0]) );
    OR2 U137 ( .O(n328), .I1(B[1]), .I0(A[1]) );
    NAND2 U138 ( .O(n245), .I1(n329), .I0(n330) );
endmodule


module alu ( alu_a, alu_b, alu_out, alu_control, alu_flags, signedflag );
input  [15:0] alu_a;
input  [15:0] alu_b;
output [4:0] alu_flags;
output [15:0] alu_out;
input  [2:0] alu_control;
input  signedflag;
    wire \alu_out53<10> , \alu_out53<14> , \alu_out53<7> , \alu_out53<5> , 
        \alu_out53<8> , \alu_out53<12> , \alu_out63<13> , \alu_flags55<4> , 
        \alu_out63<4> , \alu_out63<9> , \alu_out63<0> , \alu_flags55<2> , 
        \alu_out63<2> , \alu_out63<15> , \alu_out63<6> , \alu_flags67<4> , 
        \alu_out63<11> , \alu_out63<7> , \alu_out63<10> , \alu_flags64<2> , 
        \alu_out63<3> , \alu_out63<14> , \alu_out63<8> , \alu_out63<1> , 
        \alu_out63<12> , \alu_out63<5> , \alu_flags64<4> , \alu_out53<13> , 
        \alu_out53<9> , \alu_out<15> , \alu_out53<6> , \alu_out53<15> , 
        \alu_out53<11> , n978, n980, n982, n984, n986, n988, n1010, n1012, 
        n1013, n1014, n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, 
        n1023, n1024, n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, 
        n1033, n1034, n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, 
        n1043, n1044, n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, 
        n1053, n1054, n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, 
        n1063, n1064, n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, 
        n1073, n1074, n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, 
        n1083, n1084, n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, 
        n1093, n1094, n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, 
        n1103, n1104, n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, 
        n1113, n1114, n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, 
        n1123, n1124, n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, 
        n1133, n1134, n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, 
        n1147, n1148, n1149, n1150, n1151, n1153, n1154, n1155, n1156, n1157, 
        n1159, n1164, n1166, n1168, n1170, n1172, n1174, n1175, n1178, n1180, 
        n1181, n1182, n1184, n1185, n1188, n1189, n1191, n1192, n1194, n1195, 
        n1196, n1197, n1199, n1200, n1201, n1202, n1203, n1205, n1206, n1207, 
        n1208, n1209, n1210, n1212, n1213, n1214, n1215, n1216, n1217, n1218, 
        n1220, n1221, n1222, n1223, n1224, n1225, n1226, n1228, n1229, n1230, 
        n1231, n1233, n1234, n1235, n1236, n1238, n1239, n1240, n1241, n1242, 
        n1243, n1244, n1245, n1246, n1247, n1248, n1249, n1250, n1251, n1252, 
        n1253, n1254, n1255, n1256, n1264, n1266, n1268, n1270, n1272, n1280, 
        n1281, n1282, n1283, n1284, n1285, \*cell*885/U19/Z_15 , 
        \*cell*885/U19/Z_14 , \*cell*885/U19/Z_13 , \*cell*885/U19/Z_12 , 
        \*cell*885/U19/Z_11 , \*cell*885/U19/Z_10 , \*cell*885/U19/Z_9 , 
        \*cell*885/U19/Z_8 , \*cell*885/U19/Z_7 , \*cell*885/U19/Z_6 , 
        \*cell*885/U19/Z_5 , \*cell*885/U19/Z_4 , \*cell*885/U19/Z_3 , 
        \*cell*885/U19/Z_2 , \*cell*885/U19/Z_1 , \*cell*885/U19/Z_0 , 
        \*cell*885/U11/Z_3 , \*cell*885/U11/Z_2 , \*cell*885/U11/Z_1 , 
        \*cell*885/U11/Z_0 , \*cell*885/U10/Z_7 , \*cell*885/U10/Z_6 , 
        \*cell*885/U10/Z_5 , \*cell*885/U10/Z_4 , \*cell*885/U10/Z_3 , 
        \*cell*885/U10/Z_2 , \*cell*885/U10/Z_1 , \*cell*885/U10/Z_0 , net973, 
        net972, net971, net970, net964, net963, net962, net961, net960, net959, 
        net958, net957, n1290, n1291, n1292, n1293, n1294, n1295, n1296, n1297, 
        n1298, n1299, n1300, n1301, n1302, n1303, n1304, n1305, n1306, n1307, 
        n1308, n1309, n1310, n1311, n1312, n1313, n1314, n1315, n1316, n1317, 
        n1318, n1319, n1320, n1321, n1322, n1323, n1324, n1325, n1326, n1327, 
        n1328, n1329, n1330, n1331, n1332, n1333, n1334, n1335, n1336, n1337, 
        n1338, n1339, n1340, n1341, n1342, n1343, n1344, n1345, n1346, n1347, 
        n1348, n1349, n1350, n1351, n1352, n1353, n1354, n1355, n1356, n1357, 
        n1358, n1359, n1360, n1361, n1362, n1363, n1364, n1365, n1366, n1367, 
        n1368, n1369, n1370, n1371, n1372, n1373, n1374, n1375, n1376, n1377, 
        n1378, n1379, n1380, n1381, n1382, n1383, n1384, n1385, n1386, n1387, 
        n1388, n1389, n1390, n1391, n1392, n1393, n1394, n1395, n1396, n1397, 
        n1398, n1399, n1400, n1401, n1402, n1403, n1404, n1405, n1406, n1407, 
        n1408, n1409, n1410, n1411, n1412, n1413, n1414, n1415, n1416, n1417, 
        n1418, n1419, n1420, n1421, n1422, n1423, n1424, n1425, n1426, n1427, 
        n1428, n1429, n1430, n1431, n1432, n1433, n1434, n1435, n1436, n1437, 
        n1438, n1439, n1440, n1441, n1442, n1443, n1444, n1445, n1446, n1447, 
        n1448, n1449, n1450, n1451, n1452, n1453, n1454, n1455, n1456, n1457, 
        n1458, n1459, n1460, n1461, n1462, n1463, n1464, n1465, n1466, n1467, 
        n1468, n1469, n1470, n1471, n1472, n1473, n1474, n1475, n1476, n1477, 
        n1478, n1479, n1480, n1481, n1482, n1483, n1484, n1485, n1486, n1487, 
        n1488, n1489, n1490, n1491, n1492, n1493, n1494, n1495, n1496, n1497, 
        n1498, n1499, n1500, n1501, n1502, n1503, n1504, n1505, n1506, n1507, 
        n1508, n1509, n1510, n1511, n1512, n1513, n1514, n1515, n1516, n1517, 
        n1518, n1519, n1520, n1521, n1522, n1523, n1524, n1525, n1526, n1527, 
        n1528, n1529, n1530, n1531, n1532, n1533, n1534, n1535, n1536, n1537, 
        n1538, n1539, n1540, n1541, n1542, n1543, n1544, n1545, n1546, n1547, 
        n1548, n1549, n1550, n1551, n1552, n1553, n1554, n1555, n1556, n1557, 
        n1558, n1559, n1560, n1561, n1562, n1563, n1564, n1565, n1566, n1567, 
        n1568, n1569, n1570, n1571, n1572, n1573, n1574, n1575, n1576, n1577, 
        n1578, n1579, n1580, n1581, n1582, n1583, n1584, n1585, n1586, n1587, 
        n1588, n1589, n1590, n1591, n1592, n1593, n1594, n1595, n1596, n1597, 
        n1598, n1599, n1600, n1601, n1602, n1603, n1604, n1605, n1606, n1607, 
        n1608, n1609, n1610, n1611, n1612, n1613, n1614, n1615, n1616, n1617, 
        n1618, n1619, n1620, n1621, n1622, n1623, n1624, n1625, n1626, n1627, 
        n1628, n1629, n1630, n1631, n1632, n1633, n1634, n1635, n1636, n1637, 
        n1638, n1639, n1640, n1641, n1642, n1643, n1644, n1645, n1646, n1647, 
        n1648, n1649, n1650, n1651, n1652, n1653, n1654, n1655, n1656, n1657, 
        n1658, n1659, n1660, n1661, n1662, n1663, n1664, n1665, n1666, n1667, 
        n1668, n1669, n1670, n1671, n1672, n1673, n1674, n1675, n1676, n1677, 
        n1678, n1679, n1680, n1681, n1682, n1683, n1684, n1685, n1686, n1687, 
        n1688, n1689, n1690, n1691, n1692, n1693, n1694, n1695, n1696, n1697, 
        n1698, n1699, n1700, n1701, n1702, n1703, n1704, n1705, n1706, n1707, 
        n1708, n1709, n1710, n1711, n1712, n1713, n1714, n1715, n1716, n1717, 
        n1718, n1719, n1720, n1721, n1722, n1723, n1724, n1725, n1726, n1727, 
        n1728, n1729, n1730, n1731, n1732, n1733, n1734, n1735, n1736, n1737, 
        n1738, n1739, n1740, n1741, n1742, n1743, n1744, n1745, n1746, n1747, 
        n1748, n1749, n1750, n1751, n1752, n1753, n1754, n1755, n1756, n1757, 
        n1758, n1759, n1760, n1761, n1762, n1763, n1764, n1765, n1766, n1767, 
        n1768, n1769, n1770, n1771, n1772, n1773, n1774, n1775, n1776, n1777, 
        n1778, n1779, n1780, n1781, n1782, n1783, n1784, n1785, n1786, n1787, 
        n1788, n1789, n1790, n1791, n1792, n1793, n1794, n1795, n1796, n1798, 
        n1799, n1800, n1801, n1802, n1803, n1804, n1805, n1806, n1807, n1808, 
        n1809, n1810, n1811, n1812, n1813, n1814, n1815, n1816, n1817, n1818, 
        n1819, n1820, n1821, n1822, n1823, n1824, n1825, n1826, n1827, n1828, 
        n1829, n1830, n1831, n1832, n1833, n1834, n1835, n1836, n1837, n1838, 
        n1839, n1840, n1841, n1842, n1843, n1844, n1845, n1846, n1847, n1848, 
        n1849, n1850, n1851, n1852, n1853, n1854, n1855, n1856, n1857, n1858, 
        n1859, n1860, n1861, n1862, n1863, n1864, n1865, n1866, n1867, n1868, 
        n1869, n1870, n1871, n1872, n1873, n1874, n1875, n1876, n1877, n1878, 
        n1879, n1880, n1881, n1882, n1883, n1884, n1885, n1886, n1887, n1888, 
        n1889, n1890, n1891, n1892, n1893, n1894, n1895, n1896, n1897, n1898, 
        n1899, n1900, n1901, n1902, n1903, n1904, n1905, n1906, n1907, n1908, 
        n1909, n1910, n1911, n1912, n1913, n1914, n1915, n1916, n1917, n1918, 
        n1919, n1920, n1921, n1922, n1923, n1924, n1925, n1926, n1927, n1928, 
        n1929, n1930, n1931, n1932, n1933, n1934, n1935, n1936, n1937, n1938, 
        n1939, n1940, n1941, n1942, n1943, n1944, n1945, n1946, n1947, n1948, 
        n1949, n1950, n1951, n1952, n1953, n1954, n1955, n1956, n1957, n1958, 
        n1959, n1960, n1961, n1962, n1963, n1964, n1965, n1966, n1967, n1968, 
        n1969, n1970, n1971, n1972, n1973, n1974, n1975, n1976, n1977, n1978, 
        n1979, n1980, n1981, n1982, n1983, n1984, n1985, n1986, n1987, n1988, 
        n1989, n1990, n1991, n1992, n1993, n1994, n1995, n1996, n1997, n1998, 
        n1999;
    wire SYNOPSYS_UNCONNECTED_1 , SYNOPSYS_UNCONNECTED_2 , 
	SYNOPSYS_UNCONNECTED_3 , SYNOPSYS_UNCONNECTED_4 ;
    assign alu_out[15] = \alu_out<15> ;
    assign alu_flags[1] = \alu_out<15> ;
    alu_DW01_sub_5_0 sub_190 ( .A({1'b0, alu_b[3], alu_b[2], alu_b[1], 
        alu_b[0]}), .B({1'b0, alu_a[3], alu_a[2], alu_a[1], alu_a[0]}), .CI(
        1'b0), .DIFF({\alu_flags64<4> , SYNOPSYS_UNCONNECTED_1, 
        SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4
        }) );
    alu_DW01_add_9_0 r65 ( .A({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        \*cell*885/U11/Z_3 , \*cell*885/U11/Z_2 , \*cell*885/U11/Z_1 , 
        \*cell*885/U11/Z_0 }), .B({1'b0, \*cell*885/U10/Z_7 , 
        \*cell*885/U10/Z_6 , \*cell*885/U10/Z_5 , \*cell*885/U10/Z_4 , 
        \*cell*885/U10/Z_3 , \*cell*885/U10/Z_2 , \*cell*885/U10/Z_1 , 
        \*cell*885/U10/Z_0 }), .CI(1'b0), .SUM({\alu_flags55<4> , 
        \alu_out53<7> , \alu_out53<6> , \alu_out53<5> , \alu_flags67<4> , 
        net970, net971, net972, net973}) );
    alu_DW01_sub_17_0 sub_187 ( .A({1'b0, alu_b[15], alu_b[14], alu_b[13], 
        alu_b[12], alu_b[11], alu_b[10], alu_b[9], alu_b[8], alu_b[7], 
        alu_b[6], alu_b[5], alu_b[4], alu_b[3], alu_b[2], alu_b[1], alu_b[0]}), 
        .B({1'b0, alu_a[15], alu_a[14], alu_a[13], alu_a[12], alu_a[11], 
        alu_a[10], alu_a[9], alu_a[8], alu_a[7], alu_a[6], alu_a[5], alu_a[4], 
        alu_a[3], alu_a[2], alu_a[1], alu_a[0]}), .CI(1'b0), .DIFF({
        \alu_flags64<2> , \alu_out63<15> , \alu_out63<14> , \alu_out63<13> , 
        \alu_out63<12> , \alu_out63<11> , \alu_out63<10> , \alu_out63<9> , 
        \alu_out63<8> , \alu_out63<7> , \alu_out63<6> , \alu_out63<5> , 
        \alu_out63<4> , \alu_out63<3> , \alu_out63<2> , \alu_out63<1> , 
        \alu_out63<0> }) );
    alu_DW01_add_17_0 r79 ( .A({1'b0, \*cell*885/U19/Z_15 , 
        \*cell*885/U19/Z_14 , \*cell*885/U19/Z_13 , \*cell*885/U19/Z_12 , 
        \*cell*885/U19/Z_11 , \*cell*885/U19/Z_10 , \*cell*885/U19/Z_9 , 
        \*cell*885/U19/Z_8 , \*cell*885/U19/Z_7 , \*cell*885/U19/Z_6 , 
        \*cell*885/U19/Z_5 , \*cell*885/U19/Z_4 , \*cell*885/U19/Z_3 , 
        \*cell*885/U19/Z_2 , \*cell*885/U19/Z_1 , \*cell*885/U19/Z_0 }), .B({
        1'b0, alu_a[15], alu_a[14], alu_a[13], alu_a[12], alu_a[11], alu_a[10], 
        alu_a[9], alu_a[8], alu_a[7], alu_a[6], alu_a[5], alu_a[4], alu_a[3], 
        alu_a[2], alu_a[1], alu_a[0]}), .CI(1'b0), .SUM({\alu_flags55<2> , 
        \alu_out53<15> , \alu_out53<14> , \alu_out53<13> , \alu_out53<12> , 
        \alu_out53<11> , \alu_out53<10> , \alu_out53<9> , \alu_out53<8> , 
        net957, net958, net959, net960, net961, net962, net963, net964}) );
    INV U563 ( .O(n1290), .I(n1021) );
    INV U564 ( .O(n1291), .I(n980) );
    OR4 U565 ( .O(n1251), .I3(alu_b[6]), .I2(n1290), .I1(alu_b[7]), .I0(n1291)
         );
    OR4 U566 ( .O(n1250), .I3(alu_b[8]), .I2(alu_b[9]), .I1(alu_b[10]), .I0(
        alu_b[11]) );
    OR4 U567 ( .O(n1249), .I3(alu_b[12]), .I2(alu_b[13]), .I1(alu_b[14]), .I0(
        alu_b[15]) );
    OR4 U568 ( .O(n1256), .I3(n1285), .I2(n1253), .I1(alu_a[14]), .I0(alu_a
        [15]) );
    OR4 U569 ( .O(n1255), .I3(alu_a[13]), .I2(alu_a[12]), .I1(alu_a[11]), .I0(
        alu_a[10]) );
    OR4 U570 ( .O(n1254), .I3(alu_a[9]), .I2(alu_a[8]), .I1(alu_a[7]), .I0(
        alu_a[6]) );
    OR4 U571 ( .O(n1285), .I3(alu_a[5]), .I2(alu_a[4]), .I1(alu_a[3]), .I0(
        alu_a[2]) );
    OR4 U572 ( .O(n1248), .I3(net957), .I2(net958), .I1(net959), .I0(net960)
         );
    OR4 U573 ( .O(n1247), .I3(net961), .I2(net962), .I1(net963), .I0(net964)
         );
    OR4 U574 ( .O(n1134), .I3(\alu_out53<14> ), .I2(\alu_out53<15> ), .I1(
        \alu_out53<13> ), .I0(\alu_out53<12> ) );
    OR4 U575 ( .O(n1133), .I3(\alu_out53<11> ), .I2(\alu_out53<10> ), .I1(
        \alu_out53<9> ), .I0(\alu_out53<8> ) );
    OR4 U576 ( .O(n1131), .I3(n1284), .I2(n1283), .I1(n1280), .I0(n1151) );
    OR4 U577 ( .O(n1130), .I3(n1239), .I2(n1234), .I1(n1229), .I0(n1224) );
    OR4 U578 ( .O(n1284), .I3(n1216), .I2(n1208), .I1(n1272), .I0(n1270) );
    OR4 U579 ( .O(n1283), .I3(n1268), .I2(n1266), .I1(n1264), .I0(n1184) );
    OR4 U580 ( .O(n1126), .I3(n1282), .I2(n1281), .I1(n1238), .I0(n1142) );
    OR4 U581 ( .O(n1125), .I3(n1233), .I2(n1228), .I1(n1220), .I0(n1212) );
    OR4 U582 ( .O(n1282), .I3(n1114), .I2(n1199), .I1(n1194), .I0(n1191) );
    OR4 U583 ( .O(n1281), .I3(n1188), .I2(n1185), .I1(n1182), .I0(n1178) );
    OR4 U584 ( .O(n1124), .I3(\alu_out63<0> ), .I2(\alu_out63<1> ), .I1(
        \alu_out63<2> ), .I0(\alu_out63<3> ) );
    OR4 U585 ( .O(n1138), .I3(\alu_out63<4> ), .I2(\alu_out63<5> ), .I1(
        \alu_out63<6> ), .I0(\alu_out63<14> ) );
    OR4 U586 ( .O(n1137), .I3(\alu_out63<15> ), .I2(\alu_out63<13> ), .I1(
        \alu_out63<12> ), .I0(\alu_out63<11> ) );
    OR4 U587 ( .O(n1136), .I3(\alu_out63<10> ), .I2(\alu_out63<9> ), .I1(
        \alu_out63<8> ), .I0(\alu_out63<7> ) );
    XOR2 U588 ( .O(n1280), .I1(alu_b[0]), .I0(alu_a[0]) );
    XOR2 U589 ( .O(n1239), .I1(alu_a[10]), .I0(alu_b[10]) );
    XOR2 U590 ( .O(n1234), .I1(alu_a[11]), .I0(alu_b[11]) );
    XOR2 U591 ( .O(n1229), .I1(alu_a[12]), .I0(alu_b[12]) );
    XOR2 U592 ( .O(n1224), .I1(alu_a[13]), .I0(alu_b[13]) );
    XOR2 U593 ( .O(n1216), .I1(alu_a[14]), .I0(alu_b[14]) );
    XOR2 U594 ( .O(n1208), .I1(alu_a[15]), .I0(alu_b[15]) );
    XOR2 U595 ( .O(n1272), .I1(alu_b[1]), .I0(alu_a[1]) );
    XOR2 U596 ( .O(n1270), .I1(alu_b[2]), .I0(alu_a[2]) );
    XOR2 U597 ( .O(n1268), .I1(alu_b[3]), .I0(alu_a[3]) );
    XOR2 U598 ( .O(n1266), .I1(alu_b[4]), .I0(alu_a[4]) );
    XOR2 U599 ( .O(n1264), .I1(alu_a[5]), .I0(alu_b[5]) );
    XOR2 U600 ( .O(n1184), .I1(alu_a[6]), .I0(alu_b[6]) );
    XOR2 U601 ( .O(n1150), .I1(alu_a[7]), .I0(alu_b[7]) );
    XOR2 U602 ( .O(n1149), .I1(alu_a[8]), .I0(alu_b[8]) );
    XOR2 U603 ( .O(n1148), .I1(alu_a[9]), .I0(alu_b[9]) );
    OR2 U604 ( .O(n1294), .I1(n1292), .I0(alu_b[0]) );
    NAND2 U605 ( .O(n1293), .I1(n1292), .I0(alu_a[0]) );
    OR2 U606 ( .O(n1292), .I1(alu_control[0]), .I0(alu_control[2]) );
    NAND2 U607 ( .O(\*cell*885/U10/Z_0 ), .I1(n1293), .I0(n1294) );
    OR2 U608 ( .O(n1297), .I1(n1295), .I0(alu_b[1]) );
    NAND2 U609 ( .O(n1296), .I1(n1295), .I0(alu_a[1]) );
    OR2 U610 ( .O(n1295), .I1(alu_control[0]), .I0(alu_control[2]) );
    NAND2 U611 ( .O(\*cell*885/U10/Z_1 ), .I1(n1296), .I0(n1297) );
    OR2 U612 ( .O(n1300), .I1(n1298), .I0(alu_b[2]) );
    NAND2 U613 ( .O(n1299), .I1(n1298), .I0(alu_a[2]) );
    OR2 U614 ( .O(n1298), .I1(alu_control[0]), .I0(alu_control[2]) );
    NAND2 U615 ( .O(\*cell*885/U10/Z_2 ), .I1(n1299), .I0(n1300) );
    OR2 U616 ( .O(n1303), .I1(n1301), .I0(alu_b[3]) );
    NAND2 U617 ( .O(n1302), .I1(n1301), .I0(alu_a[3]) );
    OR2 U618 ( .O(n1301), .I1(alu_control[0]), .I0(alu_control[2]) );
    NAND2 U619 ( .O(\*cell*885/U10/Z_3 ), .I1(n1302), .I0(n1303) );
    INV U620 ( .O(n1304), .I(alu_control[0]) );
    OR3 U621 ( .O(\*cell*885/U11/Z_0 ), .I2(alu_b[0]), .I1(n1304), .I0(
        alu_control[2]) );
    OR2 U622 ( .O(\*cell*885/U19/Z_0 ), .I1(alu_b[0]), .I0(alu_control[2]) );
    NOR2 U623 ( .O(n1305), .I1(n1252), .I0(n984) );
    OR3 U624 ( .O(n1253), .I2(alu_a[0]), .I1(n1305), .I0(alu_a[1]) );
    INV U625 ( .O(n1306), .I(n1042) );
    NOR4 U626 ( .O(n1252), .I3(n1306), .I2(n1251), .I1(n1250), .I0(n1249) );
    INV U627 ( .O(n1309), .I(n1308) );
    INV U628 ( .O(n1307), .I(n986) );
    OR3 U629 ( .O(n1308), .I2(n1248), .I1(n1247), .I0(n1307) );
    NOR2 U630 ( .O(n1132), .I1(n1309), .I0(n1122) );
    INV U631 ( .O(n1310), .I(n1311) );
    OR2 U632 ( .O(n1312), .I1(n1246), .I0(n1310) );
    NAND2 U633 ( .O(n1311), .I1(n1166), .I0(alu_a[15]) );
    AND2 U634 ( .O(n1245), .I1(n1312), .I0(n1021) );
    INV U635 ( .O(n1313), .I(alu_b[0]) );
    OR2 U636 ( .O(n1315), .I1(alu_a[14]), .I0(alu_b[0]) );
    OR2 U637 ( .O(n1314), .I1(n1313), .I0(alu_a[13]) );
    AND3 U638 ( .O(n1246), .I2(alu_b[1]), .I1(n1314), .I0(n1315) );
    INV U639 ( .O(n1316), .I(n1023) );
    NAND2 U640 ( .O(n1318), .I1(alu_b[2]), .I0(n1024) );
    OR2 U641 ( .O(n1317), .I1(alu_b[2]), .I0(n1316) );
    AND3 U642 ( .O(n1118), .I2(n1164), .I1(n1317), .I0(n1318) );
    INV U643 ( .O(n1319), .I(n1154) );
    AND2 U644 ( .O(n1320), .I1(alu_b[5]), .I0(n1093) );
    NOR2 U645 ( .O(n1321), .I1(alu_b[5]), .I0(n1319) );
    OR3 U646 ( .O(n1117), .I2(n1245), .I1(n1320), .I0(n1321) );
    INV U647 ( .O(n1323), .I(n1322) );
    NAND3 U648 ( .O(n1322), .I2(signedflag), .I1(n1120), .I0(n1094) );
    NOR2 U649 ( .O(n1244), .I1(n1323), .I0(n1113) );
    INV U650 ( .O(n1324), .I(n1326) );
    INV U651 ( .O(n1325), .I(alu_b[15]) );
    OR2 U652 ( .O(n1327), .I1(n988), .I0(n1324) );
    NAND2 U653 ( .O(n1326), .I1(n1325), .I0(n986) );
    AND2 U654 ( .O(n1243), .I1(n1327), .I0(\alu_out53<15> ) );
    INV U655 ( .O(n1328), .I(alu_a[0]) );
    OR2 U656 ( .O(n1330), .I1(n1155), .I0(n1328) );
    NAND2 U657 ( .O(n1329), .I1(n1112), .I0(\alu_out63<0> ) );
    NAND2 U658 ( .O(n1111), .I1(n1329), .I0(n1330) );
    NAND2 U659 ( .O(n1332), .I1(n988), .I0(net973) );
    NAND2 U660 ( .O(n1331), .I1(n1140), .I0(n978) );
    NAND2 U661 ( .O(n1110), .I1(n1331), .I0(n1332) );
    INV U662 ( .O(n1333), .I(n1107) );
    OR4 U663 ( .O(n1129), .I3(n1192), .I2(n1181), .I1(n1333), .I0(n1147) );
    INV U664 ( .O(n1334), .I(net973) );
    OR2 U665 ( .O(n1336), .I1(alu_a[2]), .I0(net973) );
    OR2 U666 ( .O(n1335), .I1(n1334), .I0(alu_a[3]) );
    AND3 U667 ( .O(n1242), .I2(net972), .I1(n1335), .I0(n1336) );
    INV U668 ( .O(n1337), .I(alu_a[1]) );
    NOR2 U669 ( .O(n1338), .I1(alu_a[0]), .I0(net973) );
    AND2 U670 ( .O(n1339), .I1(net973), .I0(n1337) );
    NOR3 U671 ( .O(n1241), .I2(n1338), .I1(n1339), .I0(net972) );
    INV U672 ( .O(n1340), .I(n1196) );
    NAND2 U673 ( .O(n1342), .I1(n1021), .I0(n1153) );
    OR2 U674 ( .O(n1341), .I1(n1025), .I0(n1340) );
    NAND2 U675 ( .O(n1240), .I1(n1341), .I0(n1342) );
    INV U676 ( .O(n1343), .I(n1120) );
    NAND2 U677 ( .O(n1345), .I1(n986), .I0(net964) );
    OR2 U678 ( .O(n1344), .I1(n1107), .I0(n1343) );
    NAND2 U679 ( .O(n1109), .I1(n1344), .I0(n1345) );
    INV U680 ( .O(n1347), .I(n1352) );
    INV U681 ( .O(n1351), .I(n982) );
    INV U682 ( .O(n1346), .I(alu_b[0]) );
    NAND3 U683 ( .O(n1350), .I2(n1346), .I1(n982), .I0(alu_a[0]) );
    OR2 U684 ( .O(n1349), .I1(n1348), .I0(n1346) );
    NOR2 U685 ( .O(n1348), .I1(n980), .I0(n1347) );
    NAND2 U686 ( .O(n1108), .I1(n1349), .I0(n1350) );
    OR2 U687 ( .O(n1352), .I1(alu_a[0]), .I0(n1351) );
    INV U688 ( .O(n1354), .I(n1068) );
    INV U689 ( .O(n1353), .I(n1010) );
    OR2 U690 ( .O(n1356), .I1(n1044), .I0(n1353) );
    OR2 U691 ( .O(n1355), .I1(n1045), .I0(n1354) );
    NAND2 U692 ( .O(n1105), .I1(n1355), .I0(n1356) );
    INV U693 ( .O(n1358), .I(n1116) );
    INV U694 ( .O(n1357), .I(n1102) );
    OR2 U695 ( .O(n1360), .I1(n1043), .I0(n1357) );
    OR2 U696 ( .O(n1359), .I1(n1041), .I0(n1358) );
    NAND2 U697 ( .O(n1104), .I1(n1359), .I0(n1360) );
    AND2 U698 ( .O(n1238), .I1(alu_b[10]), .I0(alu_a[10]) );
    INV U699 ( .O(n1362), .I(\alu_out53<10> ) );
    INV U700 ( .O(n1361), .I(alu_a[10]) );
    OR2 U701 ( .O(n1364), .I1(n1155), .I0(n1361) );
    OR2 U702 ( .O(n1363), .I1(n1156), .I0(n1362) );
    NAND2 U703 ( .O(n1236), .I1(n1363), .I0(n1364) );
    NAND2 U704 ( .O(n1366), .I1(alu_b[10]), .I0(n980) );
    NAND2 U705 ( .O(n1365), .I1(n1112), .I0(\alu_out63<10> ) );
    NAND2 U706 ( .O(n1235), .I1(n1365), .I0(n1366) );
    INV U707 ( .O(n1367), .I(n1090) );
    OR2 U708 ( .O(n1369), .I1(alu_b[2]), .I0(n1367) );
    NAND2 U709 ( .O(n1368), .I1(alu_b[2]), .I0(n1030) );
    AND3 U710 ( .O(n1101), .I2(n1168), .I1(n1368), .I0(n1369) );
    AND2 U711 ( .O(n1233), .I1(alu_b[11]), .I0(alu_a[11]) );
    INV U712 ( .O(n1371), .I(\alu_out53<11> ) );
    INV U713 ( .O(n1370), .I(alu_a[11]) );
    OR2 U714 ( .O(n1373), .I1(n1155), .I0(n1370) );
    OR2 U715 ( .O(n1372), .I1(n1156), .I0(n1371) );
    NAND2 U716 ( .O(n1231), .I1(n1372), .I0(n1373) );
    NAND2 U717 ( .O(n1375), .I1(alu_b[11]), .I0(n980) );
    NAND2 U718 ( .O(n1374), .I1(n1112), .I0(\alu_out63<11> ) );
    NAND2 U719 ( .O(n1230), .I1(n1374), .I0(n1375) );
    AND2 U720 ( .O(n1228), .I1(alu_b[12]), .I0(alu_a[12]) );
    INV U721 ( .O(n1377), .I(\alu_out53<12> ) );
    INV U722 ( .O(n1376), .I(alu_a[12]) );
    OR2 U723 ( .O(n1379), .I1(n1155), .I0(n1376) );
    OR2 U724 ( .O(n1378), .I1(n1156), .I0(n1377) );
    NAND2 U725 ( .O(n1226), .I1(n1378), .I0(n1379) );
    NAND2 U726 ( .O(n1381), .I1(alu_b[12]), .I0(n980) );
    NAND2 U727 ( .O(n1380), .I1(n1112), .I0(\alu_out63<12> ) );
    NAND2 U728 ( .O(n1225), .I1(n1380), .I0(n1381) );
    NAND4 U729 ( .O(n1128), .I3(n1106), .I2(n1103), .I1(n1099), .I0(n1097) );
    INV U730 ( .O(n1382), .I(alu_b[0]) );
    OR2 U731 ( .O(n1384), .I1(alu_a[11]), .I0(alu_b[0]) );
    OR2 U732 ( .O(n1383), .I1(n1382), .I0(alu_a[10]) );
    AND3 U733 ( .O(n1223), .I2(alu_b[1]), .I1(n1383), .I0(n1384) );
    INV U734 ( .O(n1385), .I(alu_a[12]) );
    NOR2 U735 ( .O(n1386), .I1(alu_a[13]), .I0(alu_b[0]) );
    AND2 U736 ( .O(n1387), .I1(alu_b[0]), .I0(n1385) );
    NOR3 U737 ( .O(n1222), .I2(n1386), .I1(n1387), .I0(alu_b[1]) );
    INV U738 ( .O(n1388), .I(n1014) );
    NAND2 U739 ( .O(n1390), .I1(alu_b[2]), .I0(n1015) );
    OR2 U740 ( .O(n1389), .I1(alu_b[2]), .I0(n1388) );
    AND3 U741 ( .O(n1221), .I2(n1164), .I1(n1389), .I0(n1390) );
    AND2 U742 ( .O(n1220), .I1(alu_b[13]), .I0(alu_a[13]) );
    INV U743 ( .O(n1392), .I(\alu_out53<13> ) );
    INV U744 ( .O(n1391), .I(alu_a[13]) );
    OR2 U745 ( .O(n1394), .I1(n1155), .I0(n1391) );
    OR2 U746 ( .O(n1393), .I1(n1156), .I0(n1392) );
    NAND2 U747 ( .O(n1218), .I1(n1393), .I0(n1394) );
    NAND2 U748 ( .O(n1396), .I1(alu_b[13]), .I0(n980) );
    NAND2 U749 ( .O(n1395), .I1(n1112), .I0(\alu_out63<13> ) );
    NAND2 U750 ( .O(n1217), .I1(n1395), .I0(n1396) );
    INV U751 ( .O(n1397), .I(alu_b[0]) );
    OR2 U752 ( .O(n1399), .I1(alu_a[12]), .I0(alu_b[0]) );
    OR2 U753 ( .O(n1398), .I1(n1397), .I0(alu_a[11]) );
    AND3 U754 ( .O(n1215), .I2(alu_b[1]), .I1(n1398), .I0(n1399) );
    INV U755 ( .O(n1400), .I(alu_a[13]) );
    NOR2 U756 ( .O(n1401), .I1(alu_a[14]), .I0(alu_b[0]) );
    AND2 U757 ( .O(n1402), .I1(alu_b[0]), .I0(n1400) );
    NOR3 U758 ( .O(n1214), .I2(n1401), .I1(n1402), .I0(alu_b[1]) );
    INV U759 ( .O(n1403), .I(n1041) );
    NAND2 U760 ( .O(n1405), .I1(alu_b[2]), .I0(n1043) );
    OR2 U761 ( .O(n1404), .I1(alu_b[2]), .I0(n1403) );
    AND3 U762 ( .O(n1213), .I2(n1164), .I1(n1404), .I0(n1405) );
    AND2 U763 ( .O(n1212), .I1(alu_b[14]), .I0(alu_a[14]) );
    INV U764 ( .O(n1407), .I(\alu_out53<14> ) );
    INV U765 ( .O(n1406), .I(alu_a[14]) );
    OR2 U766 ( .O(n1409), .I1(n1155), .I0(n1406) );
    OR2 U767 ( .O(n1408), .I1(n1156), .I0(n1407) );
    NAND2 U768 ( .O(n1210), .I1(n1408), .I0(n1409) );
    NAND2 U769 ( .O(n1411), .I1(alu_b[14]), .I0(n980) );
    NAND2 U770 ( .O(n1410), .I1(n1112), .I0(\alu_out63<14> ) );
    NAND2 U771 ( .O(n1209), .I1(n1410), .I0(n1411) );
    INV U772 ( .O(n1412), .I(alu_b[0]) );
    OR2 U773 ( .O(n1414), .I1(alu_a[13]), .I0(alu_b[0]) );
    OR2 U774 ( .O(n1413), .I1(n1412), .I0(alu_a[12]) );
    AND3 U775 ( .O(n1207), .I2(alu_b[1]), .I1(n1413), .I0(n1414) );
    INV U776 ( .O(n1415), .I(alu_b[0]) );
    NOR2 U777 ( .O(n1416), .I1(n1415), .I0(alu_a[14]) );
    NOR2 U778 ( .O(n1417), .I1(alu_a[15]), .I0(alu_b[0]) );
    NOR3 U779 ( .O(n1206), .I2(n1416), .I1(n1417), .I0(alu_b[1]) );
    INV U780 ( .O(n1419), .I(\alu_out53<15> ) );
    INV U781 ( .O(n1418), .I(alu_a[15]) );
    OR2 U782 ( .O(n1421), .I1(n1155), .I0(n1418) );
    OR2 U783 ( .O(n1420), .I1(n1156), .I0(n1419) );
    NAND2 U784 ( .O(n1205), .I1(n1420), .I0(n1421) );
    AND2 U785 ( .O(n1114), .I1(alu_b[15]), .I0(alu_a[15]) );
    NAND2 U786 ( .O(n1423), .I1(n1112), .I0(\alu_out63<15> ) );
    NAND2 U787 ( .O(n1422), .I1(n1114), .I0(n978) );
    NAND2 U788 ( .O(n1203), .I1(n1422), .I0(n1423) );
    INV U789 ( .O(n1424), .I(alu_a[1]) );
    OR2 U790 ( .O(n1426), .I1(n1155), .I0(n1424) );
    NAND2 U791 ( .O(n1425), .I1(n1112), .I0(\alu_out63<1> ) );
    NAND2 U792 ( .O(n1089), .I1(n1425), .I0(n1426) );
    NAND2 U793 ( .O(n1428), .I1(n988), .I0(net972) );
    NAND2 U794 ( .O(n1427), .I1(n1178), .I0(n978) );
    NAND2 U795 ( .O(n1088), .I1(n1427), .I0(n1428) );
    INV U796 ( .O(n1429), .I(net973) );
    OR2 U797 ( .O(n1431), .I1(alu_a[3]), .I0(net973) );
    OR2 U798 ( .O(n1430), .I1(n1429), .I0(alu_a[4]) );
    AND3 U799 ( .O(n1202), .I2(net972), .I1(n1430), .I0(n1431) );
    INV U800 ( .O(n1432), .I(alu_a[2]) );
    NOR2 U801 ( .O(n1433), .I1(alu_a[1]), .I0(net973) );
    AND2 U802 ( .O(n1434), .I1(net973), .I0(n1432) );
    NOR3 U803 ( .O(n1201), .I2(n1433), .I1(n1434), .I0(net972) );
    INV U804 ( .O(n1435), .I(n1018) );
    OR2 U805 ( .O(n1437), .I1(net971), .I0(n1435) );
    NAND2 U806 ( .O(n1436), .I1(net971), .I0(n1017) );
    AND3 U807 ( .O(n1200), .I2(n1012), .I1(n1436), .I0(n1437) );
    INV U808 ( .O(n1438), .I(n1120) );
    NAND2 U809 ( .O(n1440), .I1(n986), .I0(net963) );
    OR2 U810 ( .O(n1439), .I1(n1085), .I0(n1438) );
    NAND2 U811 ( .O(n1087), .I1(n1439), .I0(n1440) );
    INV U812 ( .O(n1442), .I(n1447) );
    INV U813 ( .O(n1446), .I(n982) );
    INV U814 ( .O(n1441), .I(alu_b[1]) );
    NAND3 U815 ( .O(n1445), .I2(n1441), .I1(n982), .I0(alu_a[1]) );
    OR2 U816 ( .O(n1444), .I1(n1443), .I0(n1441) );
    NOR2 U817 ( .O(n1443), .I1(n980), .I0(n1442) );
    NAND2 U818 ( .O(n1086), .I1(n1444), .I0(n1445) );
    OR2 U819 ( .O(n1447), .I1(alu_a[1]), .I0(n1446) );
    INV U820 ( .O(n1448), .I(alu_a[2]) );
    OR2 U821 ( .O(n1450), .I1(n1155), .I0(n1448) );
    NAND2 U822 ( .O(n1449), .I1(n1112), .I0(\alu_out63<2> ) );
    NAND2 U823 ( .O(n1084), .I1(n1449), .I0(n1450) );
    NAND2 U824 ( .O(n1452), .I1(n988), .I0(net971) );
    NAND2 U825 ( .O(n1451), .I1(n1199), .I0(n978) );
    NAND2 U826 ( .O(n1083), .I1(n1451), .I0(n1452) );
    AND2 U827 ( .O(n1199), .I1(alu_a[2]), .I0(alu_b[2]) );
    INV U828 ( .O(n1454), .I(n1021) );
    INV U829 ( .O(n1453), .I(n1010) );
    OR2 U830 ( .O(n1456), .I1(n1046), .I0(n1453) );
    OR2 U831 ( .O(n1455), .I1(n1043), .I0(n1454) );
    NAND2 U832 ( .O(n1079), .I1(n1455), .I0(n1456) );
    INV U833 ( .O(n1457), .I(n1458) );
    OR2 U834 ( .O(n1459), .I1(n1197), .I0(n1457) );
    NAND2 U835 ( .O(n1458), .I1(n1016), .I0(alu_a[2]) );
    AND2 U836 ( .O(n1195), .I1(n1459), .I0(n1068) );
    INV U837 ( .O(n1460), .I(alu_a[3]) );
    INV U838 ( .O(n1461), .I(net973) );
    OR3 U839 ( .O(n1463), .I2(n1461), .I1(net972), .I0(n1460) );
    NAND3 U840 ( .O(n1462), .I2(n1461), .I1(net972), .I0(alu_a[4]) );
    NAND2 U841 ( .O(n1197), .I1(n1462), .I0(n1463) );
    INV U842 ( .O(n1464), .I(\alu_flags67<4> ) );
    AND4 U843 ( .O(n1196), .I3(n1464), .I2(alu_b[5]), .I1(net970), .I0(net971)
         );
    INV U844 ( .O(n1465), .I(n1120) );
    NAND2 U845 ( .O(n1467), .I1(n986), .I0(net962) );
    OR2 U846 ( .O(n1466), .I1(n1080), .I0(n1465) );
    NAND2 U847 ( .O(n1082), .I1(n1466), .I0(n1467) );
    INV U848 ( .O(n1469), .I(n1474) );
    INV U849 ( .O(n1473), .I(n982) );
    INV U850 ( .O(n1468), .I(alu_b[2]) );
    NAND3 U851 ( .O(n1472), .I2(n1468), .I1(n982), .I0(alu_a[2]) );
    OR2 U852 ( .O(n1471), .I1(n1470), .I0(n1468) );
    NOR2 U853 ( .O(n1470), .I1(n980), .I0(n1469) );
    NAND2 U854 ( .O(n1081), .I1(n1471), .I0(n1472) );
    OR2 U855 ( .O(n1474), .I1(alu_a[2]), .I0(n1473) );
    INV U856 ( .O(n1475), .I(alu_a[3]) );
    OR2 U857 ( .O(n1477), .I1(n1155), .I0(n1475) );
    NAND2 U858 ( .O(n1476), .I1(n1112), .I0(\alu_out63<3> ) );
    NAND2 U859 ( .O(n1078), .I1(n1476), .I0(n1477) );
    NAND2 U860 ( .O(n1479), .I1(n988), .I0(net970) );
    NAND2 U861 ( .O(n1478), .I1(n1194), .I0(n978) );
    NAND2 U862 ( .O(n1077), .I1(n1478), .I0(n1479) );
    AND2 U863 ( .O(n1194), .I1(alu_a[3]), .I0(alu_b[3]) );
    NAND4 U864 ( .O(n1192), .I3(n1096), .I2(n1085), .I1(n1080), .I0(n1074) );
    INV U865 ( .O(n1481), .I(n1021) );
    INV U866 ( .O(n1480), .I(n1010) );
    OR2 U867 ( .O(n1483), .I1(n1033), .I0(n1480) );
    OR2 U868 ( .O(n1482), .I1(n1031), .I0(n1481) );
    NAND2 U869 ( .O(n1072), .I1(n1482), .I0(n1483) );
    INV U870 ( .O(n1485), .I(n1484) );
    NAND3 U871 ( .O(n1484), .I2(n1121), .I1(n1188), .I0(n1170) );
    OR2 U872 ( .O(n1071), .I1(n1070), .I0(n1485) );
    INV U873 ( .O(n1486), .I(net972) );
    OR2 U874 ( .O(n1488), .I1(alu_a[4]), .I0(net972) );
    OR2 U875 ( .O(n1487), .I1(n1486), .I0(alu_a[6]) );
    AND3 U876 ( .O(n1069), .I2(net973), .I1(n1487), .I0(n1488) );
    INV U877 ( .O(n1489), .I(n1120) );
    NAND2 U878 ( .O(n1491), .I1(n986), .I0(net961) );
    OR2 U879 ( .O(n1490), .I1(n1074), .I0(n1489) );
    NAND2 U880 ( .O(n1076), .I1(n1490), .I0(n1491) );
    INV U881 ( .O(n1493), .I(n1498) );
    INV U882 ( .O(n1497), .I(n982) );
    INV U883 ( .O(n1492), .I(alu_b[3]) );
    NAND3 U884 ( .O(n1496), .I2(n1492), .I1(n982), .I0(alu_a[3]) );
    OR2 U885 ( .O(n1495), .I1(n1494), .I0(n1492) );
    NOR2 U886 ( .O(n1494), .I1(n980), .I0(n1493) );
    NAND2 U887 ( .O(n1075), .I1(n1495), .I0(n1496) );
    OR2 U888 ( .O(n1498), .I1(alu_a[3]), .I0(n1497) );
    INV U889 ( .O(n1499), .I(alu_a[4]) );
    OR2 U890 ( .O(n1501), .I1(n1155), .I0(n1499) );
    NAND2 U891 ( .O(n1500), .I1(n1112), .I0(\alu_out63<4> ) );
    NAND2 U892 ( .O(n1067), .I1(n1500), .I0(n1501) );
    NAND2 U893 ( .O(n1503), .I1(n988), .I0(\alu_flags67<4> ) );
    NAND2 U894 ( .O(n1502), .I1(n1191), .I0(n978) );
    NAND2 U895 ( .O(n1066), .I1(n1502), .I0(n1503) );
    AND2 U896 ( .O(n1191), .I1(alu_a[4]), .I0(alu_b[4]) );
    INV U897 ( .O(n1504), .I(n1120) );
    NAND2 U898 ( .O(n1506), .I1(n986), .I0(net960) );
    OR2 U899 ( .O(n1505), .I1(n1063), .I0(n1504) );
    NAND2 U900 ( .O(n1065), .I1(n1505), .I0(n1506) );
    INV U901 ( .O(n1508), .I(n1513) );
    INV U902 ( .O(n1512), .I(n982) );
    INV U903 ( .O(n1507), .I(alu_b[4]) );
    NAND3 U904 ( .O(n1511), .I2(n1507), .I1(n982), .I0(alu_a[4]) );
    OR2 U905 ( .O(n1510), .I1(n1509), .I0(n1507) );
    NOR2 U906 ( .O(n1509), .I1(n980), .I0(n1508) );
    NAND2 U907 ( .O(n1064), .I1(n1510), .I0(n1511) );
    OR2 U908 ( .O(n1513), .I1(alu_a[4]), .I0(n1512) );
    INV U909 ( .O(n1514), .I(alu_a[5]) );
    OR2 U910 ( .O(n1516), .I1(n1155), .I0(n1514) );
    NAND2 U911 ( .O(n1515), .I1(n1112), .I0(\alu_out63<5> ) );
    NAND2 U912 ( .O(n1061), .I1(n1515), .I0(n1516) );
    NAND2 U913 ( .O(n1518), .I1(n988), .I0(\alu_out53<5> ) );
    NAND2 U914 ( .O(n1517), .I1(n1188), .I0(n978) );
    NAND2 U915 ( .O(n1060), .I1(n1517), .I0(n1518) );
    AND2 U916 ( .O(n1188), .I1(alu_b[5]), .I0(alu_a[5]) );
    INV U917 ( .O(n1520), .I(n1068) );
    INV U918 ( .O(n1519), .I(n1010) );
    OR2 U919 ( .O(n1522), .I1(n1018), .I0(n1519) );
    OR2 U920 ( .O(n1521), .I1(n1054), .I0(n1520) );
    NAND2 U921 ( .O(n1056), .I1(n1521), .I0(n1522) );
    INV U922 ( .O(n1524), .I(n1180) );
    INV U923 ( .O(n1523), .I(n1116) );
    OR2 U924 ( .O(n1526), .I1(n1015), .I0(n1523) );
    OR2 U925 ( .O(n1525), .I1(n1017), .I0(n1524) );
    NAND2 U926 ( .O(n1055), .I1(n1525), .I0(n1526) );
    INV U927 ( .O(n1527), .I(n1120) );
    NAND2 U928 ( .O(n1529), .I1(n986), .I0(net959) );
    OR2 U929 ( .O(n1528), .I1(n1057), .I0(n1527) );
    NAND2 U930 ( .O(n1059), .I1(n1528), .I0(n1529) );
    INV U931 ( .O(n1531), .I(n1536) );
    INV U932 ( .O(n1535), .I(n982) );
    INV U933 ( .O(n1530), .I(alu_b[5]) );
    NAND3 U934 ( .O(n1534), .I2(n1530), .I1(n982), .I0(alu_a[5]) );
    OR2 U935 ( .O(n1533), .I1(n1532), .I0(n1530) );
    NOR2 U936 ( .O(n1532), .I1(n980), .I0(n1531) );
    NAND2 U937 ( .O(n1058), .I1(n1533), .I0(n1534) );
    OR2 U938 ( .O(n1536), .I1(alu_a[5]), .I0(n1535) );
    NAND2 U939 ( .O(n1539), .I1(n980), .I0(alu_b[6]) );
    NAND2 U940 ( .O(n1538), .I1(n1537), .I0(alu_a[6]) );
    OR2 U941 ( .O(n1537), .I1(n980), .I0(n984) );
    NAND2 U942 ( .O(n1053), .I1(n1538), .I0(n1539) );
    AND2 U943 ( .O(n1185), .I1(alu_b[6]), .I0(alu_a[6]) );
    NAND2 U944 ( .O(n1541), .I1(n1112), .I0(\alu_out63<6> ) );
    NAND2 U945 ( .O(n1540), .I1(n1185), .I0(n978) );
    NAND2 U946 ( .O(n1052), .I1(n1540), .I0(n1541) );
    NAND2 U947 ( .O(n1543), .I1(n986), .I0(net958) );
    NAND2 U948 ( .O(n1542), .I1(n988), .I0(\alu_out53<6> ) );
    NAND2 U949 ( .O(n1051), .I1(n1542), .I0(n1543) );
    INV U950 ( .O(n1544), .I(n1120) );
    OR2 U951 ( .O(n1546), .I1(n1049), .I0(n1544) );
    NAND2 U952 ( .O(n1545), .I1(n1184), .I0(n982) );
    NAND2 U953 ( .O(n1050), .I1(n1545), .I0(n1546) );
    INV U954 ( .O(n1548), .I(n1068) );
    INV U955 ( .O(n1547), .I(n1010) );
    OR2 U956 ( .O(n1550), .I1(n1045), .I0(n1547) );
    OR2 U957 ( .O(n1549), .I1(n1046), .I0(n1548) );
    NAND2 U958 ( .O(n1048), .I1(n1549), .I0(n1550) );
    INV U959 ( .O(n1552), .I(n1180) );
    INV U960 ( .O(n1551), .I(n1116) );
    OR2 U961 ( .O(n1554), .I1(n1043), .I0(n1551) );
    OR2 U962 ( .O(n1553), .I1(n1044), .I0(n1552) );
    NAND2 U963 ( .O(n1047), .I1(n1553), .I0(n1554) );
    NAND2 U964 ( .O(n1557), .I1(n980), .I0(alu_b[7]) );
    NAND2 U965 ( .O(n1556), .I1(n1555), .I0(alu_a[7]) );
    OR2 U966 ( .O(n1555), .I1(n980), .I0(n984) );
    NAND2 U967 ( .O(n1040), .I1(n1556), .I0(n1557) );
    AND2 U968 ( .O(n1182), .I1(alu_b[7]), .I0(alu_a[7]) );
    NAND2 U969 ( .O(n1559), .I1(n1112), .I0(\alu_out63<7> ) );
    NAND2 U970 ( .O(n1558), .I1(n1182), .I0(n978) );
    NAND2 U971 ( .O(n1039), .I1(n1558), .I0(n1559) );
    NAND2 U972 ( .O(n1561), .I1(n986), .I0(net957) );
    NAND2 U973 ( .O(n1560), .I1(n988), .I0(\alu_out53<7> ) );
    NAND2 U974 ( .O(n1038), .I1(n1560), .I0(n1561) );
    INV U975 ( .O(n1562), .I(n1120) );
    OR2 U976 ( .O(n1564), .I1(n1036), .I0(n1562) );
    NAND2 U977 ( .O(n1563), .I1(n1150), .I0(n982) );
    NAND2 U978 ( .O(n1037), .I1(n1563), .I0(n1564) );
    NAND4 U979 ( .O(n1181), .I3(n1063), .I2(n1057), .I1(n1049), .I0(n1036) );
    INV U980 ( .O(n1566), .I(n1068) );
    INV U981 ( .O(n1565), .I(n1010) );
    OR2 U982 ( .O(n1568), .I1(n1032), .I0(n1565) );
    OR2 U983 ( .O(n1567), .I1(n1033), .I0(n1566) );
    NAND2 U984 ( .O(n1035), .I1(n1567), .I0(n1568) );
    INV U985 ( .O(n1569), .I(n1116) );
    OR2 U986 ( .O(n1571), .I1(n1031), .I0(n1569) );
    NAND2 U987 ( .O(n1570), .I1(n1180), .I0(n1092) );
    NAND2 U988 ( .O(n1034), .I1(n1570), .I0(n1571) );
    INV U989 ( .O(n1572), .I(alu_b[5]) );
    INV U990 ( .O(n1573), .I(net970) );
    NOR4 U991 ( .O(n1180), .I3(net971), .I2(\alu_flags67<4> ), .I1(n1572), 
        .I0(n1573) );
    INV U992 ( .O(n1575), .I(n1068) );
    INV U993 ( .O(n1574), .I(n1010) );
    OR2 U994 ( .O(n1577), .I1(n1025), .I0(n1574) );
    OR2 U995 ( .O(n1576), .I1(n1026), .I0(n1575) );
    NAND2 U996 ( .O(n1028), .I1(n1576), .I0(n1577) );
    AND2 U997 ( .O(n1178), .I1(alu_a[1]), .I0(alu_b[1]) );
    INV U998 ( .O(n1578), .I(n1116) );
    NAND2 U999 ( .O(n1580), .I1(n1102), .I0(n1153) );
    OR2 U1000 ( .O(n1579), .I1(n1024), .I0(n1578) );
    NAND2 U1001 ( .O(n1027), .I1(n1579), .I0(n1580) );
    AND2 U1002 ( .O(n1141), .I1(alu_b[8]), .I0(alu_a[8]) );
    INV U1003 ( .O(n1582), .I(\alu_out53<8> ) );
    INV U1004 ( .O(n1581), .I(alu_a[8]) );
    OR2 U1005 ( .O(n1584), .I1(n1155), .I0(n1581) );
    OR2 U1006 ( .O(n1583), .I1(n1156), .I0(n1582) );
    NAND2 U1007 ( .O(n1175), .I1(n1583), .I0(n1584) );
    NAND2 U1008 ( .O(n1586), .I1(alu_b[8]), .I0(n980) );
    NAND2 U1009 ( .O(n1585), .I1(n1112), .I0(\alu_out63<8> ) );
    NAND2 U1010 ( .O(n1174), .I1(n1585), .I0(n1586) );
    NOR4 U1011 ( .O(n1021), .I3(alu_b[5]), .I2(alu_b[2]), .I1(alu_b[3]), .I0(
        alu_b[4]) );
    AND2 U1012 ( .O(n1172), .I1(net972), .I0(net973) );
    INV U1013 ( .O(n1588), .I(n1068) );
    INV U1014 ( .O(n1587), .I(n1010) );
    OR2 U1015 ( .O(n1590), .I1(n1017), .I0(n1587) );
    OR2 U1016 ( .O(n1589), .I1(n1018), .I0(n1588) );
    NAND2 U1017 ( .O(n1020), .I1(n1589), .I0(n1590) );
    INV U1018 ( .O(n1591), .I(net972) );
    NOR2 U1019 ( .O(n1170), .I1(net973), .I0(n1591) );
    INV U1020 ( .O(n1592), .I(alu_b[2]) );
    NOR4 U1021 ( .O(n1116), .I3(n1592), .I2(alu_b[5]), .I1(alu_b[3]), .I0(
        alu_b[4]) );
    NOR3 U1022 ( .O(n1168), .I2(alu_b[3]), .I1(alu_b[4]), .I0(alu_b[5]) );
    INV U1023 ( .O(n1593), .I(alu_b[0]) );
    NOR2 U1024 ( .O(n1166), .I1(alu_b[1]), .I0(n1593) );
    INV U1025 ( .O(n1595), .I(n1116) );
    INV U1026 ( .O(n1594), .I(n1102) );
    OR2 U1027 ( .O(n1597), .I1(n1015), .I0(n1594) );
    OR2 U1028 ( .O(n1596), .I1(n1014), .I0(n1595) );
    NAND2 U1029 ( .O(n1019), .I1(n1596), .I0(n1597) );
    INV U1030 ( .O(n1598), .I(alu_b[3]) );
    NOR3 U1031 ( .O(n1164), .I2(alu_b[5]), .I1(alu_b[4]), .I0(n1598) );
    NOR2 U1032 ( .O(n1091), .I1(alu_b[5]), .I0(alu_b[4]) );
    AND2 U1033 ( .O(n1140), .I1(alu_a[0]), .I0(alu_b[0]) );
    AND2 U1034 ( .O(n1139), .I1(alu_b[9]), .I0(alu_a[9]) );
    INV U1035 ( .O(n1600), .I(\alu_out53<9> ) );
    INV U1036 ( .O(n1599), .I(alu_a[9]) );
    OR2 U1037 ( .O(n1602), .I1(n1155), .I0(n1599) );
    OR2 U1038 ( .O(n1601), .I1(n1156), .I0(n1600) );
    NAND2 U1039 ( .O(n1159), .I1(n1601), .I0(n1602) );
    INV U1040 ( .O(n1603), .I(alu_control[1]) );
    NOR3 U1041 ( .O(n1112), .I2(alu_control[2]), .I1(alu_control[0]), .I0(
        n1603) );
    NAND2 U1042 ( .O(n1605), .I1(alu_b[9]), .I0(n980) );
    NAND2 U1043 ( .O(n1604), .I1(n1112), .I0(\alu_out63<9> ) );
    NAND2 U1044 ( .O(n1157), .I1(n1604), .I0(n1605) );
    INV U1045 ( .O(n1606), .I(n1153) );
    INV U1046 ( .O(n1607), .I(alu_b[4]) );
    NOR4 U1047 ( .O(n1154), .I3(alu_b[3]), .I2(alu_b[2]), .I1(n1606), .I0(
        n1607) );
    INV U1048 ( .O(n1608), .I(n982) );
    OR4 U1049 ( .O(n1151), .I3(n1150), .I2(n1149), .I1(n1608), .I0(n1148) );
    NAND4 U1050 ( .O(n1147), .I3(n1120), .I2(n1094), .I1(n1029), .I0(n1022) );
    INV U1051 ( .O(n1609), .I(alu_b[5]) );
    NOR4 U1052 ( .O(n1068), .I3(n1609), .I2(\alu_flags67<4> ), .I1(net970), 
        .I0(net971) );
    NOR2 U1053 ( .O(n1100), .I1(\alu_flags67<4> ), .I0(net970) );
    INV U1054 ( .O(n1610), .I(n978) );
    OR4 U1055 ( .O(n1142), .I3(n1141), .I2(n1140), .I1(n1610), .I0(n1139) );
    INV U1056 ( .O(n1611), .I(n1112) );
    OR4 U1057 ( .O(n1123), .I3(n1138), .I2(n1137), .I1(n1611), .I0(n1136) );
    OR3 U1058 ( .O(n1613), .I2(alu_control[2]), .I1(alu_control[0]), .I0(alu_b
        [4]) );
    NAND2 U1059 ( .O(n1612), .I1(alu_control[2]), .I0(alu_a[4]) );
    NAND2 U1060 ( .O(\*cell*885/U10/Z_4 ), .I1(n1612), .I0(n1613) );
    INV U1061 ( .O(n1615), .I(n1614) );
    OR3 U1062 ( .O(n1614), .I2(n1133), .I1(n1132), .I0(n1134) );
    OR2 U1063 ( .O(n1135), .I1(n1127), .I0(n1615) );
    OR2 U1064 ( .O(n1617), .I1(n1124), .I0(n1123) );
    OR2 U1065 ( .O(n1616), .I1(n1126), .I0(n1125) );
    NAND2 U1066 ( .O(n1127), .I1(n1616), .I0(n1617) );
    INV U1067 ( .O(n1618), .I(n1116) );
    NOR2 U1068 ( .O(n1619), .I1(n1618), .I0(n1098) );
    NOR3 U1069 ( .O(n1119), .I2(n1118), .I1(n1117), .I0(n1619) );
    INV U1070 ( .O(n1622), .I(n1621) );
    INV U1071 ( .O(n1620), .I(\alu_out53<15> ) );
    NAND3 U1072 ( .O(n1621), .I2(n986), .I1(n1620), .I0(n1114) );
    OR2 U1073 ( .O(alu_flags[3]), .I1(n1115), .I0(n1622) );
    INV U1074 ( .O(n1623), .I(alu_b[15]) );
    NAND3 U1075 ( .O(n1624), .I2(\alu_out63<15> ), .I1(n1623), .I0(n1112) );
    NAND2 U1076 ( .O(n1113), .I1(n1624), .I0(alu_a[15]) );
    OR4 U1077 ( .O(alu_out[0]), .I3(n1111), .I2(n1110), .I1(n1109), .I0(n1108)
         );
    INV U1078 ( .O(n1625), .I(n1021) );
    NOR2 U1079 ( .O(n1626), .I1(n1625), .I0(n1095) );
    NOR3 U1080 ( .O(n1106), .I2(n1105), .I1(n1104), .I0(n1626) );
    NAND2 U1081 ( .O(n1628), .I1(n1092), .I0(n1068) );
    NAND2 U1082 ( .O(n1627), .I1(n1093), .I0(n1091) );
    AND2 U1083 ( .O(n1094), .I1(n1627), .I0(n1628) );
    OR4 U1084 ( .O(alu_out[1]), .I3(n1089), .I2(n1088), .I1(n1087), .I0(n1086)
         );
    OR4 U1085 ( .O(alu_out[2]), .I3(n1084), .I2(n1083), .I1(n1082), .I0(n1081)
         );
    OR4 U1086 ( .O(alu_out[3]), .I3(n1078), .I2(n1077), .I1(n1076), .I0(n1075)
         );
    AND2 U1087 ( .O(n1629), .I1(n1073), .I0(n1012) );
    NOR3 U1088 ( .O(n1074), .I2(n1072), .I1(n1071), .I0(n1629) );
    INV U1089 ( .O(n1630), .I(n1631) );
    OR2 U1090 ( .O(n1632), .I1(n1069), .I0(n1630) );
    NAND2 U1091 ( .O(n1631), .I1(n1016), .I0(alu_a[3]) );
    AND2 U1092 ( .O(n1070), .I1(n1632), .I0(n1068) );
    OR4 U1093 ( .O(alu_out[4]), .I3(n1067), .I2(n1066), .I1(n1065), .I0(n1064)
         );
    OR4 U1094 ( .O(alu_out[5]), .I3(n1061), .I2(n1060), .I1(n1059), .I0(n1058)
         );
    INV U1095 ( .O(n1633), .I(n1021) );
    NOR2 U1096 ( .O(n1634), .I1(n1633), .I0(n1014) );
    NOR3 U1097 ( .O(n1057), .I2(n1056), .I1(n1055), .I0(n1634) );
    OR4 U1098 ( .O(alu_out[6]), .I3(n1053), .I2(n1052), .I1(n1051), .I0(n1050)
         );
    INV U1099 ( .O(n1635), .I(n1021) );
    NOR2 U1100 ( .O(n1636), .I1(n1635), .I0(n1041) );
    NOR3 U1101 ( .O(n1049), .I2(n1048), .I1(n1047), .I0(n1636) );
    INV U1102 ( .O(n1637), .I(alu_a[15]) );
    NOR2 U1103 ( .O(n1638), .I1(alu_a[14]), .I0(net973) );
    AND2 U1104 ( .O(n1639), .I1(net973), .I0(n1637) );
    OR3 U1105 ( .O(n1044), .I2(net972), .I1(n1638), .I0(n1639) );
    OR4 U1106 ( .O(alu_out[7]), .I3(n1040), .I2(n1039), .I1(n1038), .I0(n1037)
         );
    INV U1107 ( .O(n1640), .I(n1021) );
    NOR2 U1108 ( .O(n1641), .I1(n1640), .I0(n1030) );
    NOR3 U1109 ( .O(n1036), .I2(n1035), .I1(n1034), .I0(n1641) );
    INV U1110 ( .O(n1642), .I(n1021) );
    NOR2 U1111 ( .O(n1643), .I1(n1642), .I0(n1023) );
    NOR3 U1112 ( .O(n1029), .I2(n1028), .I1(n1027), .I0(n1643) );
    INV U1113 ( .O(n1644), .I(n1021) );
    NOR2 U1114 ( .O(n1645), .I1(n1644), .I0(n1013) );
    NOR3 U1115 ( .O(n1022), .I2(n1020), .I1(n1019), .I0(n1645) );
    INV U1116 ( .O(n1646), .I(alu_a[0]) );
    NOR2 U1117 ( .O(n1647), .I1(alu_a[1]), .I0(alu_b[0]) );
    AND2 U1118 ( .O(n1648), .I1(alu_b[0]), .I0(n1646) );
    OR3 U1119 ( .O(n1015), .I2(alu_b[1]), .I1(n1647), .I0(n1648) );
    INV U1120 ( .O(n1649), .I(\alu_flags67<4> ) );
    AND3 U1121 ( .O(n1012), .I2(net970), .I1(n1649), .I0(alu_b[5]) );
    INV U1122 ( .O(n1650), .I(alu_b[5]) );
    INV U1123 ( .O(n1651), .I(net971) );
    NOR4 U1124 ( .O(n1010), .I3(net970), .I2(\alu_flags67<4> ), .I1(n1650), 
        .I0(n1651) );
    INV U1125 ( .O(n1652), .I(alu_b[1]) );
    NOR2 U1126 ( .O(\*cell*885/U19/Z_1 ), .I1(alu_control[2]), .I0(n1652) );
    INV U1127 ( .O(n1653), .I(alu_b[2]) );
    NOR2 U1128 ( .O(\*cell*885/U19/Z_2 ), .I1(alu_control[2]), .I0(n1653) );
    INV U1129 ( .O(n1654), .I(alu_b[3]) );
    NOR2 U1130 ( .O(\*cell*885/U19/Z_3 ), .I1(alu_control[2]), .I0(n1654) );
    INV U1131 ( .O(n1655), .I(alu_b[4]) );
    NOR2 U1132 ( .O(\*cell*885/U19/Z_4 ), .I1(alu_control[2]), .I0(n1655) );
    INV U1133 ( .O(n1656), .I(alu_b[5]) );
    NOR2 U1134 ( .O(\*cell*885/U19/Z_5 ), .I1(alu_control[2]), .I0(n1656) );
    INV U1135 ( .O(n1657), .I(alu_b[6]) );
    NOR2 U1136 ( .O(\*cell*885/U19/Z_6 ), .I1(alu_control[2]), .I0(n1657) );
    INV U1137 ( .O(n1658), .I(alu_b[7]) );
    NOR2 U1138 ( .O(\*cell*885/U19/Z_7 ), .I1(alu_control[2]), .I0(n1658) );
    INV U1139 ( .O(n1659), .I(alu_b[8]) );
    NOR2 U1140 ( .O(\*cell*885/U19/Z_8 ), .I1(alu_control[2]), .I0(n1659) );
    INV U1141 ( .O(n1660), .I(alu_b[9]) );
    NOR2 U1142 ( .O(\*cell*885/U19/Z_9 ), .I1(alu_control[2]), .I0(n1660) );
    INV U1143 ( .O(n1661), .I(alu_b[10]) );
    NOR2 U1144 ( .O(\*cell*885/U19/Z_10 ), .I1(alu_control[2]), .I0(n1661) );
    INV U1145 ( .O(n1662), .I(alu_b[11]) );
    NOR2 U1146 ( .O(\*cell*885/U19/Z_11 ), .I1(alu_control[2]), .I0(n1662) );
    INV U1147 ( .O(n1663), .I(alu_b[12]) );
    NOR2 U1148 ( .O(\*cell*885/U19/Z_12 ), .I1(alu_control[2]), .I0(n1663) );
    INV U1149 ( .O(n1664), .I(alu_b[13]) );
    NOR2 U1150 ( .O(\*cell*885/U19/Z_13 ), .I1(alu_control[2]), .I0(n1664) );
    INV U1151 ( .O(n1665), .I(alu_b[14]) );
    NOR2 U1152 ( .O(\*cell*885/U19/Z_14 ), .I1(alu_control[2]), .I0(n1665) );
    INV U1153 ( .O(n1666), .I(alu_b[15]) );
    NOR2 U1154 ( .O(\*cell*885/U19/Z_15 ), .I1(alu_control[2]), .I0(n1666) );
    AND2 U1155 ( .O(\*cell*885/U11/Z_1 ), .I1(alu_control[0]), .I0(alu_b[1])
         );
    AND2 U1156 ( .O(\*cell*885/U11/Z_2 ), .I1(alu_control[0]), .I0(alu_b[2])
         );
    AND2 U1157 ( .O(\*cell*885/U11/Z_3 ), .I1(alu_control[0]), .I0(alu_b[3])
         );
    AND2 U1158 ( .O(\*cell*885/U10/Z_5 ), .I1(alu_control[2]), .I0(alu_a[5])
         );
    AND2 U1159 ( .O(\*cell*885/U10/Z_6 ), .I1(alu_control[2]), .I0(alu_a[6])
         );
    AND2 U1160 ( .O(\*cell*885/U10/Z_7 ), .I1(alu_control[2]), .I0(alu_a[7])
         );
    AND3 U1161 ( .O(n984), .I2(alu_control[0]), .I1(alu_control[2]), .I0(
        alu_control[1]) );
    INV U1162 ( .O(n1667), .I(alu_control[1]) );
    AND3 U1163 ( .O(n982), .I2(alu_control[0]), .I1(n1667), .I0(alu_control[2]
        ) );
    INV U1164 ( .O(n1668), .I(alu_control[2]) );
    AND3 U1165 ( .O(n978), .I2(alu_control[0]), .I1(n1668), .I0(alu_control[1]
        ) );
    NOR2 U1166 ( .O(n1156), .I1(n988), .I0(n986) );
    INV U1167 ( .O(n1669), .I(alu_control[0]) );
    AND3 U1168 ( .O(n988), .I2(alu_control[1]), .I1(n1669), .I0(alu_control[2]
        ) );
    NOR2 U1169 ( .O(n1155), .I1(n984), .I0(n980) );
    INV U1170 ( .O(n1670), .I(alu_control[2]) );
    NOR3 U1171 ( .O(n980), .I2(alu_control[1]), .I1(alu_control[0]), .I0(n1670
        ) );
    NAND2 U1172 ( .O(n1672), .I1(net971), .I0(n1092) );
    OR2 U1173 ( .O(n1671), .I1(n1032), .I0(net971) );
    NAND2 U1174 ( .O(n1073), .I1(n1671), .I0(n1672) );
    INV U1175 ( .O(n1673), .I(alu_a[15]) );
    NOR3 U1176 ( .O(n1092), .I2(net972), .I1(net973), .I0(n1673) );
    NAND2 U1177 ( .O(n1675), .I1(alu_b[2]), .I0(n1153) );
    OR2 U1178 ( .O(n1674), .I1(n1024), .I0(alu_b[2]) );
    NAND2 U1179 ( .O(n1189), .I1(n1674), .I0(n1675) );
    INV U1180 ( .O(n1676), .I(alu_a[0]) );
    NOR3 U1181 ( .O(n1153), .I2(alu_b[0]), .I1(alu_b[1]), .I0(n1676) );
    INV U1182 ( .O(n1678), .I(n1677) );
    OR2 U1183 ( .O(n1677), .I1(n1686), .I0(n1685) );
    NOR2 U1184 ( .O(n1115), .I1(n1678), .I0(n1244) );
    INV U1185 ( .O(n1681), .I(n1680) );
    INV U1186 ( .O(n1679), .I(\alu_out63<15> ) );
    NAND3 U1187 ( .O(n1680), .I2(alu_b[15]), .I1(n1679), .I0(n1112) );
    OR2 U1188 ( .O(n1686), .I1(alu_a[15]), .I0(n1681) );
    INV U1189 ( .O(n1684), .I(n1683) );
    INV U1190 ( .O(n1682), .I(n1094) );
    NAND3 U1191 ( .O(n1683), .I2(signedflag), .I1(n1682), .I0(n1120) );
    OR2 U1192 ( .O(n1685), .I1(n1243), .I0(n1684) );
    INV U1193 ( .O(n1688), .I(n1687) );
    OR2 U1194 ( .O(n1687), .I1(alu_b[3]), .I0(n1697) );
    NOR2 U1195 ( .O(n1093), .I1(n1688), .I0(n1696) );
    NAND2 U1196 ( .O(n1692), .I1(n1690), .I0(n1689) );
    OR2 U1197 ( .O(n1691), .I1(n1690), .I0(n1090) );
    OR2 U1198 ( .O(n1689), .I1(n1206), .I0(n1207) );
    INV U1199 ( .O(n1690), .I(alu_b[2]) );
    NAND2 U1200 ( .O(n1697), .I1(n1691), .I0(n1692) );
    INV U1201 ( .O(n1693), .I(n1031) );
    NAND2 U1202 ( .O(n1695), .I1(alu_b[2]), .I0(n1693) );
    OR2 U1203 ( .O(n1694), .I1(n1030), .I0(alu_b[2]) );
    AND3 U1204 ( .O(n1696), .I2(alu_b[3]), .I1(n1694), .I0(n1695) );
    OR2 U1205 ( .O(alu_flags[0]), .I1(n1702), .I0(n1703) );
    INV U1206 ( .O(n1699), .I(n1698) );
    OR3 U1207 ( .O(n1698), .I2(n1255), .I1(n1254), .I0(n1256) );
    OR2 U1208 ( .O(n1703), .I1(n1135), .I0(n1699) );
    OR2 U1209 ( .O(n1701), .I1(n1129), .I0(n1128) );
    OR2 U1210 ( .O(n1700), .I1(n1131), .I0(n1130) );
    NAND2 U1211 ( .O(n1702), .I1(n1700), .I0(n1701) );
    INV U1212 ( .O(n1704), .I(n1706) );
    AND3 U1213 ( .O(n1122), .I2(n1016), .I1(n1704), .I0(n1121) );
    INV U1214 ( .O(n1705), .I(n988) );
    OR4 U1215 ( .O(n1706), .I3(n1705), .I2(\alu_out53<7> ), .I1(\alu_out53<6> 
        ), .I0(\alu_out53<5> ) );
    NOR3 U1216 ( .O(n1121), .I2(net970), .I1(net971), .I0(\alu_flags67<4> ) );
    INV U1217 ( .O(n1709), .I(n1708) );
    INV U1218 ( .O(n1707), .I(n1119) );
    NAND2 U1219 ( .O(n1708), .I1(n1707), .I0(n1120) );
    OR2 U1220 ( .O(alu_flags[2]), .I1(n1713), .I0(n1709) );
    INV U1221 ( .O(n1710), .I(\alu_flags55<2> ) );
    OR2 U1222 ( .O(n1712), .I1(n1156), .I0(n1710) );
    NAND2 U1223 ( .O(n1711), .I1(n1112), .I0(\alu_flags64<2> ) );
    NAND2 U1224 ( .O(n1713), .I1(n1711), .I0(n1712) );
    NOR3 U1225 ( .O(n1120), .I2(alu_control[1]), .I1(alu_control[0]), .I0(
        alu_control[2]) );
    INV U1226 ( .O(n1715), .I(n1714) );
    NAND2 U1227 ( .O(n1714), .I1(n986), .I0(\alu_flags67<4> ) );
    OR2 U1228 ( .O(alu_flags[4]), .I1(n1719), .I0(n1715) );
    NAND2 U1229 ( .O(n1717), .I1(\alu_flags55<4> ), .I0(n988) );
    NAND2 U1230 ( .O(n1716), .I1(n1112), .I0(\alu_flags64<4> ) );
    NAND2 U1231 ( .O(n1719), .I1(n1716), .I0(n1717) );
    INV U1232 ( .O(n1718), .I(alu_control[0]) );
    NOR3 U1233 ( .O(n986), .I2(alu_control[2]), .I1(alu_control[1]), .I0(n1718
        ) );
    NOR2 U1234 ( .O(n1107), .I1(n1727), .I0(n1726) );
    INV U1235 ( .O(n1721), .I(n1180) );
    INV U1236 ( .O(n1720), .I(n1010) );
    OR2 U1237 ( .O(n1723), .I1(n1062), .I0(n1720) );
    OR2 U1238 ( .O(n1722), .I1(n1026), .I0(n1721) );
    NAND2 U1239 ( .O(n1727), .I1(n1722), .I0(n1723) );
    OR2 U1240 ( .O(n1724), .I1(n1241), .I0(n1242) );
    AND2 U1241 ( .O(n1725), .I1(n1724), .I0(n1068) );
    OR2 U1242 ( .O(n1726), .I1(n1240), .I0(n1725) );
    OR2 U1243 ( .O(alu_out[10]), .I1(n1732), .I0(n1733) );
    AND2 U1244 ( .O(n1728), .I1(n1239), .I0(n982) );
    OR3 U1245 ( .O(n1733), .I2(n1235), .I1(n1728), .I0(n1236) );
    INV U1246 ( .O(n1729), .I(n1120) );
    OR2 U1247 ( .O(n1731), .I1(n1106), .I0(n1729) );
    NAND2 U1248 ( .O(n1730), .I1(n1238), .I0(n978) );
    NAND2 U1249 ( .O(n1732), .I1(n1730), .I0(n1731) );
    OR2 U1250 ( .O(alu_out[11]), .I1(n1738), .I0(n1739) );
    AND2 U1251 ( .O(n1734), .I1(n1234), .I0(n982) );
    OR3 U1252 ( .O(n1739), .I2(n1230), .I1(n1734), .I0(n1231) );
    INV U1253 ( .O(n1735), .I(n1120) );
    OR2 U1254 ( .O(n1737), .I1(n1103), .I0(n1735) );
    NAND2 U1255 ( .O(n1736), .I1(n1233), .I0(n978) );
    NAND2 U1256 ( .O(n1738), .I1(n1736), .I0(n1737) );
    INV U1257 ( .O(n1742), .I(n1741) );
    INV U1258 ( .O(n1740), .I(n1031) );
    NAND2 U1259 ( .O(n1741), .I1(n1102), .I0(n1740) );
    NOR2 U1260 ( .O(n1103), .I1(n1742), .I0(n1746) );
    INV U1261 ( .O(n1744), .I(n1743) );
    NAND3 U1262 ( .O(n1743), .I2(alu_b[5]), .I1(n1073), .I0(n1100) );
    OR2 U1263 ( .O(n1746), .I1(n1101), .I0(n1744) );
    INV U1264 ( .O(n1745), .I(alu_b[3]) );
    NOR4 U1265 ( .O(n1102), .I3(n1745), .I2(alu_b[5]), .I1(alu_b[2]), .I0(
        alu_b[4]) );
    OR2 U1266 ( .O(alu_out[12]), .I1(n1752), .I0(n1751) );
    INV U1267 ( .O(n1747), .I(n1120) );
    OR2 U1268 ( .O(n1749), .I1(n1099), .I0(n1747) );
    NAND2 U1269 ( .O(n1748), .I1(n1228), .I0(n978) );
    NAND2 U1270 ( .O(n1752), .I1(n1748), .I0(n1749) );
    AND2 U1271 ( .O(n1750), .I1(n1229), .I0(n982) );
    OR3 U1272 ( .O(n1751), .I2(n1225), .I1(n1750), .I0(n1226) );
    NOR2 U1273 ( .O(n1099), .I1(n1760), .I0(n1761) );
    INV U1274 ( .O(n1754), .I(n1021) );
    INV U1275 ( .O(n1753), .I(n1068) );
    OR2 U1276 ( .O(n1756), .I1(n1025), .I0(n1753) );
    OR2 U1277 ( .O(n1755), .I1(n1098), .I0(n1754) );
    NAND2 U1278 ( .O(n1761), .I1(n1755), .I0(n1756) );
    INV U1279 ( .O(n1757), .I(n1116) );
    OR2 U1280 ( .O(n1759), .I1(n1023), .I0(n1757) );
    NAND2 U1281 ( .O(n1758), .I1(n1189), .I0(n1164) );
    NAND2 U1282 ( .O(n1760), .I1(n1758), .I0(n1759) );
    NOR2 U1283 ( .O(n1098), .I1(n1768), .I0(n1769) );
    INV U1284 ( .O(n1762), .I(alu_a[11]) );
    NOR2 U1285 ( .O(n1763), .I1(alu_a[12]), .I0(alu_b[0]) );
    AND2 U1286 ( .O(n1764), .I1(alu_b[0]), .I0(n1762) );
    NOR3 U1287 ( .O(n1769), .I2(n1763), .I1(n1764), .I0(alu_b[1]) );
    INV U1288 ( .O(n1765), .I(alu_b[0]) );
    OR2 U1289 ( .O(n1767), .I1(alu_a[10]), .I0(alu_b[0]) );
    OR2 U1290 ( .O(n1766), .I1(n1765), .I0(alu_a[9]) );
    AND3 U1291 ( .O(n1768), .I2(alu_b[1]), .I1(n1766), .I0(n1767) );
    OR2 U1292 ( .O(alu_out[13]), .I1(n1774), .I0(n1775) );
    AND2 U1293 ( .O(n1770), .I1(n1224), .I0(n982) );
    OR3 U1294 ( .O(n1775), .I2(n1217), .I1(n1770), .I0(n1218) );
    INV U1295 ( .O(n1771), .I(n1120) );
    OR2 U1296 ( .O(n1773), .I1(n1097), .I0(n1771) );
    NAND2 U1297 ( .O(n1772), .I1(n1220), .I0(n978) );
    NAND2 U1298 ( .O(n1774), .I1(n1772), .I0(n1773) );
    NOR2 U1299 ( .O(n1097), .I1(n1783), .I0(n1782) );
    INV U1300 ( .O(n1777), .I(n1116) );
    INV U1301 ( .O(n1776), .I(n1068) );
    OR2 U1302 ( .O(n1779), .I1(n1017), .I0(n1776) );
    OR2 U1303 ( .O(n1778), .I1(n1013), .I0(n1777) );
    NAND2 U1304 ( .O(n1783), .I1(n1778), .I0(n1779) );
    OR2 U1305 ( .O(n1780), .I1(n1222), .I0(n1223) );
    AND2 U1306 ( .O(n1781), .I1(n1780), .I0(n1021) );
    OR2 U1307 ( .O(n1782), .I1(n1221), .I0(n1781) );
    OR2 U1308 ( .O(alu_out[14]), .I1(n1789), .I0(n1788) );
    INV U1309 ( .O(n1784), .I(n1120) );
    OR2 U1310 ( .O(n1786), .I1(n1096), .I0(n1784) );
    NAND2 U1311 ( .O(n1785), .I1(n1212), .I0(n978) );
    NAND2 U1312 ( .O(n1789), .I1(n1785), .I0(n1786) );
    AND2 U1313 ( .O(n1787), .I1(n1216), .I0(n982) );
    OR3 U1314 ( .O(n1788), .I2(n1209), .I1(n1787), .I0(n1210) );
    NOR2 U1315 ( .O(n1096), .I1(n1796), .I0(n1798) );
    OR2 U1316 ( .O(n1790), .I1(n1214), .I0(n1215) );
    AND2 U1317 ( .O(n1791), .I1(n1790), .I0(n1021) );
    OR2 U1318 ( .O(n1798), .I1(n1213), .I0(n1791) );
    INV U1319 ( .O(n1793), .I(n1116) );
    INV U1320 ( .O(n1792), .I(n1068) );
    OR2 U1321 ( .O(n1795), .I1(n1044), .I0(n1792) );
    OR2 U1322 ( .O(n1794), .I1(n1095), .I0(n1793) );
    NAND2 U1323 ( .O(n1796), .I1(n1794), .I0(n1795) );
    NOR2 U1324 ( .O(n1095), .I1(n1805), .I0(n1806) );
    INV U1325 ( .O(n1799), .I(alu_a[9]) );
    NOR2 U1326 ( .O(n1800), .I1(alu_a[10]), .I0(alu_b[0]) );
    AND2 U1327 ( .O(n1801), .I1(alu_b[0]), .I0(n1799) );
    NOR3 U1328 ( .O(n1806), .I2(n1800), .I1(n1801), .I0(alu_b[1]) );
    INV U1329 ( .O(n1802), .I(alu_b[0]) );
    OR2 U1330 ( .O(n1804), .I1(alu_a[8]), .I0(alu_b[0]) );
    OR2 U1331 ( .O(n1803), .I1(n1802), .I0(alu_a[7]) );
    AND3 U1332 ( .O(n1805), .I2(alu_b[1]), .I1(n1803), .I0(n1804) );
    OR2 U1333 ( .O(\alu_out<15> ), .I1(n1812), .I0(n1811) );
    INV U1334 ( .O(n1807), .I(n1120) );
    NAND2 U1335 ( .O(n1809), .I1(alu_b[15]), .I0(n980) );
    OR2 U1336 ( .O(n1808), .I1(n1094), .I0(n1807) );
    NAND2 U1337 ( .O(n1812), .I1(n1808), .I0(n1809) );
    AND2 U1338 ( .O(n1810), .I1(n1208), .I0(n982) );
    OR3 U1339 ( .O(n1811), .I2(n1203), .I1(n1810), .I0(n1205) );
    NOR2 U1340 ( .O(n1090), .I1(n1819), .I0(n1820) );
    INV U1341 ( .O(n1813), .I(alu_a[10]) );
    NOR2 U1342 ( .O(n1814), .I1(alu_a[11]), .I0(alu_b[0]) );
    AND2 U1343 ( .O(n1815), .I1(alu_b[0]), .I0(n1813) );
    NOR3 U1344 ( .O(n1820), .I2(n1814), .I1(n1815), .I0(alu_b[1]) );
    INV U1345 ( .O(n1816), .I(alu_b[0]) );
    OR2 U1346 ( .O(n1818), .I1(alu_a[9]), .I0(alu_b[0]) );
    OR2 U1347 ( .O(n1817), .I1(n1816), .I0(alu_a[8]) );
    AND3 U1348 ( .O(n1819), .I2(alu_b[1]), .I1(n1817), .I0(n1818) );
    NOR2 U1349 ( .O(n1085), .I1(n1827), .I0(n1828) );
    INV U1350 ( .O(n1822), .I(n1021) );
    INV U1351 ( .O(n1821), .I(n1010) );
    OR2 U1352 ( .O(n1824), .I1(n1054), .I0(n1821) );
    OR2 U1353 ( .O(n1823), .I1(n1015), .I0(n1822) );
    NAND2 U1354 ( .O(n1828), .I1(n1823), .I0(n1824) );
    OR2 U1355 ( .O(n1825), .I1(n1201), .I0(n1202) );
    AND2 U1356 ( .O(n1826), .I1(n1825), .I0(n1068) );
    OR2 U1357 ( .O(n1827), .I1(n1200), .I0(n1826) );
    NOR3 U1358 ( .O(n1080), .I2(n1834), .I1(n1835), .I0(n1079) );
    INV U1359 ( .O(n1830), .I(n1829) );
    NAND3 U1360 ( .O(n1829), .I2(n1121), .I1(n1188), .I0(n1172) );
    OR2 U1361 ( .O(n1835), .I1(n1195), .I0(n1830) );
    INV U1362 ( .O(n1831), .I(n1045) );
    OR2 U1363 ( .O(n1833), .I1(net971), .I0(n1831) );
    NAND2 U1364 ( .O(n1832), .I1(net971), .I0(n1044) );
    AND3 U1365 ( .O(n1834), .I2(n1012), .I1(n1832), .I0(n1833) );
    NOR2 U1366 ( .O(n1063), .I1(n1844), .I0(n1843) );
    INV U1367 ( .O(n1836), .I(n1068) );
    OR2 U1368 ( .O(n1838), .I1(n1062), .I0(n1836) );
    NAND2 U1369 ( .O(n1837), .I1(n1189), .I0(n1168) );
    NAND2 U1370 ( .O(n1844), .I1(n1837), .I0(n1838) );
    INV U1371 ( .O(n1840), .I(n1180) );
    INV U1372 ( .O(n1839), .I(n1010) );
    OR2 U1373 ( .O(n1842), .I1(n1026), .I0(n1839) );
    OR2 U1374 ( .O(n1841), .I1(n1025), .I0(n1840) );
    NAND2 U1375 ( .O(n1843), .I1(n1841), .I0(n1842) );
    NOR2 U1376 ( .O(n1062), .I1(n1851), .I0(n1852) );
    INV U1377 ( .O(n1845), .I(alu_a[5]) );
    NOR2 U1378 ( .O(n1846), .I1(alu_a[4]), .I0(net973) );
    AND2 U1379 ( .O(n1847), .I1(net973), .I0(n1845) );
    NOR3 U1380 ( .O(n1852), .I2(n1846), .I1(n1847), .I0(net972) );
    INV U1381 ( .O(n1848), .I(net973) );
    OR2 U1382 ( .O(n1850), .I1(alu_a[6]), .I0(net973) );
    OR2 U1383 ( .O(n1849), .I1(n1848), .I0(alu_a[7]) );
    AND3 U1384 ( .O(n1851), .I2(net972), .I1(n1849), .I0(n1850) );
    NOR2 U1385 ( .O(n1054), .I1(n1860), .I0(n1859) );
    INV U1386 ( .O(n1853), .I(net973) );
    OR2 U1387 ( .O(n1855), .I1(alu_a[7]), .I0(net973) );
    OR2 U1388 ( .O(n1854), .I1(n1853), .I0(alu_a[8]) );
    AND3 U1389 ( .O(n1860), .I2(net972), .I1(n1854), .I0(n1855) );
    INV U1390 ( .O(n1856), .I(alu_a[6]) );
    NOR2 U1391 ( .O(n1857), .I1(alu_a[5]), .I0(net973) );
    AND2 U1392 ( .O(n1858), .I1(net973), .I0(n1856) );
    NOR3 U1393 ( .O(n1859), .I2(n1857), .I1(n1858), .I0(net972) );
    NOR2 U1394 ( .O(n1046), .I1(n1868), .I0(n1867) );
    INV U1395 ( .O(n1861), .I(net973) );
    OR2 U1396 ( .O(n1863), .I1(alu_a[8]), .I0(net973) );
    OR2 U1397 ( .O(n1862), .I1(n1861), .I0(alu_a[9]) );
    AND3 U1398 ( .O(n1868), .I2(net972), .I1(n1862), .I0(n1863) );
    INV U1399 ( .O(n1864), .I(alu_a[7]) );
    NOR2 U1400 ( .O(n1865), .I1(alu_a[6]), .I0(net973) );
    AND2 U1401 ( .O(n1866), .I1(net973), .I0(n1864) );
    NOR3 U1402 ( .O(n1867), .I2(n1865), .I1(n1866), .I0(net972) );
    NOR2 U1403 ( .O(n1045), .I1(n1875), .I0(n1876) );
    INV U1404 ( .O(n1869), .I(alu_a[11]) );
    NOR2 U1405 ( .O(n1870), .I1(alu_a[10]), .I0(net973) );
    AND2 U1406 ( .O(n1871), .I1(net973), .I0(n1869) );
    NOR3 U1407 ( .O(n1876), .I2(n1870), .I1(n1871), .I0(net972) );
    INV U1408 ( .O(n1872), .I(net973) );
    OR2 U1409 ( .O(n1874), .I1(alu_a[12]), .I0(net973) );
    OR2 U1410 ( .O(n1873), .I1(n1872), .I0(alu_a[13]) );
    AND3 U1411 ( .O(n1875), .I2(net972), .I1(n1873), .I0(n1874) );
    INV U1412 ( .O(n1878), .I(n1877) );
    NAND2 U1413 ( .O(n1877), .I1(n1042), .I0(alu_a[2]) );
    NOR2 U1414 ( .O(n1043), .I1(n1878), .I0(n1883) );
    INV U1415 ( .O(n1879), .I(alu_a[1]) );
    INV U1416 ( .O(n1880), .I(alu_b[0]) );
    OR3 U1417 ( .O(n1882), .I2(n1880), .I1(alu_b[1]), .I0(n1879) );
    NAND3 U1418 ( .O(n1881), .I2(n1880), .I1(alu_a[0]), .I0(alu_b[1]) );
    NAND2 U1419 ( .O(n1883), .I1(n1881), .I0(n1882) );
    NOR2 U1420 ( .O(n1042), .I1(alu_b[0]), .I0(alu_b[1]) );
    NOR2 U1421 ( .O(n1041), .I1(n1890), .I0(n1891) );
    INV U1422 ( .O(n1884), .I(alu_a[5]) );
    NOR2 U1423 ( .O(n1885), .I1(alu_a[6]), .I0(alu_b[0]) );
    AND2 U1424 ( .O(n1886), .I1(alu_b[0]), .I0(n1884) );
    NOR3 U1425 ( .O(n1891), .I2(n1885), .I1(n1886), .I0(alu_b[1]) );
    INV U1426 ( .O(n1887), .I(alu_b[0]) );
    OR2 U1427 ( .O(n1889), .I1(alu_a[4]), .I0(alu_b[0]) );
    OR2 U1428 ( .O(n1888), .I1(n1887), .I0(alu_a[3]) );
    AND3 U1429 ( .O(n1890), .I2(alu_b[1]), .I1(n1888), .I0(n1889) );
    NOR2 U1430 ( .O(n1033), .I1(n1899), .I0(n1898) );
    INV U1431 ( .O(n1892), .I(net973) );
    OR2 U1432 ( .O(n1894), .I1(alu_a[9]), .I0(net973) );
    OR2 U1433 ( .O(n1893), .I1(n1892), .I0(alu_a[10]) );
    AND3 U1434 ( .O(n1899), .I2(net972), .I1(n1893), .I0(n1894) );
    INV U1435 ( .O(n1895), .I(alu_a[8]) );
    NOR2 U1436 ( .O(n1896), .I1(alu_a[7]), .I0(net973) );
    AND2 U1437 ( .O(n1897), .I1(net973), .I0(n1895) );
    NOR3 U1438 ( .O(n1898), .I2(n1896), .I1(n1897), .I0(net972) );
    NOR2 U1439 ( .O(n1032), .I1(n1907), .I0(n1906) );
    INV U1440 ( .O(n1900), .I(net973) );
    OR2 U1441 ( .O(n1902), .I1(alu_a[13]), .I0(net973) );
    OR2 U1442 ( .O(n1901), .I1(n1900), .I0(alu_a[14]) );
    AND3 U1443 ( .O(n1907), .I2(net972), .I1(n1901), .I0(n1902) );
    INV U1444 ( .O(n1903), .I(alu_a[12]) );
    NOR2 U1445 ( .O(n1904), .I1(alu_a[11]), .I0(net973) );
    AND2 U1446 ( .O(n1905), .I1(net973), .I0(n1903) );
    NOR3 U1447 ( .O(n1906), .I2(n1904), .I1(n1905), .I0(net972) );
    NOR2 U1448 ( .O(n1031), .I1(n1915), .I0(n1914) );
    INV U1449 ( .O(n1908), .I(alu_a[2]) );
    NOR2 U1450 ( .O(n1909), .I1(alu_a[3]), .I0(alu_b[0]) );
    AND2 U1451 ( .O(n1910), .I1(alu_b[0]), .I0(n1908) );
    NOR3 U1452 ( .O(n1915), .I2(n1909), .I1(n1910), .I0(alu_b[1]) );
    INV U1453 ( .O(n1911), .I(alu_b[0]) );
    OR2 U1454 ( .O(n1913), .I1(alu_a[1]), .I0(alu_b[0]) );
    OR2 U1455 ( .O(n1912), .I1(n1911), .I0(alu_a[0]) );
    AND3 U1456 ( .O(n1914), .I2(alu_b[1]), .I1(n1912), .I0(n1913) );
    NOR2 U1457 ( .O(n1030), .I1(n1923), .I0(n1922) );
    INV U1458 ( .O(n1916), .I(alu_b[0]) );
    OR2 U1459 ( .O(n1918), .I1(alu_a[5]), .I0(alu_b[0]) );
    OR2 U1460 ( .O(n1917), .I1(n1916), .I0(alu_a[4]) );
    AND3 U1461 ( .O(n1923), .I2(alu_b[1]), .I1(n1917), .I0(n1918) );
    INV U1462 ( .O(n1919), .I(alu_a[6]) );
    NOR2 U1463 ( .O(n1920), .I1(alu_a[7]), .I0(alu_b[0]) );
    AND2 U1464 ( .O(n1921), .I1(alu_b[0]), .I0(n1919) );
    NOR3 U1465 ( .O(n1922), .I2(n1920), .I1(n1921), .I0(alu_b[1]) );
    OR2 U1466 ( .O(alu_out[8]), .I1(n1928), .I0(n1929) );
    AND2 U1467 ( .O(n1924), .I1(n1149), .I0(n982) );
    OR3 U1468 ( .O(n1929), .I2(n1174), .I1(n1924), .I0(n1175) );
    INV U1469 ( .O(n1925), .I(n1120) );
    OR2 U1470 ( .O(n1927), .I1(n1029), .I0(n1925) );
    NAND2 U1471 ( .O(n1926), .I1(n1141), .I0(n978) );
    NAND2 U1472 ( .O(n1928), .I1(n1926), .I0(n1927) );
    NOR2 U1473 ( .O(n1026), .I1(n1937), .I0(n1936) );
    INV U1474 ( .O(n1930), .I(net973) );
    OR2 U1475 ( .O(n1932), .I1(alu_a[10]), .I0(net973) );
    OR2 U1476 ( .O(n1931), .I1(n1930), .I0(alu_a[11]) );
    AND3 U1477 ( .O(n1937), .I2(net972), .I1(n1931), .I0(n1932) );
    INV U1478 ( .O(n1933), .I(alu_a[9]) );
    NOR2 U1479 ( .O(n1934), .I1(alu_a[8]), .I0(net973) );
    AND2 U1480 ( .O(n1935), .I1(net973), .I0(n1933) );
    NOR3 U1481 ( .O(n1936), .I2(n1934), .I1(n1935), .I0(net972) );
    NOR2 U1482 ( .O(n1025), .I1(n1944), .I0(n1945) );
    INV U1483 ( .O(n1938), .I(alu_a[13]) );
    NOR2 U1484 ( .O(n1939), .I1(alu_a[12]), .I0(net973) );
    AND2 U1485 ( .O(n1940), .I1(net973), .I0(n1938) );
    NOR3 U1486 ( .O(n1945), .I2(n1939), .I1(n1940), .I0(net972) );
    INV U1487 ( .O(n1941), .I(net973) );
    OR2 U1488 ( .O(n1943), .I1(alu_a[14]), .I0(net973) );
    OR2 U1489 ( .O(n1942), .I1(n1941), .I0(alu_a[15]) );
    AND3 U1490 ( .O(n1944), .I2(net972), .I1(n1942), .I0(n1943) );
    NOR2 U1491 ( .O(n1024), .I1(n1954), .I0(n1953) );
    INV U1492 ( .O(n1946), .I(alu_a[3]) );
    INV U1493 ( .O(n1947), .I(alu_b[0]) );
    OR3 U1494 ( .O(n1949), .I2(n1947), .I1(alu_b[1]), .I0(n1946) );
    NAND3 U1495 ( .O(n1948), .I2(n1947), .I1(alu_a[2]), .I0(alu_b[1]) );
    NAND2 U1496 ( .O(n1954), .I1(n1948), .I0(n1949) );
    INV U1497 ( .O(n1950), .I(alu_a[4]) );
    OR3 U1498 ( .O(n1952), .I2(alu_b[0]), .I1(alu_b[1]), .I0(n1950) );
    NAND3 U1499 ( .O(n1951), .I2(alu_b[0]), .I1(alu_a[1]), .I0(alu_b[1]) );
    NAND2 U1500 ( .O(n1953), .I1(n1951), .I0(n1952) );
    NOR2 U1501 ( .O(n1023), .I1(n1961), .I0(n1962) );
    INV U1502 ( .O(n1955), .I(alu_a[7]) );
    NOR2 U1503 ( .O(n1956), .I1(alu_a[8]), .I0(alu_b[0]) );
    AND2 U1504 ( .O(n1957), .I1(alu_b[0]), .I0(n1955) );
    NOR3 U1505 ( .O(n1962), .I2(n1956), .I1(n1957), .I0(alu_b[1]) );
    INV U1506 ( .O(n1958), .I(alu_b[0]) );
    OR2 U1507 ( .O(n1960), .I1(alu_a[6]), .I0(alu_b[0]) );
    OR2 U1508 ( .O(n1959), .I1(n1958), .I0(alu_a[5]) );
    AND3 U1509 ( .O(n1961), .I2(alu_b[1]), .I1(n1959), .I0(n1960) );
    OR2 U1510 ( .O(alu_out[9]), .I1(n1967), .I0(n1968) );
    AND2 U1511 ( .O(n1963), .I1(n1148), .I0(n982) );
    OR3 U1512 ( .O(n1968), .I2(n1157), .I1(n1963), .I0(n1159) );
    INV U1513 ( .O(n1964), .I(n1120) );
    NAND2 U1514 ( .O(n1966), .I1(n1139), .I0(n978) );
    OR2 U1515 ( .O(n1965), .I1(n1022), .I0(n1964) );
    NAND2 U1516 ( .O(n1967), .I1(n1965), .I0(n1966) );
    NOR2 U1517 ( .O(n1018), .I1(n1975), .I0(n1976) );
    INV U1518 ( .O(n1969), .I(alu_a[10]) );
    NOR2 U1519 ( .O(n1970), .I1(alu_a[9]), .I0(net973) );
    AND2 U1520 ( .O(n1971), .I1(net973), .I0(n1969) );
    NOR3 U1521 ( .O(n1976), .I2(n1970), .I1(n1971), .I0(net972) );
    INV U1522 ( .O(n1972), .I(net973) );
    OR2 U1523 ( .O(n1974), .I1(alu_a[11]), .I0(net973) );
    OR2 U1524 ( .O(n1973), .I1(n1972), .I0(alu_a[12]) );
    AND3 U1525 ( .O(n1975), .I2(net972), .I1(n1973), .I0(n1974) );
    INV U1526 ( .O(n1978), .I(n1977) );
    NAND2 U1527 ( .O(n1977), .I1(n1016), .I0(alu_a[13]) );
    NOR2 U1528 ( .O(n1017), .I1(n1978), .I0(n1983) );
    INV U1529 ( .O(n1979), .I(alu_a[14]) );
    INV U1530 ( .O(n1980), .I(net973) );
    OR3 U1531 ( .O(n1982), .I2(n1980), .I1(net972), .I0(n1979) );
    NAND3 U1532 ( .O(n1981), .I2(n1980), .I1(net972), .I0(alu_a[15]) );
    NAND2 U1533 ( .O(n1983), .I1(n1981), .I0(n1982) );
    NOR2 U1534 ( .O(n1016), .I1(net972), .I0(net973) );
    NOR2 U1535 ( .O(n1014), .I1(n1991), .I0(n1990) );
    INV U1536 ( .O(n1984), .I(alu_b[0]) );
    OR2 U1537 ( .O(n1986), .I1(alu_a[3]), .I0(alu_b[0]) );
    OR2 U1538 ( .O(n1985), .I1(n1984), .I0(alu_a[2]) );
    AND3 U1539 ( .O(n1991), .I2(alu_b[1]), .I1(n1985), .I0(n1986) );
    INV U1540 ( .O(n1987), .I(alu_a[4]) );
    NOR2 U1541 ( .O(n1988), .I1(alu_a[5]), .I0(alu_b[0]) );
    AND2 U1542 ( .O(n1989), .I1(alu_b[0]), .I0(n1987) );
    NOR3 U1543 ( .O(n1990), .I2(n1988), .I1(n1989), .I0(alu_b[1]) );
    NOR2 U1544 ( .O(n1013), .I1(n1999), .I0(n1998) );
    INV U1545 ( .O(n1992), .I(alu_b[0]) );
    OR2 U1546 ( .O(n1994), .I1(alu_a[7]), .I0(alu_b[0]) );
    OR2 U1547 ( .O(n1993), .I1(n1992), .I0(alu_a[6]) );
    AND3 U1548 ( .O(n1999), .I2(alu_b[1]), .I1(n1993), .I0(n1994) );
    INV U1549 ( .O(n1995), .I(alu_a[8]) );
    NOR2 U1550 ( .O(n1996), .I1(alu_a[9]), .I0(alu_b[0]) );
    AND2 U1551 ( .O(n1997), .I1(alu_b[0]), .I0(n1995) );
    NOR3 U1552 ( .O(n1998), .I2(n1996), .I1(n1997), .I0(alu_b[1]) );
endmodule


module disp_decoder ( nibble, ascii );
input  [3:0] nibble;
output [6:0] ascii;
    wire n116, n117, n118, n119, n120, n121, n104, n105, n106, n107, n108, 
        n109, n110, n111, n112, n113, n114, n115;
    OBUF_S U43 ( .O(ascii[6]), .I(n121) );
    OBUF_S U44 ( .O(ascii[5]), .I(n120) );
    OBUF_S U45 ( .O(ascii[4]), .I(n120) );
    OBUF_S U46 ( .O(ascii[3]), .I(n119) );
    OBUF_S U47 ( .O(ascii[2]), .I(n118) );
    OBUF_S U48 ( .O(ascii[1]), .I(n117) );
    OBUF_S U49 ( .O(ascii[0]), .I(n116) );
    OR2 U50 ( .O(n104), .I1(nibble[1]), .I0(nibble[2]) );
    NAND2 U51 ( .O(n120), .I1(n104), .I0(nibble[3]) );
    OR2 U52 ( .O(n105), .I1(nibble[1]), .I0(nibble[2]) );
    XOR2 U53 ( .O(n116), .I1(n106), .I0(nibble[0]) );
    AND2 U54 ( .O(n106), .I1(n105), .I0(nibble[3]) );
    INV U55 ( .O(n108), .I(nibble[3]) );
    INV U56 ( .O(n107), .I(nibble[1]) );
    NAND3 U57 ( .O(n111), .I2(n109), .I1(n107), .I0(nibble[2]) );
    OR2 U58 ( .O(n110), .I1(n109), .I0(n107) );
    NOR2 U59 ( .O(n109), .I1(nibble[0]), .I0(n108) );
    NAND2 U60 ( .O(n117), .I1(n110), .I0(n111) );
    INV U61 ( .O(n112), .I(nibble[3]) );
    OR3 U62 ( .O(n113), .I2(n112), .I1(nibble[0]), .I0(nibble[1]) );
    AND2 U63 ( .O(n118), .I1(n113), .I0(nibble[2]) );
    INV U64 ( .O(n114), .I(nibble[3]) );
    NOR3 U65 ( .O(n119), .I2(nibble[1]), .I1(nibble[2]), .I0(n114) );
    OR2 U66 ( .O(n115), .I1(nibble[2]), .I0(nibble[1]) );
    AND2 U67 ( .O(n121), .I1(n115), .I0(nibble[3]) );
endmodule


module disp_mux ( select, word0, word1, out );
input  [2:0] select;
input  [15:0] word0;
input  [15:0] word1;
output [3:0] out;
    wire n149, n151, n153, n155, n157, n159, n161, n163, n164, n165, n166, 
        n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, 
        n179, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247, n248, 
        n249, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259, n260, 
        n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, 
        n273, n274, n275;
    NAND2 U46 ( .O(n239), .I1(word1[8]), .I0(n161) );
    NAND2 U47 ( .O(n238), .I1(word1[12]), .I0(n163) );
    NAND2 U48 ( .O(n179), .I1(n238), .I0(n239) );
    NAND2 U49 ( .O(n241), .I1(word1[0]), .I0(n157) );
    NAND2 U50 ( .O(n240), .I1(word1[4]), .I0(n159) );
    NAND2 U51 ( .O(n178), .I1(n240), .I0(n241) );
    NAND2 U52 ( .O(n243), .I1(word0[8]), .I0(n153) );
    NAND2 U53 ( .O(n242), .I1(word0[12]), .I0(n155) );
    NAND2 U54 ( .O(n177), .I1(n242), .I0(n243) );
    NAND2 U55 ( .O(n245), .I1(word0[0]), .I0(n149) );
    NAND2 U56 ( .O(n244), .I1(word0[4]), .I0(n151) );
    NAND2 U57 ( .O(n176), .I1(n244), .I0(n245) );
    NAND2 U58 ( .O(n247), .I1(word1[9]), .I0(n161) );
    NAND2 U59 ( .O(n246), .I1(word1[13]), .I0(n163) );
    NAND2 U60 ( .O(n175), .I1(n246), .I0(n247) );
    NAND2 U61 ( .O(n249), .I1(word1[1]), .I0(n157) );
    NAND2 U62 ( .O(n248), .I1(word1[5]), .I0(n159) );
    NAND2 U63 ( .O(n174), .I1(n248), .I0(n249) );
    NAND2 U64 ( .O(n251), .I1(word0[9]), .I0(n153) );
    NAND2 U65 ( .O(n250), .I1(word0[13]), .I0(n155) );
    NAND2 U66 ( .O(n173), .I1(n250), .I0(n251) );
    NAND2 U67 ( .O(n253), .I1(word0[1]), .I0(n149) );
    NAND2 U68 ( .O(n252), .I1(word0[5]), .I0(n151) );
    NAND2 U69 ( .O(n172), .I1(n252), .I0(n253) );
    NAND2 U70 ( .O(n255), .I1(word1[10]), .I0(n161) );
    NAND2 U71 ( .O(n254), .I1(word1[14]), .I0(n163) );
    NAND2 U72 ( .O(n171), .I1(n254), .I0(n255) );
    NAND2 U73 ( .O(n257), .I1(word1[2]), .I0(n157) );
    NAND2 U74 ( .O(n256), .I1(word1[6]), .I0(n159) );
    NAND2 U75 ( .O(n170), .I1(n256), .I0(n257) );
    NAND2 U76 ( .O(n259), .I1(word0[10]), .I0(n153) );
    NAND2 U77 ( .O(n258), .I1(word0[14]), .I0(n155) );
    NAND2 U78 ( .O(n169), .I1(n258), .I0(n259) );
    NAND2 U79 ( .O(n261), .I1(word0[2]), .I0(n149) );
    NAND2 U80 ( .O(n260), .I1(word0[6]), .I0(n151) );
    NAND2 U81 ( .O(n168), .I1(n260), .I0(n261) );
    NAND2 U82 ( .O(n263), .I1(word1[11]), .I0(n161) );
    NAND2 U83 ( .O(n262), .I1(word1[15]), .I0(n163) );
    NAND2 U84 ( .O(n167), .I1(n262), .I0(n263) );
    NAND2 U85 ( .O(n265), .I1(word1[3]), .I0(n157) );
    NAND2 U86 ( .O(n264), .I1(word1[7]), .I0(n159) );
    NAND2 U87 ( .O(n166), .I1(n264), .I0(n265) );
    NAND2 U88 ( .O(n267), .I1(word0[11]), .I0(n153) );
    NAND2 U89 ( .O(n266), .I1(word0[15]), .I0(n155) );
    NAND2 U90 ( .O(n165), .I1(n266), .I0(n267) );
    NAND2 U91 ( .O(n269), .I1(word0[3]), .I0(n149) );
    NAND2 U92 ( .O(n268), .I1(word0[7]), .I0(n151) );
    NAND2 U93 ( .O(n164), .I1(n268), .I0(n269) );
    OR4 U94 ( .O(out[0]), .I3(n179), .I2(n178), .I1(n177), .I0(n176) );
    OR4 U95 ( .O(out[1]), .I3(n175), .I2(n174), .I1(n173), .I0(n172) );
    OR4 U96 ( .O(out[2]), .I3(n171), .I2(n170), .I1(n169), .I0(n168) );
    OR4 U97 ( .O(out[3]), .I3(n167), .I2(n166), .I1(n165), .I0(n164) );
    AND3 U98 ( .O(n163), .I2(select[2]), .I1(select[0]), .I0(select[1]) );
    INV U99 ( .O(n270), .I(select[0]) );
    AND3 U100 ( .O(n161), .I2(select[2]), .I1(n270), .I0(select[1]) );
    INV U101 ( .O(n271), .I(select[1]) );
    AND3 U102 ( .O(n159), .I2(select[2]), .I1(n271), .I0(select[0]) );
    INV U103 ( .O(n272), .I(select[2]) );
    NOR3 U104 ( .O(n157), .I2(select[0]), .I1(select[1]), .I0(n272) );
    INV U105 ( .O(n273), .I(select[2]) );
    AND3 U106 ( .O(n155), .I2(select[1]), .I1(n273), .I0(select[0]) );
    INV U107 ( .O(n274), .I(select[1]) );
    NOR3 U108 ( .O(n153), .I2(select[0]), .I1(select[2]), .I0(n274) );
    INV U109 ( .O(n275), .I(select[0]) );
    NOR3 U110 ( .O(n151), .I2(select[1]), .I1(select[2]), .I0(n275) );
    NOR3 U111 ( .O(n149), .I2(select[1]), .I1(select[2]), .I0(select[0]) );
endmodule


module mux4_to_2 ( bus_select, in0, in1, in2, in3, out0, out1 );
input  [15:0] in0;
output [15:0] out0;
input  [15:0] in1;
input  [15:0] in2;
input  [15:0] in3;
output [15:0] out1;
input  bus_select;
    wire n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, 
        n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, 
        n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, 
        n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184, 
        n185, n186, n187, n188, n189, n190, n191, n192, n193, n198, n199, n200, 
        n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, 
        n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, 
        n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, 
        n237;
    tri \in1<7> , \in1<3> , \in1<1> , \in1<8> , \in1<5> , \in1<15> , \in1<11> , 
        \in1<13> , \in1<12> , \in1<10> , \in1<14> , \in1<4> , \in1<0> , 
        \in1<9> , \in1<2> , \in1<6> ;
    assign \in1<15>  = in1[15];
    assign \in1<14>  = in1[14];
    assign \in1<13>  = in1[13];
    assign \in1<12>  = in1[12];
    assign \in1<11>  = in1[11];
    assign \in1<10>  = in1[10];
    assign \in1<9>  = in1[9];
    assign \in1<8>  = in1[8];
    assign \in1<7>  = in1[7];
    assign \in1<6>  = in1[6];
    assign \in1<5>  = in1[5];
    assign \in1<4>  = in1[4];
    assign \in1<3>  = in1[3];
    assign \in1<2>  = in1[2];
    assign \in1<1>  = in1[1];
    assign \in1<0>  = in1[0];
    INV U74 ( .O(n138), .I(in0[0]) );
    NAND2 U75 ( .O(n140), .I1(bus_select), .I0(in2[0]) );
    OR2 U76 ( .O(n139), .I1(bus_select), .I0(n138) );
    NAND2 U77 ( .O(out0[0]), .I1(n139), .I0(n140) );
    INV U78 ( .O(n141), .I(in0[10]) );
    NAND2 U79 ( .O(n143), .I1(bus_select), .I0(in2[10]) );
    OR2 U80 ( .O(n142), .I1(bus_select), .I0(n141) );
    NAND2 U81 ( .O(out0[10]), .I1(n142), .I0(n143) );
    INV U82 ( .O(n144), .I(in0[11]) );
    NAND2 U83 ( .O(n146), .I1(bus_select), .I0(in2[11]) );
    OR2 U84 ( .O(n145), .I1(bus_select), .I0(n144) );
    NAND2 U85 ( .O(out0[11]), .I1(n145), .I0(n146) );
    INV U86 ( .O(n147), .I(in0[12]) );
    NAND2 U87 ( .O(n149), .I1(bus_select), .I0(in2[12]) );
    OR2 U88 ( .O(n148), .I1(bus_select), .I0(n147) );
    NAND2 U89 ( .O(out0[12]), .I1(n148), .I0(n149) );
    INV U90 ( .O(n150), .I(in0[13]) );
    NAND2 U91 ( .O(n152), .I1(bus_select), .I0(in2[13]) );
    OR2 U92 ( .O(n151), .I1(bus_select), .I0(n150) );
    NAND2 U93 ( .O(out0[13]), .I1(n151), .I0(n152) );
    INV U94 ( .O(n153), .I(in0[14]) );
    NAND2 U95 ( .O(n155), .I1(bus_select), .I0(in2[14]) );
    OR2 U96 ( .O(n154), .I1(bus_select), .I0(n153) );
    NAND2 U97 ( .O(out0[14]), .I1(n154), .I0(n155) );
    INV U98 ( .O(n156), .I(in0[15]) );
    NAND2 U99 ( .O(n158), .I1(bus_select), .I0(in2[15]) );
    OR2 U100 ( .O(n157), .I1(bus_select), .I0(n156) );
    NAND2 U101 ( .O(out0[15]), .I1(n157), .I0(n158) );
    INV U102 ( .O(n159), .I(in0[1]) );
    NAND2 U103 ( .O(n161), .I1(bus_select), .I0(in2[1]) );
    OR2 U104 ( .O(n160), .I1(bus_select), .I0(n159) );
    NAND2 U105 ( .O(out0[1]), .I1(n160), .I0(n161) );
    INV U106 ( .O(n162), .I(in0[2]) );
    NAND2 U107 ( .O(n164), .I1(bus_select), .I0(in2[2]) );
    OR2 U108 ( .O(n163), .I1(bus_select), .I0(n162) );
    NAND2 U109 ( .O(out0[2]), .I1(n163), .I0(n164) );
    INV U110 ( .O(n165), .I(in0[3]) );
    NAND2 U111 ( .O(n167), .I1(bus_select), .I0(in2[3]) );
    OR2 U112 ( .O(n166), .I1(bus_select), .I0(n165) );
    NAND2 U113 ( .O(out0[3]), .I1(n166), .I0(n167) );
    INV U114 ( .O(n168), .I(in0[4]) );
    NAND2 U115 ( .O(n170), .I1(bus_select), .I0(in2[4]) );
    OR2 U116 ( .O(n169), .I1(bus_select), .I0(n168) );
    NAND2 U117 ( .O(out0[4]), .I1(n169), .I0(n170) );
    INV U118 ( .O(n171), .I(in0[5]) );
    NAND2 U119 ( .O(n173), .I1(bus_select), .I0(in2[5]) );
    OR2 U120 ( .O(n172), .I1(bus_select), .I0(n171) );
    NAND2 U121 ( .O(out0[5]), .I1(n172), .I0(n173) );
    INV U122 ( .O(n174), .I(in0[6]) );
    NAND2 U123 ( .O(n176), .I1(bus_select), .I0(in2[6]) );
    OR2 U124 ( .O(n175), .I1(bus_select), .I0(n174) );
    NAND2 U125 ( .O(out0[6]), .I1(n175), .I0(n176) );
    INV U126 ( .O(n177), .I(in0[7]) );
    NAND2 U127 ( .O(n179), .I1(bus_select), .I0(in2[7]) );
    OR2 U128 ( .O(n178), .I1(bus_select), .I0(n177) );
    NAND2 U129 ( .O(out0[7]), .I1(n178), .I0(n179) );
    INV U130 ( .O(n180), .I(in0[8]) );
    NAND2 U131 ( .O(n182), .I1(bus_select), .I0(in2[8]) );
    OR2 U132 ( .O(n181), .I1(bus_select), .I0(n180) );
    NAND2 U133 ( .O(out0[8]), .I1(n181), .I0(n182) );
    INV U134 ( .O(n183), .I(in0[9]) );
    NAND2 U135 ( .O(n185), .I1(bus_select), .I0(in2[9]) );
    OR2 U136 ( .O(n184), .I1(bus_select), .I0(n183) );
    NAND2 U137 ( .O(out0[9]), .I1(n184), .I0(n185) );
    INV U138 ( .O(n186), .I(\in1<0> ) );
    NAND2 U139 ( .O(n188), .I1(bus_select), .I0(in3[0]) );
    OR2 U140 ( .O(n187), .I1(bus_select), .I0(n186) );
    NAND2 U141 ( .O(out1[0]), .I1(n187), .I0(n188) );
    INV U142 ( .O(n189), .I(\in1<10> ) );
    NAND2 U143 ( .O(n191), .I1(bus_select), .I0(in3[10]) );
    OR2 U144 ( .O(n190), .I1(bus_select), .I0(n189) );
    NAND2 U145 ( .O(out1[10]), .I1(n190), .I0(n191) );
    INV U146 ( .O(n192), .I(\in1<11> ) );
    NAND2 U147 ( .O(n198), .I1(bus_select), .I0(in3[11]) );
    OR2 U148 ( .O(n193), .I1(bus_select), .I0(n192) );
    NAND2 U149 ( .O(out1[11]), .I1(n193), .I0(n198) );
    INV U150 ( .O(n199), .I(\in1<12> ) );
    NAND2 U151 ( .O(n201), .I1(bus_select), .I0(in3[12]) );
    OR2 U152 ( .O(n200), .I1(bus_select), .I0(n199) );
    NAND2 U153 ( .O(out1[12]), .I1(n200), .I0(n201) );
    INV U154 ( .O(n202), .I(\in1<13> ) );
    NAND2 U155 ( .O(n204), .I1(bus_select), .I0(in3[13]) );
    OR2 U156 ( .O(n203), .I1(bus_select), .I0(n202) );
    NAND2 U157 ( .O(out1[13]), .I1(n203), .I0(n204) );
    INV U158 ( .O(n205), .I(\in1<14> ) );
    NAND2 U159 ( .O(n207), .I1(bus_select), .I0(in3[14]) );
    OR2 U160 ( .O(n206), .I1(bus_select), .I0(n205) );
    NAND2 U161 ( .O(out1[14]), .I1(n206), .I0(n207) );
    INV U162 ( .O(n208), .I(\in1<15> ) );
    NAND2 U163 ( .O(n210), .I1(bus_select), .I0(in3[15]) );
    OR2 U164 ( .O(n209), .I1(bus_select), .I0(n208) );
    NAND2 U165 ( .O(out1[15]), .I1(n209), .I0(n210) );
    INV U166 ( .O(n211), .I(\in1<1> ) );
    NAND2 U167 ( .O(n213), .I1(bus_select), .I0(in3[1]) );
    OR2 U168 ( .O(n212), .I1(bus_select), .I0(n211) );
    NAND2 U169 ( .O(out1[1]), .I1(n212), .I0(n213) );
    INV U170 ( .O(n214), .I(\in1<2> ) );
    NAND2 U171 ( .O(n216), .I1(bus_select), .I0(in3[2]) );
    OR2 U172 ( .O(n215), .I1(bus_select), .I0(n214) );
    NAND2 U173 ( .O(out1[2]), .I1(n215), .I0(n216) );
    INV U174 ( .O(n217), .I(\in1<3> ) );
    NAND2 U175 ( .O(n219), .I1(bus_select), .I0(in3[3]) );
    OR2 U176 ( .O(n218), .I1(bus_select), .I0(n217) );
    NAND2 U177 ( .O(out1[3]), .I1(n218), .I0(n219) );
    INV U178 ( .O(n220), .I(\in1<4> ) );
    NAND2 U179 ( .O(n222), .I1(bus_select), .I0(in3[4]) );
    OR2 U180 ( .O(n221), .I1(bus_select), .I0(n220) );
    NAND2 U181 ( .O(out1[4]), .I1(n221), .I0(n222) );
    INV U182 ( .O(n223), .I(\in1<5> ) );
    NAND2 U183 ( .O(n225), .I1(bus_select), .I0(in3[5]) );
    OR2 U184 ( .O(n224), .I1(bus_select), .I0(n223) );
    NAND2 U185 ( .O(out1[5]), .I1(n224), .I0(n225) );
    INV U186 ( .O(n226), .I(\in1<6> ) );
    NAND2 U187 ( .O(n228), .I1(bus_select), .I0(in3[6]) );
    OR2 U188 ( .O(n227), .I1(bus_select), .I0(n226) );
    NAND2 U189 ( .O(out1[6]), .I1(n227), .I0(n228) );
    INV U190 ( .O(n229), .I(\in1<7> ) );
    NAND2 U191 ( .O(n231), .I1(bus_select), .I0(in3[7]) );
    OR2 U192 ( .O(n230), .I1(bus_select), .I0(n229) );
    NAND2 U193 ( .O(out1[7]), .I1(n230), .I0(n231) );
    INV U194 ( .O(n232), .I(\in1<8> ) );
    NAND2 U195 ( .O(n234), .I1(bus_select), .I0(in3[8]) );
    OR2 U196 ( .O(n233), .I1(bus_select), .I0(n232) );
    NAND2 U197 ( .O(out1[8]), .I1(n233), .I0(n234) );
    INV U198 ( .O(n235), .I(\in1<9> ) );
    NAND2 U199 ( .O(n237), .I1(bus_select), .I0(in3[9]) );
    OR2 U200 ( .O(n236), .I1(bus_select), .I0(n235) );
    NAND2 U201 ( .O(out1[9]), .I1(n236), .I0(n237) );
endmodule


module display ( sal, sce12, sce34, scue, scu, swr, sclr, sa, sd, bus0, bus1, 
    bus2, bus3, clk, bus_select );
output [1:0] sa;
input  [15:0] bus0;
output [6:0] sd;
input  [15:0] bus1;
input  [15:0] bus2;
input  [15:0] bus3;
input  clk, bus_select;
output sal, sce12, sce34, scue, scu, swr, sclr;
    wire \word0<9> , \word0<6> , \multiple_wait_state233<0> , \word0<2> , 
        \word0<0> , \multiple_wait_state<0> , \word1<0> , \word0<4> , 
        \sa216<0> , \word1<11> , \out<0> , \word1<9> , \word0<12> , 
        \word1<15> , \word1<6> , \word1<4> , \word0<14> , \word0<10> , 
        \out<3> , \out<2> , \word1<13> , \word1<2> , \word0<11> , \word1<12> , 
        \word1<7> , \word1<3> , \word0<15> , \word1<14> , \word1<5> , \out<1> , 
        \word1<10> , \word1<1> , \word1<8> , \word0<13> , \word0<5> , 
        \word0<1> , \sa216<1> , \word0<8> , \word0<7> , \word0<3> , 
        \multiple_wait_state<3> , n501, \*cell*855/U2/CONTROL1 , n503, n507, 
        n508, n510, n511, n513;
    tri \bus1<3> , \bus1<14> , \bus1<7> , \bus1<10> , \bus1<12> , \bus1<5> , 
        \bus1<8> , \bus1<1> , \bus1<9> , \bus1<13> , \bus1<0> , \bus1<4> , 
        \bus1<6> , \bus1<11> , \bus1<2> , \bus1<15> ;
    assign sal = 1'b1;
    assign scue = 1'b0;
    assign scu = 1'b1;
    assign sclr = 1'b1;
    assign \bus1<15>  = bus1[15];
    assign \bus1<14>  = bus1[14];
    assign \bus1<13>  = bus1[13];
    assign \bus1<12>  = bus1[12];
    assign \bus1<11>  = bus1[11];
    assign \bus1<10>  = bus1[10];
    assign \bus1<9>  = bus1[9];
    assign \bus1<8>  = bus1[8];
    assign \bus1<7>  = bus1[7];
    assign \bus1<6>  = bus1[6];
    assign \bus1<5>  = bus1[5];
    assign \bus1<4>  = bus1[4];
    assign \bus1<3>  = bus1[3];
    assign \bus1<2>  = bus1[2];
    assign \bus1<1>  = bus1[1];
    assign \bus1<0>  = bus1[0];
    disp_mux mux1 ( .select({sce12, sa[1], sa[0]}), .word0({\word1<15> , 
        \word1<14> , \word1<13> , \word1<12> , \word1<11> , \word1<10> , 
        \word1<9> , \word1<8> , \word1<7> , \word1<6> , \word1<5> , \word1<4> , 
        \word1<3> , \word1<2> , \word1<1> , \word1<0> }), .word1({\word0<15> , 
        \word0<14> , \word0<13> , \word0<12> , \word0<11> , \word0<10> , 
        \word0<9> , \word0<8> , \word0<7> , \word0<6> , \word0<5> , \word0<4> , 
        \word0<3> , \word0<2> , \word0<1> , \word0<0> }), .out({\out<3> , 
        \out<2> , \out<1> , \out<0> }) );
    mux4_to_2 mux2 ( .bus_select(bus_select), .in0(bus0), .in1({\bus1<15> , 
        \bus1<14> , \bus1<13> , \bus1<12> , \bus1<11> , \bus1<10> , \bus1<9> , 
        \bus1<8> , \bus1<7> , \bus1<6> , \bus1<5> , \bus1<4> , \bus1<3> , 
        \bus1<2> , \bus1<1> , \bus1<0> }), .in2(bus2), .in3(bus3), .out0({
        \word0<15> , \word0<14> , \word0<13> , \word0<12> , \word0<11> , 
        \word0<10> , \word0<9> , \word0<8> , \word0<7> , \word0<6> , 
        \word0<5> , \word0<4> , \word0<3> , \word0<2> , \word0<1> , \word0<0> 
        }), .out1({\word1<15> , \word1<14> , \word1<13> , \word1<12> , 
        \word1<11> , \word1<10> , \word1<9> , \word1<8> , \word1<7> , 
        \word1<6> , \word1<5> , \word1<4> , \word1<3> , \word1<2> , \word1<1> , 
        \word1<0> }) );
    disp_decoder decoder1 ( .nibble({\out<3> , \out<2> , \out<1> , \out<0> }), 
        .ascii(sd) );
    OBUF_S U149 ( .O(sce34), .I(n503) );
    INV U150 ( .O(n503), .I(sce12) );
    OFD_S swr_reg ( .Q(swr), .D(\multiple_wait_state<0> ), .C(clk) );
    INV U151 ( .O(\multiple_wait_state233<0> ), .I(\multiple_wait_state<0> )
         );
    INV U152 ( .O(n501), .I(\multiple_wait_state<3> ) );
    FDCE sce12_reg ( .Q(sce12), .D(n501), .C(clk), .CE(\*cell*855/U2/CONTROL1 
        ), .CLR(1'b0) );
    FDC \multiple_wait_state_reg<0>  ( .Q(\multiple_wait_state<0> ), .D(
        \multiple_wait_state233<0> ), .C(clk), .CLR(1'b0) );
    FDCE \sa_reg<1>  ( .Q(sa[1]), .D(\sa216<1> ), .C(clk), .CE(
        \multiple_wait_state233<0> ), .CLR(1'b0) );
    FDCE \sa_reg<0>  ( .Q(sa[0]), .D(\sa216<0> ), .C(clk), .CE(
        \multiple_wait_state233<0> ), .CLR(1'b0) );
    XOR2 U155 ( .O(n511), .I1(n507), .I0(\sa216<1> ) );
    AND2 U156 ( .O(n507), .I1(\multiple_wait_state<0> ), .I0(\sa216<0> ) );
    XOR2 U157 ( .O(n510), .I1(n508), .I0(\multiple_wait_state<3> ) );
    AND3 U158 ( .O(n508), .I2(\sa216<1> ), .I1(\multiple_wait_state<0> ), .I0(
        \sa216<0> ) );
    FDC \multiple_wait_state_reg<3>  ( .Q(\multiple_wait_state<3> ), .D(n510), 
        .C(clk), .CLR(1'b0) );
    FDC \multiple_wait_state_reg<2>  ( .Q(\sa216<1> ), .D(n511), .C(clk), 
        .CLR(1'b0) );
    XOR2 U160 ( .O(n513), .I1(\sa216<0> ), .I0(\multiple_wait_state<0> ) );
    NOR3 U161 ( .O(\*cell*855/U2/CONTROL1 ), .I2(\sa216<0> ), .I1(\sa216<1> ), 
        .I0(\multiple_wait_state<0> ) );
    FDC \multiple_wait_state_reg<1>  ( .Q(\sa216<0> ), .D(n513), .C(clk), 
        .CLR(1'b0) );
endmodule


module control_unit ( clk, reset, ir_bus, imm_bus, sel_fl_alu, alu_flags2, 
    ext_wr, ext_rd, ext_iom, io_en, io_dir, alu_to_mem, ir_en, ir2_en, wr_addr, 
    a_addr, intr, b_addr, wr_clk, alu_control, addr_en, sel_imm_rega, 
    regstore_reset, inta, iflag, signedflag );
input  [15:0] ir_bus;
input  [15:0] imm_bus;
input  [15:0] alu_flags2;
output [3:0] b_addr;
output [3:0] wr_addr;
output [3:0] a_addr;
output [2:0] alu_control;
input  clk, reset, intr;
output sel_fl_alu, ext_wr, ext_rd, ext_iom, io_en, io_dir, alu_to_mem, ir_en, 
    ir2_en, wr_clk, addr_en, sel_imm_rega, regstore_reset, inta, iflag, 
    signedflag;
    wire \multiple_wait_state<6> , \a_addr3413<3> , n3368, n3314, 
        \multiple_wait_state<2> , n3341, \multiple_wait_state<0> , 
        \multiple_wait_state<4> , \n3469<0> , \condition<15> , \condition<26> , 
        n3451, n3488, \condition<5> , \condition<8> , \condition<11> , 
        \condition<22> , \n3442<0> , \condition<18> , \condition<1> , 
        \condition<3> , \condition<30> , \condition<29> , \condition<13> , 
        \condition<20> , \n3414<0> , \condition<7> , n3332, \condition<17> , 
        \condition<24> , \condition<6> , \condition1973<0> , \condition<16> , 
        \condition<25> , \condition<2> , \condition<31> , \condition<28> , 
        \condition<12> , \condition<21> , sum8970, \condition<9> , 
        \condition<10> , \condition<23> , \condition<19> , \condition<0> , 
        n3359, \condition<14> , \condition<27> , \n3404<0> , \condition<4> , 
        n3350, n3377, \multiple_wait_state<5> , \multiple_wait_state<1> , 
        n3323, \multiple_wait_state<3> , n3386, \n3479<0> , n11857, n11858, 
        n10717, n10718, n10719, n10720, n10721, n10722, n10723, n10724, n10725, 
        n10726, n10727, n10729, n10730, n10731, n10732, n10734, n10735, n10736, 
        n10737, n10738, n10739, n10740, n10741, n10742, n10743, n10745, n10746, 
        n10748, n10749, n10750, n10751, n10752, n10753, n10754, n10755, n10756, 
        n10757, n10758, n10759, n10760, n10761, n10762, n10763, n10764, n10765, 
        n10766, n10767, n10768, n10769, n10770, n10771, n10772, n10773, n10774, 
        n10775, n10776, n10777, n10778, n10779, n10780, n10781, n10782, n10783, 
        n10784, n10785, n10786, n10787, n10788, n10789, n10790, n10791, n10792, 
        n10793, n10794, n10795, n10796, n10797, n10799, n10800, n10801, n10802, 
        n10803, n10804, n10805, n10806, n10807, n10808, n10810, n10811, n10812, 
        n10813, n10814, n10815, n10816, n10817, n10818, n10819, n10820, n10821, 
        n10822, n10823, n10824, n10825, n10826, n10827, n10828, n10829, n10830, 
        n10831, n10832, n10833, n10834, n10835, n10836, n10837, n10838, n10839, 
        n10841, n10842, n10843, n10844, n10845, n10846, n10847, n10848, n10849, 
        n10851, n10852, n10853, n10854, n10855, n10856, n10857, n10858, n10859, 
        n10860, n10861, n10862, n10863, n10864, n10865, n10866, n10867, n10868, 
        n10869, n10870, n10871, n10872, n10873, n10874, n10875, n10876, n10877, 
        n10878, n10879, n10880, n10881, n10882, n10883, n10884, n10885, n10886, 
        n10887, n10888, n10889, n10890, n10891, n10892, n10893, n10894, n10895, 
        n10896, n10897, n10898, n10899, n10900, n10901, n10902, n10903, n10904, 
        n10905, n10906, n10907, n10908, n10909, n10910, n10911, n10912, n10913, 
        n10914, n10915, n10916, n10917, n10919, n10920, n10921, n10922, n10923, 
        n10924, n10925, n10926, n10927, n10928, n10929, n10930, n10931, n10932, 
        n10933, n10934, n10935, n10936, n10937, n10938, n10939, n10955, n10961, 
        n10962, n10964, n10973, n10977, n10986, n10987, n10989, n10993, n10999, 
        n11000, n11001, n11002, n11003, n11004, n11005, n11006, n11007, n11008, 
        n11009, n11010, n11013, n11014, n11015, n11016, n11017, n11018, n11020, 
        n11022, n11029, n11033, n11037, n11038, n11039, n11040, n11043, n11046, 
        n11047, n11048, n11056, n11057, n11059, n11062, n11063, n11066, n11071, 
        n11072, n11073, n11076, n11077, n11078, n11079, n11080, n11081, n11082, 
        n11083, n11084, n11086, n11087, n11091, n11092, n11093, n11110, 
        \*cell*964/U99/CONTROL2 , \*cell*964/U98/CONTROL2 , 
        \*cell*964/U88/CONTROL2 , \*cell*964/U87/CONTROL2 , 
        \*cell*964/U85/CONTROL1 , \*cell*964/U69/CONTROL2 , 
        \*cell*964/U67/CONTROL2 , \*cell*964/U47/CONTROL1 , 
        \*cell*964/U3/CONTROL2 , \*cell*964/U2/CONTROL1 , 
        \*cell*964/U1/CONTROL2 , n11131, n11132, n11135, n11136, n11140, 
        n11141, n11142, n11143, n11145, n11147, n11148, n11149, n11150, n11152, 
        n11153, n11154, n11155, n11156, n11158, n11159, n11160, n11161, n11162, 
        n11166, n11167, n11168, n11169, n11170, n11171, n11172, n11176, n11177, 
        n11178, n11179, n11183, n11184, n11185, n11189, n11190, n11191, n11192, 
        n11193, n11197, n11198, n11199, n11200, n11201, n11205, n11206, n11207, 
        n11208, n11209, n11210, n11217, n11218, n11222, n11223, n11224, n11225, 
        n11229, n11233, n11237, n11238, n11242, n11246, n11247, n11251, n11252, 
        n11253, n11254, n11255, n11256, n11257, n11258, n11259, n11260, n11261, 
        n11262, n11263, n11264, n11265, n11266, n11267, n11268, n11269, n11270, 
        n11271, n11272, n11273, n11274, n11275, n11276, n11277, n11278, n11279, 
        n11280, n11281, n11282, n11283, n11284, n11285, n11286, n11287, n11288, 
        n11289, n11290, n11291, n11292, n11293, n11294, n11295, n11296, n11297, 
        n11298, n11299, n11300, n11301, n11302, n11303, n11304, n11305, n11306, 
        n11307, n11308, n11309, n11310, n11311, n11312, n11313, n11314, n11315, 
        n11316, n11317, n11318, n11319, n11320, n11321, n11322, n11323, n11324, 
        n11325, n11326, n11327, n11328, n11329, n11330, n11331, n11332, n11333, 
        n11334, n11335, n11336, n11337, n11338, n11339, n11340, n11341, n11342, 
        n11343, n11344, n11345, n11346, n11347, n11348, n11349, n11350, n11351, 
        n11352, n11353, n11354, n11355, n11356, n11357, n11359, n11360, n11361, 
        n11362, n11363, n11364, n11365, n11366, n11367, n11368, n11369, n11370, 
        n11371, n11372, n11373, n11374, n11375, n11376, n11377, n11379, n11380, 
        n11381, n11383, n11384, n11385, n11386, n11387, n11389, n11390, n11391, 
        n11392, n11393, n11394, n11395, n11396, n11397, n11398, n11399, n11400, 
        n11401, n11403, n11404, n11405, n11406, n11407, n11408, n11409, n11410, 
        n11411, n11412, n11413, n11414, n11415, n11416, n11417, n11418, n11419, 
        n11420, n11421, n11422, n11423, n11424, n11425, n11426, n11427, n11428, 
        n11429, n11430, n11431, n11432, n11433, n11434, n11435, n11436, n11437, 
        n11438, n11439, n11440, n11441, n11442, n11443, n11444, n11445, n11446, 
        n11447, n11448, n11449, n11450, n11451, n11452, n11453, n11454, n11456, 
        n11457, n11458, n11459, n11460, n11461, n11462, n11464, n11465, n11466, 
        n11467, n11468, n11469, n11470, n11471, n11472, n11473, n11474, n11475, 
        n11476, n11477, n11478, n11479, n11480, n11481, n11482, n11483, n11484, 
        n11485, n11486, n11488, n11489, n11490, n11491, n11492, n11493, n11494, 
        n11495, n11496, n11497, n11498, n11499, n11500, n11501, n11502, n11503, 
        n11504, n11505, n11506, n11508, n11509, n11510, n11511, n11512, n11513, 
        n11514, n11516, n11517, n11518, n11519, n11520, n11521, n11522, n11523, 
        n11525, n11526, n11527, n11528, n11529, n11530, n11531, n11532, n11533, 
        n11534, n11535, n11536, n11537, n11538, n11539, n11540, n11541, n11542, 
        n11543, n11544, n11545, n11547, n11548, n11549, n11550, n11551, n11552, 
        n11553, n11554, n11555, n11556, n11557, n11558, n11559, n11560, n11561, 
        n11562, n11563, n11565, n11566, n11567, n11568, n11569, n11570, n11572, 
        n11573, n11574, n11575, n11576, n11577, n11578, n11579, n11580, n11581, 
        n11582, n11583, n11584, n11585, n11586, n11587, n11588, n11589, n11590, 
        n11591, n11592, n11593, n11594, n11595, n11596, n11597, n11598, n11599, 
        n11600, n11601, n11602, n11603, n11605, n11606, n11607, n11608, n11609, 
        n11610, n11611, n11612, n11613, n11614, n11615, n11616, n11617, n11619, 
        n11620, n11621, n11622, n11623, n11624, n11625, n11626, n11627, n11628, 
        n11629, n11631, n11632, n11633, n11634, n11635, n11636, n11637, n11638, 
        n11639, n11640, n11641, n11643, n11644, n11645, n11646, n11647, n11648, 
        n11649, n11650, n11652, n11653, n11654, n11655, n11656, n11657, n11658, 
        n11659, n11660, n11661, n11663, n11664, n11665, n11666, n11667, n11668, 
        n11669, n11670, n11672, n11673, n11674, n11675, n11676, n11677, n11678, 
        n11680, n11681, n11682, n11683, n11684, n11685, n11687, n11688, n11689, 
        n11690, n11691, n11692, n11693, n11694, n11695, n11696, n11697, n11698, 
        n11699, n11700, n11701, n11702, n11703, n11704, n11706, n11707, n11708, 
        n11709, n11710, n11711, n11712, n11713, n11714, n11715, n11716, n11717, 
        n11718, n11719, n11720, n11721, n11722, n11723, n11725, n11726, n11727, 
        n11728, n11729, n11731, n11732, n11733, n11734, n11735, n11736, n11737, 
        n11738, n11739, n11741, n11742, n11743, n11744, n11745, n11746, n11747, 
        n11748, n11749, n11750, n11751, n11752, n11753, n11754, n11755, n11756, 
        n11757, n11758, n11759, n11760, n11761, n11762, n11763, n11764, n11765, 
        n11766, n11767, n11768, n11769, n11770, n11771, n11772, n11773, n11774, 
        n11775, n11776, n11777, n11778, n11779, n11780, n11781, n11782, n11783, 
        n11784, n11785, n11786, n11787, n11788, n11789, n11790, n11791, n11792, 
        n11793, n11794, n11795, n11796, n11797, n11798, n11799, n11800, n11801, 
        n11802, n11803, n11804, n11805, n11806, n11807, n11808, n11809, n11810, 
        n11811, n11812, n11813, n11814, n11815, n11816, n11818, n11819, n11820, 
        n11821, n11822, n11823, n11824, n11825, n11826, n11827, n11828, n11829, 
        n11830, n11831, n11832, n11833, n11835, n11836, n11837, n11838, n11839, 
        n11840, n11841, n11842, n11843, n11844, n11845, n11846, n11847, n11848, 
        n11849, n11850, n11851, n11852, n11853, n11854, n11855, n11856;
    assign iflag = alu_flags2[5];
    OBUF_S U3549 ( .O(ext_iom), .I(n11858) );
    IBUF U3550 ( .O(sum8970), .I(intr) );
    OBUF_S U3551 ( .O(inta), .I(n11857) );
    INV U3552 ( .O(n11110), .I(\multiple_wait_state<0> ) );
    INV U3553 ( .O(n11131), .I(ir_bus[0]) );
    AND3 U3554 ( .O(n10908), .I2(n10749), .I1(n11131), .I0(n10805) );
    INV U3555 ( .O(n11132), .I(\multiple_wait_state<2> ) );
    AND3 U3556 ( .O(n11059), .I2(n10811), .I1(n11132), .I0(n10805) );
    FDCE \condition_reg<12>  ( .Q(\condition<12> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    NAND2 U3559 ( .O(n11136), .I1(n10762), .I0(n10769) );
    NAND2 U3560 ( .O(n11135), .I1(n11062), .I0(n10721) );
    NAND2 U3561 ( .O(n11063), .I1(n11135), .I0(n11136) );
    NOR3 U3562 ( .O(n11062), .I2(\multiple_wait_state<4> ), .I1(
        \multiple_wait_state<3> ), .I0(\multiple_wait_state<2> ) );
    FDCE ext_rd_reg ( .Q(ext_rd), .D(\*cell*964/U3/CONTROL2 ), .C(clk), .CE(
        n3314), .CLR(1'b0) );
    AND2 U3564 ( .O(n10894), .I1(n10739), .I0(n10805) );
    AND3 U3565 ( .O(n11066), .I2(\multiple_wait_state<2> ), .I1(n10721), .I0(
        n10745) );
    FDCE ir_en_reg ( .Q(ir_en), .D(n11110), .C(clk), .CE(
        \*cell*964/U87/CONTROL2 ), .CLR(1'b0) );
    AND3 U3567 ( .O(n11071), .I2(\multiple_wait_state<0> ), .I1(n10818), .I0(
        n10741) );
    AND3 U3568 ( .O(n10898), .I2(\multiple_wait_state<0> ), .I1(n10741), .I0(
        n10760) );
    FDCE sel_fl_alu_reg ( .Q(sel_fl_alu), .D(\*cell*964/U85/CONTROL1 ), .C(clk
        ), .CE(n3341), .CLR(1'b0) );
    OR2 U3570 ( .O(n11140), .I1(n10760), .I0(n10830) );
    AND2 U3571 ( .O(n11141), .I1(n11140), .I0(n10748) );
    OR2 U3572 ( .O(n11073), .I1(n10727), .I0(n11141) );
    INV U3573 ( .O(n11143), .I(n11142) );
    NAND3 U3574 ( .O(n11142), .I2(\multiple_wait_state<4> ), .I1(n10769), .I0(
        n10913) );
    OR2 U3575 ( .O(n11072), .I1(n10725), .I0(n11143) );
    FDCE inta_reg ( .Q(n11857), .D(\*cell*964/U69/CONTROL2 ), .C(clk), .CE(
        n3377), .CLR(1'b0) );
    AND3 U3577 ( .O(n10899), .I2(\multiple_wait_state<0> ), .I1(n10739), .I0(
        n10741) );
    INV U3578 ( .O(n11145), .I(\multiple_wait_state<0> ) );
    AND3 U3579 ( .O(n10895), .I2(n10741), .I1(n11145), .I0(n10739) );
    FDCE ir2_en_reg ( .Q(ir2_en), .D(n11110), .C(clk), .CE(
        \*cell*964/U88/CONTROL2 ), .CLR(1'b0) );
    INV U3581 ( .O(n11147), .I(n11148) );
    OR2 U3582 ( .O(n11149), .I1(\*cell*964/U98/CONTROL2 ), .I0(n11147) );
    NAND2 U3583 ( .O(n11148), .I1(n10783), .I0(\multiple_wait_state<1> ) );
    AND2 U3584 ( .O(n11079), .I1(n11149), .I0(n10769) );
    AND2 U3585 ( .O(n11150), .I1(n10722), .I0(n10738) );
    OR3 U3586 ( .O(n11078), .I2(n10734), .I1(n11150), .I0(n10740) );
    FDCE signedflag_reg ( .Q(signedflag), .D(imm_bus[10]), .C(clk), .CE(n3488), 
        .CLR(1'b0) );
    INV U3588 ( .O(n11152), .I(n10769) );
    OR2 U3589 ( .O(n11154), .I1(n10911), .I0(n11152) );
    NAND2 U3590 ( .O(n11153), .I1(n11020), .I0(n10721) );
    NAND2 U3591 ( .O(n11080), .I1(n11153), .I0(n11154) );
    OR2 U3592 ( .O(n11155), .I1(n10748), .I0(n10853) );
    AND2 U3593 ( .O(n11156), .I1(n11155), .I0(n10868) );
    OR2 U3594 ( .O(n10904), .I1(n10729), .I0(n11156) );
    FDCE \a_addr_reg<3>  ( .Q(a_addr[3]), .D(\a_addr3413<3> ), .C(clk), .CE(
        \n3414<0> ), .CLR(1'b0) );
    INV U3596 ( .O(n11158), .I(n10915) );
    NAND2 U3597 ( .O(n11160), .I1(n11159), .I0(n10769) );
    OR2 U3598 ( .O(n11159), .I1(n10764), .I0(n11158) );
    NAND2 U3599 ( .O(n11076), .I1(n11160), .I0(n10870) );
    OR2 U3600 ( .O(n11161), .I1(n10748), .I0(n10738) );
    AND2 U3601 ( .O(n11162), .I1(n11161), .I0(n10758) );
    OR2 U3602 ( .O(n11081), .I1(n10767), .I0(n11162) );
    FDCE \condition_reg<4>  ( .Q(\condition<4> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<21>  ( .Q(\condition<21> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3606 ( .O(n11166), .I(n11167) );
    OR2 U3607 ( .O(n11168), .I1(n10742), .I0(n11166) );
    NAND2 U3608 ( .O(n11167), .I1(n10989), .I0(\multiple_wait_state<1> ) );
    AND2 U3609 ( .O(n11083), .I1(n11168), .I0(\multiple_wait_state<0> ) );
    INV U3610 ( .O(n11169), .I(n11171) );
    INV U3611 ( .O(n11170), .I(reset) );
    OR2 U3612 ( .O(n11172), .I1(n10721), .I0(n11169) );
    NAND2 U3613 ( .O(n11171), .I1(n11170), .I0(n10741) );
    AND2 U3614 ( .O(n11077), .I1(n11172), .I0(n10742) );
    FDCE \condition_reg<31>  ( .Q(\condition<31> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<28>  ( .Q(\condition<28> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    OR3 U3618 ( .O(n11176), .I2(n10925), .I1(ir_bus[15]), .I0(ir_bus[13]) );
    NAND2 U3619 ( .O(n10926), .I1(n11176), .I0(n10924) );
    INV U3620 ( .O(n11179), .I(n11178) );
    INV U3621 ( .O(n11177), .I(n11029) );
    OR3 U3622 ( .O(n11178), .I2(\multiple_wait_state<6> ), .I1(
        \multiple_wait_state<3> ), .I0(n11177) );
    OR2 U3623 ( .O(n10922), .I1(n10770), .I0(n11179) );
    FDCE \condition_reg<9>  ( .Q(\condition<9> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<16>  ( .Q(\condition<16> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    NOR2 U3627 ( .O(n11084), .I1(n10920), .I0(\multiple_wait_state<2> ) );
    INV U3628 ( .O(n11183), .I(imm_bus[14]) );
    OR2 U3629 ( .O(n11185), .I1(n10929), .I0(n11183) );
    NAND2 U3630 ( .O(n11184), .I1(n11084), .I0(ir_bus[4]) );
    NAND2 U3631 ( .O(n10930), .I1(n11184), .I0(n11185) );
    FDCE \condition_reg<2>  ( .Q(\condition<2> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<25>  ( .Q(\condition<25> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3635 ( .O(n11189), .I(n11029) );
    NOR2 U3636 ( .O(n11190), .I1(n11189), .I0(\multiple_wait_state<2> ) );
    NOR3 U3637 ( .O(n11087), .I2(n11086), .I1(\multiple_wait_state<6> ), .I0(
        n11190) );
    OR2 U3638 ( .O(n11193), .I1(\multiple_wait_state<0> ), .I0(n11191) );
    NAND2 U3639 ( .O(n11192), .I1(\multiple_wait_state<0> ), .I0(n10868) );
    NOR2 U3640 ( .O(n11191), .I1(n10739), .I0(n11020) );
    NAND2 U3641 ( .O(n11086), .I1(n11192), .I0(n11193) );
    FDCE \condition_reg<27>  ( .Q(\condition<27> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<14>  ( .Q(\condition<14> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3645 ( .O(n11197), .I(imm_bus[13]) );
    OR2 U3646 ( .O(n11199), .I1(n10929), .I0(n11197) );
    NAND2 U3647 ( .O(n11198), .I1(n11084), .I0(ir_bus[3]) );
    NAND2 U3648 ( .O(n10932), .I1(n11198), .I0(n11199) );
    NAND2 U3649 ( .O(n11200), .I1(n10781), .I0(\multiple_wait_state<1> ) );
    AND2 U3650 ( .O(n11201), .I1(n11200), .I0(\multiple_wait_state<6> ) );
    NOR2 U3651 ( .O(n10931), .I1(n11201), .I0(n11087) );
    FDCE \condition_reg<19>  ( .Q(\condition<19> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<6>  ( .Q(\condition<6> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3655 ( .O(n11205), .I(imm_bus[11]) );
    OR2 U3656 ( .O(n11207), .I1(n10929), .I0(n11205) );
    NAND2 U3657 ( .O(n11206), .I1(n11084), .I0(ir_bus[1]) );
    NAND2 U3658 ( .O(n10934), .I1(n11206), .I0(n11207) );
    INV U3659 ( .O(n11208), .I(imm_bus[12]) );
    OR2 U3660 ( .O(n11210), .I1(n10929), .I0(n11208) );
    NAND2 U3661 ( .O(n11209), .I1(n11084), .I0(ir_bus[2]) );
    NAND2 U3662 ( .O(n10933), .I1(n11209), .I0(n11210) );
    FDCE \condition_reg<23>  ( .Q(\condition<23> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<10>  ( .Q(\condition<10> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    AND3 U3666 ( .O(\*cell*964/U87/CONTROL2 ), .I2(n10741), .I1(n10783), .I0(
        n10786) );
    AND3 U3667 ( .O(\*cell*964/U88/CONTROL2 ), .I2(n10741), .I1(n10914), .I0(
        n10913) );
    FDCE \condition_reg<18>  ( .Q(\condition<18> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<7>  ( .Q(\condition<7> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    XOR2 U3671 ( .O(n11005), .I1(alu_flags2[3]), .I0(alu_flags2[1]) );
    OR2 U3672 ( .O(n11217), .I1(n10762), .I0(n11062) );
    AND2 U3673 ( .O(n11218), .I1(n11217), .I0(n10748) );
    OR2 U3674 ( .O(n10935), .I1(n10792), .I0(n11218) );
    FDCE \condition_reg<22>  ( .Q(\condition<22> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<11>  ( .Q(\condition<11> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3678 ( .O(n11222), .I(n10743) );
    INV U3679 ( .O(n11223), .I(n10741) );
    OR4 U3680 ( .O(n11015), .I3(n11222), .I2(n11223), .I1(
        \multiple_wait_state<0> ), .I0(ir_bus[14]) );
    INV U3681 ( .O(n11224), .I(n10749) );
    INV U3682 ( .O(n11225), .I(n10741) );
    OR4 U3683 ( .O(n10746), .I3(n11224), .I2(n11225), .I1(
        \multiple_wait_state<0> ), .I0(ir_bus[14]) );
    FDCE \condition_reg<15>  ( .Q(\condition<15> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<3>  ( .Q(\condition<3> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    NAND4 U3687 ( .O(n10843), .I3(n10720), .I2(ir_bus[14]), .I1(
        \multiple_wait_state<2> ), .I0(\multiple_wait_state<1> ) );
    INV U3688 ( .O(n11229), .I(n10814) );
    OR4 U3689 ( .O(n10824), .I3(n10820), .I2(n10817), .I1(n11229), .I0(n10816)
         );
    FDCE \condition_reg<17>  ( .Q(\condition<17> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<26>  ( .Q(\condition<26> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    OR4 U3693 ( .O(n11091), .I3(n10827), .I2(n10796), .I1(n10767), .I0(n10961)
         );
    INV U3694 ( .O(n11233), .I(n10845) );
    OR4 U3695 ( .O(n10860), .I3(n10838), .I2(n11033), .I1(n11233), .I0(n10962)
         );
    FDCE \condition_reg<8>  ( .Q(\condition<8> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<24>  ( .Q(\condition<24> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3699 ( .O(n11237), .I(n10880) );
    OR4 U3700 ( .O(n11093), .I3(n10866), .I2(n11043), .I1(n11237), .I0(n10861)
         );
    INV U3701 ( .O(n11238), .I(n10887) );
    OR4 U3702 ( .O(n11092), .I3(n11238), .I2(n10787), .I1(n10730), .I0(n10729)
         );
    FDCE \condition_reg<13>  ( .Q(\condition<13> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<1>  ( .Q(\condition<1> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3706 ( .O(n11242), .I(n10873) );
    OR4 U3707 ( .O(n10906), .I3(n11057), .I2(n10878), .I1(n11242), .I0(n10881)
         );
    OR4 U3708 ( .O(n10905), .I3(n11046), .I2(n10827), .I1(n10832), .I0(n10885)
         );
    FDCE \condition_reg<5>  ( .Q(\condition<5> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<20>  ( .Q(\condition<20> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    INV U3712 ( .O(n11246), .I(n10903) );
    INV U3713 ( .O(n11247), .I(n10901) );
    OR4 U3714 ( .O(n10907), .I3(n11071), .I2(n11079), .I1(n11246), .I0(n11247)
         );
    FDCE \condition_reg<30>  ( .Q(\condition<30> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    FDCE \condition_reg<29>  ( .Q(\condition<29> ), .D(1'b0), .C(clk), .CE(
        \n3469<0> ), .CLR(1'b0) );
    AND3 U3718 ( .O(n11056), .I2(\multiple_wait_state<2> ), .I1(n10805), .I0(
        n10811) );
    OR3 U3719 ( .O(n11252), .I2(ir_bus[13]), .I1(ir_bus[12]), .I0(ir_bus[11])
         );
    NAND2 U3720 ( .O(n11251), .I1(ir_bus[13]), .I0(ir_bus[12]) );
    AND3 U3721 ( .O(n10875), .I2(n10735), .I1(n11251), .I0(n11252) );
    AND3 U3722 ( .O(n10886), .I2(\multiple_wait_state<2> ), .I1(n10805), .I0(
        n10745) );
    AND3 U3723 ( .O(n10883), .I2(\multiple_wait_state<1> ), .I1(
        \*cell*964/U98/CONTROL2 ), .I0(n10805) );
    AND3 U3724 ( .O(n10882), .I2(n10913), .I1(n10805), .I0(n10786) );
    INV U3725 ( .O(n11253), .I(n10864) );
    OR4 U3726 ( .O(n11048), .I3(n10875), .I2(n10886), .I1(n11253), .I0(n10865)
         );
    AND2 U3727 ( .O(n11254), .I1(n10836), .I0(n3488) );
    OR3 U3728 ( .O(n10871), .I2(n10737), .I1(n11254), .I0(n10775) );
    NAND2 U3729 ( .O(n11256), .I1(n10738), .I0(n10786) );
    NAND2 U3730 ( .O(n11255), .I1(n10811), .I0(n10732) );
    NAND2 U3731 ( .O(n11047), .I1(n11255), .I0(n11256) );
    OR2 U3732 ( .O(n11257), .I1(n10742), .I0(n10830) );
    AND2 U3733 ( .O(n11258), .I1(n11257), .I0(n10738) );
    OR2 U3734 ( .O(n10869), .I1(n10740), .I0(n11258) );
    AND3 U3735 ( .O(n11046), .I2(\multiple_wait_state<0> ), .I1(n10868), .I0(
        n10964) );
    AND3 U3736 ( .O(n10889), .I2(\multiple_wait_state<0> ), .I1(n10928), .I0(
        n10964) );
    INV U3737 ( .O(n11259), .I(\multiple_wait_state<0> ) );
    AND3 U3738 ( .O(n11043), .I2(n10964), .I1(n11259), .I0(n10928) );
    INV U3739 ( .O(n11260), .I(n10755) );
    OR2 U3740 ( .O(n11262), .I1(n10753), .I0(n11260) );
    NAND2 U3741 ( .O(n11261), .I1(n10868), .I0(n10748) );
    NAND2 U3742 ( .O(n10863), .I1(n11261), .I0(n11262) );
    INV U3743 ( .O(n11265), .I(n11264) );
    INV U3744 ( .O(n11263), .I(\multiple_wait_state<4> ) );
    NAND3 U3745 ( .O(n11264), .I2(n10777), .I1(n11263), .I0(n11037) );
    OR2 U3746 ( .O(n10862), .I1(\*cell*964/U3/CONTROL2 ), .I0(n11265) );
    INV U3747 ( .O(n11266), .I(n10758) );
    NOR2 U3748 ( .O(n11267), .I1(n10761), .I0(n11266) );
    OR3 U3749 ( .O(n10859), .I2(n10756), .I1(n11267), .I0(n10773) );
    OR2 U3750 ( .O(n11269), .I1(n10857), .I0(\multiple_wait_state<4> ) );
    NAND2 U3751 ( .O(n11268), .I1(n10936), .I0(\*cell*964/U69/CONTROL2 ) );
    NAND2 U3752 ( .O(n10858), .I1(n11268), .I0(n11269) );
    OR2 U3753 ( .O(n11271), .I1(n10847), .I0(n10753) );
    NAND2 U3754 ( .O(n11270), .I1(n10721), .I0(n10818) );
    NAND2 U3755 ( .O(n11040), .I1(n11270), .I0(n11271) );
    NOR2 U3756 ( .O(n11273), .I1(\multiple_wait_state<0> ), .I0(n11272) );
    AND2 U3757 ( .O(n11272), .I1(n10830), .I0(n10757) );
    NOR2 U3758 ( .O(n11039), .I1(n11273), .I0(n11038) );
    INV U3759 ( .O(n11274), .I(n3488) );
    NOR2 U3760 ( .O(n10842), .I1(n10836), .I0(n11274) );
    INV U3761 ( .O(n11275), .I(\multiple_wait_state<0> ) );
    AND3 U3762 ( .O(n10838), .I2(n10964), .I1(n11275), .I0(n10808) );
    INV U3763 ( .O(n11276), .I(\multiple_wait_state<0> ) );
    AND3 U3764 ( .O(n10833), .I2(n10741), .I1(n11276), .I0(n11020) );
    INV U3765 ( .O(n11277), .I(ir_bus[11]) );
    NOR2 U3766 ( .O(n11278), .I1(n11277), .I0(n10770) );
    NOR2 U3767 ( .O(n11279), .I1(n10792), .I0(ir_bus[11]) );
    OR3 U3768 ( .O(n10828), .I2(ir_bus[12]), .I1(n11278), .I0(n11279) );
    AND3 U3769 ( .O(n10827), .I2(\multiple_wait_state<2> ), .I1(n10771), .I0(
        n10721) );
    AND3 U3770 ( .O(n11029), .I2(\multiple_wait_state<0> ), .I1(
        \multiple_wait_state<4> ), .I0(\multiple_wait_state<1> ) );
    AND2 U3771 ( .O(n10825), .I1(n10783), .I0(n10786) );
    INV U3772 ( .O(n11280), .I(n10830) );
    NAND2 U3773 ( .O(n11282), .I1(n10741), .I0(n10760) );
    OR2 U3774 ( .O(n11281), .I1(n10837), .I0(n11280) );
    NAND2 U3775 ( .O(n10823), .I1(n11281), .I0(n11282) );
    AND3 U3776 ( .O(n10813), .I2(\multiple_wait_state<0> ), .I1(n11020), .I0(
        n10964) );
    INV U3777 ( .O(n11283), .I(\multiple_wait_state<2> ) );
    AND3 U3778 ( .O(n10812), .I2(n10805), .I1(n11283), .I0(n10771) );
    OR2 U3779 ( .O(n11284), .I1(n10868), .I0(n10928) );
    AND2 U3780 ( .O(n11285), .I1(n11284), .I0(n10964) );
    OR2 U3781 ( .O(n10822), .I1(n10986), .I0(n11285) );
    AND3 U3782 ( .O(n10986), .I2(\multiple_wait_state<0> ), .I1(n10808), .I0(
        n10964) );
    INV U3783 ( .O(n11286), .I(\multiple_wait_state<0> ) );
    AND3 U3784 ( .O(n11022), .I2(n10741), .I1(n11286), .I0(n10722) );
    INV U3785 ( .O(n11287), .I(\multiple_wait_state<6> ) );
    OR2 U3786 ( .O(n11289), .I1(n11287), .I0(\multiple_wait_state<0> ) );
    INV U3787 ( .O(n11288), .I(\multiple_wait_state<5> ) );
    AND3 U3788 ( .O(n10821), .I2(n10722), .I1(n11288), .I0(n11289) );
    NOR2 U3789 ( .O(n11291), .I1(n11018), .I0(n11290) );
    AND2 U3790 ( .O(n11290), .I1(n10914), .I0(n10732) );
    NOR2 U3791 ( .O(n10806), .I1(n11291), .I0(\multiple_wait_state<3> ) );
    INV U3792 ( .O(n11292), .I(n11294) );
    INV U3793 ( .O(n11293), .I(n11016) );
    OR2 U3794 ( .O(n11295), .I1(n11017), .I0(n11292) );
    NAND2 U3795 ( .O(n11294), .I1(n11293), .I0(n10844) );
    AND2 U3796 ( .O(n11018), .I1(n11295), .I0(\multiple_wait_state<1> ) );
    OR2 U3797 ( .O(n11297), .I1(n10853), .I0(n10721) );
    INV U3798 ( .O(n11296), .I(\multiple_wait_state<4> ) );
    AND3 U3799 ( .O(n11017), .I2(\multiple_wait_state<2> ), .I1(n11296), .I0(
        n11297) );
    INV U3800 ( .O(n11298), .I(n10748) );
    OR2 U3801 ( .O(n11300), .I1(n10801), .I0(n11015) );
    OR2 U3802 ( .O(n11299), .I1(n11298), .I0(n10804) );
    AND2 U3803 ( .O(n11016), .I1(n11299), .I0(n11300) );
    INV U3804 ( .O(n11302), .I(ir_bus[13]) );
    INV U3805 ( .O(n11301), .I(ir_bus[14]) );
    OR2 U3806 ( .O(n11305), .I1(n11303), .I0(n11301) );
    OR2 U3807 ( .O(n11304), .I1(ir_bus[14]), .I0(ir_bus[13]) );
    AND2 U3808 ( .O(n11303), .I1(n11302), .I0(n10743) );
    AND3 U3809 ( .O(n10803), .I2(ir_bus[15]), .I1(n11304), .I0(n11305) );
    OR2 U3810 ( .O(n11306), .I1(\condition<29> ), .I0(\condition<28> ) );
    AND2 U3811 ( .O(n11307), .I1(n11306), .I0(n10750) );
    OR2 U3812 ( .O(n10939), .I1(n11014), .I0(n11307) );
    OR2 U3813 ( .O(n11308), .I1(\condition<27> ), .I0(\condition<26> ) );
    AND2 U3814 ( .O(n11309), .I1(n11308), .I0(n10750) );
    OR2 U3815 ( .O(n11014), .I1(n11013), .I0(n11309) );
    OR2 U3816 ( .O(n11310), .I1(\condition<25> ), .I0(\condition<24> ) );
    AND2 U3817 ( .O(n11013), .I1(n11310), .I0(n10750) );
    INV U3818 ( .O(n11313), .I(n11312) );
    INV U3819 ( .O(n11311), .I(n10750) );
    NAND2 U3820 ( .O(n11312), .I1(\condition1973<0> ), .I0(n11311) );
    NOR2 U3821 ( .O(n10724), .I1(n11313), .I0(n11010) );
    OR2 U3822 ( .O(n11316), .I1(ir_bus[8]), .I0(n11314) );
    NAND2 U3823 ( .O(n11315), .I1(ir_bus[8]), .I0(n11007) );
    NOR2 U3824 ( .O(n11314), .I1(n11008), .I0(n11009) );
    NAND2 U3825 ( .O(n10800), .I1(n11315), .I0(n11316) );
    INV U3826 ( .O(n11317), .I(ir_bus[7]) );
    NOR2 U3827 ( .O(n11318), .I1(n11317), .I0(alu_flags2[0]) );
    NOR3 U3828 ( .O(n11009), .I2(ir_bus[10]), .I1(ir_bus[9]), .I0(n11318) );
    INV U3829 ( .O(n11319), .I(ir_bus[7]) );
    OR2 U3830 ( .O(n11321), .I1(alu_flags2[3]), .I0(ir_bus[7]) );
    OR2 U3831 ( .O(n11320), .I1(n11319), .I0(alu_flags2[4]) );
    AND3 U3832 ( .O(n11008), .I2(ir_bus[9]), .I1(n11320), .I0(n11321) );
    INV U3833 ( .O(n11322), .I(ir_bus[9]) );
    OR3 U3834 ( .O(n11324), .I2(n11322), .I1(n11005), .I0(n10799) );
    OR2 U3835 ( .O(n11323), .I1(n10999), .I0(ir_bus[9]) );
    NAND2 U3836 ( .O(n11007), .I1(n11323), .I0(n11324) );
    INV U3837 ( .O(n11325), .I(n11326) );
    OR2 U3838 ( .O(n11327), .I1(n11325), .I0(n11005) );
    NAND2 U3839 ( .O(n11326), .I1(ir_bus[7]), .I0(alu_flags2[0]) );
    NAND2 U3840 ( .O(n11006), .I1(n11327), .I0(ir_bus[9]) );
    XOR2 U3841 ( .O(n11328), .I1(n10799), .I0(alu_flags2[2]) );
    AND2 U3842 ( .O(n11329), .I1(ir_bus[10]), .I0(n11328) );
    NOR2 U3843 ( .O(n11004), .I1(n11329), .I0(n11003) );
    NOR2 U3844 ( .O(n11331), .I1(n11330), .I0(ir_bus[8]) );
    NOR2 U3845 ( .O(n11330), .I1(n11000), .I0(n11001) );
    OR2 U3846 ( .O(n11003), .I1(n11002), .I0(n11331) );
    INV U3847 ( .O(n11332), .I(ir_bus[7]) );
    NOR4 U3848 ( .O(n11001), .I3(n11332), .I2(ir_bus[10]), .I1(ir_bus[9]), 
        .I0(alu_flags2[0]) );
    INV U3849 ( .O(n11333), .I(alu_flags2[3]) );
    OR2 U3850 ( .O(n11335), .I1(ir_bus[7]), .I0(n11333) );
    NAND2 U3851 ( .O(n11334), .I1(ir_bus[7]), .I0(alu_flags2[4]) );
    AND3 U3852 ( .O(n11000), .I2(ir_bus[9]), .I1(n11334), .I0(n11335) );
    INV U3853 ( .O(n11336), .I(n10885) );
    NAND2 U3854 ( .O(n11338), .I1(ir_bus[12]), .I0(n11336) );
    OR2 U3855 ( .O(n11337), .I1(n10770), .I0(ir_bus[12]) );
    AND3 U3856 ( .O(n10790), .I2(ir_bus[11]), .I1(n11337), .I0(n11338) );
    INV U3857 ( .O(n11339), .I(\multiple_wait_state<1> ) );
    AND3 U3858 ( .O(n10885), .I2(n10805), .I1(n11339), .I0(
        \*cell*964/U98/CONTROL2 ) );
    INV U3859 ( .O(n11341), .I(n11340) );
    XOR2 U3860 ( .O(n11340), .I1(ir_bus[15]), .I0(ir_bus[13]) );
    OR2 U3861 ( .O(n10793), .I1(n11341), .I0(ir_bus[14]) );
    INV U3862 ( .O(n11344), .I(n11343) );
    INV U3863 ( .O(n11342), .I(n10742) );
    OR3 U3864 ( .O(n11343), .I2(\multiple_wait_state<5> ), .I1(
        \multiple_wait_state<0> ), .I0(n11342) );
    OR2 U3865 ( .O(n10789), .I1(n10962), .I0(n11344) );
    XOR2 U3866 ( .O(n11345), .I1(\multiple_wait_state<0> ), .I0(
        \multiple_wait_state<2> ) );
    AND3 U3867 ( .O(n10854), .I2(n10741), .I1(n11345), .I0(n10993) );
    INV U3868 ( .O(n11346), .I(\multiple_wait_state<3> ) );
    NOR3 U3869 ( .O(n10993), .I2(\multiple_wait_state<4> ), .I1(
        \multiple_wait_state<1> ), .I0(n11346) );
    AND3 U3870 ( .O(n10962), .I2(\multiple_wait_state<0> ), .I1(n10902), .I0(
        n10741) );
    OR2 U3871 ( .O(n11347), .I1(n10769), .I0(n10805) );
    AND2 U3872 ( .O(n10766), .I1(n11347), .I0(n10902) );
    INV U3873 ( .O(n11348), .I(\multiple_wait_state<4> ) );
    XOR2 U3874 ( .O(n11349), .I1(\multiple_wait_state<0> ), .I0(
        \multiple_wait_state<3> ) );
    AND3 U3875 ( .O(n10781), .I2(\multiple_wait_state<2> ), .I1(n11348), .I0(
        n11349) );
    INV U3876 ( .O(n11350), .I(\multiple_wait_state<4> ) );
    AND3 U3877 ( .O(n10989), .I2(\multiple_wait_state<3> ), .I1(n11350), .I0(
        \multiple_wait_state<2> ) );
    INV U3878 ( .O(n11351), .I(n10849) );
    INV U3879 ( .O(n11352), .I(n10772) );
    OR4 U3880 ( .O(n10987), .I3(n10962), .I2(n10986), .I1(n11351), .I0(n11352)
         );
    AND3 U3881 ( .O(n10773), .I2(\multiple_wait_state<0> ), .I1(n10868), .I0(
        n10741) );
    INV U3882 ( .O(n11353), .I(\multiple_wait_state<0> ) );
    AND3 U3883 ( .O(n10770), .I2(n10741), .I1(n11353), .I0(n10762) );
    INV U3884 ( .O(n11354), .I(\multiple_wait_state<6> ) );
    NOR3 U3885 ( .O(n10853), .I2(\multiple_wait_state<5> ), .I1(
        \multiple_wait_state<0> ), .I0(n11354) );
    OR2 U3886 ( .O(n11356), .I1(n10765), .I0(\multiple_wait_state<6> ) );
    NAND2 U3887 ( .O(n11355), .I1(n10938), .I0(n10853) );
    NAND2 U3888 ( .O(n10973), .I1(n11355), .I0(n11356) );
    AND2 U3889 ( .O(n10799), .I1(ir_bus[7]), .I0(alu_flags2[0]) );
    INV U3890 ( .O(n11357), .I(reset) );
    NOR2 U3891 ( .O(\*cell*964/U47/CONTROL1 ), .I1(\multiple_wait_state<0> ), 
        .I0(n11357) );
    AND2 U3892 ( .O(n10755), .I1(\multiple_wait_state<1> ), .I0(
        \multiple_wait_state<0> ) );
    FDCE regstore_reset_reg ( .Q(regstore_reset), .D(\*cell*964/U47/CONTROL1 ), 
        .C(clk), .CE(n3386), .CLR(1'b0) );
    INV U3894 ( .O(n11359), .I(ir_bus[15]) );
    NOR2 U3895 ( .O(n10955), .I1(ir_bus[13]), .I0(n11359) );
    INV U3896 ( .O(n11361), .I(n11360) );
    NAND2 U3897 ( .O(n11360), .I1(ir_bus[15]), .I0(ir_bus[13]) );
    NOR2 U3898 ( .O(n10810), .I1(n11361), .I0(ir_bus[14]) );
    INV U3899 ( .O(n11362), .I(ir_bus[12]) );
    NOR2 U3900 ( .O(n10736), .I1(ir_bus[11]), .I0(n11362) );
    NOR2 U3901 ( .O(n10743), .I1(ir_bus[11]), .I0(ir_bus[12]) );
    INV U3902 ( .O(n11363), .I(\multiple_wait_state<0> ) );
    NOR2 U3903 ( .O(n10936), .I1(\multiple_wait_state<1> ), .I0(n11363) );
    NOR4 U3904 ( .O(n10742), .I3(\multiple_wait_state<2> ), .I2(
        \multiple_wait_state<4> ), .I1(\multiple_wait_state<1> ), .I0(
        \multiple_wait_state<3> ) );
    INV U3905 ( .O(n11364), .I(\multiple_wait_state<6> ) );
    AND4 U3906 ( .O(n10732), .I3(n11364), .I2(\multiple_wait_state<2> ), .I1(
        \multiple_wait_state<5> ), .I0(\multiple_wait_state<0> ) );
    INV U3907 ( .O(n11365), .I(\multiple_wait_state<4> ) );
    AND3 U3908 ( .O(n10754), .I2(\multiple_wait_state<3> ), .I1(n11365), .I0(
        \multiple_wait_state<1> ) );
    NOR2 U3909 ( .O(n10777), .I1(\multiple_wait_state<2> ), .I0(
        \multiple_wait_state<1> ) );
    INV U3910 ( .O(n11366), .I(\multiple_wait_state<2> ) );
    NOR4 U3911 ( .O(n10758), .I3(n11366), .I2(\multiple_wait_state<4> ), .I1(
        \multiple_wait_state<1> ), .I0(\multiple_wait_state<3> ) );
    NOR3 U3912 ( .O(n10748), .I2(\multiple_wait_state<5> ), .I1(
        \multiple_wait_state<0> ), .I0(\multiple_wait_state<6> ) );
    OR2 U3913 ( .O(n11367), .I1(\multiple_wait_state<2> ), .I0(
        \multiple_wait_state<0> ) );
    AND2 U3914 ( .O(n11369), .I1(n11368), .I0(n11367) );
    NOR2 U3915 ( .O(n11370), .I1(\multiple_wait_state<0> ), .I0(n11368) );
    INV U3916 ( .O(n11368), .I(\multiple_wait_state<6> ) );
    NOR3 U3917 ( .O(n10785), .I2(n11369), .I1(n11370), .I0(
        \multiple_wait_state<5> ) );
    XOR2 U3918 ( .O(n11371), .I1(\multiple_wait_state<2> ), .I0(
        \multiple_wait_state<5> ) );
    AND3 U3919 ( .O(n10937), .I2(\multiple_wait_state<3> ), .I1(n11371), .I0(
        n10936) );
    INV U3920 ( .O(n11374), .I(n11373) );
    INV U3921 ( .O(n11372), .I(\multiple_wait_state<6> ) );
    NAND3 U3922 ( .O(n11373), .I2(\multiple_wait_state<5> ), .I1(n11372), .I0(
        n10739) );
    OR2 U3923 ( .O(\*cell*964/U2/CONTROL1 ), .I1(n10846), .I0(n11374) );
    INV U3924 ( .O(n11375), .I(n10855) );
    INV U3925 ( .O(n11376), .I(n10826) );
    OR4 U3926 ( .O(\*cell*964/U85/CONTROL1 ), .I3(n10865), .I2(n10935), .I1(
        n11375), .I0(n11376) );
    AND2 U3927 ( .O(n11377), .I1(n10722), .I0(ir_bus[6]) );
    OR3 U3928 ( .O(n11379), .I2(n10931), .I1(n11377), .I0(n10934) );
    FDCE \a_addr_reg<0>  ( .Q(a_addr[0]), .D(n11379), .C(clk), .CE(\n3414<0> ), 
        .CLR(1'b0) );
    AND2 U3930 ( .O(n11380), .I1(n10722), .I0(ir_bus[7]) );
    OR3 U3931 ( .O(n11384), .I2(n10931), .I1(n11380), .I0(n10933) );
    AND2 U3932 ( .O(n11381), .I1(n10722), .I0(ir_bus[8]) );
    OR3 U3933 ( .O(n11383), .I2(n10931), .I1(n11381), .I0(n10932) );
    FDCE \a_addr_reg<2>  ( .Q(a_addr[2]), .D(n11383), .C(clk), .CE(\n3414<0> ), 
        .CLR(1'b0) );
    FDCE \a_addr_reg<1>  ( .Q(a_addr[1]), .D(n11384), .C(clk), .CE(\n3414<0> ), 
        .CLR(1'b0) );
    AND2 U3935 ( .O(n11385), .I1(n10722), .I0(ir_bus[9]) );
    OR3 U3936 ( .O(\a_addr3413<3> ), .I2(n10930), .I1(n11385), .I0(n10931) );
    INV U3937 ( .O(n11386), .I(ir_bus[12]) );
    NOR2 U3938 ( .O(n11387), .I1(n10923), .I0(n11386) );
    OR3 U3939 ( .O(n11389), .I2(n10926), .I1(n11387), .I0(n10927) );
    FDCE \alu_control_reg<1>  ( .Q(alu_control[1]), .D(n11389), .C(clk), .CE(
        \n3404<0> ), .CLR(1'b0) );
    INV U3941 ( .O(n11391), .I(n11390) );
    NAND3 U3942 ( .O(n11390), .I2(\multiple_wait_state<4> ), .I1(n10718), .I0(
        ir_bus[15]) );
    NOR2 U3943 ( .O(n10923), .I1(n11391), .I0(n10720) );
    INV U3944 ( .O(n11393), .I(n10836) );
    INV U3945 ( .O(n11392), .I(\multiple_wait_state<2> ) );
    OR2 U3946 ( .O(n11395), .I1(n11392), .I0(\multiple_wait_state<1> ) );
    OR2 U3947 ( .O(n11394), .I1(n10920), .I0(n11393) );
    AND2 U3948 ( .O(n10921), .I1(n11394), .I0(n11395) );
    INV U3949 ( .O(n11397), .I(n11396) );
    NAND3 U3950 ( .O(n11396), .I2(\multiple_wait_state<0> ), .I1(n10818), .I0(
        \multiple_wait_state<5> ) );
    OR2 U3951 ( .O(n10917), .I1(n10916), .I0(n11397) );
    NAND2 U3952 ( .O(n11401), .I1(n11398), .I0(\multiple_wait_state<2> ) );
    OR2 U3953 ( .O(n11400), .I1(\multiple_wait_state<1> ), .I0(
        \multiple_wait_state<2> ) );
    NAND2 U3954 ( .O(n11399), .I1(\multiple_wait_state<4> ), .I0(
        \multiple_wait_state<3> ) );
    OR3 U3955 ( .O(n11398), .I2(\multiple_wait_state<3> ), .I1(
        \multiple_wait_state<1> ), .I0(\multiple_wait_state<4> ) );
    NAND3 U3956 ( .O(n10911), .I2(n11399), .I1(n11400), .I0(n11401) );
    OR4 U3957 ( .O(n11403), .I3(n10907), .I2(n10906), .I1(n10905), .I0(n10904)
         );
    NOR4 U3958 ( .O(n10896), .I3(n10895), .I2(n10894), .I1(n10842), .I0(n10893
        ) );
    FDC \multiple_wait_state_reg<3>  ( .Q(\multiple_wait_state<3> ), .D(n11403
        ), .C(clk), .CLR(1'b0) );
    AND2 U3960 ( .O(n11404), .I1(n10736), .I0(n10726) );
    NOR3 U3961 ( .O(n10887), .I2(n10886), .I1(n10885), .I0(n11404) );
    INV U3962 ( .O(n11405), .I(n10873) );
    NOR4 U3963 ( .O(n10876), .I3(n11405), .I2(n10875), .I1(n10874), .I0(n10734
        ) );
    NAND2 U3964 ( .O(n11407), .I1(n10851), .I0(ir_bus[0]) );
    NAND2 U3965 ( .O(n11406), .I1(n10721), .I0(n10818) );
    AND2 U3966 ( .O(n10873), .I1(n11406), .I0(n11407) );
    OR2 U3967 ( .O(n11408), .I1(n10868), .I0(n10758) );
    AND2 U3968 ( .O(n11409), .I1(n11408), .I0(n10738) );
    NOR2 U3969 ( .O(n10870), .I1(n11409), .I0(n10869) );
    INV U3970 ( .O(n11410), .I(n10845) );
    OR4 U3971 ( .O(n3314), .I3(n10863), .I2(n10862), .I1(n11410), .I0(n10861)
         );
    AND2 U3972 ( .O(n11411), .I1(n10726), .I0(ir_bus[12]) );
    OR3 U3973 ( .O(n3323), .I2(n10756), .I1(n11411), .I0(n3377) );
    INV U3974 ( .O(n11412), .I(n10852) );
    OR4 U3975 ( .O(n3332), .I3(n10860), .I2(n10859), .I1(n11412), .I0(n10858)
         );
    NAND2 U3976 ( .O(n11413), .I1(\multiple_wait_state<6> ), .I0(
        \multiple_wait_state<3> ) );
    NAND3 U3977 ( .O(n10857), .I2(\multiple_wait_state<2> ), .I1(n11413), .I0(
        n10755) );
    INV U3978 ( .O(n11414), .I(n10855) );
    INV U3979 ( .O(n11415), .I(n10848) );
    OR4 U3980 ( .O(n3341), .I3(n10856), .I2(n10833), .I1(n11414), .I0(n11415)
         );
    AND2 U3981 ( .O(n11416), .I1(n10853), .I0(n10754) );
    NOR3 U3982 ( .O(n10855), .I2(n10854), .I1(n10734), .I0(n11416) );
    INV U3983 ( .O(n11417), .I(n10754) );
    OR2 U3984 ( .O(n11418), .I1(n10837), .I0(n11417) );
    NAND3 U3985 ( .O(n3350), .I2(n10841), .I1(n11418), .I0(n10852) );
    INV U3986 ( .O(n11419), .I(n10754) );
    NOR2 U3987 ( .O(n11420), .I1(n10753), .I0(n11419) );
    OR3 U3988 ( .O(n3359), .I2(\*cell*964/U67/CONTROL2 ), .I1(n11420), .I0(
        n10846) );
    OR2 U3989 ( .O(n11422), .I1(\multiple_wait_state<0> ), .I0(
        \multiple_wait_state<4> ) );
    NAND2 U3990 ( .O(n11421), .I1(\multiple_wait_state<4> ), .I0(
        \multiple_wait_state<3> ) );
    AND3 U3991 ( .O(n10847), .I2(\multiple_wait_state<1> ), .I1(n11421), .I0(
        n11422) );
    NAND3 U3992 ( .O(n11423), .I2(n10769), .I1(n10771), .I0(n10743) );
    AND2 U3993 ( .O(n10835), .I1(n11423), .I0(n10791) );
    OR4 U3994 ( .O(n3451), .I3(n10824), .I2(n10823), .I1(n10822), .I0(n10821)
         );
    NOR2 U3995 ( .O(n11425), .I1(n11424), .I0(\multiple_wait_state<6> ) );
    NOR2 U3996 ( .O(n11424), .I1(n10818), .I0(n10764) );
    OR2 U3997 ( .O(n10820), .I1(n10819), .I0(n11425) );
    INV U3998 ( .O(n11426), .I(\multiple_wait_state<4> ) );
    NAND2 U3999 ( .O(n11427), .I1(n11426), .I0(n10718) );
    AND2 U4000 ( .O(n11428), .I1(n11427), .I0(\multiple_wait_state<1> ) );
    NOR2 U4001 ( .O(n10817), .I1(n11428), .I0(n10815) );
    INV U4002 ( .O(n11429), .I(\multiple_wait_state<2> ) );
    NAND3 U4003 ( .O(n11430), .I2(n10731), .I1(n11429), .I0(n10721) );
    NAND2 U4004 ( .O(n10816), .I1(n11430), .I0(n10763) );
    NAND3 U4005 ( .O(n11431), .I2(\multiple_wait_state<2> ), .I1(n10805), .I0(
        n10786) );
    AND2 U4006 ( .O(n10815), .I1(n11431), .I0(n10807) );
    AND2 U4007 ( .O(n11432), .I1(n10811), .I0(n10732) );
    NOR3 U4008 ( .O(n10814), .I2(n10813), .I1(n10812), .I0(n11432) );
    INV U4009 ( .O(n11435), .I(n11434) );
    INV U4010 ( .O(n11433), .I(n10802) );
    NAND3 U4011 ( .O(n11434), .I2(ir_bus[12]), .I1(n11433), .I0(ir_bus[13]) );
    NOR2 U4012 ( .O(n10804), .I1(n11435), .I0(n10803) );
    INV U4013 ( .O(n11436), .I(ir_bus[11]) );
    NAND2 U4014 ( .O(n11437), .I1(n11436), .I0(iflag) );
    AND2 U4015 ( .O(n11438), .I1(n11437), .I0(ir_bus[14]) );
    NOR2 U4016 ( .O(n10802), .I1(n11438), .I0(ir_bus[15]) );
    INV U4017 ( .O(n11439), .I(n10723) );
    NOR4 U4018 ( .O(n10801), .I3(n11439), .I2(n10724), .I1(n10752), .I0(n10751
        ) );
    INV U4019 ( .O(n11440), .I(n10795) );
    OR4 U4020 ( .O(\n3479<0> ), .I3(n10797), .I2(n10796), .I1(n11440), .I0(
        n10794) );
    NAND2 U4021 ( .O(n11441), .I1(n10792), .I0(n10743) );
    AND2 U4022 ( .O(n11442), .I1(n11441), .I0(n10791) );
    NOR2 U4023 ( .O(n10794), .I1(n11442), .I0(n10793) );
    INV U4024 ( .O(n11444), .I(n11443) );
    NAND3 U4025 ( .O(n11443), .I2(n10742), .I1(n10721), .I0(n10736) );
    NOR2 U4026 ( .O(n10791), .I1(n11444), .I0(n10790) );
    INV U4027 ( .O(n11447), .I(n11446) );
    INV U4028 ( .O(n11445), .I(\multiple_wait_state<3> ) );
    NAND3 U4029 ( .O(n11446), .I2(n10785), .I1(n11445), .I0(n10786) );
    OR2 U4030 ( .O(n10788), .I1(n10787), .I0(n11447) );
    NAND3 U4031 ( .O(n11448), .I2(\multiple_wait_state<0> ), .I1(n10783), .I0(
        \multiple_wait_state<4> ) );
    AND2 U4032 ( .O(n10784), .I1(n11448), .I0(n10782) );
    INV U4033 ( .O(n11449), .I(ir_bus[6]) );
    OR2 U4034 ( .O(n11451), .I1(n10768), .I0(n11449) );
    INV U4035 ( .O(n11450), .I(n10781) );
    NAND3 U4036 ( .O(n11457), .I2(n11450), .I1(n11451), .I0(n10776) );
    INV U4037 ( .O(n11452), .I(ir_bus[8]) );
    OR2 U4038 ( .O(n11454), .I1(n10768), .I0(n11452) );
    INV U4039 ( .O(n11453), .I(n10781) );
    NAND3 U4040 ( .O(n11456), .I2(n11453), .I1(n11454), .I0(n10780) );
    FDCE \wr_addr_reg<2>  ( .Q(wr_addr[2]), .D(n11456), .C(clk), .CE(
        \n3442<0> ), .CLR(1'b0) );
    FDCE \wr_addr_reg<0>  ( .Q(wr_addr[0]), .D(n11457), .C(clk), .CE(
        \n3442<0> ), .CLR(1'b0) );
    INV U4042 ( .O(n11458), .I(ir_bus[9]) );
    OR2 U4043 ( .O(n11460), .I1(n10768), .I0(n11458) );
    INV U4044 ( .O(n11459), .I(n10781) );
    NAND3 U4045 ( .O(n11464), .I2(n11459), .I1(n11460), .I0(n10780) );
    INV U4046 ( .O(n11461), .I(\multiple_wait_state<4> ) );
    NAND3 U4047 ( .O(n11462), .I2(n10777), .I1(n11461), .I0(n10738) );
    NAND2 U4048 ( .O(n10778), .I1(n11462), .I0(n10776) );
    FDCE \wr_addr_reg<3>  ( .Q(wr_addr[3]), .D(n11464), .C(clk), .CE(
        \n3442<0> ), .CLR(1'b0) );
    INV U4050 ( .O(n11465), .I(n10772) );
    NOR4 U4051 ( .O(n10776), .I3(n11465), .I2(n10775), .I1(n10774), .I0(n10773
        ) );
    INV U4052 ( .O(n11466), .I(n10764) );
    OR2 U4053 ( .O(n11468), .I1(n11466), .I0(\multiple_wait_state<0> ) );
    NAND2 U4054 ( .O(n11467), .I1(n10717), .I0(\multiple_wait_state<4> ) );
    AND2 U4055 ( .O(n10765), .I1(n11467), .I0(n11468) );
    OR2 U4056 ( .O(n11469), .I1(\multiple_wait_state<0> ), .I0(reset) );
    AND3 U4057 ( .O(n3386), .I2(n10741), .I1(n11469), .I0(n10742) );
    AND4 U4058 ( .O(n10740), .I3(n10739), .I2(n10738), .I1(sum8970), .I0(iflag
        ) );
    AND4 U4059 ( .O(n10737), .I3(n10736), .I2(n10735), .I1(ir_bus[13]), .I0(
        iflag) );
    AND3 U4060 ( .O(n10729), .I2(ir_bus[12]), .I1(n10726), .I0(ir_bus[11]) );
    NOR2 U4061 ( .O(n11082), .I1(n10920), .I0(n10836) );
    XOR2 U4062 ( .O(n11470), .I1(\multiple_wait_state<0> ), .I0(
        \multiple_wait_state<1> ) );
    OR3 U4063 ( .O(n10920), .I2(n11470), .I1(\multiple_wait_state<4> ), .I0(
        \multiple_wait_state<3> ) );
    INV U4064 ( .O(n11471), .I(\multiple_wait_state<0> ) );
    AND3 U4065 ( .O(n10890), .I2(n10741), .I1(n11471), .I0(n10764) );
    AND2 U4066 ( .O(n10764), .I1(n10783), .I0(n10914) );
    INV U4067 ( .O(n11472), .I(\multiple_wait_state<0> ) );
    AND3 U4068 ( .O(n11057), .I2(n10741), .I1(n11472), .I0(n10818) );
    AND2 U4069 ( .O(n10818), .I1(n10777), .I0(n10731) );
    AND3 U4070 ( .O(n10878), .I2(n10731), .I1(n10805), .I0(n10777) );
    AND2 U4071 ( .O(n10731), .I1(\multiple_wait_state<4> ), .I0(
        \multiple_wait_state<3> ) );
    AND3 U4072 ( .O(n10877), .I2(n10805), .I1(n10783), .I0(n10914) );
    INV U4073 ( .O(n11473), .I(\multiple_wait_state<2> ) );
    NOR2 U4074 ( .O(n10783), .I1(\multiple_wait_state<3> ), .I0(n11473) );
    INV U4075 ( .O(n11474), .I(\multiple_wait_state<0> ) );
    AND3 U4076 ( .O(n10861), .I2(n10741), .I1(n11474), .I0(n10928) );
    INV U4077 ( .O(n11475), .I(\multiple_wait_state<4> ) );
    INV U4078 ( .O(n11476), .I(\multiple_wait_state<1> ) );
    NOR4 U4079 ( .O(n10928), .I3(\multiple_wait_state<3> ), .I2(
        \multiple_wait_state<2> ), .I1(n11475), .I0(n11476) );
    INV U4080 ( .O(n11477), .I(\multiple_wait_state<2> ) );
    AND3 U4081 ( .O(n10846), .I2(n10745), .I1(n11477), .I0(n11037) );
    INV U4082 ( .O(n11478), .I(reset) );
    NOR4 U4083 ( .O(n11037), .I3(n11478), .I2(\multiple_wait_state<6> ), .I1(
        \multiple_wait_state<5> ), .I0(\multiple_wait_state<0> ) );
    AND3 U4084 ( .O(n11033), .I2(\multiple_wait_state<3> ), .I1(n10721), .I0(
        n10786) );
    INV U4085 ( .O(n11479), .I(\multiple_wait_state<1> ) );
    NOR2 U4086 ( .O(n10786), .I1(\multiple_wait_state<4> ), .I0(n11479) );
    INV U4087 ( .O(n11480), .I(\multiple_wait_state<0> ) );
    AND3 U4088 ( .O(n10819), .I2(n10964), .I1(n11480), .I0(n11020) );
    AND2 U4089 ( .O(n11020), .I1(n10786), .I0(n10913) );
    INV U4090 ( .O(n11481), .I(ir_bus[9]) );
    AND3 U4091 ( .O(n11002), .I2(ir_bus[8]), .I1(n11481), .I0(n10999) );
    INV U4092 ( .O(n11482), .I(ir_bus[7]) );
    OR2 U4093 ( .O(n11484), .I1(alu_flags2[1]), .I0(ir_bus[7]) );
    OR2 U4094 ( .O(n11483), .I1(n11482), .I0(alu_flags2[2]) );
    NAND2 U4095 ( .O(n10999), .I1(n11483), .I0(n11484) );
    AND3 U4096 ( .O(n10851), .I2(\multiple_wait_state<2> ), .I1(n10771), .I0(
        n10805) );
    INV U4097 ( .O(n11485), .I(\multiple_wait_state<3> ) );
    AND3 U4098 ( .O(n10771), .I2(\multiple_wait_state<1> ), .I1(n11485), .I0(
        \multiple_wait_state<4> ) );
    AND3 U4099 ( .O(n10787), .I2(\multiple_wait_state<1> ), .I1(n10721), .I0(
        \*cell*964/U98/CONTROL2 ) );
    INV U4100 ( .O(n11486), .I(\multiple_wait_state<3> ) );
    NOR3 U4101 ( .O(\*cell*964/U98/CONTROL2 ), .I2(\multiple_wait_state<2> ), 
        .I1(\multiple_wait_state<4> ), .I0(n11486) );
    FDCE io_dir_reg ( .Q(io_dir), .D(\*cell*964/U98/CONTROL2 ), .C(clk), .CE(
        n3359), .CLR(1'b0) );
    INV U4103 ( .O(n11488), .I(\multiple_wait_state<2> ) );
    AND3 U4104 ( .O(n10767), .I2(n10721), .I1(n11488), .I0(n10771) );
    INV U4105 ( .O(n11489), .I(\multiple_wait_state<6> ) );
    AND3 U4106 ( .O(n10721), .I2(\multiple_wait_state<0> ), .I1(n11489), .I0(
        \multiple_wait_state<5> ) );
    INV U4107 ( .O(n11490), .I(\multiple_wait_state<0> ) );
    AND3 U4108 ( .O(n10775), .I2(n10964), .I1(n11490), .I0(n10722) );
    INV U4109 ( .O(n11491), .I(\multiple_wait_state<1> ) );
    INV U4110 ( .O(n11492), .I(\multiple_wait_state<3> ) );
    NOR4 U4111 ( .O(n10722), .I3(\multiple_wait_state<4> ), .I2(
        \multiple_wait_state<2> ), .I1(n11491), .I0(n11492) );
    INV U4112 ( .O(n11493), .I(\multiple_wait_state<0> ) );
    AND3 U4113 ( .O(n10893), .I2(n10760), .I1(n11493), .I0(n10741) );
    INV U4114 ( .O(n11494), .I(\multiple_wait_state<1> ) );
    AND4 U4115 ( .O(n10760), .I3(n11494), .I2(\multiple_wait_state<2> ), .I1(
        \multiple_wait_state<4> ), .I0(\multiple_wait_state<3> ) );
    AND3 U4116 ( .O(n10874), .I2(n10913), .I1(n10721), .I0(n10914) );
    NOR2 U4117 ( .O(n10913), .I1(\multiple_wait_state<2> ), .I0(
        \multiple_wait_state<3> ) );
    INV U4118 ( .O(n11495), .I(\multiple_wait_state<2> ) );
    AND3 U4119 ( .O(n10961), .I2(n10811), .I1(n11495), .I0(n10721) );
    AND3 U4120 ( .O(n10811), .I2(\multiple_wait_state<3> ), .I1(
        \multiple_wait_state<4> ), .I0(\multiple_wait_state<1> ) );
    INV U4121 ( .O(n11496), .I(\multiple_wait_state<0> ) );
    AND3 U4122 ( .O(n10977), .I2(n10964), .I1(n11496), .I0(n10868) );
    INV U4123 ( .O(n11497), .I(\multiple_wait_state<6> ) );
    NOR2 U4124 ( .O(n10964), .I1(\multiple_wait_state<5> ), .I0(n11497) );
    INV U4125 ( .O(n11499), .I(n11498) );
    NAND2 U4126 ( .O(n11498), .I1(n10741), .I0(\multiple_wait_state<0> ) );
    NOR2 U4127 ( .O(n10761), .I1(n11499), .I0(n10805) );
    INV U4128 ( .O(n11500), .I(\multiple_wait_state<5> ) );
    NOR3 U4129 ( .O(n10805), .I2(\multiple_wait_state<6> ), .I1(
        \multiple_wait_state<0> ), .I0(n11500) );
    INV U4130 ( .O(n11502), .I(n11501) );
    NAND2 U4131 ( .O(n11501), .I1(n10805), .I0(n10749) );
    NOR2 U4132 ( .O(n10795), .I1(n11502), .I0(n10734) );
    INV U4133 ( .O(n11503), .I(\multiple_wait_state<3> ) );
    AND4 U4134 ( .O(n10749), .I3(n11503), .I2(\multiple_wait_state<2> ), .I1(
        \multiple_wait_state<4> ), .I0(\multiple_wait_state<1> ) );
    AND3 U4135 ( .O(n10792), .I2(\multiple_wait_state<0> ), .I1(n10749), .I0(
        n10741) );
    NOR2 U4136 ( .O(n10741), .I1(\multiple_wait_state<6> ), .I0(
        \multiple_wait_state<5> ) );
    INV U4137 ( .O(n11505), .I(n11504) );
    NAND2 U4138 ( .O(n11504), .I1(n10928), .I0(\*cell*964/U1/CONTROL2 ) );
    NOR2 U4139 ( .O(n10929), .I1(n11505), .I0(n10916) );
    INV U4140 ( .O(n11506), .I(\multiple_wait_state<5> ) );
    NOR2 U4141 ( .O(\*cell*964/U1/CONTROL2 ), .I1(\multiple_wait_state<0> ), 
        .I0(n11506) );
    FDCE ext_wr_reg ( .Q(ext_wr), .D(\*cell*964/U1/CONTROL2 ), .C(clk), .CE(
        \*cell*964/U2/CONTROL1 ), .CLR(1'b0) );
    NAND2 U4143 ( .O(n11508), .I1(n10844), .I0(\multiple_wait_state<0> ) );
    AND2 U4144 ( .O(n10925), .I1(n11508), .I0(n10782) );
    AND2 U4145 ( .O(n10844), .I1(\multiple_wait_state<2> ), .I0(
        \multiple_wait_state<4> ) );
    INV U4146 ( .O(n11511), .I(n11510) );
    INV U4147 ( .O(n11509), .I(n10919) );
    NAND2 U4148 ( .O(n11510), .I1(n11509), .I0(ir_bus[1]) );
    OR2 U4149 ( .O(n11517), .I1(n11516), .I0(n11511) );
    INV U4150 ( .O(n11512), .I(imm_bus[11]) );
    OR2 U4151 ( .O(n11514), .I1(n10921), .I0(n11512) );
    NAND2 U4152 ( .O(n11513), .I1(n11082), .I0(ir_bus[6]) );
    NAND2 U4153 ( .O(n11516), .I1(n11513), .I0(n11514) );
    FDCE \b_addr_reg<0>  ( .Q(b_addr[0]), .D(n11517), .C(clk), .CE(\n3479<0> ), 
        .CLR(1'b0) );
    INV U4155 ( .O(n11520), .I(n11519) );
    INV U4156 ( .O(n11518), .I(n10919) );
    NAND2 U4157 ( .O(n11519), .I1(n11518), .I0(ir_bus[3]) );
    OR2 U4158 ( .O(n11526), .I1(n11525), .I0(n11520) );
    INV U4159 ( .O(n11521), .I(imm_bus[13]) );
    OR2 U4160 ( .O(n11523), .I1(n10921), .I0(n11521) );
    NAND2 U4161 ( .O(n11522), .I1(n11082), .I0(ir_bus[8]) );
    NAND2 U4162 ( .O(n11525), .I1(n11522), .I0(n11523) );
    FDCE \b_addr_reg<2>  ( .Q(b_addr[2]), .D(n11526), .C(clk), .CE(\n3479<0> ), 
        .CLR(1'b0) );
    NOR3 U4164 ( .O(n10900), .I2(n10898), .I1(n10897), .I0(n10899) );
    AND3 U4165 ( .O(n10897), .I2(\multiple_wait_state<2> ), .I1(n10993), .I0(
        n10721) );
    NOR3 U4166 ( .O(n10891), .I2(n10889), .I1(n10888), .I0(n10890) );
    AND3 U4167 ( .O(n10888), .I2(\multiple_wait_state<0> ), .I1(n10764), .I0(
        n10741) );
    NOR3 U4168 ( .O(n10884), .I2(n10882), .I1(n10881), .I0(n10883) );
    INV U4169 ( .O(n11527), .I(\multiple_wait_state<1> ) );
    AND3 U4170 ( .O(n10881), .I2(\*cell*964/U98/CONTROL2 ), .I1(n11527), .I0(
        n10721) );
    NOR3 U4171 ( .O(n10879), .I2(n10877), .I1(n10856), .I0(n10878) );
    AND3 U4172 ( .O(n10856), .I2(n10913), .I1(n10914), .I0(n10805) );
    INV U4173 ( .O(n11529), .I(n11528) );
    NAND2 U4174 ( .O(n11528), .I1(n10796), .I0(ir_bus[0]) );
    NOR2 U4175 ( .O(n10872), .I1(n11529), .I0(n10812) );
    AND3 U4176 ( .O(n10796), .I2(\multiple_wait_state<3> ), .I1(n10732), .I0(
        n10786) );
    INV U4177 ( .O(n11531), .I(n11530) );
    NAND2 U4178 ( .O(n11530), .I1(n10797), .I0(ir_bus[0]) );
    NOR2 U4179 ( .O(n10864), .I1(n11531), .I0(n10813) );
    INV U4180 ( .O(n11532), .I(\multiple_wait_state<2> ) );
    AND3 U4181 ( .O(n10797), .I2(n10745), .I1(n11532), .I0(n10853) );
    INV U4182 ( .O(n11534), .I(n11533) );
    NAND2 U4183 ( .O(n11533), .I1(n10808), .I0(n10769) );
    NOR2 U4184 ( .O(n10849), .I1(n11534), .I0(n10774) );
    AND3 U4185 ( .O(n10774), .I2(\multiple_wait_state<0> ), .I1(n10830), .I0(
        n10964) );
    INV U4186 ( .O(n11535), .I(n10845) );
    OR3 U4187 ( .O(n3377), .I2(n10774), .I1(n11535), .I0(n10846) );
    OR3 U4188 ( .O(n11536), .I2(n10844), .I1(n10731), .I0(
        \multiple_wait_state<5> ) );
    NAND2 U4189 ( .O(n10845), .I1(n11536), .I0(\multiple_wait_state<6> ) );
    INV U4190 ( .O(n11539), .I(n11538) );
    INV U4191 ( .O(n11537), .I(n10837) );
    NAND2 U4192 ( .O(n11538), .I1(n10722), .I0(n11537) );
    NOR2 U4193 ( .O(n10839), .I1(n11539), .I0(n10838) );
    INV U4194 ( .O(n11542), .I(n11541) );
    INV U4195 ( .O(n11540), .I(\multiple_wait_state<0> ) );
    NAND2 U4196 ( .O(n11541), .I1(n10964), .I0(n11540) );
    NOR2 U4197 ( .O(n10837), .I1(n11542), .I0(n10721) );
    NOR3 U4198 ( .O(n10836), .I2(imm_bus[0]), .I1(imm_bus[1]), .I0(n11543) );
    OR4 U4199 ( .O(n11543), .I3(imm_bus[2]), .I2(imm_bus[3]), .I1(imm_bus[4]), 
        .I0(imm_bus[5]) );
    INV U4200 ( .O(n11544), .I(ir_bus[7]) );
    OR2 U4201 ( .O(n11545), .I1(n10768), .I0(n11544) );
    NAND2 U4202 ( .O(n11547), .I1(n11545), .I0(n10780) );
    NOR4 U4203 ( .O(n10768), .I3(n10767), .I2(n10766), .I1(n10759), .I0(n10734
        ) );
    FDCE \wr_addr_reg<1>  ( .Q(wr_addr[1]), .D(n11547), .C(clk), .CE(
        \n3442<0> ), .CLR(1'b0) );
    INV U4205 ( .O(n11549), .I(n11548) );
    NAND2 U4206 ( .O(n11548), .I1(n10771), .I0(n10769) );
    NOR2 U4207 ( .O(n10772), .I1(n11549), .I0(n10770) );
    INV U4208 ( .O(n11550), .I(\multiple_wait_state<0> ) );
    NOR3 U4209 ( .O(n10769), .I2(\multiple_wait_state<6> ), .I1(
        \multiple_wait_state<5> ), .I0(n11550) );
    INV U4210 ( .O(n11551), .I(\multiple_wait_state<0> ) );
    AND3 U4211 ( .O(n10759), .I2(n10757), .I1(n11551), .I0(n10758) );
    XOR2 U4212 ( .O(n10757), .I1(\multiple_wait_state<5> ), .I0(
        \multiple_wait_state<6> ) );
    INV U4213 ( .O(n11553), .I(n11552) );
    OR2 U4214 ( .O(n11552), .I1(n10754), .I0(n10755) );
    NOR2 U4215 ( .O(n10756), .I1(n11553), .I0(n10753) );
    NAND2 U4216 ( .O(n11554), .I1(n10808), .I0(n10805) );
    AND2 U4217 ( .O(n10753), .I1(n11554), .I0(n10807) );
    INV U4218 ( .O(n11555), .I(ir_bus[13]) );
    AND3 U4219 ( .O(n3488), .I2(n10735), .I1(n11555), .I0(n10743) );
    INV U4220 ( .O(n11556), .I(ir_bus[15]) );
    AND4 U4221 ( .O(n10735), .I3(n11556), .I2(n10749), .I1(n10748), .I0(ir_bus
        [14]) );
    INV U4222 ( .O(n11557), .I(ir_bus[12]) );
    AND3 U4223 ( .O(n10727), .I2(ir_bus[11]), .I1(n11557), .I0(n10726) );
    INV U4224 ( .O(n11559), .I(n11558) );
    NAND2 U4225 ( .O(n11558), .I1(ir_bus[15]), .I0(ir_bus[13]) );
    NOR2 U4226 ( .O(n10726), .I1(n11559), .I0(n10746) );
    INV U4227 ( .O(n11561), .I(n11560) );
    NAND2 U4228 ( .O(n11560), .I1(n10722), .I0(n10721) );
    OR2 U4229 ( .O(\*cell*964/U67/CONTROL2 ), .I1(\*cell*964/U3/CONTROL2 ), 
        .I0(n11561) );
    INV U4230 ( .O(n11562), .I(n10758) );
    OR2 U4231 ( .O(n11563), .I1(n10761), .I0(n11562) );
    NAND2 U4232 ( .O(\*cell*964/U3/CONTROL2 ), .I1(n11563), .I0(n10849) );
    FDCE io_en_reg ( .Q(io_en), .D(\*cell*964/U67/CONTROL2 ), .C(clk), .CE(
        n3332), .CLR(1'b0) );
    INV U4234 ( .O(n11565), .I(n10719) );
    AND3 U4235 ( .O(n10720), .I2(\multiple_wait_state<4> ), .I1(n11565), .I0(
        n10718) );
    NOR2 U4236 ( .O(n10718), .I1(\multiple_wait_state<3> ), .I0(
        \multiple_wait_state<0> ) );
    OR3 U4237 ( .O(n11573), .I2(n11572), .I1(n10927), .I0(n10926) );
    INV U4238 ( .O(n11566), .I(ir_bus[11]) );
    NOR2 U4239 ( .O(n11567), .I1(n11566), .I0(ir_bus[13]) );
    AND2 U4240 ( .O(n11568), .I1(n11566), .I0(ir_bus[12]) );
    NOR3 U4241 ( .O(n11572), .I2(n11567), .I1(n11568), .I0(n10923) );
    NAND2 U4242 ( .O(n11570), .I1(n10868), .I0(\multiple_wait_state<0> ) );
    NAND2 U4243 ( .O(n11569), .I1(n11029), .I0(n10913) );
    NAND2 U4244 ( .O(n10927), .I1(n11569), .I0(n11570) );
    FDCE \alu_control_reg<2>  ( .Q(alu_control[2]), .D(n11573), .C(clk), .CE(
        \n3404<0> ), .CLR(1'b0) );
    INV U4246 ( .O(n11575), .I(n11574) );
    OR2 U4247 ( .O(n11574), .I1(\multiple_wait_state<5> ), .I0(n11583) );
    NOR2 U4248 ( .O(n10916), .I1(n11575), .I0(n11582) );
    INV U4249 ( .O(n11576), .I(n10762) );
    OR2 U4250 ( .O(n11578), .I1(\multiple_wait_state<0> ), .I0(n11576) );
    NAND2 U4251 ( .O(n11577), .I1(n11029), .I0(n10783) );
    NAND2 U4252 ( .O(n11583), .I1(n11577), .I0(n11578) );
    INV U4253 ( .O(n11579), .I(n10717) );
    OR2 U4254 ( .O(n11581), .I1(n11579), .I0(\multiple_wait_state<4> ) );
    INV U4255 ( .O(n11580), .I(n11083) );
    AND3 U4256 ( .O(n11582), .I2(\multiple_wait_state<5> ), .I1(n11580), .I0(
        n11581) );
    INV U4257 ( .O(n11586), .I(n11585) );
    INV U4258 ( .O(n11584), .I(\multiple_wait_state<5> ) );
    NAND2 U4259 ( .O(n11585), .I1(n10868), .I0(n11584) );
    NOR2 U4260 ( .O(n11038), .I1(n11586), .I0(n11591) );
    INV U4261 ( .O(n11587), .I(n11588) );
    OR2 U4262 ( .O(n11589), .I1(n11587), .I0(\multiple_wait_state<6> ) );
    OR2 U4263 ( .O(n11588), .I1(n10760), .I0(n10722) );
    NAND2 U4264 ( .O(n11591), .I1(n11589), .I0(\multiple_wait_state<0> ) );
    INV U4265 ( .O(n11590), .I(\multiple_wait_state<3> ) );
    NOR4 U4266 ( .O(n10868), .I3(n11590), .I2(\multiple_wait_state<2> ), .I1(
        \multiple_wait_state<4> ), .I0(\multiple_wait_state<1> ) );
    INV U4267 ( .O(n11592), .I(\condition<0> ) );
    NOR3 U4268 ( .O(n11010), .I2(n11595), .I1(n11594), .I0(n11592) );
    INV U4269 ( .O(n11593), .I(n10750) );
    OR4 U4270 ( .O(n11595), .I3(n11593), .I2(\condition<1> ), .I1(
        \condition<2> ), .I0(\condition<3> ) );
    OR4 U4271 ( .O(n11594), .I3(\condition<4> ), .I2(\condition<5> ), .I1(
        \condition<6> ), .I0(\condition<7> ) );
    INV U4272 ( .O(n11597), .I(n11596) );
    OR2 U4273 ( .O(n11596), .I1(n11606), .I0(ir_bus[6]) );
    OR2 U4274 ( .O(\condition1973<0> ), .I1(n11605), .I0(n11597) );
    INV U4275 ( .O(n11600), .I(n11599) );
    INV U4276 ( .O(n11598), .I(ir_bus[10]) );
    OR3 U4277 ( .O(n11599), .I2(n11598), .I1(n10799), .I0(alu_flags2[2]) );
    NOR2 U4278 ( .O(n11606), .I1(n11600), .I0(n10800) );
    INV U4279 ( .O(n11601), .I(ir_bus[8]) );
    NAND2 U4280 ( .O(n11603), .I1(n11602), .I0(n11004) );
    OR2 U4281 ( .O(n11602), .I1(n11006), .I0(n11601) );
    AND2 U4282 ( .O(n11605), .I1(n11603), .I0(ir_bus[6]) );
    FDCE \condition_reg<0>  ( .Q(\condition<0> ), .D(\condition1973<0> ), .C(
        clk), .CE(\n3469<0> ), .CLR(1'b0) );
    NOR2 U4284 ( .O(\n3469<0> ), .I1(n11611), .I0(n10750) );
    INV U4285 ( .O(n11609), .I(n11608) );
    INV U4286 ( .O(n11607), .I(n10753) );
    NAND3 U4287 ( .O(n11608), .I2(n11607), .I1(n10810), .I0(n10749) );
    NOR2 U4288 ( .O(n11611), .I1(n11609), .I0(n10725) );
    OR2 U4289 ( .O(n11610), .I1(ir_bus[8]), .I0(ir_bus[9]) );
    AND2 U4290 ( .O(n10750), .I1(n11610), .I0(ir_bus[10]) );
    INV U4291 ( .O(n11613), .I(n11612) );
    NAND2 U4292 ( .O(n11612), .I1(n10938), .I0(\*cell*964/U1/CONTROL2 ) );
    OR2 U4293 ( .O(n11620), .I1(n11619), .I0(n11613) );
    INV U4294 ( .O(n11616), .I(n11615) );
    INV U4295 ( .O(n11614), .I(\multiple_wait_state<5> ) );
    NAND3 U4296 ( .O(n11615), .I2(n10913), .I1(n11614), .I0(n10755) );
    OR2 U4297 ( .O(n11619), .I1(n10937), .I0(n11616) );
    INV U4298 ( .O(n11617), .I(\multiple_wait_state<1> ) );
    NOR3 U4299 ( .O(n10938), .I2(\multiple_wait_state<2> ), .I1(
        \multiple_wait_state<3> ), .I0(n11617) );
    FDCE addr_en_reg ( .Q(addr_en), .D(n11620), .C(clk), .CE(
        \*cell*964/U99/CONTROL2 ), .CLR(1'b0) );
    OR2 U4301 ( .O(\*cell*964/U99/CONTROL2 ), .I1(n11625), .I0(n11626) );
    OR2 U4302 ( .O(n11621), .I1(n10758), .I0(n10808) );
    AND2 U4303 ( .O(n11622), .I1(n11621), .I0(n10748) );
    OR2 U4304 ( .O(n11626), .I1(n10899), .I0(n11622) );
    INV U4305 ( .O(n11623), .I(\multiple_wait_state<6> ) );
    NAND3 U4306 ( .O(n11624), .I2(n10755), .I1(n11623), .I0(n11062) );
    NAND2 U4307 ( .O(n11625), .I1(n11624), .I0(n10884) );
    OR2 U4308 ( .O(n11633), .I1(n11632), .I0(n11631) );
    INV U4309 ( .O(n11627), .I(\multiple_wait_state<4> ) );
    NOR4 U4310 ( .O(n11632), .I3(n11627), .I2(ir_bus[13]), .I1(ir_bus[12]), 
        .I0(\multiple_wait_state<0> ) );
    INV U4311 ( .O(n11628), .I(ir_bus[11]) );
    OR2 U4312 ( .O(n11629), .I1(n10923), .I0(n11628) );
    NAND3 U4313 ( .O(n11631), .I2(n10924), .I1(n11629), .I0(n10925) );
    FDCE \alu_control_reg<0>  ( .Q(alu_control[0]), .D(n11633), .C(clk), .CE(
        \n3404<0> ), .CLR(1'b0) );
    INV U4315 ( .O(n11635), .I(n11634) );
    NAND2 U4316 ( .O(n11634), .I1(n10739), .I0(n10748) );
    NOR2 U4317 ( .O(n10924), .I1(n11635), .I0(n11639) );
    INV U4318 ( .O(n11636), .I(n10839) );
    OR4 U4319 ( .O(n11639), .I3(n10833), .I2(n10832), .I1(n11636), .I0(n10962)
         );
    INV U4320 ( .O(n11637), .I(\multiple_wait_state<2> ) );
    INV U4321 ( .O(n11638), .I(\multiple_wait_state<3> ) );
    NOR4 U4322 ( .O(n10739), .I3(\multiple_wait_state<1> ), .I2(
        \multiple_wait_state<4> ), .I1(n11637), .I0(n11638) );
    OR3 U4323 ( .O(n11644), .I2(n10865), .I1(n11643), .I0(n10922) );
    INV U4324 ( .O(n11640), .I(n10839) );
    INV U4325 ( .O(n11641), .I(n10831) );
    OR4 U4326 ( .O(n11643), .I3(n10766), .I2(n10832), .I1(n11640), .I0(n11641)
         );
    AND3 U4327 ( .O(n10865), .I2(\multiple_wait_state<2> ), .I1(n10853), .I0(
        n10745) );
    FDCE alu_to_mem_reg ( .Q(alu_to_mem), .D(n11644), .C(clk), .CE(n3368), 
        .CLR(1'b0) );
    INV U4329 ( .O(n11647), .I(n11646) );
    INV U4330 ( .O(n11645), .I(n10919) );
    NAND2 U4331 ( .O(n11646), .I1(n11645), .I0(ir_bus[2]) );
    OR2 U4332 ( .O(n11653), .I1(n11652), .I0(n11647) );
    INV U4333 ( .O(n11648), .I(imm_bus[12]) );
    OR2 U4334 ( .O(n11650), .I1(n10921), .I0(n11648) );
    NAND2 U4335 ( .O(n11649), .I1(n11082), .I0(ir_bus[7]) );
    NAND2 U4336 ( .O(n11652), .I1(n11649), .I0(n11650) );
    FDCE \b_addr_reg<1>  ( .Q(b_addr[1]), .D(n11653), .C(clk), .CE(\n3479<0> ), 
        .CLR(1'b0) );
    INV U4338 ( .O(n11656), .I(n11655) );
    INV U4339 ( .O(n11654), .I(n10919) );
    NAND2 U4340 ( .O(n11655), .I1(n11654), .I0(ir_bus[4]) );
    OR2 U4341 ( .O(n11664), .I1(n11663), .I0(n11656) );
    INV U4342 ( .O(n11657), .I(imm_bus[14]) );
    OR2 U4343 ( .O(n11659), .I1(n10921), .I0(n11657) );
    NAND2 U4344 ( .O(n11658), .I1(n11082), .I0(ir_bus[9]) );
    NAND2 U4345 ( .O(n11663), .I1(n11658), .I0(n11659) );
    INV U4346 ( .O(n11661), .I(n11660) );
    NAND2 U4347 ( .O(n11660), .I1(n10771), .I0(\*cell*964/U1/CONTROL2 ) );
    NOR2 U4348 ( .O(n10919), .I1(n11661), .I0(n10917) );
    FDCE \b_addr_reg<3>  ( .Q(b_addr[3]), .D(n11664), .C(clk), .CE(\n3479<0> ), 
        .CLR(1'b0) );
    INV U4350 ( .O(n11667), .I(n11666) );
    INV U4351 ( .O(n11665), .I(n11672) );
    NAND2 U4352 ( .O(n11666), .I1(n11665), .I0(n10810) );
    OR2 U4353 ( .O(n11673), .I1(\*cell*964/U69/CONTROL2 ), .I0(n11667) );
    INV U4354 ( .O(n11668), .I(n10771) );
    INV U4355 ( .O(n11669), .I(ir_bus[0]) );
    OR4 U4356 ( .O(n11672), .I3(n10743), .I2(n11668), .I1(
        \multiple_wait_state<6> ), .I0(n11669) );
    INV U4357 ( .O(n11670), .I(\multiple_wait_state<4> ) );
    NOR4 U4358 ( .O(\*cell*964/U69/CONTROL2 ), .I3(n11670), .I2(
        \multiple_wait_state<2> ), .I1(\multiple_wait_state<3> ), .I0(
        \multiple_wait_state<5> ) );
    FDCE ext_iom_reg ( .Q(n11858), .D(n11673), .C(clk), .CE(n3323), .CLR(1'b0)
         );
    INV U4360 ( .O(n11674), .I(n10912) );
    OR3 U4361 ( .O(n11682), .I2(n11681), .I1(n11674), .I0(n11680) );
    INV U4362 ( .O(n11675), .I(n10896) );
    INV U4363 ( .O(n11676), .I(n10879) );
    OR4 U4364 ( .O(n11681), .I3(n11057), .I2(n10890), .I1(n11675), .I0(n11676)
         );
    INV U4365 ( .O(n11677), .I(n10748) );
    OR2 U4366 ( .O(n11678), .I1(n10915), .I0(n11677) );
    NAND3 U4367 ( .O(n11680), .I2(n10867), .I1(n11678), .I0(n10887) );
    FDC \multiple_wait_state_reg<0>  ( .Q(\multiple_wait_state<0> ), .D(n11682
        ), .C(clk), .CLR(1'b0) );
    OR2 U4369 ( .O(n11689), .I1(n11688), .I0(n11687) );
    INV U4370 ( .O(n11683), .I(n10912) );
    INV U4371 ( .O(n11684), .I(n10900) );
    OR4 U4372 ( .O(n11688), .I3(n11076), .I2(n11077), .I1(n11683), .I0(n11684)
         );
    INV U4373 ( .O(n11685), .I(n10876) );
    OR4 U4374 ( .O(n11687), .I3(n11071), .I2(n11066), .I1(n11685), .I0(n10881)
         );
    FDC \multiple_wait_state_reg<1>  ( .Q(\multiple_wait_state<1> ), .D(n11689
        ), .C(clk), .CLR(1'b0) );
    INV U4376 ( .O(n11691), .I(n11690) );
    NAND2 U4377 ( .O(n11690), .I1(n10914), .I0(n10913) );
    NOR2 U4378 ( .O(n10915), .I1(n11691), .I0(n11695) );
    NOR2 U4379 ( .O(n11693), .I1(n11692), .I0(\multiple_wait_state<1> ) );
    NOR2 U4380 ( .O(n11692), .I1(reset), .I0(\*cell*964/U98/CONTROL2 ) );
    OR2 U4381 ( .O(n11695), .I1(n10758), .I0(n11693) );
    INV U4382 ( .O(n11694), .I(\multiple_wait_state<4> ) );
    NOR2 U4383 ( .O(n10914), .I1(\multiple_wait_state<1> ), .I0(n11694) );
    INV U4384 ( .O(n11696), .I(n10910) );
    NOR3 U4385 ( .O(n10912), .I2(n11701), .I1(n11700), .I0(n11696) );
    INV U4386 ( .O(n11697), .I(n10882) );
    NAND4 U4387 ( .O(n11701), .I3(n11697), .I2(n10903), .I1(n10892), .I0(
        n10872) );
    OR2 U4388 ( .O(n11699), .I1(n10748), .I0(n10853) );
    OR2 U4389 ( .O(n11698), .I1(n10928), .I0(n11020) );
    AND2 U4390 ( .O(n11700), .I1(n11698), .I0(n11699) );
    OR2 U4391 ( .O(n11708), .I1(n11706), .I0(n11707) );
    INV U4392 ( .O(n11702), .I(n10910) );
    OR4 U4393 ( .O(n11707), .I3(n11081), .I2(n11080), .I1(n11702), .I0(n11048)
         );
    INV U4394 ( .O(n11703), .I(n10901) );
    INV U4395 ( .O(n11704), .I(n10891) );
    OR4 U4396 ( .O(n11706), .I3(n10877), .I2(n11066), .I1(n11703), .I0(n11704)
         );
    FDC \multiple_wait_state_reg<2>  ( .Q(\multiple_wait_state<2> ), .D(n11708
        ), .C(clk), .CLR(1'b0) );
    NOR3 U4398 ( .O(n10910), .I2(n10909), .I1(n10908), .I0(n11710) );
    AND2 U4399 ( .O(n11709), .I1(n10825), .I0(n10748) );
    OR3 U4400 ( .O(n11710), .I2(n10725), .I1(n11709), .I0(n10737) );
    AND3 U4401 ( .O(n10909), .I2(n10786), .I1(n10783), .I0(n10805) );
    INV U4402 ( .O(n11712), .I(n11711) );
    NAND2 U4403 ( .O(n11711), .I1(n10902), .I0(n10805) );
    NOR2 U4404 ( .O(n10903), .I1(n11712), .I0(n11714) );
    OR4 U4405 ( .O(n11714), .I3(n10883), .I2(n11022), .I1(n10775), .I0(n10727)
         );
    INV U4406 ( .O(n11713), .I(\multiple_wait_state<2> ) );
    AND4 U4407 ( .O(n10902), .I3(n11713), .I2(\multiple_wait_state<4> ), .I1(
        \multiple_wait_state<1> ), .I0(\multiple_wait_state<3> ) );
    NOR2 U4408 ( .O(n10901), .I1(n11717), .I0(n11718) );
    INV U4409 ( .O(n11715), .I(n10753) );
    OR4 U4410 ( .O(n11718), .I3(n10962), .I2(n10787), .I1(n11715), .I0(n10961)
         );
    INV U4411 ( .O(n11716), .I(n11078) );
    NAND4 U4412 ( .O(n11717), .I3(n11716), .I2(n10900), .I1(n10896), .I0(
        n10892) );
    INV U4413 ( .O(n11720), .I(n11719) );
    NAND2 U4414 ( .O(n11719), .I1(n10808), .I0(n10748) );
    NOR2 U4415 ( .O(n10892), .I1(n11720), .I0(n11722) );
    OR4 U4416 ( .O(n11722), .I3(n11056), .I2(n10838), .I1(n10770), .I0(n10730)
         );
    INV U4417 ( .O(n11721), .I(\multiple_wait_state<4> ) );
    AND4 U4418 ( .O(n10808), .I3(n11721), .I2(\multiple_wait_state<2> ), .I1(
        \multiple_wait_state<1> ), .I0(\multiple_wait_state<3> ) );
    OR2 U4419 ( .O(n11727), .I1(n11726), .I0(n11725) );
    INV U4420 ( .O(n11723), .I(n10891) );
    OR4 U4421 ( .O(n11726), .I3(n11071), .I2(n11057), .I1(n11723), .I0(n10898)
         );
    OR4 U4422 ( .O(n11725), .I3(n11093), .I2(n11073), .I1(n11072), .I0(n10987)
         );
    FDC \multiple_wait_state_reg<4>  ( .Q(\multiple_wait_state<4> ), .D(n11727
        ), .C(clk), .CLR(1'b0) );
    OR2 U4424 ( .O(n11733), .I1(n11732), .I0(n11731) );
    INV U4425 ( .O(n11728), .I(n10884) );
    OR4 U4426 ( .O(n11732), .I3(n10894), .I2(n11066), .I1(n11728), .I0(n10909)
         );
    INV U4427 ( .O(n11729), .I(n10880) );
    OR4 U4428 ( .O(n11731), .I3(n11092), .I2(n10897), .I1(n11729), .I0(n11063)
         );
    FDC \multiple_wait_state_reg<5>  ( .Q(\multiple_wait_state<5> ), .D(n11733
        ), .C(clk), .CLR(1'b0) );
    NOR2 U4430 ( .O(n10880), .I1(n11737), .I0(n11738) );
    INV U4431 ( .O(n11734), .I(n10879) );
    OR4 U4432 ( .O(n11738), .I3(n11059), .I2(n11056), .I1(n11734), .I0(n10842)
         );
    INV U4433 ( .O(n11735), .I(n10876) );
    INV U4434 ( .O(n11736), .I(n10872) );
    OR4 U4435 ( .O(n11737), .I3(n10908), .I2(n11091), .I1(n11735), .I0(n11736)
         );
    OR3 U4436 ( .O(n11743), .I2(n10871), .I1(n11742), .I0(n11741) );
    INV U4437 ( .O(n11739), .I(n11047) );
    NAND4 U4438 ( .O(n11742), .I3(n11739), .I2(n10870), .I1(n10867), .I0(
        n10864) );
    OR4 U4439 ( .O(n11741), .I3(n10889), .I2(n11043), .I1(n10838), .I0(n10819)
         );
    FDC \multiple_wait_state_reg<6>  ( .Q(\multiple_wait_state<6> ), .D(n11743
        ), .C(clk), .CLR(1'b0) );
    NOR3 U4441 ( .O(n10867), .I2(n10866), .I1(n10865), .I0(n11748) );
    INV U4442 ( .O(n11744), .I(n10797) );
    OR2 U4443 ( .O(n11746), .I1(ir_bus[0]), .I0(n11744) );
    INV U4444 ( .O(n11745), .I(n10977) );
    NAND3 U4445 ( .O(n11748), .I2(n11745), .I1(n11746), .I0(n10753) );
    INV U4446 ( .O(n11747), .I(\multiple_wait_state<0> ) );
    AND3 U4447 ( .O(n10866), .I2(n10964), .I1(n11747), .I0(n10830) );
    NOR3 U4448 ( .O(n10852), .I2(n10851), .I1(n10734), .I0(n11754) );
    INV U4449 ( .O(n11749), .I(n11751) );
    INV U4450 ( .O(n11750), .I(\multiple_wait_state<5> ) );
    OR2 U4451 ( .O(n11752), .I1(n10853), .I0(n11749) );
    NAND2 U4452 ( .O(n11751), .I1(n11750), .I0(\*cell*964/U47/CONTROL1 ) );
    AND2 U4453 ( .O(n11754), .I1(n11752), .I0(n10742) );
    INV U4454 ( .O(n11753), .I(\multiple_wait_state<1> ) );
    AND3 U4455 ( .O(n10734), .I2(n10731), .I1(n11753), .I0(n10732) );
    OR2 U4456 ( .O(n3368), .I1(n11757), .I0(n11758) );
    INV U4457 ( .O(n11755), .I(n10848) );
    OR4 U4458 ( .O(n11758), .I3(n10888), .I2(n11040), .I1(n11755), .I0(n11039)
         );
    INV U4459 ( .O(n11756), .I(n10814) );
    OR4 U4460 ( .O(n11757), .I3(n10838), .I2(n10833), .I1(n11756), .I0(n10775)
         );
    INV U4461 ( .O(n11759), .I(n10745) );
    OR2 U4462 ( .O(n11760), .I1(n11769), .I0(n11759) );
    AND2 U4463 ( .O(n10848), .I1(n11760), .I0(n10829) );
    INV U4464 ( .O(n11762), .I(n11766) );
    INV U4465 ( .O(n11763), .I(\multiple_wait_state<0> ) );
    INV U4466 ( .O(n11761), .I(\multiple_wait_state<2> ) );
    OR2 U4467 ( .O(n11768), .I1(n11764), .I0(n11761) );
    OR2 U4468 ( .O(n11767), .I1(n11762), .I0(n11037) );
    OR2 U4469 ( .O(n11765), .I1(\multiple_wait_state<2> ), .I0(
        \multiple_wait_state<0> ) );
    AND2 U4470 ( .O(n11764), .I1(n10964), .I0(n11763) );
    NAND2 U4471 ( .O(n11766), .I1(n11765), .I0(n10964) );
    NAND2 U4472 ( .O(n11769), .I1(n11767), .I0(n11768) );
    NOR3 U4473 ( .O(n10745), .I2(\multiple_wait_state<1> ), .I1(
        \multiple_wait_state<3> ), .I0(\multiple_wait_state<4> ) );
    INV U4474 ( .O(n11770), .I(n11775) );
    NAND3 U4475 ( .O(\n3404<0> ), .I2(n10839), .I1(n11770), .I0(n10841) );
    INV U4476 ( .O(n11771), .I(n10741) );
    NOR2 U4477 ( .O(n11772), .I1(n10843), .I0(n11771) );
    OR3 U4478 ( .O(n11775), .I2(n10797), .I1(n11772), .I0(n10842) );
    INV U4479 ( .O(n11773), .I(n10810) );
    OR2 U4480 ( .O(n11774), .I1(n11773), .I0(n10835) );
    AND2 U4481 ( .O(n10841), .I1(n11774), .I0(n10834) );
    OR2 U4482 ( .O(\n3414<0> ), .I1(n11783), .I0(n11782) );
    INV U4483 ( .O(n11778), .I(n11777) );
    INV U4484 ( .O(n11776), .I(n10955) );
    OR3 U4485 ( .O(n11777), .I2(n10835), .I1(ir_bus[14]), .I0(n11776) );
    OR2 U4486 ( .O(n11783), .I1(n10797), .I0(n11778) );
    INV U4487 ( .O(n11779), .I(n10808) );
    OR2 U4488 ( .O(n11781), .I1(n10837), .I0(n11779) );
    INV U4489 ( .O(n11780), .I(n11033) );
    NAND3 U4490 ( .O(n11782), .I2(n11780), .I1(n11781), .I0(n10834) );
    NOR3 U4491 ( .O(n10834), .I2(n10833), .I1(n10832), .I0(n11787) );
    INV U4492 ( .O(n11786), .I(n11785) );
    INV U4493 ( .O(n11784), .I(\multiple_wait_state<2> ) );
    NAND3 U4494 ( .O(n11785), .I2(n10769), .I1(n11784), .I0(n10779) );
    OR2 U4495 ( .O(n11787), .I1(n10854), .I0(n11786) );
    AND3 U4496 ( .O(n10832), .I2(\multiple_wait_state<0> ), .I1(n10825), .I0(
        n10964) );
    INV U4497 ( .O(n11788), .I(n11793) );
    NAND3 U4498 ( .O(\n3442<0> ), .I2(n10829), .I1(n11788), .I0(n10831) );
    AND2 U4499 ( .O(n11789), .I1(n10853), .I0(n10754) );
    OR3 U4500 ( .O(n11793), .I2(n10759), .I1(n11789), .I0(n10774) );
    INV U4501 ( .O(n11790), .I(n10810) );
    OR2 U4502 ( .O(n11792), .I1(n10828), .I0(n11790) );
    INV U4503 ( .O(n11791), .I(n10827) );
    AND3 U4504 ( .O(n10829), .I2(n10826), .I1(n11791), .I0(n11792) );
    INV U4505 ( .O(n11795), .I(n11794) );
    NAND2 U4506 ( .O(n11794), .I1(n10830), .I0(n10805) );
    NOR2 U4507 ( .O(n10831), .I1(n11795), .I0(n11797) );
    AND2 U4508 ( .O(n11796), .I1(n10742), .I0(n10738) );
    OR3 U4509 ( .O(n11797), .I2(n10734), .I1(n11796), .I0(n10773) );
    AND2 U4510 ( .O(n10830), .I1(n10914), .I0(n10913) );
    INV U4511 ( .O(n11799), .I(n11798) );
    NAND2 U4512 ( .O(n11798), .I1(n10825), .I0(n10738) );
    NOR2 U4513 ( .O(n10826), .I1(n11799), .I0(n11804) );
    INV U4514 ( .O(n11802), .I(n11801) );
    INV U4515 ( .O(n11800), .I(\multiple_wait_state<6> ) );
    NAND3 U4516 ( .O(n11801), .I2(n10913), .I1(n11800), .I0(n11029) );
    OR2 U4517 ( .O(n11804), .I1(n10766), .I0(n11802) );
    INV U4518 ( .O(n11803), .I(\multiple_wait_state<5> ) );
    AND3 U4519 ( .O(n10738), .I2(\multiple_wait_state<0> ), .I1(n11803), .I0(
        \multiple_wait_state<6> ) );
    NOR2 U4520 ( .O(n10807), .I1(n11809), .I0(n11810) );
    OR2 U4521 ( .O(n11805), .I1(n10760), .I0(n10742) );
    AND2 U4522 ( .O(n11806), .I1(n11805), .I0(n10805) );
    OR2 U4523 ( .O(n11810), .I1(n10806), .I0(n11806) );
    NAND2 U4524 ( .O(n11808), .I1(n10902), .I0(n10748) );
    NAND2 U4525 ( .O(n11807), .I1(n10739), .I0(n10853) );
    NAND2 U4526 ( .O(n11809), .I1(n11807), .I0(n11808) );
    OR3 U4527 ( .O(n11820), .I2(n10789), .I1(n11818), .I0(n11819) );
    INV U4528 ( .O(n11812), .I(n10808) );
    INV U4529 ( .O(n11811), .I(n10928) );
    OR2 U4530 ( .O(n11814), .I1(n10761), .I0(n11811) );
    OR2 U4531 ( .O(n11813), .I1(n10837), .I0(n11812) );
    NAND2 U4532 ( .O(n11819), .I1(n11813), .I0(n11814) );
    INV U4533 ( .O(n11815), .I(ir_bus[15]) );
    NOR2 U4534 ( .O(n11816), .I1(n10784), .I0(n11815) );
    OR3 U4535 ( .O(n11818), .I2(n10788), .I1(n11816), .I0(n10854) );
    FDCE sel_imm_rega_reg ( .Q(sel_imm_rega), .D(n11820), .C(clk), .CE(n3350), 
        .CLR(1'b0) );
    NOR2 U4537 ( .O(n10782), .I1(n11825), .I0(n10717) );
    INV U4538 ( .O(n11821), .I(\multiple_wait_state<0> ) );
    NAND3 U4539 ( .O(n11823), .I2(\multiple_wait_state<3> ), .I1(n11821), .I0(
        \multiple_wait_state<4> ) );
    OR3 U4540 ( .O(n11822), .I2(\multiple_wait_state<3> ), .I1(n11821), .I0(
        \multiple_wait_state<1> ) );
    NAND2 U4541 ( .O(n11825), .I1(n11822), .I0(n11823) );
    INV U4542 ( .O(n11824), .I(\multiple_wait_state<3> ) );
    NOR4 U4543 ( .O(n10717), .I3(n11824), .I2(\multiple_wait_state<2> ), .I1(
        \multiple_wait_state<1> ), .I0(\multiple_wait_state<0> ) );
    INV U4544 ( .O(n11827), .I(n11826) );
    NAND2 U4545 ( .O(n11826), .I1(n10779), .I0(n10732) );
    NOR2 U4546 ( .O(n10780), .I1(n11827), .I0(n11831) );
    INV U4547 ( .O(n11830), .I(n11829) );
    INV U4548 ( .O(n11828), .I(\multiple_wait_state<2> ) );
    NAND3 U4549 ( .O(n11829), .I2(n10805), .I1(n11828), .I0(n10914) );
    OR2 U4550 ( .O(n11831), .I1(n10778), .I0(n11830) );
    AND2 U4551 ( .O(n10779), .I1(\multiple_wait_state<4> ), .I0(
        \multiple_wait_state<1> ) );
    OR2 U4552 ( .O(n11837), .I1(n11835), .I0(n11836) );
    OR4 U4553 ( .O(n11836), .I3(n10893), .I2(n10874), .I1(n10961), .I0(n10973)
         );
    NAND2 U4554 ( .O(n11833), .I1(n10754), .I0(n10785) );
    INV U4555 ( .O(n11832), .I(n10977) );
    NAND3 U4556 ( .O(n11835), .I2(n11832), .I1(n11833), .I0(n10763) );
    FDCE wr_clk_reg ( .Q(wr_clk), .D(n11837), .C(clk), .CE(n3451), .CLR(1'b0)
         );
    INV U4558 ( .O(n11840), .I(n11839) );
    INV U4559 ( .O(n11838), .I(n10761) );
    NAND2 U4560 ( .O(n11839), .I1(n10762), .I0(n11838) );
    NOR2 U4561 ( .O(n10763), .I1(n11840), .I0(n11841) );
    AND3 U4562 ( .O(n11841), .I2(\multiple_wait_state<0> ), .I1(n10758), .I0(
        n10757) );
    AND4 U4563 ( .O(n10762), .I3(\multiple_wait_state<2> ), .I2(
        \multiple_wait_state<4> ), .I1(\multiple_wait_state<1> ), .I0(
        \multiple_wait_state<3> ) );
    OR2 U4564 ( .O(n11842), .I1(n11843), .I0(n11844) );
    AND2 U4565 ( .O(n10752), .I1(n11842), .I0(n10750) );
    OR4 U4566 ( .O(n11844), .I3(\condition<8> ), .I2(\condition<9> ), .I1(
        \condition<10> ), .I0(\condition<11> ) );
    OR4 U4567 ( .O(n11843), .I3(\condition<12> ), .I2(\condition<13> ), .I1(
        \condition<14> ), .I0(\condition<15> ) );
    OR2 U4568 ( .O(n11845), .I1(n11847), .I0(n11846) );
    AND2 U4569 ( .O(n10751), .I1(n11845), .I0(n10750) );
    OR4 U4570 ( .O(n11847), .I3(\condition<20> ), .I2(\condition<21> ), .I1(
        \condition<22> ), .I0(\condition<23> ) );
    OR4 U4571 ( .O(n11846), .I3(\condition<16> ), .I2(\condition<17> ), .I1(
        \condition<18> ), .I0(\condition<19> ) );
    NOR2 U4572 ( .O(n10730), .I1(n11850), .I0(n10719) );
    NAND4 U4573 ( .O(n11850), .I3(n10749), .I2(n10748), .I1(ir_bus[15]), .I0(
        ir_bus[14]) );
    OR3 U4574 ( .O(n11849), .I2(ir_bus[13]), .I1(ir_bus[11]), .I0(ir_bus[12])
         );
    NAND2 U4575 ( .O(n11848), .I1(ir_bus[13]), .I0(ir_bus[12]) );
    NAND2 U4576 ( .O(n10719), .I1(n11848), .I0(n11849) );
    INV U4577 ( .O(n11851), .I(n10723) );
    NOR3 U4578 ( .O(n10725), .I2(n11856), .I1(n10724), .I0(n11851) );
    INV U4579 ( .O(n11852), .I(n10743) );
    INV U4580 ( .O(n11853), .I(n10726) );
    OR4 U4581 ( .O(n11856), .I3(n10752), .I2(n11852), .I1(n10751), .I0(n11853)
         );
    OR2 U4582 ( .O(n11854), .I1(\condition<30> ), .I0(\condition<31> ) );
    AND2 U4583 ( .O(n11855), .I1(n11854), .I0(n10750) );
    NOR2 U4584 ( .O(n10723), .I1(n11855), .I0(n10939) );
endmodule


module latch_0 ( in, out, enableh );
input  [15:0] in;
output [15:0] out;
input  enableh;
    FDC \out_reg<14>  ( .Q(out[14]), .D(in[14]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<15>  ( .Q(out[15]), .D(in[15]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<12>  ( .Q(out[12]), .D(in[12]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<13>  ( .Q(out[13]), .D(in[13]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<10>  ( .Q(out[10]), .D(in[10]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<11>  ( .Q(out[11]), .D(in[11]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<8>  ( .Q(out[8]), .D(in[8]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<9>  ( .Q(out[9]), .D(in[9]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<6>  ( .Q(out[6]), .D(in[6]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<7>  ( .Q(out[7]), .D(in[7]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<4>  ( .Q(out[4]), .D(in[4]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<5>  ( .Q(out[5]), .D(in[5]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<2>  ( .Q(out[2]), .D(in[2]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<3>  ( .Q(out[3]), .D(in[3]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<0>  ( .Q(out[0]), .D(in[0]), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<1>  ( .Q(out[1]), .D(in[1]), .C(enableh), .CLR(1'b0) );
endmodule


module latch_1 ( in, out, enableh );
input  [15:0] in;
output [15:0] out;
input  enableh;
    tri \in<15> , \in<14> , \in<10> , \in<13> , \in<12> , \in<9> , \in<8> , 
        \in<7> , \in<3> , \in<5> , \in<1> , \in<6> , \in<4> , \in<0> , \in<2> , 
        \in<11> ;
    assign \in<15>  = in[15];
    assign \in<14>  = in[14];
    assign \in<13>  = in[13];
    assign \in<12>  = in[12];
    assign \in<11>  = in[11];
    assign \in<10>  = in[10];
    assign \in<9>  = in[9];
    assign \in<8>  = in[8];
    assign \in<7>  = in[7];
    assign \in<6>  = in[6];
    assign \in<5>  = in[5];
    assign \in<4>  = in[4];
    assign \in<3>  = in[3];
    assign \in<2>  = in[2];
    assign \in<1>  = in[1];
    assign \in<0>  = in[0];
    FDC \out_reg<14>  ( .Q(out[14]), .D(\in<14> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<15>  ( .Q(out[15]), .D(\in<15> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<12>  ( .Q(out[12]), .D(\in<12> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<13>  ( .Q(out[13]), .D(\in<13> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<10>  ( .Q(out[10]), .D(\in<10> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<11>  ( .Q(out[11]), .D(\in<11> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<8>  ( .Q(out[8]), .D(\in<8> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<9>  ( .Q(out[9]), .D(\in<9> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<6>  ( .Q(out[6]), .D(\in<6> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<7>  ( .Q(out[7]), .D(\in<7> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<4>  ( .Q(out[4]), .D(\in<4> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<5>  ( .Q(out[5]), .D(\in<5> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<2>  ( .Q(out[2]), .D(\in<2> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<3>  ( .Q(out[3]), .D(\in<3> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<0>  ( .Q(out[0]), .D(\in<0> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<1>  ( .Q(out[1]), .D(\in<1> ), .C(enableh), .CLR(1'b0) );
endmodule


module latch_2 ( in, out, enableh );
input  [15:0] in;
output [15:0] out;
input  enableh;
    tri \in<15> , \in<14> , \in<10> , \in<13> , \in<12> , \in<9> , \in<8> , 
        \in<7> , \in<3> , \in<5> , \in<1> , \in<6> , \in<4> , \in<0> , \in<2> , 
        \in<11> ;
    assign \in<15>  = in[15];
    assign \in<14>  = in[14];
    assign \in<13>  = in[13];
    assign \in<12>  = in[12];
    assign \in<11>  = in[11];
    assign \in<10>  = in[10];
    assign \in<9>  = in[9];
    assign \in<8>  = in[8];
    assign \in<7>  = in[7];
    assign \in<6>  = in[6];
    assign \in<5>  = in[5];
    assign \in<4>  = in[4];
    assign \in<3>  = in[3];
    assign \in<2>  = in[2];
    assign \in<1>  = in[1];
    assign \in<0>  = in[0];
    FDC \out_reg<14>  ( .Q(out[14]), .D(\in<14> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<15>  ( .Q(out[15]), .D(\in<15> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<12>  ( .Q(out[12]), .D(\in<12> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<13>  ( .Q(out[13]), .D(\in<13> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<10>  ( .Q(out[10]), .D(\in<10> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<11>  ( .Q(out[11]), .D(\in<11> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<8>  ( .Q(out[8]), .D(\in<8> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<9>  ( .Q(out[9]), .D(\in<9> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<6>  ( .Q(out[6]), .D(\in<6> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<7>  ( .Q(out[7]), .D(\in<7> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<4>  ( .Q(out[4]), .D(\in<4> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<5>  ( .Q(out[5]), .D(\in<5> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<2>  ( .Q(out[2]), .D(\in<2> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<3>  ( .Q(out[3]), .D(\in<3> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<0>  ( .Q(out[0]), .D(\in<0> ), .C(enableh), .CLR(1'b0) );
    FDC \out_reg<1>  ( .Q(out[1]), .D(\in<1> ), .C(enableh), .CLR(1'b0) );
endmodule


module tranceiver_0 ( port1, port2, io_en, io_dir );
inout  [15:0] port1;
inout  [15:0] port2;
input  io_en, io_dir;
    wire \port1_tri_enable110<1> , n1729, n1730, n1731, n1732, n1733, n1734, 
        n1735, n1736, n1737, n1738, n1739, n1740, n1741, n1742, n1743, n1744, 
        n1780, n1797;
    tri \port2<14> , \port2<10> , \port2<12> , \port2<5> , \port2<1> , 
        \port2<8> , \port2<3> , \port2<7> , \port2<6> , \port2<2> , \port2<0> , 
        \port2<9> , \port2<4> , \port2<13> , \port2<11> , \port2<15> , 
        \port1<15> , \port1<14> , \port1<13> , \port1<12> , \port1<11> , 
        \port1<10> , \port1<9> , \port1<8> , \port1<7> , \port1<6> , 
        \port1<5> , \port1<4> , \port1<3> , \port1<2> , \port1<1> , \port1<0> ;
    tran( \port1<15> , port1[15] );
    tran( \port1<14> , port1[14] );
    tran( \port1<13> , port1[13] );
    tran( \port1<12> , port1[12] );
    tran( \port1<11> , port1[11] );
    tran( \port1<10> , port1[10] );
    tran( \port1<9> , port1[9] );
    tran( \port1<8> , port1[8] );
    tran( \port1<7> , port1[7] );
    tran( \port1<6> , port1[6] );
    tran( \port1<5> , port1[5] );
    tran( \port1<4> , port1[4] );
    tran( \port1<3> , port1[3] );
    tran( \port1<2> , port1[2] );
    tran( \port1<1> , port1[1] );
    tran( \port1<0> , port1[0] );
    tran( \port2<15> , port2[15] );
    tran( \port2<14> , port2[14] );
    tran( \port2<13> , port2[13] );
    tran( \port2<12> , port2[12] );
    tran( \port2<11> , port2[11] );
    tran( \port2<10> , port2[10] );
    tran( \port2<9> , port2[9] );
    tran( \port2<8> , port2[8] );
    tran( \port2<7> , port2[7] );
    tran( \port2<6> , port2[6] );
    tran( \port2<5> , port2[5] );
    tran( \port2<4> , port2[4] );
    tran( \port2<3> , port2[3] );
    tran( \port2<2> , port2[2] );
    tran( \port2<1> , port2[1] );
    tran( \port2<0> , port2[0] );
    BUFT \port2_tri3<2>  ( .O(\port2<2> ), .I(n1731), .T(n1780) );
    BUFT \port2_tri13<12>  ( .O(\port2<12> ), .I(n1743), .T(n1780) );
    BUFT \port2_tri12<11>  ( .O(\port2<11> ), .I(n1736), .T(n1780) );
    BUFT \port2_tri16<15>  ( .O(\port2<15> ), .I(n1733), .T(n1780) );
    BUFT \port2_tri14<13>  ( .O(\port2<13> ), .I(n1730), .T(n1780) );
    BUFT \port2_tri4<3>  ( .O(\port2<3> ), .I(n1742), .T(n1780) );
    BUFT \port2_tri15<14>  ( .O(\port2<14> ), .I(n1741), .T(n1780) );
    BUFT \port2_tri7<6>  ( .O(\port2<6> ), .I(n1729), .T(n1780) );
    BUFT \port2_tri11<10>  ( .O(\port2<10> ), .I(n1737), .T(n1780) );
    BUFT \port2_tri<0>  ( .O(\port2<0> ), .I(n1734), .T(n1780) );
    BUFT \port2_tri9<8>  ( .O(\port2<8> ), .I(n1739), .T(n1780) );
    BUFT \port2_tri2<1>  ( .O(\port2<1> ), .I(n1740), .T(n1780) );
    BUFT \port2_tri10<9>  ( .O(\port2<9> ), .I(n1732), .T(n1780) );
    BUFT \port2_tri6<5>  ( .O(\port2<5> ), .I(n1738), .T(n1780) );
    BUFT \port2_tri8<7>  ( .O(\port2<7> ), .I(n1744), .T(n1780) );
    BUFT \port2_tri5<4>  ( .O(\port2<4> ), .I(n1735), .T(n1780) );
    IOBUF_N_S U365 ( .O(n1733), .IO(\port1<15> ), .I(\port2<15> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U366 ( .O(n1741), .IO(\port1<14> ), .I(\port2<14> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U367 ( .O(n1730), .IO(\port1<13> ), .I(\port2<13> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U368 ( .O(n1743), .IO(\port1<12> ), .I(\port2<12> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U369 ( .O(n1736), .IO(\port1<11> ), .I(\port2<11> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U370 ( .O(n1737), .IO(\port1<10> ), .I(\port2<10> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U371 ( .O(n1732), .IO(\port1<9> ), .I(\port2<9> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U372 ( .O(n1739), .IO(\port1<8> ), .I(\port2<8> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U373 ( .O(n1744), .IO(\port1<7> ), .I(\port2<7> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U374 ( .O(n1729), .IO(\port1<6> ), .I(\port2<6> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U375 ( .O(n1738), .IO(\port1<5> ), .I(\port2<5> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U376 ( .O(n1735), .IO(\port1<4> ), .I(\port2<4> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U377 ( .O(n1742), .IO(\port1<3> ), .I(\port2<3> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U378 ( .O(n1731), .IO(\port1<2> ), .I(\port2<2> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U379 ( .O(n1740), .IO(\port1<1> ), .I(\port2<1> ), .T(
        \port1_tri_enable110<1> ) );
    IOBUF_N_S U380 ( .O(n1734), .IO(\port1<0> ), .I(\port2<0> ), .T(
        \port1_tri_enable110<1> ) );
    NAND2 U381 ( .O(\port1_tri_enable110<1> ), .I1(io_dir), .I0(io_en) );
    INV U382 ( .O(n1797), .I(io_en) );
    OR2 U383 ( .O(n1780), .I1(n1797), .I0(io_dir) );
endmodule


module tranceiver_1 ( port1, port2, io_en, io_dir );
inout  [15:0] port1;
inout  [15:0] port2;
input  io_en, io_dir;
    wire n1700, n1701, n2000;
    tri \port2<14> , \port2<10> , \port2<12> , \port1<6> , \port2<5> , 
        \port1<13> , \port1<2> , \port2<1> , \port2<8> , \port1<9> , 
        \port1<15> , \port1<0> , \port2<3> , \port1<4> , \port2<7> , 
        \port1<11> , \port1<10> , \port2<6> , \port1<5> , \port1<8> , 
        \port1<1> , \port2<2> , \port1<14> , \port2<0> , \port1<3> , 
        \port2<9> , \port1<12> , \port1<7> , \port2<4> , \port2<13> , 
        \port2<11> , \port2<15> ;
    tran( \port1<15> , port1[15] );
    tran( \port1<14> , port1[14] );
    tran( \port1<13> , port1[13] );
    tran( \port1<12> , port1[12] );
    tran( \port1<11> , port1[11] );
    tran( \port1<10> , port1[10] );
    tran( \port1<9> , port1[9] );
    tran( \port1<8> , port1[8] );
    tran( \port1<7> , port1[7] );
    tran( \port1<6> , port1[6] );
    tran( \port1<5> , port1[5] );
    tran( \port1<4> , port1[4] );
    tran( \port1<3> , port1[3] );
    tran( \port1<2> , port1[2] );
    tran( \port1<1> , port1[1] );
    tran( \port1<0> , port1[0] );
    tran( \port2<15> , port2[15] );
    tran( \port2<14> , port2[14] );
    tran( \port2<13> , port2[13] );
    tran( \port2<12> , port2[12] );
    tran( \port2<11> , port2[11] );
    tran( \port2<10> , port2[10] );
    tran( \port2<9> , port2[9] );
    tran( \port2<8> , port2[8] );
    tran( \port2<7> , port2[7] );
    tran( \port2<6> , port2[6] );
    tran( \port2<5> , port2[5] );
    tran( \port2<4> , port2[4] );
    tran( \port2<3> , port2[3] );
    tran( \port2<2> , port2[2] );
    tran( \port2<1> , port2[1] );
    tran( \port2<0> , port2[0] );
    BUFT \port1_tri5<4>  ( .O(\port1<4> ), .I(\port2<4> ), .T(n1700) );
    BUFT \port2_tri3<2>  ( .O(\port2<2> ), .I(\port1<2> ), .T(n1701) );
    BUFT \port2_tri13<12>  ( .O(\port2<12> ), .I(\port1<12> ), .T(n1701) );
    BUFT \port2_tri12<11>  ( .O(\port2<11> ), .I(\port1<11> ), .T(n1701) );
    BUFT \port1_tri8<7>  ( .O(\port1<7> ), .I(\port2<7> ), .T(n1700) );
    BUFT \port1_tri<0>  ( .O(\port1<0> ), .I(\port2<0> ), .T(n1700) );
    BUFT \port2_tri16<15>  ( .O(\port2<15> ), .I(\port1<15> ), .T(n1701) );
    BUFT \port1_tri6<5>  ( .O(\port1<5> ), .I(\port2<5> ), .T(n1700) );
    BUFT \port2_tri14<13>  ( .O(\port2<13> ), .I(\port1<13> ), .T(n1701) );
    BUFT \port2_tri4<3>  ( .O(\port2<3> ), .I(\port1<3> ), .T(n1701) );
    BUFT \port1_tri2<1>  ( .O(\port1<1> ), .I(\port2<1> ), .T(n1700) );
    BUFT \port1_tri10<9>  ( .O(\port1<9> ), .I(\port2<9> ), .T(n1700) );
    BUFT \port2_tri15<14>  ( .O(\port2<14> ), .I(\port1<14> ), .T(n1701) );
    BUFT \port2_tri7<6>  ( .O(\port2<6> ), .I(\port1<6> ), .T(n1701) );
    BUFT \port1_tri9<8>  ( .O(\port1<8> ), .I(\port2<8> ), .T(n1700) );
    BUFT \port2_tri11<10>  ( .O(\port2<10> ), .I(\port1<10> ), .T(n1701) );
    BUFT \port2_tri<0>  ( .O(\port2<0> ), .I(\port1<0> ), .T(n1701) );
    BUFT \port1_tri7<6>  ( .O(\port1<6> ), .I(\port2<6> ), .T(n1700) );
    BUFT \port1_tri16<15>  ( .O(\port1<15> ), .I(\port2<15> ), .T(n1700) );
    BUFT \port2_tri9<8>  ( .O(\port2<8> ), .I(\port1<8> ), .T(n1701) );
    BUFT \port2_tri2<1>  ( .O(\port2<1> ), .I(\port1<1> ), .T(n1701) );
    BUFT \port1_tri13<12>  ( .O(\port1<12> ), .I(\port2<12> ), .T(n1700) );
    BUFT \port1_tri4<3>  ( .O(\port1<3> ), .I(\port2<3> ), .T(n1700) );
    BUFT \port2_tri10<9>  ( .O(\port2<9> ), .I(\port1<9> ), .T(n1701) );
    BUFT \port1_tri12<11>  ( .O(\port1<11> ), .I(\port2<11> ), .T(n1700) );
    BUFT \port2_tri6<5>  ( .O(\port2<5> ), .I(\port1<5> ), .T(n1701) );
    BUFT \port2_tri8<7>  ( .O(\port2<7> ), .I(\port1<7> ), .T(n1701) );
    BUFT \port1_tri11<10>  ( .O(\port1<10> ), .I(\port2<10> ), .T(n1700) );
    BUFT \port1_tri14<13>  ( .O(\port1<13> ), .I(\port2<13> ), .T(n1700) );
    BUFT \port2_tri5<4>  ( .O(\port2<4> ), .I(\port1<4> ), .T(n1701) );
    BUFT \port1_tri15<14>  ( .O(\port1<14> ), .I(\port2<14> ), .T(n1700) );
    BUFT \port1_tri3<2>  ( .O(\port1<2> ), .I(\port2<2> ), .T(n1700) );
    NAND2 U301 ( .O(n1700), .I1(io_en), .I0(io_dir) );
    INV U302 ( .O(n2000), .I(io_en) );
    OR2 U303 ( .O(n1701), .I1(n2000), .I0(io_dir) );
endmodule


module micro ( data_bus, address_bus, wr, rd, iom, sal, sce12, sce34, scue, 
    scu, swr, sclr, sa, sd, clk, reset, bus_select, disp_clk, intr, inta, 
    p24_dir, p25_dir );
inout  [15:0] data_bus;
output [15:0] address_bus;
output [1:0] sa;
output [6:0] sd;
input  clk, reset, bus_select, disp_clk, intr;
output wr, rd, iom, sal, sce12, sce34, scue, scu, swr, sclr, inta, p24_dir, 
    p25_dir;
    wire ext_rd, \alu_a<14> , \alu_a<3> , \alu_control<0> , \imm<13> , 
        \transfer_bus<3> , \rega<10> , \rega<9> , \b_addr<0> , \alu_flags2<3> , 
        \regb<3> , \rega<0> , \alu_out<2> , \rega<14> , \a_addr<1> , 
        \alu_a<10> , \alu_a<7> , \alu_out<6> , \alu_flags<2> , 
        \transfer_bus<7> , \rega<4> , \regb<7> , \alu_flags2<7> , \imm<15> , 
        \transfer_bus<5> , \rega<6> , \regb<5> , \alu_flags2<5> , \alu_out<4> , 
        \alu_flags<0> , iflag, io_en, io_dir, \ir_bus<5> , \alu_a<8> , n195, 
        \alu_out<0> , \alu_a<12> , \alu_a<5> , \alu_flags<4> , regstore_reset, 
        \a_addr<3> , \imm<11> , \b_addr<2> , \alu_flags2<1> , 
        \transfer_bus<1> , \rega<2> , \regb<1> , \wr_addr<0> , 
        \transfer_bus<8> , \alu_a<1> , \regb<8> , \alu_flags2<8> , 
        \alu_out<9> , \rega<12> , \imm<3> , n194, \alu_control<2> , 
        \transfer_bus<11> , \alu_flags2<14> , \ir_bus<11> , \imm<7> , 
        \ir_bus<15> , \ir_bus<8> , \transfer_bus<15> , \alu_flags2<10> , 
        \regb<13> , \alu_out<13> , \alu_out<11> , \ir_bus<1> , sel_fl_alu, 
        \ir_bus<3> , n196, \regb<11> , \alu_flags2<12> , \imm<8> , \imm<5> , 
        n197, \regb<15> , \ir_bus<7> , \alu_out<15> , \ir_bus<13> , 
        \wr_addr<2> , \regb<14> , \imm<1> , \imm<9> , \transfer_bus<13> , 
        \alu_out<14> , \ir_bus<6> , \imm<0> , \ir_bus<12> , wr_clk, 
        \wr_addr<3> , \transfer_bus<12> , \alu_out<10> , \ir_bus<2> , 
        sel_imm_rega, \regb<10> , \alu_flags2<13> , addr_en, \imm<4> , 
        \ir_bus<14> , ir2_en, \ir_bus<9> , \transfer_bus<14> , \imm<6> , 
        \alu_flags2<11> , \alu_out<12> , \regb<12> , \imm<2> , \ir_bus<0> , 
        \alu_flags2<15> , \transfer_bus<10> , sel_tri, \ir_bus<10> , 
        \ir_bus<4> , \wr_addr<1> , \alu_out<1> , \imm<10> , ir_en, 
        \transfer_bus<0> , \a_addr<2> , \rega<3> , \alu_a<9> , \regb<0> , 
        \b_addr<3> , \alu_flags2<0> , \alu_flags2<9> , \alu_a<0> , \regb<9> , 
        \transfer_bus<9> , \rega<13> , \alu_out<8> , signedflag, \alu_out<5> , 
        \imm<14> , \alu_flags2<4> , \transfer_bus<4> , \rega<7> , 
        \alu_flags<1> , \regb<4> , ext_wr, \alu_out<7> , \rega<15> , 
        \alu_a<13> , \alu_a<4> , \alu_a<11> , \alu_a<6> , \alu_flags<3> , 
        \transfer_bus<6> , \alu_flags2<6> , io_dir1, \rega<5> , \regb<6> , 
        \alu_control<1> , alu_to_mem, \rega<11> , \rega<8> , \alu_a<15> , 
        \alu_a<2> , \imm<12> , \transfer_bus<2> , \rega<1> , \regb<2> , 
        \b_addr<1> , \alu_flags2<2> , \alu_out<3> , \a_addr<0> , n526, n525, 
        n524, n523, n522, n521, n520, n519, n518, n517, n516, n515, n514, n504, 
        n502, n501, n500, n499, n498, n497, n496, n480, n491, n492, n493, n494, 
        n495;
    tri \data_bus<14> , \data_buf<2> , \ip<2> , \data_bus<12> , \data_bus<10> , 
        \data_buf<6> , \ip<6> , \data_buf<4> , \ip<4> , \data_bus<8> , 
        \data_buf<9> , \data_buf<0> , \ip<0> , \ip<9> , \data_buf<10> , 
        \data_bus<1> , \data_buf<14> , \ip<11> , \ip<15> , \data_bus<7> , 
        \data_bus<5> , \ip<13> , \data_bus<3> , \data_buf<12> , \data_bus<2> , 
        \ip<12> , \data_bus<6> , \data_buf<13> , \data_buf<15> , \ip<14> , 
        \data_bus<4> , \data_bus<9> , \data_buf<11> , \data_bus<0> , \ip<10> , 
        \data_buf<1> , \ip<1> , \data_bus<13> , \data_buf<8> , \ip<8> , 
        \data_buf<5> , \ip<5> , \data_bus<11> , \data_buf<7> , \ip<7> , 
        \data_bus<15> , \data_buf<3> , \ip<3> ;
    tran( \data_bus<15> , data_bus[15] );
    tran( \data_bus<14> , data_bus[14] );
    tran( \data_bus<13> , data_bus[13] );
    tran( \data_bus<12> , data_bus[12] );
    tran( \data_bus<11> , data_bus[11] );
    tran( \data_bus<10> , data_bus[10] );
    tran( \data_bus<9> , data_bus[9] );
    tran( \data_bus<8> , data_bus[8] );
    tran( \data_bus<7> , data_bus[7] );
    tran( \data_bus<6> , data_bus[6] );
    tran( \data_bus<5> , data_bus[5] );
    tran( \data_bus<4> , data_bus[4] );
    tran( \data_bus<3> , data_bus[3] );
    tran( \data_bus<2> , data_bus[2] );
    tran( \data_bus<1> , data_bus[1] );
    tran( \data_bus<0> , data_bus[0] );
    latch_2 latch3 ( .in({\ip<15> , \ip<14> , \ip<13> , \ip<12> , \ip<11> , 
        \ip<10> , \ip<9> , \ip<8> , \ip<7> , \ip<6> , \ip<5> , \ip<4> , 
        \ip<3> , \ip<2> , \ip<1> , \ip<0> }), .out({\ir_bus<15> , \ir_bus<14> , 
        \ir_bus<13> , \ir_bus<12> , \ir_bus<11> , \ir_bus<10> , \ir_bus<9> , 
        \ir_bus<8> , \ir_bus<7> , \ir_bus<6> , \ir_bus<5> , \ir_bus<4> , 
        \ir_bus<3> , \ir_bus<2> , \ir_bus<1> , \ir_bus<0> }), .enableh(ir2_en)
         );
    mux2x1 mux1 ( .in0({\imm<15> , \imm<14> , \imm<13> , \imm<12> , \imm<11> , 
        \imm<10> , \imm<9> , \imm<8> , \imm<7> , \imm<6> , \imm<5> , \imm<4> , 
        \imm<3> , \imm<2> , \imm<1> , \imm<0> }), .in1({\rega<15> , \rega<14> , 
        \rega<13> , \rega<12> , \rega<11> , \rega<10> , \rega<9> , \rega<8> , 
        \rega<7> , \rega<6> , \rega<5> , \rega<4> , \rega<3> , \rega<2> , 
        \rega<1> , \rega<0> }), .out({\alu_a<15> , \alu_a<14> , \alu_a<13> , 
        \alu_a<12> , \alu_a<11> , \alu_a<10> , \alu_a<9> , \alu_a<8> , 
        \alu_a<7> , \alu_a<6> , \alu_a<5> , \alu_a<4> , \alu_a<3> , \alu_a<2> , 
        \alu_a<1> , \alu_a<0> }), .select(sel_imm_rega) );
    regstore regstore1 ( .regwr({\ip<15> , \ip<14> , \ip<13> , \ip<12> , 
        \ip<11> , \ip<10> , \ip<9> , \ip<8> , \ip<7> , \ip<6> , \ip<5> , 
        \ip<4> , \ip<3> , \ip<2> , \ip<1> , \ip<0> }), .rega({\rega<15> , 
        \rega<14> , \rega<13> , \rega<12> , \rega<11> , \rega<10> , \rega<9> , 
        \rega<8> , \rega<7> , \rega<6> , \rega<5> , \rega<4> , \rega<3> , 
        \rega<2> , \rega<1> , \rega<0> }), .regb({\regb<15> , \regb<14> , 
        \regb<13> , \regb<12> , \regb<11> , \regb<10> , \regb<9> , \regb<8> , 
        \regb<7> , \regb<6> , \regb<5> , \regb<4> , \regb<3> , \regb<2> , 
        \regb<1> , \regb<0> }), .wr_addr({\wr_addr<3> , \wr_addr<2> , 
        \wr_addr<1> , \wr_addr<0> }), .a_addr({\a_addr<3> , \a_addr<2> , 
        \a_addr<1> , \a_addr<0> }), .b_addr({\b_addr<3> , \b_addr<2> , 
        \b_addr<1> , \b_addr<0> }), .wr_clk(wr_clk), .clk(n194), 
        .regstore_reset(regstore_reset), .alu_flags2({\alu_flags2<15> , 
        \alu_flags2<14> , \alu_flags2<13> , \alu_flags2<12> , \alu_flags2<11> , 
        \alu_flags2<10> , \alu_flags2<9> , \alu_flags2<8> , \alu_flags2<7> , 
        \alu_flags2<6> , \alu_flags2<5> , \alu_flags2<4> , \alu_flags2<3> , 
        \alu_flags2<2> , \alu_flags2<1> , \alu_flags2<0> }) );
    control_unit control1 ( .clk(n194), .reset(n195), .ir_bus({\ir_bus<15> , 
        \ir_bus<14> , \ir_bus<13> , \ir_bus<12> , \ir_bus<11> , \ir_bus<10> , 
        \ir_bus<9> , \ir_bus<8> , \ir_bus<7> , \ir_bus<6> , \ir_bus<5> , 
        \ir_bus<4> , \ir_bus<3> , \ir_bus<2> , \ir_bus<1> , \ir_bus<0> }), 
        .imm_bus({\imm<15> , \imm<14> , \imm<13> , \imm<12> , \imm<11> , 
        \imm<10> , \imm<9> , \imm<8> , \imm<7> , \imm<6> , \imm<5> , \imm<4> , 
        \imm<3> , \imm<2> , \imm<1> , \imm<0> }), .sel_fl_alu(sel_fl_alu), 
        .alu_flags2({\alu_flags2<15> , \alu_flags2<14> , \alu_flags2<13> , 
        \alu_flags2<12> , \alu_flags2<11> , \alu_flags2<10> , \alu_flags2<9> , 
        \alu_flags2<8> , \alu_flags2<7> , \alu_flags2<6> , \alu_flags2<5> , 
        \alu_flags2<4> , \alu_flags2<3> , \alu_flags2<2> , \alu_flags2<1> , 
        \alu_flags2<0> }), .ext_wr(ext_wr), .ext_rd(ext_rd), .ext_iom(iom), 
        .io_en(io_en), .io_dir(io_dir), .alu_to_mem(alu_to_mem), .ir_en(ir_en), 
        .ir2_en(ir2_en), .wr_addr({\wr_addr<3> , \wr_addr<2> , \wr_addr<1> , 
        \wr_addr<0> }), .a_addr({\a_addr<3> , \a_addr<2> , \a_addr<1> , 
        \a_addr<0> }), .intr(intr), .b_addr({\b_addr<3> , \b_addr<2> , 
        \b_addr<1> , \b_addr<0> }), .wr_clk(wr_clk), .alu_control({
        \alu_control<2> , \alu_control<1> , \alu_control<0> }), .addr_en(
        addr_en), .sel_imm_rega(sel_imm_rega), .regstore_reset(regstore_reset), 
        .inta(inta), .iflag(iflag), .signedflag(signedflag) );
    tranceiver_1 trans2 ( .port1({\data_buf<15> , \data_buf<14> , 
        \data_buf<13> , \data_buf<12> , \data_buf<11> , \data_buf<10> , 
        \data_buf<9> , \data_buf<8> , \data_buf<7> , \data_buf<6> , 
        \data_buf<5> , \data_buf<4> , \data_buf<3> , \data_buf<2> , 
        \data_buf<1> , \data_buf<0> }), .port2({\ip<15> , \ip<14> , \ip<13> , 
        \ip<12> , \ip<11> , \ip<10> , \ip<9> , \ip<8> , \ip<7> , \ip<6> , 
        \ip<5> , \ip<4> , \ip<3> , \ip<2> , \ip<1> , \ip<0> }), .io_en(io_en), 
        .io_dir(io_dir) );
    latch_1 latch2 ( .in({\ip<15> , \ip<14> , \ip<13> , \ip<12> , \ip<11> , 
        \ip<10> , \ip<9> , \ip<8> , \ip<7> , \ip<6> , \ip<5> , \ip<4> , 
        \ip<3> , \ip<2> , \ip<1> , \ip<0> }), .out({\imm<15> , \imm<14> , 
        \imm<13> , \imm<12> , \imm<11> , \imm<10> , \imm<9> , \imm<8> , 
        \imm<7> , \imm<6> , \imm<5> , \imm<4> , \imm<3> , \imm<2> , \imm<1> , 
        \imm<0> }), .enableh(ir_en) );
    alu alu1 ( .alu_a({\alu_a<15> , \alu_a<14> , \alu_a<13> , \alu_a<12> , 
        \alu_a<11> , \alu_a<10> , \alu_a<9> , \alu_a<8> , \alu_a<7> , 
        \alu_a<6> , \alu_a<5> , \alu_a<4> , \alu_a<3> , \alu_a<2> , \alu_a<1> , 
        \alu_a<0> }), .alu_b({\regb<15> , \regb<14> , \regb<13> , \regb<12> , 
        \regb<11> , \regb<10> , \regb<9> , \regb<8> , \regb<7> , \regb<6> , 
        \regb<5> , \regb<4> , \regb<3> , \regb<2> , \regb<1> , \regb<0> }), 
        .alu_out({\alu_out<15> , \alu_out<14> , \alu_out<13> , \alu_out<12> , 
        \alu_out<11> , \alu_out<10> , \alu_out<9> , \alu_out<8> , \alu_out<7> , 
        \alu_out<6> , \alu_out<5> , \alu_out<4> , \alu_out<3> , \alu_out<2> , 
        \alu_out<1> , \alu_out<0> }), .alu_control({\alu_control<2> , 
        \alu_control<1> , \alu_control<0> }), .alu_flags({\alu_flags<4> , 
        \alu_flags<3> , \alu_flags<2> , \alu_flags<1> , \alu_flags<0> }), 
        .signedflag(signedflag) );
    tristate tristate1 ( .in({\transfer_bus<15> , \transfer_bus<14> , 
        \transfer_bus<13> , \transfer_bus<12> , \transfer_bus<11> , 
        \transfer_bus<10> , \transfer_bus<9> , \transfer_bus<8> , 
        \transfer_bus<7> , \transfer_bus<6> , \transfer_bus<5> , 
        \transfer_bus<4> , \transfer_bus<3> , \transfer_bus<2> , 
        \transfer_bus<1> , \transfer_bus<0> }), .out({\ip<15> , \ip<14> , 
        \ip<13> , \ip<12> , \ip<11> , \ip<10> , \ip<9> , \ip<8> , \ip<7> , 
        \ip<6> , \ip<5> , \ip<4> , \ip<3> , \ip<2> , \ip<1> , \ip<0> }), 
        .enable(sel_tri) );
    display display1 ( .sce12(n524), .sce34(sce34), .swr(swr), .sa({n525, n526
        }), .sd(sd), .bus0({n496, n497, n498, n499, n500, n501, n502, n504, 
        n514, n515, n516, n517, n518, n519, n520, n521}), .bus1({
        \data_buf<15> , \data_buf<14> , \data_buf<13> , \data_buf<12> , 
        \data_buf<11> , \data_buf<10> , \data_buf<9> , \data_buf<8> , 
        \data_buf<7> , \data_buf<6> , \data_buf<5> , \data_buf<4> , 
        \data_buf<3> , \data_buf<2> , \data_buf<1> , \data_buf<0> }), .bus2({
        \alu_out<15> , \alu_out<14> , \alu_out<13> , \alu_out<12> , 
        \alu_out<11> , \alu_out<10> , \alu_out<9> , \alu_out<8> , \alu_out<7> , 
        \alu_out<6> , \alu_out<5> , \alu_out<4> , \alu_out<3> , \alu_out<2> , 
        \alu_out<1> , \alu_out<0> }), .bus3({\imm<15> , \imm<14> , \imm<13> , 
        \imm<12> , \imm<11> , \imm<10> , \imm<9> , \imm<8> , \imm<7> , 
        \imm<6> , \imm<5> , \imm<4> , \imm<3> , \imm<2> , \imm<1> , \imm<0> }), 
        .clk(n197), .bus_select(n196) );
    latch_0 latch1 ( .in({\alu_out<15> , \alu_out<14> , \alu_out<13> , 
        \alu_out<12> , \alu_out<11> , \alu_out<10> , \alu_out<9> , 
        \alu_out<8> , \alu_out<7> , \alu_out<6> , \alu_out<5> , \alu_out<4> , 
        \alu_out<3> , \alu_out<2> , \alu_out<1> , \alu_out<0> }), .out({n496, 
        n497, n498, n499, n500, n501, n502, n504, n514, n515, n516, n517, n518, 
        n519, n520, n521}), .enableh(addr_en) );
    tranceiver_0 trans1 ( .port1({\data_bus<15> , \data_bus<14> , 
        \data_bus<13> , \data_bus<12> , \data_bus<11> , \data_bus<10> , 
        \data_bus<9> , \data_bus<8> , \data_bus<7> , \data_bus<6> , 
        \data_bus<5> , \data_bus<4> , \data_bus<3> , \data_bus<2> , 
        \data_bus<1> , \data_bus<0> }), .port2({\data_buf<15> , \data_buf<14> , 
        \data_buf<13> , \data_buf<12> , \data_buf<11> , \data_buf<10> , 
        \data_buf<9> , \data_buf<8> , \data_buf<7> , \data_buf<6> , 
        \data_buf<5> , \data_buf<4> , \data_buf<3> , \data_buf<2> , 
        \data_buf<1> , \data_buf<0> }), .io_en(io_en), .io_dir(io_dir1) );
    flagmuxer flagmux1 ( .in0({\alu_flags<4> , \alu_flags<3> , \alu_flags<2> , 
        \alu_flags<1> , \alu_flags<0> }), .in1({\alu_out<15> , \alu_out<14> , 
        \alu_out<13> , \alu_out<12> , \alu_out<11> , \alu_out<10> , 
        \alu_out<9> , \alu_out<8> , \alu_out<7> , \alu_out<6> , \alu_out<5> , 
        \alu_out<4> , \alu_out<3> , \alu_out<2> , \alu_out<1> , \alu_out<0> }), 
        .out({\transfer_bus<15> , \transfer_bus<14> , \transfer_bus<13> , 
        \transfer_bus<12> , \transfer_bus<11> , \transfer_bus<10> , 
        \transfer_bus<9> , \transfer_bus<8> , \transfer_bus<7> , 
        \transfer_bus<6> , \transfer_bus<5> , \transfer_bus<4> , 
        \transfer_bus<3> , \transfer_bus<2> , \transfer_bus<1> , 
        \transfer_bus<0> }), .select(sel_fl_alu), .iflag(iflag) );
    OBUF_S U135 ( .O(address_bus[15]), .I(n496) );
    OBUF_S U136 ( .O(address_bus[14]), .I(n497) );
    OBUF_S U137 ( .O(address_bus[13]), .I(n498) );
    OBUF_S U138 ( .O(address_bus[12]), .I(n499) );
    OBUF_S U139 ( .O(address_bus[11]), .I(n500) );
    OBUF_S U140 ( .O(address_bus[10]), .I(n501) );
    OBUF_S U141 ( .O(address_bus[9]), .I(n502) );
    OBUF_S U142 ( .O(address_bus[8]), .I(n504) );
    OBUF_S U143 ( .O(address_bus[7]), .I(n514) );
    OBUF_S U144 ( .O(address_bus[6]), .I(n515) );
    OBUF_S U145 ( .O(address_bus[5]), .I(n516) );
    OBUF_S U146 ( .O(address_bus[4]), .I(n517) );
    OBUF_S U147 ( .O(address_bus[3]), .I(n518) );
    OBUF_S U148 ( .O(address_bus[2]), .I(n519) );
    OBUF_S U149 ( .O(address_bus[1]), .I(n520) );
    OBUF_S U150 ( .O(address_bus[0]), .I(n521) );
    OBUF_S U151 ( .O(wr), .I(n522) );
    OBUF_S U152 ( .O(rd), .I(n523) );
    OBUF_S U153 ( .O(sal), .I(1'b1) );
    OBUF_S U154 ( .O(sce12), .I(n524) );
    OBUF_S U155 ( .O(scue), .I(n480) );
    INV U156 ( .O(n480), .I(1'b1) );
    OBUF_S U157 ( .O(scu), .I(1'b1) );
    OBUF_S U158 ( .O(sclr), .I(1'b1) );
    OBUF_S U159 ( .O(sa[1]), .I(n525) );
    OBUF_S U160 ( .O(sa[0]), .I(n526) );
    IBUF U161 ( .O(n194), .I(clk) );
    IBUF U162 ( .O(n195), .I(reset) );
    IBUF U163 ( .O(n196), .I(bus_select) );
    IBUF U164 ( .O(n197), .I(disp_clk) );
    OBUF_S U165 ( .O(p24_dir), .I(1'b1) );
    OBUF_S U166 ( .O(p25_dir), .I(1'b0) );
    INV U167 ( .O(n491), .I(ext_wr) );
    NOR2 U168 ( .O(n522), .I1(ext_rd), .I0(n491) );
    AND2 U169 ( .O(io_dir1), .I1(io_dir), .I0(io_en) );
    NAND2 U170 ( .O(n493), .I1(io_dir), .I0(io_en) );
    INV U171 ( .O(n492), .I(ext_wr) );
    AND3 U172 ( .O(n523), .I2(ext_rd), .I1(n492), .I0(n493) );
    INV U173 ( .O(n494), .I(io_en) );
    OR2 U174 ( .O(n495), .I1(io_dir), .I0(n494) );
    AND2 U175 ( .O(sel_tri), .I1(n495), .I0(alu_to_mem) );
endmodule

