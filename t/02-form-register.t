# Something looking a bit more real-world
use Test::More;
plan tests => 11;

use Spark::Form;
use Data::Dumper 'Dumper';
#Local lib
use lib 't/lib';
use TestApp::Form::Field::Email;
use TestApp::Form::Field::Password;

#Create a form
my $form = Spark::Form->new;

my $email = TestApp::Form::Field::Email->new(name => 'email', form => $form);
my $pass1 = TestApp::Form::Field::Password->new(name => 'password', form => $form);
my $pass2 = TestApp::Form::Field::Password->new(name => 'confirm_password', confirm=>'password', form => $form);

#First off, verify there are no fields in an empty form
is_deeply([$form->fields_a],[],"Fields are not yet populated");

#Add an email
$form->add($email);
cmp_ok(scalar $form->fields_a,'==',1,"Email field added");

#Validate
$form->data({email => 'blah'});
$form->validate;
#die Dumper $email;
is(scalar $form->errors, 1, 'One error');

#Revalidate
$form->data({email => 'blah@blah.com'});
$form->validate;
is(scalar $form->errors, 0, 'No error');

#Add a password
$form->add($pass1);
cmp_ok(scalar $form->fields_a,'==',2,"Password field added");

#Validate
$form->data({email => 'blah',password => 'foo'});
$form->validate;
is(scalar $form->errors, 2, 'Two errors');

#Revalidate
$form->data({email => 'blah@blah.com',password => 'password'});
$form->validate;
is(scalar $form->errors, 0, 'No error');

#And a confirm password
$form->add($pass2,confirm=>'password');
cmp_ok(scalar $form->fields_a,'==',3,"Password confirm field added");

#Validate
$form->data({email => 'blah',password=>'password',confirm_password=>'foo'});
$form->validate;
is(scalar $form->errors, 3, 'Three errors');

#Revalidate
$form->data({email => 'blah@blah.com',password=>'password',confirm_password=>'password'});
$form->validate;
is(scalar $form->errors, 0, 'No error');

is($form->valid,1,"Form is valid");
