#!/usr/bin/perl
use strict;
use warnings;
use feature ":5.10";

# global variables
# below is the sample space of words
my @sample_space = ("computer","radio","calculator","teacher","bureau","police","geometry","president","subject","country","enviroment","
classroom","animals","province","month","politics","puzzle","instrument","kitchen","language","
vampire","ghost","solution","service","software","virus25","security","phonenumber","expert","website","agreement","
support","compatibility","advanced","search","triathlon","immediately","encyclopedia","endurance","
distance","nature","history","organization","international","championship","government","popularity","
thousand","feature","wetsuit","fitness","legendary","variation","equal","approximately","segment","
priority","physics","branche","science","mathematics","lightning","dispersion","accelerator","detector","
terminology","design","operation","foundation","application","prediction","reference","measurement","
concept","perspective","overview","position","airplane","symmetry","dimension","toxic","algebra","illustration","
classic","verification","citation","unusual","resource","analysis","license","comedy","screenplay","
production","release","emphasis","director","trademark","vehicle","aircraft","experiment");

my @guesses = ();  # it is the array/list which store the guess 
my $done = 0; # it is check mark for completion of game
my $try = 0; #it is the totao number of wrong attemps made by user

&main(); # calling the main method , which is starting of game

sub main {

        my $random_word = @sample_space [int(rand(99)) - 1]; # choosing a random word using rand function
        my $size = length($random_word);  # it gives length of a random word

        print"The random word from given sample space is: " . $random_word . "\n";

        for (my $i=0; $i < $size; $i++) {   # initialising the guesses array with _
                $guesses [$i] = '_';
        }

        #while game is not completed

        while (!$done) {

                &Display();   #display the current diagram of hangman

                &CurrentState($size); # it shows the current state of game 

                print "\n\n\nEnter a character/letter : ";

                my $guess = lc(<STDIN>);  #taking input and convert it into lower case by using lc() function

                if($guess=~/^\s*$/)   #it checks if input is only white space then goto next iteration
                {
                    print("Please give valid input. Try Again\n");
                    next;
                }

                $guess=~ s/^\s+|\s+$//g; # it trims whitespace from both front and back of the text
                chomp($guess); # remove newline
                
                &letterChecker($random_word, $guess);  #it is for cheking letter , see below code for more explaination

                $done = &winChecker($random_word);   #winner detector , see below code for more explaination
        }

    &CurrentState($size);  # it shows the current state of game

    print "\n\nHurray , you Win!\n";
}

#it prints the current state of guesses list/array
sub CurrentState()
{
    my ($size) = @_;
    for(my $j=0 ; $j<$size ;$j++) {print ("$guesses[$j] ");}
}

#it displays the current postion of hangman
sub Display() {
    if($try == 0) {&Display1();}
    elsif ($try == 1) {&Display2();}
    elsif ($try == 2) {&Display3();}
    elsif ($try == 3) {&Display4();}
    elsif ($try == 4) {&Display5();}
    elsif ($try == 5) {&Display6();}
    elsif ($try == 6) {&Display7();}
}

# it checks the valid or invalid guess 
sub letterChecker {

    my ($random_word, $guess) = @_;
    my @chars = split("",$random_word);   #it splits the random_word to characters
    my $x=0;    # check for the guess which is not the part of random_word
    my $lindex =0; #index checking

    for (my $j=0; $j< length($random_word) ; $j++)
    {
        if($chars[$j] eq $guess){$x=1}; #if guess character matches any letter of random_word then x=1
    }

    if($x==0) {$lindex = -1};  # it implies guessesd letter dont matches any letter of random_word

    #if guessesd letter dont matches any letter of random_word

    if ($lindex == -1)
    {
        print "Wrong attempt !\n";
        $try++;  #increases the wrong attempt
    } 

    #if guessesd letter matches any letter of random_word

    else 
    {
            my $iletter;
            my @chars2 = split("", $random_word); #it splits the random_word to characters

            for(my $p=0 ; $p < length($random_word) ; $p++)
            {
                $iletter = $chars2[$p];
                if ($guess eq $guesses[$p])  # check for already existence of guessed letter
                 {
                    print "You already guessed $guess!, try other letter\n";
                 }
               if ($guess eq $iletter)
                 {
                   $guesses [$p] = $iletter;  # writing the guessed letter in guesses array
                 }
            }
    }
}

# it detects winning or loosing of game

sub winChecker {
    my ($random_word) = @_;
    my $letter;
    my @chars3 = split("" , $random_word); #it splits the random_word to characters

# below loop matches the guesses srray to random_word 

    for (my $i=0; $i< length($random_word); $i++) {
        $letter = $chars3[$i];

        if ($letter ne $guesses [$i]) {  # if not equals 
            return 0;
        }

    } 
    return 1;  # if all matches
}

sub Display1
{
        print "  -------\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub Display2
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     O\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub Display3
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     O\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub Display4
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     O\n";
        print "  |    \\|\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub Display5
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     O\n";
        print "  |    \\|/\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub Display6
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     O\n";
        print "  |    \\|/\n";
        print "  |    /\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub Display7
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     X\n";
        print "  |    \\|/\n";
        print "  |    /\ \\\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
    print "Opps ! You lost!\n";
    exit 0;   # exit means all lifes are over game ended
}