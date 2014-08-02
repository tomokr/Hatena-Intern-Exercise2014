#!/usr/bin/perl -w
    use strict;
	use warnings;

my $p = Person->new();
#print $p; #これを出力するとHASHになる

# 読み出しの場合
print $p->name()."\n";
#my $age = $p->age();

# 書き込みの場合
#$p->name("Suzuki");

# 書き込んだ後、読み出す場合
#print $p->age(34);

package Person;

sub new {
  my $class = shift;
  my $self = {
    Name => 'none',
    Age => 10,
  };
  return bless ($self, $class);
}

sub name {
  my $self = shift;
  if( @_ ){ $self->{Name} = shift }
  return $self->{Name};
}

sub age {
  my $self = shift;
  if( @_ ){ $self->{Age} = shift }
  return $self->{Age};
}
