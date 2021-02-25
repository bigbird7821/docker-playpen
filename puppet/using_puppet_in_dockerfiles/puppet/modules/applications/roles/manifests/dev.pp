class roles::dev {
  include profiles::base::core
  #include profiles::docker::examples::container_with_ssh
  #include profiles::docker::examples::shared_volume
  #include profiles::docker::oracle_xe
}