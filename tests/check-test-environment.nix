# this can be used to check if the nixcloud specific test environment is working
{
  name = "check-test-environment";
  machine = {};
  testScript = ''
    start_all()
    machine.wait_for_unit("multi-user.target")
    machine.succeed("ls")
  '';
}
