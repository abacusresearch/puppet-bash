# == Define: bash::define
#
define bash::define (
  $config_file_path                          = undef,
  Optional[String] $config_file_owner        = undef,
  Optional[String] $config_file_group        = undef,
  Optional[String] $config_file_mode         = undef,
  Optional[String] $config_file_source       = undef,
  Optional[String] $config_file_string       = undef,
  Optional[String] $config_file_template     = undef,

  Optional[String] $config_file_require      = undef,

  $config_file_options_hash                  = $::bash::config_file_options_hash,
) {
  if $config_file_path { validate_absolute_path($config_file_path) }

  $_config_file_path  = pick($config_file_path, "${::bash::config_dir_path}/${name}")
  $_config_file_owner = pick($config_file_owner, $::bash::config_file_owner)
  $_config_file_group = pick($config_file_group, $::bash::config_file_group)
  $_config_file_mode = pick($config_file_mode, $::bash::config_file_mode)
  $config_file_content = default_content($config_file_string, $config_file_template)

  $_config_file_require = pick($config_file_require, $::bash::config_file_require)

  file { "define_${name}":
    ensure  => $::bash::config_file_ensure,
    path    => $_config_file_path,
    owner   => $_config_file_owner,
    group   => $_config_file_group,
    mode    => $_config_file_mode,
    source  => $config_file_source,
    content => $config_file_content,
    require => $_config_file_require,
  }
}
