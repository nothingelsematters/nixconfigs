{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # make builder
    gnumake
    # exposing a web server running on your local machine to the internet
    ngrok
    # PostgreSQL client
    postgresql_15
  ];
}
