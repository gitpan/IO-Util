#!perl -w
; use strict
; use Test::More tests => 4


; use IO::Util qw(capture)

; sub print_something
   { print shift()
   }
   
; my $out = capture { print_something('a'); print_something('b')}
; is ( $$out
     , 'ab'
     )
     
; select STDERR

; $out = capture { print_something('c'); print_something('d')} STDERR
; is ( $$out
     , 'cd'
     )

; select STDOUT



; tie *STDOUT, 'My::test_tie'

; $out = capture { print_something('e'); print_something('f')}
; ok (  ($$out eq 'ef')
     && (ref(tied *STDOUT) eq 'My::test_tie')
     )
; untie *STDOUT

; $, = '*'
; $\ = '#'

; $out = capture { print 'X', 'Y'
                 ; printf '%2$d %1$d', 12, 34
                 ; print_something('Z');
                 }
; is( $$out
    , 'X*Y#34 12Z#'
    )

; package My::test_tie

; my $output = ''

; sub TIEHANDLE
   { bless \@_, shift()
   }

; sub PRINT
   { my $s = shift
   }


