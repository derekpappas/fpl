#!/usr/bin/perl

my $base_dir = "$ENV{WORK}/trunk/scripts/release_test";
my $output = "$base_dir/check_output.tb";
my $gen_dir = "$base_dir/gen_dir";
my $pp_file = "$base_dir/preproc_file.tmp";
my $report_file = "$base_dir/report.tb";

my $test_root_dir = "$ENV{WORK}/test";

my $failed_tests = 0;
my $passed_tests = 0;
my $count_tests = 0;

our %systemErrorMap;

$systemErrorMap{"139"} = "Exit code 139: Segmentation fault";
$systemErrorMap{"9"}   = "Exit code 9: Ran out of CPU time.";
$systemErrorMap{"64"}  = "Exit code 64: The framework ended the job nicely for you, most likely because the job was running out of CPU time. But it means you did not go through all the data requested. The solution is to submit the job to a queue with more resources (bigger CPU time limit).";
$systemErrorMap{"125"} = "Exit code 125: An ErrMsg(severe) was reached in your job.";
$systemErrorMap{"127"} = "Exit code 127: Something wrong with the machine?";
$systemErrorMap{"130"} = "Exit code 130: The job ran out of CPU or swap time. If swap time is the culprit, check for memory leaks.";
$systemErrorMap{"131"} = "Exit code 131: The job ran out of CPU or swap time. If swap time is the culprit, check for memory leaks.";
$systemErrorMap{"134"} = "Exit code 134: The job is killed with an abort signal, and you probably got core dumped. Often this is caused either by an assert() or an ErrMsg(fatal) being hit in your job. There may be a run-time bug in your code. Use a debugger like gdb or dbx to find out what's wrong.";
$systemErrorMap{"137"} = "Exit code 137: The job was killed because it exceeded the time limit."; 
$systemErrorMap{"140"} = "Exit code 140: The job exceeded the \"wall clock\" time limit (as opposed to the CPU time limit).";

&main();

sub get_attr {
    if (@ARGV==0) {
        &help();
        exit;
    }
    else {
        return @ARGV[0];
    }
}

sub call {
    my ($file, $call) = @_;

    system("$call");
    my $exec_code = $? >> 8;
    my $check_exceptions = `grep -e "exception" -ni $output`;

    if (defined(@systemErrorMap{$exec_code})) {
        print "Command '$call' terminated with '@systemErrorMap{$exec_code}'\n";
        &fail($call);
    }
    elsif ($check_exceptions != "") {
        &fail($call);
    }
    else {
        my $check_errors = `grep -e "error" -ni $output`;

        if ($file =~ m/_invalid/) {
            if ($check_errors == "") {
                &fail($call);
            }
            else {
                $passed_tests++;
            }
        }
        else {
            if ($check_errors != "") {
                &fail($call);
            }
            else {
                $passed_tests++;
            }
        }
    }
    $count_tests++;
}

sub fail {
    my ($call) = @_;

    system("echo \"command: '$call'\" >> $report_file");

    $failed_tests++;
}

sub main {
    my $test_dir = &get_attr();
    system("echo > $report_file");
    system("echo \"Directory set to '$test_root_dir/$test_dir'\";echo");

    my $dir_list = `ls $test_root_dir/$test_dir`;
    my @dir_list = split(/\n/, $dir_list);
    chomp(@dir_list);

    foreach my $dir(@dir_list) {
        my $cf_file = `find $test_root_dir/$test_dir/$dir -name \"top.cf\" -print`;
        chomp($cf_file);
        if ($cf_file) {
            system("echo \"Found .cf file '$cf_file'\"");
            my $call = "cslc --cpp_gen --csim_gen --dir $gen_dir --csl_pp_filename $pp_file --f $cf_file &> $output";
            &call($cf_file, $call);
        }
        else {
            my $test_list = `find $test_root_dir/$test_dir/$dir -name \"*.csl\" -print`;
            my @test_list = split(/\n/, $test_list);
            chomp(@test_list);

            if (@test_list) {
                foreach my $test(@test_list) {
                    my $call = "cslc --cpp_gen --csim_gen --dir $gen_dir --csl_pp_filename $pp_file $test &> $output";
                    &call($test, $call);
                }
            }
        }
    }

    print "Total tests:       $count_tests\n";
    print "Failed tests:      $failed_tests\n";
    print "Passed tests:      $passed_tests\n";

    if ($count_tests > 0) {
        my $perc = $passed_tests / $count_tests * 100;
        print "Percentage passed: $perc\n";

        if ($perc < 100) {
            print "\nFAILED\n";
            print "Refer to '$report_file' for details on tests that failed\n";
        }
        else {
            print "\nPASSED\n";
        }
    }
}

sub help() {
    system("echo \"usage: release_test.pl TARGET\"");
    system("echo TARGET:");
    system("echo \"      any subdirs of '$test_root_dir'\"");
}
