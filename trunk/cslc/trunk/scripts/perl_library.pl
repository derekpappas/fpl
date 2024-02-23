#!/usr/bin/perl

# load_file: Open a file, read each line into an array, close the
#            file and return the array of lines.
##
sub load_file
{ 
  my ($file) = shift;
  my @file_contents;

  open(FILE, $file) or die "Unable to open file $file: $!\n";
  @file_contents = <FILE>;
  close FILE;

  return @file_contents;
} 

##  
# load_dir: Open a directory, read each entry into an array, close
#           the directory handle and return the array.
##
sub load_dir
{
  my ($dir) = shift;
  my @dir_contents;

  opendir(DIR, $dir) or die "Unable to open dir $dir: $!\n";
  @dir_contents = readdir(DIR);
  close(DIR);

  return @dir_contents;
}

##
# rsort: Sort then reverse an array.
##
sub rsort
{
  my (@contents) = @_;

  @contents = sort(@contents);

  return (reverse(@contents));
}

##
# atomic_chomp: Chomp every item on an array, return the array.
##
sub atomic_chomp
{
  my (@list2chomp) = @_;

  foreach(@list2chomp) {
    chomp($_);
  }

  return @list2chomp;
}

sub write_file
{
    my ( $f, @data ) = @_;
    @data = () unless @data;
    open F, "> $f" or die "Can't open $f : $!";
    print F @data;
    close F;
}

#sub open_write_file
#{
#    my $fileName = @_;
#    open(fileHandler, '>$fileName') or dor "Can't open for writing the file named: $fileName";
#}
