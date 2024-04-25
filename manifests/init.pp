# == Class: bash
#
class bash (
  Enum['absent','latest','present','purged'] $package_ensure = 'present',
  String $package_name                                       = $::bash::params::package_name,
  Array[Any] $package_list                                   = $::bash::params::package_list,

  Optional[Stdlib::Absolutepath] $config_dir_path            = $::bash::params::config_dir_path,
  $config_dir_purge                                          = false,
  $config_dir_recurse                                        = true,
  Optional[String] $config_dir_source                        = undef,

  Optional[Stdlib::Absolutepath] $config_file_path           = $::bash::params::config_file_path,
  String $config_file_owner                                  = $::bash::params::config_file_owner,
  String $config_file_group                                  = $::bash::params::config_file_group,
  String $config_file_mode                                   = $::bash::params::config_file_mode,
  Optional[String] $config_file_source                       = undef,
  Optional[String] $config_file_string                       = undef,
  Optional[String] $config_file_template                     = undef,

  String $config_file_require                                = $::bash::params::config_file_require,

  $config_file_hash                                          = {},
  $config_file_options_hash                                  = {},

  $color_prompt                                              = '\[\033[01;32m\]',
  $hostname_prompt                                           = '\h',
) inherits ::bash::params {
  validate_bool($config_dir_purge)
  validate_bool($config_dir_recurse)

  validate_hash($config_file_hash)
  validate_hash($config_file_options_hash)

  $config_file_content = default_content($config_file_string, $config_file_template)

  if $config_file_hash {
    create_resources('bash::define', $config_file_hash)
  }

  if $package_ensure == 'purged' {
    $config_dir_ensure  = 'absent'
    $config_file_ensure = 'absent'
  } else {
    $config_dir_ensure  = 'directory'
    $config_file_ensure = 'present'
  }

  assert_type(Enum['absent','directory'], $config_dir_ensure)
  assert_type(Enum['absent','present'], $config_file_ensure)

  anchor { 'bash::begin': } ->
  class { '::bash::install': } ->
  class { '::bash::config': } ->
  anchor { 'bash::end': }
}
