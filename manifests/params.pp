# == Class: bash::params
#
class bash::params {
  $package_name = $facts['os']['family'] ? {
    default => 'bash',
  }

  $package_list = $facts['os']['family'] ? {
    default => ['bash-completion'],
  }

  $config_dir_path = $facts['os']['family'] ? {
    default => '/etc/skel',
  }

  $config_file_path = $facts['os']['family'] ? {
    default => '/etc/skel/.bashrc',
  }

  $config_file_owner = $facts['os']['family'] ? {
    default => 'root',
  }

  $config_file_group = $facts['os']['family'] ? {
    default => 'root',
  }

  $config_file_mode = $facts['os']['family'] ? {
    default => '0644',
  }

  $config_file_require = $facts['os']['family'] ? {
    default => 'Package[bash]',
  }
}
