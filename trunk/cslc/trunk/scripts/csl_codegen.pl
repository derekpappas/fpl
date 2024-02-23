#!/usr/bin/perl
#use File::Path;
#author AndreiB
#modified for CSL by Catalin Lipsa

#globals follow
#directory where the source files (.g) are
$ARGV[0] =~ m/(\.\/)(.*)/g;
#print $1;
print $2;
#$test_dir = $2;
$test_dir = $ARGV[0];

chop($test_dir);
#working directory
$clean_dir = ".";
#path for the Lang Generator binary
$langgen_path = "LangGenerator.jar";
#index
$index=0;
#check
$checker=0;

#script working sequence
unless ( @ARGV == 2 )
  { die ("Run this script with two arguments: ./csl_codegen.pl <gramar_directory> <csl_code_directory> \n \n E.g.:    ./csl_codegen.pl ./source_g/ ./interconnect/ \n \n");
}else{
&Reader;
&Executer;
&Eraser;
&Checker;
}

#script functions definitions
sub Reader {

  #this function reads the sources directory and stores all .g files in a list
  my $DIR;
  opendir($DIR, "$test_dir");
  @grammars = grep { /(.g)/ } readdir($DIR);
  closedir($DIR);
  
  $index = @grammars;
  print "Number of grammar files found is ".$index."\n";
  #for(my $i=0;$i<$index;$i++){
  #    print "Element is ".@grammars[$i]."\n";
  #}
  
}
sub Executer {

  #this function performs the main operations of the script: directory creation, lang generator, source generator, files copying
  
  #iterate through the list and perform various operations
  for(my $i=0;$i<$index;$i++)
   {
    
    #this variable stores the name of the output file from the .g files. Note: follow naming convention
    $temp=@grammars[$i];
    
    #chop it 2 times to get rid of the extension and dot, but keep the iterator
    chop($temp);
    chop($temp);
    
    #this variable stores the name of the output directory
    $temp2 = $temp;
    
    #chop it one time to get rid of the iterator and keep the same dir for the same rule files but with different iterators
    #chop($temp2);
    #additional test in case the rule has an iterator >9 (eg. 10). In such a case the extra digit is also removed.
    if ($temp2 =~ /[0-9]/){
	chop($temp2);
	}
   
    #read directory again an check against $temp2 - if directory doesn't exist, create it
    my $DIR;
    opendir($DIR, ".");
    @existing_items = grep { /(^$temp2$)/ } readdir($DIR);
    closedir($DIR);

    $csl_dir=$ARGV[1];
    chop($csl_dir);
    if (@existing_items[0] eq $csl_dir){
        
        #sleep - doesn't do anything
        print "Directory already exists\n";
      }
      else {
        
        #create the directory for this rule
        print "Making directory ".$csl_dir."\n";
        system ("mkdir $csl_dir");
      }

    
    $csl_file_path = $temp2."/".$temp.".csl";
    $grammar_file_path = $test_dir."/".@grammars[$i];
    
    #these are the command passed to the OS to call the lang generator and the .csl generator
    $input_command1="java -jar ".$langgen_path." ".$test_dir."/".@grammars[$i]." 3 2 -range -1 >> lang.log 2>&1";
    $input_command2="\./filecut.pl ".$temp." ".$test_dir."/".$temp."\.csl";


			     if (-e $csl_file_path){
    
      #concatenated date for the csl file
      $vcmd = "ls --full-time $csl_file_path";
      $vcmd_output = `$vcmd`;

      $vdate = $vcmd_output =~ /.*([\d]{4})\-([\d]{2})\-([\d]{2})[\s]+([\d]{2})\:([\d]{2})\:([\d]{2})/g;

      $vyear = $1;
      $vmonth = $2;
      $vday = $3;
      $vhour = $4;
      $vminute = $5;
      $vsecond = $6;

      $vconcat = $vyear.$vmonth.$vday.$vhour.$vminute.$vsecond;

      #concatenated date for the grammar file
      $gcmd = "ls --full-time $grammar_file_path";
      $gcmd_output = `$gcmd`;

      $gdate = $gcmd_output =~ /.*([\d]{4})\-([\d]{2})\-([\d]{2})[\s]+([\d]{2})\:([\d]{2})\:([\d]{2})/g;

      $gyear = $1;
      $gmonth = $2;
      $gday = $3;
      $ghour = $4;
      $gminute = $5;
      $gsecond = $6;

      $gconcat = $gyear.$gmonth.$gday.$ghour.$gminute.$gsecond;
    
      $decision_maker = $vconcat - $gconcat;
      if($decision_maker > 0){
        print "No need to create this file. Next one?\n";
        $checker=$checker+1;
        }
        else {
        ################## Test file generation ##################
        #actual commands
        
        print $input_command1." \n";
        exit;
        system ("$input_command1");
        print $input_command2." \n";
        system ("$input_command2");
      

        #saving .csl files to the corresponding directory
        #$essential_file = $temp."\.csl";
        #print "Moving .csl files to ".$temp2." directory\n";
        $pattern=$temp2."*.csl";
        $total_filles = `ls $pattern | wc -l`;       
        for($file_no=0;$file_no<$total_files;$file_no++){
	          $essential_file=$temp2.$file_no.".csl";
            print "Moving ".$essential_file." \n";
            system ("mv $essential_file $temp2");
        }
        $checker=$checker+1;
        ##################/Test file generation ##################
        }

     }     
  else {
    ################## Test file generation ##################
    #actual commands
      
    print $input_command1." \n";
    system ("$input_command1");
    print $input_command2." \n";
    system ("$input_command2");

    #saving .csl files to the corresponding directory
    #$essential_file = $temp."\.csl";
    #print "Moving .csl files to ".$temp2." directory\n";
    $pattern=$temp2."*.csl";
    print "pattern =".$pattern." \n";
    $total_files = `ls $pattern | wc -l`;
    print "Am gasit ".$total_files." fisiere! \n";       
    for($file_no=0;$file_no<$total_files;$file_no++){
         $essential_file=$temp2.$file_no.".csl";
         print "Moving ".$essential_file." to ".$csl_dir." \n";
         system ("mv $essential_file $csl_dir");
       }
    $checker=$checker+1;
    ##################/Test file generation ##################
      }
    }
  }

sub Eraser {

  #this function performs the cleanup operation deleting all files that don't have a dot (generated by lang gen), in the working directory
  my $DIR;
  opendir($DIR, "$clean_dir");
  @clean_list = grep { !/(\.)/ } readdir($DIR);
  closedir($DIR);
  $eraser_index = @clean_list;
  print "Number of suspects ".$eraser_index."\n";
  $k=0;

  #iterate through the list and check if the items are files or directories (suspects). Leave directories alone (!=victims) 
  for(my $i=0;$i<$eraser_index;$i++)
    {
     if (!-d "@clean_list[$i]"){
      my $input_command="rm -f ".@clean_list[$i];
      system ("$input_command");
      $k++;
    }

  }
  print "Made a total of ".$k." victims\n";
}

sub Checker {
  
  #this function performs a check to ensure that all grammar files have been converted into .csl files
  if ($checker eq $index){
      print "The number of .csl files is equal with the number of sources. Done!\n";
    }
    else{
      print "ERROR: Not all sources have been converted! Look into it!\n";
    }
}


