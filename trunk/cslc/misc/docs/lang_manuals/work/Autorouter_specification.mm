<map version="0.8.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1210695759862" ID="Freemind_Link_1085357287" MODIFIED="1210869557464" TEXT="Autorouter_specification">
<node CREATED="1210695806598" FOLDED="true" ID="_" MODIFIED="1210863829184" POSITION="right" TEXT="Types of connectivity objects">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210695851950" ID="Freemind_Link_149671933" MODIFIED="1210695854588" TEXT="Ports"/>
<node CREATED="1210695855999" ID="Freemind_Link_300818865" MODIFIED="1210695858557" TEXT="Interfaces"/>
<node CREATED="1210695859104" ID="Freemind_Link_1054669925" MODIFIED="1210695864529" TEXT="Signals"/>
<node CREATED="1210695864897" ID="Freemind_Link_1829878856" MODIFIED="1210695870339" TEXT="Signal groups"/>
<node CREATED="1210695871241" ID="Freemind_Link_781045635" MODIFIED="1210771618648" TEXT="Unit instances"/>
</node>
<node CREATED="1210775580478" ID="Freemind_Link_1441160772" MODIFIED="1210863797733" POSITION="right" TEXT="Connection Classification">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210775634244" FOLDED="true" ID="Freemind_Link_112525732" MODIFIED="1210863831542" TEXT="By specification">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210775666413" ID="Freemind_Link_1760028624" MODIFIED="1210863838083" TEXT="Explicit connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210776595781" ID="Freemind_Link_253948237" MODIFIED="1210863786816" TEXT="Explicit connections are the connections whose endpoints and connection paths are known at the beginning of the compilation phase.">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
<node CREATED="1210775681445" ID="Freemind_Link_1008095300" MODIFIED="1210863840214" TEXT="Implicit connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210776651289" ID="Freemind_Link_1559621006" MODIFIED="1210776739350" TEXT="Implicit connections are the connections whose endpoints and connection path are determine during autorouting phase based on all connection and autorouting specification existing in the csl code."/>
<node CREATED="1210862958473" ID="Freemind_Link_1208072860" MODIFIED="1210863122527" TEXT="Implicit connections correspond to connection by name, connection by pattern, connection by scope types of connections"/>
</node>
</node>
<node CREATED="1210777551342" FOLDED="true" ID="Freemind_Link_735119729" MODIFIED="1210863833167" TEXT="By structure">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210777556870" ID="Freemind_Link_1049377126" MODIFIED="1210863842499" TEXT="Simple connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210777729802" ID="Freemind_Link_37827506" MODIFIED="1210777770712" TEXT="Simple connections are connections between unstructured connectivity objects (ex. ports and signals)"/>
<node CREATED="1210779369643" ID="Freemind_Link_1811356332" MODIFIED="1210779386198" TEXT="Simple connections can be single or multi bit connections."/>
</node>
<node CREATED="1210777569894" ID="Freemind_Link_1460411270" MODIFIED="1210863844217" TEXT="Structured connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210777771990" ID="Freemind_Link_324706387" MODIFIED="1210777812112" TEXT="Structured connections are connections between structured connectivity objects (ex. interfaces and signal groups"/>
<node CREATED="1210778938653" ID="Freemind_Link_1253253004" MODIFIED="1210779234283" TEXT="Actual version. There are not allowed connections between structured and unstructured connectivity objects."/>
<node CREATED="1210778985072" ID="Freemind_Link_247899342" MODIFIED="1210779312227" TEXT="Future version. There are allowed connection between structured and unstructured connections if they match the number of signal bits and the flattened structured connectivity object and the unstructured one bitwise respect connection rules."/>
</node>
<node CREATED="1210777813855" ID="Freemind_Link_1716798141" MODIFIED="1210863845876" TEXT="Mixed connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210777821661" ID="Freemind_Link_1091796439" MODIFIED="1210777855725" TEXT="Mixed connections are connections that contain both simple and structured connections"/>
<node CREATED="1210777863342" ID="Freemind_Link_281471652" MODIFIED="1210777916975" TEXT="Mixed connections can be specified using the connect by scope method"/>
<node CREATED="1210779479742" ID="Freemind_Link_332573060" MODIFIED="1210779518408" TEXT="Future version: Mixed connection can be specified using concatenation of different connectivity objects"/>
</node>
</node>
<node CREATED="1210777979350" FOLDED="true" ID="Freemind_Link_291571083" MODIFIED="1210863834827" TEXT="By content">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210777992130" ID="Freemind_Link_1335643501" MODIFIED="1210869065323" TEXT="Homogeneous connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210778014427" ID="Freemind_Link_1165098999" MODIFIED="1210869091537" TEXT="Homogeneous connections are those connections whose end points are of the same connectivity object type. Ex. port to port, interface to interface, port to many ports"/>
</node>
<node CREATED="1210778005098" ID="Freemind_Link_1791361894" MODIFIED="1210869123963" TEXT="Heterogeneous connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210778055827" ID="Freemind_Link_1031553468" MODIFIED="1210869114425" TEXT="Heterogeneous connections are those connections whose endpoints are of different connectivity object type. Ex. port to signal, port to constant signal, port to expression, port to scope"/>
</node>
</node>
</node>
<node CREATED="1210695822263" ID="Freemind_Link_1334442522" MODIFIED="1210863801919" POSITION="right" TEXT="Types of connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210696080650" FOLDED="true" ID="Freemind_Link_1685118500" MODIFIED="1210863850844" TEXT="Formal to actual in instantiations">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210779660289" ID="Freemind_Link_1499832399" MODIFIED="1210779787790" TEXT="All the connect statements and connections identified by autorouter result in a formal to actual mapping in unit instantiations."/>
<node CREATED="1210779789337" ID="Freemind_Link_1426949468" MODIFIED="1210779941239" TEXT="The formal to actual mapping can contain only user defined or user defined and autorouter created connectivity objects"/>
</node>
<node CREATED="1210696100699" FOLDED="true" ID="Freemind_Link_1867792630" MODIFIED="1210863853958" TEXT="Connect statement">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210864020961" ID="Freemind_Link_1361168558" MODIFIED="1210864090564" TEXT="Explicit connect">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210863381831" ID="Freemind_Link_1642845479" MODIFIED="1210864053847" TEXT="Connectivity objects can have different names and must be at different hierarchy levels."/>
<node CREATED="1210863484205" ID="Freemind_Link_1476655632" MODIFIED="1210863526435" TEXT="The connection statement specifies both the start and the end points of the connection."/>
<node CREATED="1210863527396" ID="Freemind_Link_1355589813" MODIFIED="1210863622523" TEXT="The position of the two endpoints must be fully specified relative to the scope where the connection statement is specified by using HIDs."/>
</node>
<node CREATED="1210696114372" ID="Freemind_Link_118759120" MODIFIED="1210863943422" TEXT="Connect by name">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210863901526" ID="Freemind_Link_1453005109" MODIFIED="1210863922918" TEXT="Objects that are connected have the same name"/>
<node CREATED="1210863963784" ID="Freemind_Link_1142819240" MODIFIED="1210863967161" TEXT="Types">
<node CREATED="1210696201729" ID="Freemind_Link_1751184672" MODIFIED="1210696211021" TEXT="Connect by connectivity objects">
<node CREATED="1210696226709" ID="Freemind_Link_1510715649" MODIFIED="1210696241482" TEXT="One-to-one connection">
<node CREATED="1210778230500" ID="Freemind_Link_756584764" MODIFIED="1210780011223" TEXT="In a one-to-one connection there are only two end points."/>
<node CREATED="1210780013848" ID="Freemind_Link_1124146433" MODIFIED="1210780023134" TEXT="The connection statement results in a single connection path"/>
</node>
<node CREATED="1210696242820" ID="Freemind_Link_1556150048" MODIFIED="1210696255704" TEXT="One-to-many connection">
<node CREATED="1210778280086" ID="Freemind_Link_71122451" MODIFIED="1210780038081" TEXT="In a one-to-many connection there is one start point and multiple endpoints."/>
<node CREATED="1210780041556" ID="Freemind_Link_1008124068" MODIFIED="1210780043988" TEXT="The connection statement can result in a spanning tree connection or in multiple simple path connections."/>
</node>
</node>
<node CREATED="1210696211525" ID="Freemind_Link_480547866" MODIFIED="1210696222755" TEXT="Connect by scope">
<node CREATED="1210868087731" ID="Freemind_Link_591076912" MODIFIED="1210868134555" TEXT="The connectivity objects with same name in the two scopes will be connected"/>
<node CREATED="1210778437275" ID="Freemind_Link_489014070" MODIFIED="1210780183611" TEXT="A connect by scope statement can result in 0, 1 or more connections. The connections can be one-to-one or one-to-many."/>
<node CREATED="1210778570312" ID="Freemind_Link_807983688" MODIFIED="1210780265169" TEXT="The number of resulting connections and connection types depends on the connectivity objects existing in the two scopes that are connected and on their characteristics ."/>
</node>
</node>
</node>
<node CREATED="1210868189154" ID="Freemind_Link_1362368374" MODIFIED="1210868195758" TEXT="Connect by scope">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210868197146" ID="Freemind_Link_1246418205" MODIFIED="1210868223181" TEXT="The interfaces of the two scopes will be connected"/>
<node CREATED="1210868346502" ID="Freemind_Link_1759965198" MODIFIED="1210868611805" TEXT="The connection of the connectivity objects in the interfaces will be made based on their position in the interfaces"/>
<node CREATED="1210868624778" ID="Freemind_Link_300532969" MODIFIED="1210869147271" TEXT="In order to be successfully connected the connectivity objects on the same positions in the two interfaces must be compatible connectivity object pairs"/>
<node CREATED="1210868443188" ID="Freemind_Link_652463492" MODIFIED="1210868872502" TEXT="Future version: If the two interfaces can not be connected based on the position compatibility, the autorouter can try to determine a mapping between connectivity objects in the two scopes based on name, type, width, attributes etc."/>
</node>
<node CREATED="1210863989400" ID="Freemind_Link_110530897" MODIFIED="1210863997340" TEXT="Connect by pattern">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210696120705" ID="Freemind_Link_114968471" MODIFIED="1210864010148" TEXT="Are used to simplify connection specification using patterns. Connection commands using patterns are expanded by the CSL preprocessor resulting in a set of connections of the type described above."/>
</node>
</node>
</node>
<node CREATED="1210695828583" FOLDED="true" ID="Freemind_Link_1269659853" MODIFIED="1210863804353" POSITION="right" TEXT="Connection rules">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210864131451" ID="Freemind_Link_1002700149" MODIFIED="1210864196280" TEXT="Autorouter is creating connections from csl connect statements based on a set of rules."/>
<node CREATED="1210864260087" ID="Freemind_Link_780510599" MODIFIED="1210864307212" TEXT="The set of rules describe the valid and invalid cases that are generated from a csl specification"/>
<node CREATED="1210696280860" ID="Freemind_Link_1758097439" MODIFIED="1210696320007" TEXT="Connectivity object pairs">
<node CREATED="1210864339664" ID="Freemind_Link_1862147933" MODIFIED="1210864547609" TEXT="Each connection is made between two connectivity objects which is denoted as the connectivity object pair."/>
<node CREATED="1210864423432" ID="Freemind_Link_71153806" MODIFIED="1210864485427" TEXT="The CSL code can specify explicitely or implicitly one or more connections."/>
<node CREATED="1210864549121" ID="Freemind_Link_448904802" MODIFIED="1210869155156" TEXT="In order for a connection to be valid the connectivity object pair must satisfy a set of compatibility rules."/>
<node CREATED="1210864603839" ID="Freemind_Link_117326013" MODIFIED="1210864699887" TEXT="The set of compatibility rules for the connectivity object pair is given by the compatibility matrix in Figure x"/>
<node CREATED="1210864724771" ID="Freemind_Link_306262648" MODIFIED="1210864814740" TEXT="The compatibility matrix can be different for different CSLC versions. Newer versions can extend the set of compatible connectivity object pairs."/>
</node>
<node CREATED="1210696331354" ID="Freemind_Link_1846308203" MODIFIED="1210696386956" TEXT="Use of concatenation">
<node CREATED="1210864958538" ID="Freemind_Link_542810830" MODIFIED="1210865190641" TEXT="Concatenation can be used as the parameter of the  of the connect statement."/>
<node CREATED="1210865192378" ID="Freemind_Link_77358688" MODIFIED="1210865244223" TEXT="Concatenation can not be used as the scope of the connect statement"/>
<node CREATED="1210865245619" ID="Freemind_Link_1601475172" MODIFIED="1210865365164" TEXT="Concatenation can contain only connectivity objects whose size can be determined by evaluating the terms of the concatenation"/>
</node>
<node CREATED="1210696387310" ID="Freemind_Link_81182957" MODIFIED="1210696392364" TEXT="Use of constants"/>
<node CREATED="1210696392911" ID="Freemind_Link_1971734350" MODIFIED="1210696397242" TEXT="Use of expressions"/>
<node CREATED="1210775869611" ID="Freemind_Link_498287163" MODIFIED="1210775888204" TEXT="Use of lists"/>
</node>
<node CREATED="1210696443543" FOLDED="true" ID="Freemind_Link_1864563278" MODIFIED="1210863806035" POSITION="right" TEXT="Connection checks">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210696455045" ID="Freemind_Link_926975853" MODIFIED="1210697708859" TEXT="Valid endpoint pairs ">
<node CREATED="1211189933346" ID="Freemind_Link_249753625" MODIFIED="1211189955954" TEXT="The checker will verify that the endpoint pairs are compatible"/>
</node>
<node CREATED="1210696469937" ID="Freemind_Link_556883071" MODIFIED="1210696484341" TEXT="Width">
<node CREATED="1211189306207" ID="Freemind_Link_6129789" MODIFIED="1211189771153" TEXT="The checker will verify that along the connection paths all routing signal and ports have the same width"/>
</node>
<node CREATED="1210696486051" ID="Freemind_Link_153649815" MODIFIED="1210697724209" TEXT="Source-destination valid directions">
<node CREATED="1211189973928" ID="Freemind_Link_854082982" MODIFIED="1211190013236" TEXT="The checker will verify that endpoints have valid directions"/>
<node CREATED="1211190017180" ID="Freemind_Link_1371699699" MODIFIED="1211190048086" TEXT="If the endpoints are interfaces the verification is made on a port by port basis"/>
</node>
<node CREATED="1210696515525" ID="Freemind_Link_115079518" MODIFIED="1210696525252" TEXT="Intermediate port valid direction">
<node CREATED="1211189849888" ID="Freemind_Link_652254490" MODIFIED="1211189901513" TEXT="The checker will verify that along the connection paths the routing ports have the same direction as the connection path"/>
</node>
<node CREATED="1211189414162" ID="Freemind_Link_311612245" MODIFIED="1211189831211" TEXT="Valid structured connections">
<node CREATED="1211189438615" ID="Freemind_Link_366954775" MODIFIED="1211189751596" TEXT="The checker will verify that along the connection path all routing signal groups and interfaces have the same structure"/>
</node>
<node CREATED="1210696835280" ID="Freemind_Link_1030028951" MODIFIED="1210696843745" TEXT="Attributes">
<node CREATED="1211190063436" ID="Freemind_Link_511117249" MODIFIED="1211190089420" TEXT="The checker will verify that attributes are preserved along the connection path"/>
</node>
<node CREATED="1210698474013" ID="Freemind_Link_1520515063" MODIFIED="1210698541965" TEXT="Dangling connections"/>
<node CREATED="1210698602280" ID="Freemind_Link_1143462848" MODIFIED="1210698620573" TEXT="Multi driven connectivity objects">
<node CREATED="1211190104606" ID="Freemind_Link_1285529070" MODIFIED="1211190233808" TEXT="The checker will verify that the interconnect and autorouting steps do not result in connections that makes that one or more ports are multi driven"/>
</node>
<node CREATED="1210697100865" ID="Freemind_Link_1621601256" MODIFIED="1210697106602" TEXT="Modifiers">
<node CREATED="1210697108607" ID="Freemind_Link_1468881815" MODIFIED="1210697113014" TEXT="Parameter">
<node CREATED="1211190266388" ID="Freemind_Link_785623331" MODIFIED="1211190405744" TEXT="An object instantiated with different parameters can result in objects with connectivity objects having the same name but with different widths. Checker must identify these cases"/>
</node>
<node CREATED="1210697113496" ID="Freemind_Link_119343719" MODIFIED="1210697123285" TEXT="Prefixes and Suffixes">
<node CREATED="1211190443551" ID="Freemind_Link_1042511129" MODIFIED="1211190763659" TEXT="Setting prefixes and/or suffixes changes the Verilog generated names of connectivity objects specified in CSL code and of those routing objects created by the compiler in the autorouting step."/>
</node>
</node>
</node>
<node CREATED="1210695897939" FOLDED="true" ID="Freemind_Link_1566056572" MODIFIED="1210863808155" POSITION="right" TEXT="Hierarchies">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210695909203" ID="Freemind_Link_1604703732" MODIFIED="1210695927192" TEXT="Specifying hierarchies"/>
<node CREATED="1210695927674" ID="Freemind_Link_404316186" MODIFIED="1210695940316" TEXT="Hierarchy relationships">
<node CREATED="1210695941643" ID="Freemind_Link_197504186" MODIFIED="1210695953179" TEXT="Siblings"/>
<node CREATED="1210695953868" ID="Freemind_Link_538951840" MODIFIED="1210695977901" TEXT="Parent-Child"/>
<node CREATED="1210695979050" ID="Freemind_Link_1282276780" MODIFIED="1210695993042" TEXT="Ancestor-Offspring"/>
</node>
</node>
<node CREATED="1210697758889" FOLDED="true" ID="Freemind_Link_782060379" MODIFIED="1210863814877" POSITION="right" TEXT="Creating connections">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210696015007" ID="Freemind_Link_203084986" MODIFIED="1210697824347" TEXT="Routing connectivity objects">
<node CREATED="1210696554947" ID="Freemind_Link_1512502152" MODIFIED="1210697854739" TEXT="Routing Ports">
<node CREATED="1210776834193" ID="Freemind_Link_1637622048" MODIFIED="1210776937723" TEXT="Routing ports are the ports through which are routed connection paths by the autorouter. Routing ports can be specified by the user or are created by the autorouter in the autorouting phase"/>
<node CREATED="1211184450672" ID="Freemind_Link_644910974" MODIFIED="1211184994296" TEXT="For a unit that contains only leaf units there will be created at most the same number and types of ports as of the leaf units. These will be used to route the connections path to the leaf unit ports in the case the parent unit ports are not explicitely used to route these paths."/>
<node CREATED="1211186255909" ID="Freemind_Link_1258251899" MODIFIED="1211186588390" TEXT="For a unit that contains non leaf units there will be created at most the same number and types of ports as of the children units summed with the routing ports created for these units."/>
</node>
<node CREATED="1210696559751" ID="Freemind_Link_1055761015" MODIFIED="1210697849796" TEXT="Routing Interfaces">
<node CREATED="1210776941854" ID="Freemind_Link_427511794" MODIFIED="1210777029512" TEXT="Routing interfaces are the interfaces through which are routed the structured connection paths by the autorouter. Routing interfaces can be specified by the user or are created by the autorouter in the autorouting phase."/>
<node CREATED="1211185051687" ID="Freemind_Link_430924047" MODIFIED="1211185099080" TEXT="For a unit that contains only leaf units there will be created at most the same number and types of intrerfaces as of the leaf units. These will be used to route the connections path to the leaf unit interfaces in the case the parent unit interfaces are not explicitely used to route these paths."/>
<node CREATED="1211186658596" ID="Freemind_Link_1929984239" MODIFIED="1211186687392" TEXT="For a unit that contains non leaf units there will be created at most the same number and types of interfaces as of the children units summed with the routing interfaces created for these units."/>
</node>
<node CREATED="1210698126156" ID="Freemind_Link_847891875" MODIFIED="1210698131429" TEXT="Connection signals">
<node CREATED="1210777075427" ID="Freemind_Link_269415017" MODIFIED="1210777143918" TEXT="Connection signals are signal used to connect ports on the connection path. Connection signal are created by the autorouter."/>
</node>
<node CREATED="1210698131925" ID="Freemind_Link_1288063830" MODIFIED="1210698138158" TEXT="Connection signal groups">
<node CREATED="1210777150643" ID="Freemind_Link_1915772958" MODIFIED="1210777193517" TEXT="Connection signal groups are signal groups used to connect interfaces on the connection path. Connection signal groups are created by the autorouter."/>
</node>
</node>
<node CREATED="1210696057373" ID="Freemind_Link_1036922830" MODIFIED="1210696061472" TEXT="Connection paths">
<node CREATED="1210696640533" ID="Freemind_Link_757095401" MODIFIED="1210698034335" TEXT="Classification">
<node CREATED="1210696646006" ID="Freemind_Link_971473247" MODIFIED="1210698019932" TEXT="By structure">
<node CREATED="1210696580917" ID="Freemind_Link_856800803" MODIFIED="1210696585935" TEXT="Simple paths">
<node CREATED="1210777240672" ID="Freemind_Link_824678741" MODIFIED="1210777288719" TEXT="Simple path are formed by alternation of ports and signals"/>
<node CREATED="1210777297179" ID="Freemind_Link_444887430" MODIFIED="1210777335450" TEXT="Simple paths implement the one-to-one connections."/>
</node>
<node CREATED="1210696586739" ID="Freemind_Link_331688111" MODIFIED="1210696600309" TEXT="Spanning trees">
<node CREATED="1210777339483" ID="Freemind_Link_254149512" MODIFIED="1210777418875" TEXT="Spanning trees are connection structures that distribute a signal from a source to many destinations."/>
<node CREATED="1210777419966" ID="Freemind_Link_1413487625" MODIFIED="1210777437409" TEXT="Spanning trees implement the one-to-many connections"/>
</node>
<node CREATED="1210777222484" ID="Freemind_Link_1737297828" MODIFIED="1210777232670" TEXT="Structured paths">
<node CREATED="1210777442877" ID="Freemind_Link_797977084" MODIFIED="1210777467889" TEXT="Structured paths are formed by the alternation of interfaces and signal groups"/>
<node CREATED="1210777468977" ID="Freemind_Link_1433618902" MODIFIED="1210777495160" TEXT="Structured paths implement the one-to-one structured connection"/>
<node CREATED="1210777495763" ID="Freemind_Link_1601922147" MODIFIED="1210777549868" TEXT="Structured paths"/>
</node>
</node>
<node CREATED="1210696759442" ID="Freemind_Link_1743888975" MODIFIED="1210698123375" TEXT="By completion">
<node CREATED="1210696791370" ID="Freemind_Link_6112849" MODIFIED="1210696800037" TEXT="Complete"/>
<node CREATED="1210696800375" ID="Freemind_Link_1503786250" MODIFIED="1210696808418" TEXT="Partial"/>
</node>
</node>
<node CREATED="1210697869516" ID="Freemind_Link_1417566463" MODIFIED="1210697944586" TEXT="Autorouter generated connection signals"/>
<node CREATED="1211182985465" ID="Freemind_Link_89632600" MODIFIED="1211183038047" TEXT="Connection directions">
<node CREATED="1211186943904" ID="Freemind_Link_1872134594" MODIFIED="1211188401437" TEXT="1 output port - 1 input port: direction of all connections along the connection path are to ensure that signal flows from the output port to the input port"/>
<node CREATED="1211183134634" ID="Freemind_Link_208967673" MODIFIED="1211186998748" TEXT="1 output port - multiple input ports: direction of all connections along all connection paths is to ensure that signal flow from the output port to the input ports"/>
<node CREATED="1211183448690" ID="Freemind_Link_941808381" MODIFIED="1211188566881" TEXT="2 input ports: specific for parent to child or ancestor offspring connections. The direction will be from parent to child and from ancestor to offspring."/>
<node CREATED="1211183448690" ID="Freemind_Link_1852003341" MODIFIED="1211188543438" TEXT="2 output ports: specific for parent to child or ancestor offspring connections. The direction will be from child to parent and from offspring to ancestor."/>
<node CREATED="1211186943904" ID="Freemind_Link_520849620" MODIFIED="1211188994076" TEXT="1 output port - 1 signal: direction of all connections along the connection path are to ensure that if signal is in offspring signal flows from signal to the output and if the signal is in ancestor thne signal flows from the output to the signal"/>
<node CREATED="1211183040178" ID="Freemind_Link_851087311" MODIFIED="1211189079612" TEXT="1 output port - multiple signals: direction of all connections along the connection paths are to ensure that signal flows following the rules for 1 output port - 1 singnal "/>
<node CREATED="1211187153484" ID="Freemind_Link_1151503384" MODIFIED="1211189157022" TEXT="1 input port - 1 signal: direction of all connections along the connection path are to ensure that if signal is in offspring  then signal flows from the input port to signal and if signal in in ancestor then the signal flows from signal to the input port"/>
<node CREATED="1211187257612" ID="Freemind_Link_401175733" MODIFIED="1211187621681" TEXT="Directions of connections between interfaces or between interfaces and signal groups will be determined on a port by port basis using the rules for ports"/>
</node>
</node>
<node CREATED="1210697961677" ID="Freemind_Link_1175245184" MODIFIED="1210697967850" TEXT="Naming conventions">
<node CREATED="1211183987861" ID="Freemind_Link_1841274326" MODIFIED="1211188152391" TEXT="The name of the connections will contain start point connectivity object prefixed with the unit instance name, ports along the path and the end point connectivity object prefixed with the unit instance name."/>
</node>
<node CREATED="1210698418795" ID="Freemind_Link_1004219533" MODIFIED="1210698438583" TEXT="User named connections"/>
</node>
<node CREATED="1210697151214" FOLDED="true" ID="Freemind_Link_253992364" MODIFIED="1210863816614" POSITION="right" TEXT="Autorouter options">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210697164106" ID="Freemind_Link_1452630336" MODIFIED="1210697227297" TEXT="autorouter_on/autorouter_off"/>
<node CREATED="1210697173679" ID="Freemind_Link_982090255" MODIFIED="1210697206193" TEXT="connect_by_name"/>
</node>
<node CREATED="1210697274704" FOLDED="true" ID="Freemind_Link_1623214206" MODIFIED="1210863818632" POSITION="right" TEXT="Autorouter commands">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210697290857" ID="Freemind_Link_1017301502" MODIFIED="1210697295261" TEXT="connect"/>
<node CREATED="1210783882936" ID="Freemind_Link_596575171" MODIFIED="1210783910090" TEXT="set_auto_router"/>
<node CREATED="1210783915557" ID="Freemind_Link_357007076" MODIFIED="1210783971180" TEXT="auto_connect_filter">
<node CREATED="1210784009303" ID="Freemind_Link_1106166471" MODIFIED="1210784027815" TEXT="CSL_CONNECT BY_NAME"/>
<node CREATED="1210784028969" ID="Freemind_Link_295091456" MODIFIED="1210784107189" TEXT="CSL_CONNECT_PORTS_BY_NAME"/>
<node CREATED="1210784038230" ID="Freemind_Link_686768588" MODIFIED="1210784117965" TEXT="CSL_CONNECT_INTERFACES_BY_NAME"/>
<node CREATED="1210784048382" ID="Freemind_Link_1732971232" MODIFIED="1210784144445" TEXT="CSL_CONNECT_SIGNALS_BY_NAME"/>
<node CREATED="1210784057059" ID="Freemind_Link_915264585" MODIFIED="1210784081673" TEXT="CSL_CONNECT_FUNCTION"/>
<node CREATED="1210784150422" ID="Freemind_Link_230780868" MODIFIED="1210784159357" TEXT="VERILOG_CONNECT_BY_NAME"/>
<node CREATED="1210784159970" ID="Freemind_Link_27705848" MODIFIED="1210784173691" TEXT="VERILOG_CONNECT_PORTS_BY_NAME"/>
<node CREATED="1210784174901" ID="Freemind_Link_357912266" MODIFIED="1210784181646" TEXT="ALL_CONNECT_BY_NAME"/>
<node CREATED="1210784182024" ID="Freemind_Link_436143181" MODIFIED="1210784192325" TEXT="CREATE_NEW_END_POINT_PORTS"/>
</node>
<node CREATED="1210783972978" ID="Freemind_Link_1102843696" MODIFIED="1210783999443" TEXT="autorouter_connect_bus_to_split_bus"/>
</node>
<node CREATED="1210698638178" FOLDED="true" ID="Freemind_Link_200472097" MODIFIED="1210863820582" POSITION="right" TEXT="Errors Warnings and Info messages">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210698666919" ID="Freemind_Link_892801744" MODIFIED="1210698694496" TEXT="Error messages"/>
<node CREATED="1210698670521" ID="Freemind_Link_1686931940" MODIFIED="1210698700884" TEXT="Warning messages"/>
<node CREATED="1210698674443" ID="Freemind_Link_1453463530" MODIFIED="1210698683149" TEXT="Info messages"/>
</node>
<node CREATED="1210698739330" FOLDED="true" ID="Freemind_Link_1907988179" MODIFIED="1210863822519" POSITION="right" TEXT="Reports">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210698751408" ID="Freemind_Link_515785478" MODIFIED="1210783720034" TEXT="Autorouter result statistics">
<node CREATED="1210698761006" ID="Freemind_Link_593065496" MODIFIED="1210698804756" TEXT="Connectivity objects">
<node CREATED="1210783397936" ID="Freemind_Link_1131214431" MODIFIED="1210783407261" TEXT="List of user defined ports"/>
<node CREATED="1210698821400" ID="Freemind_Link_317699690" MODIFIED="1210698827725" TEXT="Created ports">
<node CREATED="1210782993786" ID="Freemind_Link_656970164" MODIFIED="1210783050161" TEXT="List of connected ports"/>
<node CREATED="1210783133664" ID="Freemind_Link_967389522" MODIFIED="1210783140262" TEXT="List of created ports"/>
<node CREATED="1210783035962" ID="Freemind_Link_1616559787" MODIFIED="1210783093688" TEXT="List of connected ports by type: formal to actual, by connect statement"/>
<node CREATED="1210783222315" ID="Freemind_Link_1101099524" MODIFIED="1210783231291" TEXT="List of unconnected ports"/>
</node>
<node CREATED="1210698829175" ID="Freemind_Link_1758301813" MODIFIED="1210698833424" TEXT="Created signals">
<node CREATED="1210783160470" ID="Freemind_Link_125440387" MODIFIED="1210783166414" TEXT="List of connected signals"/>
<node CREATED="1210783168385" ID="Freemind_Link_1721781236" MODIFIED="1210783173168" TEXT="List of created signals"/>
<node CREATED="1210783173706" ID="Freemind_Link_1372710536" MODIFIED="1210783198694" TEXT="List of connected signals by type: formal to actual, by connect statement"/>
<node CREATED="1210783232294" ID="Freemind_Link_364842612" MODIFIED="1210783239945" TEXT="List of unconnected signals"/>
</node>
<node CREATED="1210698834230" ID="Freemind_Link_510974403" MODIFIED="1210698837622" TEXT="Created interfaces">
<node CREATED="1210782993786" ID="Freemind_Link_1708982392" MODIFIED="1210783275077" TEXT="List of connected interfaces"/>
<node CREATED="1210783133664" ID="Freemind_Link_611876948" MODIFIED="1210783283106" TEXT="List of created interfaces"/>
<node CREATED="1210783035962" ID="Freemind_Link_1114683752" MODIFIED="1210783293206" TEXT="List of connected interfaces by type: formal to actual, by connect statement"/>
<node CREATED="1210783222315" ID="Freemind_Link_1766247015" MODIFIED="1210783307194" TEXT="List of unconnected interfaces and interface ports"/>
</node>
<node CREATED="1210698838146" ID="Freemind_Link_307888640" MODIFIED="1210698844300" TEXT="Created signal groups">
<node CREATED="1210783160470" ID="Freemind_Link_1416519815" MODIFIED="1210783334393" TEXT="List of connected signal groups"/>
<node CREATED="1210783168385" ID="Freemind_Link_109834039" MODIFIED="1210783341909" TEXT="List of created signal groups"/>
<node CREATED="1210783173706" ID="Freemind_Link_726619494" MODIFIED="1210783351456" TEXT="List of connected signal groups by type: formal to actual, by connect statement"/>
<node CREATED="1210783232294" ID="Freemind_Link_232923670" MODIFIED="1210783366078" TEXT="List of unconnected signal groups, and signal group signals"/>
</node>
</node>
<node CREATED="1210698771679" ID="Freemind_Link_1728093174" MODIFIED="1210698793114" TEXT="Created connections">
<node CREATED="1210783563776" ID="Freemind_Link_169823598" MODIFIED="1210783577080" TEXT="Formal to actual connections">
<node CREATED="1210783094526" ID="Freemind_Link_498531581" MODIFIED="1210783116266" TEXT="Connection table"/>
</node>
<node CREATED="1210783577558" ID="Freemind_Link_694461737" MODIFIED="1210783596271" TEXT="Connections by connect command">
<node CREATED="1210783199804" ID="Freemind_Link_481406617" MODIFIED="1210783211083" TEXT="Connection table"/>
<node CREATED="1210783670685" ID="Freemind_Link_1877682899" MODIFIED="1210783677223" TEXT="Connection paths"/>
</node>
<node CREATED="1210783597007" ID="Freemind_Link_700296080" MODIFIED="1210783611949" TEXT="Connections by autorouter">
<node CREATED="1210783094526" ID="Freemind_Link_216123024" MODIFIED="1210783116266" TEXT="Connection table"/>
<node CREATED="1210783678214" ID="Freemind_Link_820927195" MODIFIED="1210783682633" TEXT="Connection paths"/>
</node>
</node>
</node>
<node CREATED="1210698881572" ID="Freemind_Link_229221599" MODIFIED="1210783740541" TEXT="Autorouting execution statistics">
<node CREATED="1210783745545" ID="Freemind_Link_469169523" MODIFIED="1210783749626" TEXT="Execution time"/>
<node CREATED="1210783750732" ID="Freemind_Link_776013535" MODIFIED="1210783759999" TEXT="Memory usage"/>
<node CREATED="1210783760499" ID="Freemind_Link_1974563220" MODIFIED="1210783765371" TEXT="Processor usage"/>
</node>
</node>
<node CREATED="1210698894267" ID="Freemind_Link_695399222" MODIFIED="1210863824147" POSITION="right" TEXT="Optimizations">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1210697240593" FOLDED="true" ID="Freemind_Link_82593901" MODIFIED="1210863825709" POSITION="right" TEXT="Examples">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
<node CREATED="1210698352467" ID="Freemind_Link_813321152" MODIFIED="1210698362691" TEXT="Valid">
<node CREATED="1210698339550" ID="Freemind_Link_1743954661" MODIFIED="1210698344411" TEXT="CSL code"/>
<node CREATED="1210698344863" ID="Freemind_Link_735277847" MODIFIED="1210698349137" TEXT="Verilog code"/>
</node>
<node CREATED="1210698363104" ID="Freemind_Link_1702282979" MODIFIED="1210698365836" TEXT="Invalid">
<node CREATED="1210698381818" ID="Freemind_Link_1781308792" MODIFIED="1210698387284" TEXT="CSL code"/>
<node CREATED="1210698387636" ID="Freemind_Link_750684839" MODIFIED="1210698391380" TEXT="Verilog code"/>
</node>
</node>
<node CREATED="1211182791427" FOLDED="true" ID="Freemind_Link_481919345" MODIFIED="1211182804989" POSITION="right" TEXT="Problems">
<node CREATED="1211182807688" ID="Freemind_Link_26734823" MODIFIED="1211190934805" TEXT="Mixture specifications for connections: formal to actual, explicit and implict connections made by autorouter. How user is going to manage this mixture to be sure he has specified all connections, these are correct, there are no duplicates etc"/>
<node CREATED="1211182874019" ID="Freemind_Link_1034599507" MODIFIED="1211182930492" TEXT="Unconnected connectivity objects">
<node CREATED="1211182936597" ID="Freemind_Link_871143434" MODIFIED="1211190807667" TEXT="What happens with unconncted objects"/>
<node CREATED="1211182948922" ID="Freemind_Link_739166399" MODIFIED="1211182961880" TEXT="What messages are issued by the compiler"/>
</node>
</node>
</node>
</map>
