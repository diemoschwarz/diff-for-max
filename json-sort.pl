#!/usr/bin/perl

use JSON; # imports encode_json, decode_json, to_json and from_json.
 
# from file content
local $/;
open(my $fh, $ARGV[0]);
$json_text   = <$fh>;
$perl_scalar = decode_json( $json_text );

$json = new JSON;
$json = $json->canonical(1);
    
$pretty_printed = $json->pretty->encode( $perl_scalar ); # pretty-printing

print($pretty_printed);

=cut=

 # simple and fast interfaces (expect/generate UTF-8)
 
 $utf8_encoded_json_text = encode_json $perl_hash_or_arrayref;
 $perl_hash_or_arrayref  = decode_json $utf8_encoded_json_text;



  
