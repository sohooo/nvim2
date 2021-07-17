class postgres::cluster(
  $ensure => 'present',
  $version => 13,
) {

  file { '/tmp/test':
    ensure => file,
    content => 'hi',
  }

  package { "postgresql${version}-server":
    ensure => latest,
    provider => 'yum', }
}
