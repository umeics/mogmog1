#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP::TLS;
use Encode;
my ($host, $user, $passwd, $fromaddress, $toaddress, $subject, $honbun,) = @ARGV;

Encode::from_to($honbun, 'utf8', 'iso-2022-jp');
Encode::from_to($subject, 'utf8', 'iso-2022-jp');
encode('MIME-Header-ISO_2022_JP', $subject);

my $smtp = Email::Sender::Transport::SMTP::TLS->new(host => $host, port => 587, username => $user, password => $passwd ,Timeout => 60, Debug => 1) or die;

my $email = Email::Simple->create(
  header => [
    From    => $fromaddress,
    To      => $toaddress,
    Subject => $subject,
  ],
  attributes => {
    content_type => 'text/plain',
    charset      => 'ISO-2022-JP',
    encoding     => '7bit',
  },
  body => $honbun,
);

sendmail($email, {transport => $smtp});