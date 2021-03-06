package Spark::Form::Field::Role::Printable::XHTML;

use Moose::Role;
with "Spark::Form::Field::Role::Printable";

requires 'to_xhtml';

1;
__END__

=head1 NAME

Spark::Form::Field::Role::Printable::XHTML - a xhtml1-printable form field role

=head1 SYNOPSIS

 package MyApp::Form::Field::CustomText;
 use Moose;
 extends 'Spark::Form::Field';
 with 'Spark::Form::Field::Role::Printable::XHTML';
 use HTML::Tiny;
 
 sub to_xhtml {
     my ($self) = @_;
     my $html = HTML::Tiny->new( mode => 'xml' );
     $html->input({type => 'text', value => $self->value});
 }

=head1 METHODS

=head2 to_xhtml :: Undef => Str

This function should return a html string representing your control

=head1 SEE ALSO

L<Spark::Form::Field>

=cut